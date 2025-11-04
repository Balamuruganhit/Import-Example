import org.apache.ofbiz.base.util.Debug
import org.apache.ofbiz.entity.Delegator
import org.apache.ofbiz.entity.GenericEntityException
import org.apache.ofbiz.entity.condition.EntityCondition
import org.apache.ofbiz.entity.condition.EntityOperator
import org.apache.ofbiz.service.ServiceUtil

/**
 * Service: ListMonthlyProductionStats
 * Purpose: Returns monthly counts of Production Run statuses (WorkEffortStatus) based on createdStamp
 */
def ListMonthlyProductionStats() {
    Delegator delegator = dctx.getDelegator()
    def logModule = "ListMonthlyProductionStats"

    try {
        // Get current year
        def currentYear = java.time.Year.now().getValue()

        // Fetch WorkEffortStatus records where statusId starts with "PRUN_"
        def condition = EntityCondition.makeCondition(
            EntityCondition.makeCondition("statusId", EntityOperator.LIKE, "PRUN_%")
        )

        def statusList = delegator.findList("WorkEffortStatus", condition, null, null, null, false)

        // Prepare monthly counters (index 0 = Jan ... 11 = Dec)
        def monthlyCounts = (0..<12).collect { 0 }

        statusList.each { record ->
            def createdDate = record.getTimestamp("createdStamp")
            if (createdDate) {
                def localDateTime = createdDate.toLocalDateTime()
                def year = localDateTime.getYear()
                if (year == currentYear) {
                    def monthIndex = localDateTime.getMonthValue() - 1
                    monthlyCounts[monthIndex] = monthlyCounts[monthIndex] + 1
                }
            }
        }

        // Month names
        def monthNames = [
            "January", "February", "March", "April", "May", "June",
            "July", "August", "September", "October", "November", "December"
        ]

        // Combine month labels and counts
        def monthlyProductionStats = (0..<12).collect { i ->
            [label: monthNames[i], value: monthlyCounts[i]]
        }

        Debug.logInfo("Monthly Production Status Data: ${monthlyProductionStats}", logModule)

        return [success: true, monthlyProductionStats: monthlyProductionStats]

    } catch (GenericEntityException e) {
        Debug.logError(e, "Error fetching monthly production stats", logModule)
        return ServiceUtil.returnError("Error fetching monthly production stats: ${e.message}")
    }
}
