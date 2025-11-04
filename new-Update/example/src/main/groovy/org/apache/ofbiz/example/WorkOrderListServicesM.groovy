import org.apache.ofbiz.base.util.Debug
import org.apache.ofbiz.entity.Delegator
import org.apache.ofbiz.entity.GenericEntityException
import org.apache.ofbiz.entity.condition.EntityCondition
import org.apache.ofbiz.service.ServiceUtil

/**
 * Service: ListMonthlyWorkOrderStats
 * Purpose: Returns monthly counts of all Work Orders (WorkOrderHeader) based on createdStamp
 */
def ListMonthlyWorkOrderStats() {
    Delegator delegator = dctx.getDelegator()
    def logModule = "ListMonthlyWorkOrderStats"

    try {
        // Get current year
        def currentYear = java.time.Year.now().getValue()

        // Fetch all WorkOrderHeader records
        def workOrders = delegator.findList("WorkOrderHeader", null, null, null, null, false)

        // Prepare monthly counters (index 0 = Jan ... 11 = Dec)
        def monthlyCounts = (0..<12).collect { 0 }

        workOrders.each { record ->
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
        def monthlyWorkOrderStats = (0..<12).collect { i ->
            [label: monthNames[i], value: monthlyCounts[i]]
        }

        Debug.logInfo("Monthly WorkOrder Stats (no status): ${monthlyWorkOrderStats}", logModule)

        return [success: true, monthlyWorkOrderStats: monthlyWorkOrderStats]

    } catch (GenericEntityException e) {
        Debug.logError(e, "Error fetching monthly work order stats", logModule)
        return ServiceUtil.returnError("Error fetching monthly work order stats: ${e.message}")
    }
}
