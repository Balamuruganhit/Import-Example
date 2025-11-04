import org.apache.ofbiz.entity.DelegatorFactory
import org.apache.ofbiz.entity.condition.EntityCondition
import org.apache.ofbiz.entity.condition.EntityOperator
import org.apache.ofbiz.service.ServiceUtil
import org.apache.ofbiz.base.util.Debug

def ListReworkWorkEfforts() {
    def result = ServiceUtil.returnSuccess()
    def delegator = dctx.getDelegator()

    try {
        // condition: rework field > 0 (and not null)
        def condition = EntityCondition.makeCondition([
            EntityCondition.makeCondition("rework", EntityOperator.NOT_EQUAL, null),
            EntityCondition.makeCondition("rework", EntityOperator.GREATER_THAN, BigDecimal.ZERO)
        ], EntityOperator.AND)

        def workEfforts = delegator.findList("WorkEffort", condition, null, null, null, false)
        def workEffortIds = workEfforts.collect { it.workEffortId }

        result.workEffortIds = workEffortIds
        Debug.logInfo("Rework WorkEfforts found: ${workEffortIds}", "ListReworkWorkEfforts")
    } catch (Exception e) {
        Debug.logError(e, "Error fetching rework WorkEfforts", "ListReworkWorkEfforts")
        return ServiceUtil.returnError("Error fetching rework WorkEfforts: ${e.message}")
    }

    return result
}
