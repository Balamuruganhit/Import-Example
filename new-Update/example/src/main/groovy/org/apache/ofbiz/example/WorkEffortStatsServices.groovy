import org.apache.ofbiz.entity.DelegatorFactory
import org.apache.ofbiz.entity.condition.EntityCondition
import org.apache.ofbiz.entity.condition.EntityOperator
import org.apache.ofbiz.service.ServiceUtil
import org.apache.ofbiz.base.util.Debug

def listReworkAndRejectedCounts(Map context) {
    def result = ServiceUtil.returnSuccess()
    def delegator = context?.delegator ?: DelegatorFactory.getDelegator("default")

    try {
        // --- Use uppercase field names exactly as shown in entity ---
        def reworkCondition = EntityCondition.makeCondition("REWORK", EntityOperator.NOT_EQUAL, null)
        def rejectedCondition = EntityCondition.makeCondition("QUANTITY_REJECTED", EntityOperator.NOT_EQUAL, null)

        def reworkList = delegator.findList("WorkEffort", reworkCondition, null, null, null, false)
        def rejectedList = delegator.findList("WorkEffort", rejectedCondition, null, null, null, false)

        def reworkCount = reworkList?.size() ?: 0
        def rejectedCount = rejectedList?.size() ?: 0

        Debug.logInfo("WorkEffort REWORK count: ${reworkCount}, QUANTITY_REJECTED count: ${rejectedCount}", "WorkEffortStatsServices")

        result.reworkCount = reworkCount
        result.rejectedCount = rejectedCount
    } catch (Exception e) {
        Debug.logError(e, "Error fetching WorkEffort REWORK/QUANTITY_REJECTED counts", "WorkEffortStatsServices")
        return ServiceUtil.returnError("Error fetching counts: ${e.message}")
    }

    return result
}
