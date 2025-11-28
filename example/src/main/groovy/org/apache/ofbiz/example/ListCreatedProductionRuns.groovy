import org.apache.ofbiz.entity.DelegatorFactory
import org.apache.ofbiz.entity.condition.EntityCondition
import org.apache.ofbiz.entity.condition.EntityOperator
import org.apache.ofbiz.service.ServiceUtil

def ListCreatedProductionRuns() {
    def result = ServiceUtil.returnSuccess()
    def delegator = DelegatorFactory.getDelegator("default")

    try {
        def records = delegator.findList(
            "WorkEffortStatus",
            EntityCondition.makeCondition("statusId", EntityOperator.EQUALS, "PRUN_CREATED"),
            null, null, null, false
        )

        def ids = records.collect { it.workEffortId }
        result.workEffortIds = ids
        return result
    } catch (Exception e) {
        return ServiceUtil.returnError("Failed to fetch created production runs: ${e.message}")
    }
}
