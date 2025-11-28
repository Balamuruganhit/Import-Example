import org.apache.ofbiz.entity.DelegatorFactory
import org.apache.ofbiz.service.ServiceUtil
import org.apache.ofbiz.base.util.Debug

def ListAllWorkOrders() {
    def result = ServiceUtil.returnSuccess()
    def delegator = DelegatorFactory.getDelegator("default")

    try {
        def workOrders = delegator.findList("WorkOrderHeader", null, null, null, null, false)
        result.workOrderIds = workOrders.collect { it.workOrderId }
        Debug.logInfo("✅ ListAllWorkOrders - Found ${result.workOrderIds.size()} records", "Example")
    } catch (Exception e) {
        Debug.logError(e, "❌ Error in ListAllWorkOrders", "Example")
        return ServiceUtil.returnError("Error fetching all WorkOrders: ${e.message}")
    }

    return result
}
