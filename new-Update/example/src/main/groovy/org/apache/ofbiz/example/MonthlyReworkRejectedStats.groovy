/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.
 *
 * Service: ListMonthlyReworkRejectedStats
 * Purpose: Returns monthly Rework vs Rejected quantities from WorkEffort entity
 */

import org.apache.ofbiz.base.util.Debug
import org.apache.ofbiz.entity.Delegator
import org.apache.ofbiz.entity.GenericEntityException
import org.apache.ofbiz.entity.condition.EntityCondition
import org.apache.ofbiz.entity.condition.EntityOperator
import org.apache.ofbiz.service.ServiceUtil
import java.math.BigDecimal

def ListMonthlyReworkRejectedStats() {
    Delegator delegator = dctx.getDelegator()
    def logModule = "ListMonthlyReworkRejectedStats"

    try {
        def currentYear = java.time.Year.now().getValue()

        // Only get records that have non-zero rework or rejected
        def condition = EntityCondition.makeCondition([
            EntityCondition.makeCondition("rework", EntityOperator.GREATER_THAN, BigDecimal.ZERO),
            EntityCondition.makeCondition("quantityRejected", EntityOperator.GREATER_THAN, BigDecimal.ZERO)
        ], EntityOperator.OR)

        def workEfforts = delegator.findList("WorkEffort", condition, null, null, null, false)

        // Initialize arrays as BigDecimal for safe addition
        def monthlyRework = (0..<12).collect { BigDecimal.ZERO }
        def monthlyRejected = (0..<12).collect { BigDecimal.ZERO }

        workEfforts.each { we ->
            def createdDate = we.getTimestamp("createdStamp")
            if (createdDate) {
                def localDateTime = createdDate.toLocalDateTime()
                def year = localDateTime.getYear()
                if (year == currentYear) {
                    def monthIndex = localDateTime.getMonthValue() - 1

                    def reworkVal = we.get("rework") instanceof BigDecimal ? we.get("rework") :
                                    new BigDecimal(we.get("rework") ?: 0)

                    def rejectedVal = we.get("quantityRejected") instanceof BigDecimal ? we.get("quantityRejected") :
                                      new BigDecimal(we.get("quantityRejected") ?: 0)

                    monthlyRework[monthIndex] = monthlyRework[monthIndex].add(reworkVal)
                    monthlyRejected[monthIndex] = monthlyRejected[monthIndex].add(rejectedVal)
                }
            }
        }

        def monthNames = [
            "January","February","March","April","May","June",
            "July","August","September","October","November","December"
        ]

        def monthlyStats = (0..<12).collect { i ->
            [
                label: monthNames[i],
                rework: monthlyRework[i],
                rejected: monthlyRejected[i],
                total: monthlyRework[i].add(monthlyRejected[i])
            ]
        }

        Debug.logInfo("✅ Monthly Rework vs Rejected Data: ${monthlyStats}", logModule)

        return ServiceUtil.returnSuccess().plus([monthlyReworkRejectedStats: monthlyStats])

    } catch (GenericEntityException e) {
        Debug.logError(e, "❌ Error fetching monthly rework/rejected stats", logModule)
        return ServiceUtil.returnError("Database error: ${e.getMessage()}")
    } catch (Exception e) {
        Debug.logError(e, "❌ Unexpected error in ListMonthlyReworkRejectedStats", logModule)
        return ServiceUtil.returnError("Unexpected error: ${e.getMessage()}")
    }
}
