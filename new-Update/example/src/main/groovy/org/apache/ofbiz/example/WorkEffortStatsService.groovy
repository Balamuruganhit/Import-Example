import org.apache.ofbiz.entity.DelegatorFactory
import org.apache.ofbiz.entity.condition.EntityCondition
import org.apache.ofbiz.entity.condition.EntityOperator
import org.apache.ofbiz.service.ServiceUtil
import org.apache.ofbiz.base.util.Debug

def listQuantityProducedData(Map context) {
    def result = ServiceUtil.returnSuccess()
    def delegator = context?.delegator ?: DelegatorFactory.getDelegator("default")

    try {
        // ✅ Condition: Only include work efforts of type PROD_ORDER_TASK
        def condition = EntityCondition.makeCondition(
            "workEffortTypeId", EntityOperator.EQUALS, "PROD_ORDER_TASK"
        )

        // ✅ Fetch required fields
        def workEfforts = delegator.findList(
            "WorkEffort",
            condition,
            ["workEffortId", "workEffortParentId", "quantityToProduce", "quantityProduced"] as Set,
            null,
            null,
            false
        )

        // ✅ Transform to clean data list
        def dataList = workEfforts.collect { we ->
            [
                workEffortId       : we.getString("workEffortId"),
                workEffortParentId : we.getString("workEffortParentId") ?: "N/A",
                quantityToProduce  : (we.getBigDecimal("quantityToProduce") ?: 0).toString(),
                quantityProduced   : (we.getBigDecimal("quantityProduced") ?: 0).toString()
            ]
        }

        // ✅ Return parent IDs in the response list for the frontend
        result.workEffortList = dataList.collect {
            [
                workEffortId      : it.workEffortParentId,
                quantityToProduce : it.quantityToProduce,
                quantityProduced  : it.quantityProduced
            ]
        }

    } catch (Exception e) {
        Debug.logError(e, "❌ Error fetching WorkEffort quantity data", "WorkEffortStatsServices")
        return ServiceUtil.returnError("Failed to fetch WorkEffort data: ${e.message}")
    }

    return result
}
