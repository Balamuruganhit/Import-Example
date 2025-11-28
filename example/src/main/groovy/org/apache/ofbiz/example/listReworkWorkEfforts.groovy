import org.apache.ofbiz.entity.DelegatorFactory
import org.apache.ofbiz.entity.condition.EntityCondition
import org.apache.ofbiz.entity.condition.EntityOperator
import org.apache.ofbiz.service.ServiceUtil
import org.apache.ofbiz.base.util.Debug

def ListReworkWorkEfforts(Map context) {
    def result = ServiceUtil.returnSuccess()
    def delegator = context?.delegator ?: DelegatorFactory.getDelegator("default")

    try {
        // --- Condition: rework field > 0 and not null ---
        def condition = EntityCondition.makeCondition([
            EntityCondition.makeCondition("rework", EntityOperator.NOT_EQUAL, null),
            EntityCondition.makeCondition("rework", EntityOperator.GREATER_THAN, BigDecimal.ZERO)
        ], EntityOperator.AND)

        // --- Fetch matching WorkEfforts ---
        def workEfforts = delegator.findList("WorkEffort", condition, null, null, null, false)
        def workEffortIds = workEfforts.collect { it.workEffortId }

        result.workEffortIds = workEffortIds
        Debug.logInfo("✅ Rework WorkEfforts found: ${workEffortIds}", "ListReworkWorkEfforts")
        return result

    } catch (Exception e) {
        Debug.logError(e, "❌ Error fetching Rework WorkEfforts", "ListReworkWorkEfforts")
        return ServiceUtil.returnError("Error fetching Rework WorkEfforts: ${e.message}")
    }
}
