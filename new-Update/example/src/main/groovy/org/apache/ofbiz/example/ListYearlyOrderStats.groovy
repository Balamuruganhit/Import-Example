import org.apache.ofbiz.base.util.Debug
import org.apache.ofbiz.entity.Delegator
import org.apache.ofbiz.entity.GenericEntityException
import org.apache.ofbiz.entity.condition.EntityCondition
import org.apache.ofbiz.entity.condition.EntityOperator
import org.apache.ofbiz.service.ServiceUtil

/**
 * Service: ListYearlyOrderStats
 * Purpose: Returns order counts for current and previous year dynamically
 */
def ListYearlyOrderStats() {
    Delegator delegator = dctx.getDelegator()
    def logModule = "ListYearlyOrderStats"

    try {
        // Get current and previous year dynamically
        def currentYear = java.time.Year.now().getValue()
        def previousYear = currentYear - 1

        // Define date range for both years
        def startDate = java.sql.Timestamp.valueOf("${previousYear}-01-01 00:00:00")
        def endDate = java.sql.Timestamp.valueOf("${currentYear}-12-31 23:59:59")

        // Fetch orders within the two-year range
        def condition = EntityCondition.makeCondition([
            EntityCondition.makeCondition("createdStamp", EntityOperator.GREATER_THAN_EQUAL_TO, startDate),
            EntityCondition.makeCondition("createdStamp", EntityOperator.LESS_THAN_EQUAL_TO, endDate)
        ], EntityOperator.AND)

        def orderList = delegator.findList("OrderHeader", condition, null, null, null, false)

        // Count per year
        def yearlyCounts = [(previousYear): 0, (currentYear): 0]

        orderList.each { record ->
            def createdDate = record.getTimestamp("createdStamp")
            if (createdDate) {
                def year = createdDate.toLocalDateTime().getYear()
                if (yearlyCounts.containsKey(year)) {
                    yearlyCounts[year] = yearlyCounts[year] + 1
                }
            }
        }

        // Convert to JSON-friendly list
        def yearlyOrderStats = [
            [label: previousYear.toString(), value: yearlyCounts[previousYear]],
            [label: currentYear.toString(), value: yearlyCounts[currentYear]]
        ]

        Debug.logInfo("📊 Yearly Order Stats (Prev & Current): ${yearlyOrderStats}", logModule)
        return [success: true, yearlyOrderStats: yearlyOrderStats]

    } catch (GenericEntityException e) {
        Debug.logError(e, "❌ Error fetching yearly order stats", logModule)
        return ServiceUtil.returnError("Error fetching yearly order stats: ${e.message}")
    }
}
