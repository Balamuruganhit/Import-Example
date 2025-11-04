import org.apache.ofbiz.base.util.Debug
import org.apache.ofbiz.entity.DelegatorFactory
import org.apache.ofbiz.entity.condition.EntityCondition
import org.apache.ofbiz.entity.condition.EntityOperator
import org.apache.ofbiz.service.ServiceUtil

def ListProductionRunValues(Map context) {
    // Safely handle null context
    def ctx = context ?: [:]
    def delegator = ctx.delegator ?: DelegatorFactory.getDelegator("default")
    def resultMap = [:]

    try {
        Debug.logInfo("ListProductionRunValues service started...", "ListProductionRunValues")

        // --- Count production runs with status PRUN_CREATED ---
        def createdCondition = EntityCondition.makeCondition("statusId", EntityOperator.EQUALS, "PRUN_CREATED")
        def createdList = delegator.findList("WorkEffortStatus", createdCondition, null, null, null, false)
        def createdCount = createdList?.size() ?: 0

        // --- Count production runs with status PRUN_CLOSED ---
        def closedCondition = EntityCondition.makeCondition("statusId", EntityOperator.EQUALS, "PRUN_CLOSED")
        def closedList = delegator.findList("WorkEffortStatus", closedCondition, null, null, null, false)
        def closedCount = closedList?.size() ?: 0

        Debug.logInfo("Created count: ${createdCount}, Closed count: ${closedCount}", "ListProductionRunValues")

        // --- Build output list ---
        def productionRunList = [
            [label: "Created Productions", value: createdCount],
            [label: "Closed Productions",  value: closedCount]
        ]

        // --- Return success response ---
        def result = ServiceUtil.returnSuccess()
        result.put("productionRunList", productionRunList)
        return result

    } catch (Exception e) {
        Debug.logError("Error fetching production run values: ${e.message}", "ListProductionRunValues")
        return ServiceUtil.returnError("Error fetching production run values: ${e.message}")
    }
}
