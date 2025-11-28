import org.apache.ofbiz.entity.DelegatorFactory
import org.apache.ofbiz.entity.condition.EntityCondition
import org.apache.ofbiz.entity.condition.EntityOperator
import org.apache.ofbiz.service.ServiceUtil
import org.apache.ofbiz.base.util.Debug

def ListWorkOrderCompleted() {
    def result = ServiceUtil.returnSuccess()
    def delegator = DelegatorFactory.getDelegator("default")

    try {
        def condition = EntityCondition.makeCondition("statusId", EntityOperator.EQUALS, "WO_COMPLETED")
        def workOrders = delegator.findList("WorkOrderHeader", condition, null, null, null, false)

        def workOrderIds = workOrders.collect { it.workOrderId }
        result.workOrderIds = workOrderIds

        Debug.logInfo("✅ Found ${workOrderIds.size()} WO_COMPLETED records", "Example")
    } catch (Exception e) {
        Debug.logError(e, "❌ Error in ListWorkOrderCompleted", "Example")
        return ServiceUtil.returnError("Error fetching WO_COMPLETED WorkOrders: ${e.message}")
    }

    return result
}
