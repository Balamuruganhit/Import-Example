/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.
 */

import org.apache.ofbiz.entity.DelegatorFactory
import org.apache.ofbiz.entity.condition.EntityCondition
import org.apache.ofbiz.entity.condition.EntityOperator
import org.apache.ofbiz.base.util.UtilDateTime
import org.apache.ofbiz.base.util.Debug
import org.apache.ofbiz.service.ServiceUtil

def listYearlyOrders() {
    def result = ServiceUtil.returnSuccess()
    def delegator = delegator ?: DelegatorFactory.getDelegator("default")

    try {
        // --- Get TimeZone and Locale (always pass both) ---
        def timeZone = TimeZone.getDefault()
        def locale = Locale.getDefault()

        // --- Current timestamp ---
        def now = UtilDateTime.nowTimestamp()

        // --- Get current and previous year properly ---
        def currentYear = UtilDateTime.getYear(now, timeZone, locale)
        def previousYear = currentYear - 1

        // --- Build timestamps for each year's range ---
        def startCurrentYear = UtilDateTime.toTimestamp(currentYear, 1, 1, 0, 0, 0)
        def endCurrentYear = UtilDateTime.toTimestamp(currentYear, 12, 31, 23, 59, 59)

        def startPreviousYear = UtilDateTime.toTimestamp(previousYear, 1, 1, 0, 0, 0)
        def endPreviousYear = UtilDateTime.toTimestamp(previousYear, 12, 31, 23, 59, 59)

        // --- Create conditions ---
        def currentYearCondition = EntityCondition.makeCondition([
            EntityCondition.makeCondition("createdStamp", EntityOperator.GREATER_THAN_EQUAL_TO, startCurrentYear),
            EntityCondition.makeCondition("createdStamp", EntityOperator.LESS_THAN_EQUAL_TO, endCurrentYear)
        ], EntityOperator.AND)

        def previousYearCondition = EntityCondition.makeCondition([
            EntityCondition.makeCondition("createdStamp", EntityOperator.GREATER_THAN_EQUAL_TO, startPreviousYear),
            EntityCondition.makeCondition("createdStamp", EntityOperator.LESS_THAN_EQUAL_TO, endPreviousYear)
        ], EntityOperator.AND)

        // --- Count orders ---
        def currentYearOrders = delegator.findCountByCondition("OrderHeader", currentYearCondition, null, null)
        def previousYearOrders = delegator.findCountByCondition("OrderHeader", previousYearCondition, null, null)

        // --- Prepare and return data ---
        def yearlyOrdersList = [
            [year: previousYear, totalOrders: previousYearOrders],
            [year: currentYear, totalOrders: currentYearOrders]
        ]

        result.yearlyOrdersList = yearlyOrdersList
        Debug.logInfo("✅ Yearly Orders: ${yearlyOrdersList}", "ListYearlyOrders")
        return result

    } catch (Exception e) {
        Debug.logError(e, "❌ Error in ListYearlyOrders.groovy")
        return ServiceUtil.returnError("Failed to fetch yearly order data: ${e.getMessage()}")
    }
}
