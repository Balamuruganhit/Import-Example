import org.apache.ofbiz.entity.DelegatorFactory
import org.apache.ofbiz.entity.condition.EntityCondition
import org.apache.ofbiz.entity.condition.EntityOperator
import org.apache.ofbiz.service.ServiceUtil
import org.apache.ofbiz.base.util.Debug

def ListProductionRunClosed() {
    def result = ServiceUtil.returnSuccess()
    def delegator = DelegatorFactory.getDelegator("default")

    try {
        // --- Fetch records from WorkEffortStatus where statusId = PRUN_CLOSED ---
        def records = delegator.findList(
            "WorkEffortStatus",
            EntityCondition.makeCondition("statusId", EntityOperator.EQUALS, "PRUN_CLOSED"),
            null, null, null, false
        )

        // --- Collect corresponding WorkEffort IDs ---
        def ids = records.collect { it.workEffortId }

        result.workEffortIds = ids
        Debug.logInfo("Fetched closed Production Runs: ${ids}", "ListProductionRunClosed")
        return result

    } catch (Exception e) {
        Debug.logError(e, "Error fetching closed Production Runs", "ListProductionRunClosed")
        return ServiceUtil.returnError("Failed to fetch closed production runs: ${e.message}")
    }
}
