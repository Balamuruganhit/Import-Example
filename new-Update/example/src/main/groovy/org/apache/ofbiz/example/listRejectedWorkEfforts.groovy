import org.apache.ofbiz.entity.DelegatorFactory
import org.apache.ofbiz.entity.condition.EntityCondition
import org.apache.ofbiz.entity.condition.EntityOperator
import org.apache.ofbiz.service.ServiceUtil
import org.apache.ofbiz.base.util.Debug

def ListRejectedWorkEfforts(Map context) {
    def result = ServiceUtil.returnSuccess()
    def delegator = context?.delegator ?: DelegatorFactory.getDelegator("default")

    try {
        // --- Condition: quantityRejected field > 0 and not null ---
        def condition = EntityCondition.makeCondition([
            EntityCondition.makeCondition("quantityRejected", EntityOperator.NOT_EQUAL, null),
            EntityCondition.makeCondition("quantityRejected", EntityOperator.GREATER_THAN, BigDecimal.ZERO)
        ], EntityOperator.AND)

        // --- Fetch matching WorkEfforts ---
        def workEfforts = delegator.findList("WorkEffort", condition, null, null, null, false)
        def workEffortIds = workEfforts.collect { it.workEffortId }

        result.workEffortIds = workEffortIds
        Debug.logInfo("✅ Rejected WorkEfforts found: ${workEffortIds}", "ListRejectedWorkEfforts")
        return result

    } catch (Exception e) {
        Debug.logError(e, "❌ Error fetching Rejected WorkEfforts", "ListRejectedWorkEfforts")
        return ServiceUtil.returnError("Error fetching Rejected WorkEfforts: ${e.message}")
    }
}
