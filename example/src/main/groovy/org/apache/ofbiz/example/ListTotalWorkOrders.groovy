import org.apache.ofbiz.entity.DelegatorFactory
import org.apache.ofbiz.service.ServiceUtil
import org.apache.ofbiz.base.util.Debug

def ListTotalWorkOrders() {
    def result = ServiceUtil.returnSuccess()
    def delegator = DelegatorFactory.getDelegator("default")

    try {
        def workOrders = delegator.findList("WorkOrderHeader", null, null, null, null, false)
        def workOrderIds = workOrders.collect { it.workOrderId }

        result.workOrderIds = workOrderIds
        Debug.logInfo("✅ Found ${workOrderIds.size()} total WorkOrders", "Example")
    } catch (Exception e) {
        Debug.logError(e, "❌ Error in ListTotalWorkOrders", "Example")
        return ServiceUtil.returnError("Error fetching total WorkOrders: ${e.message}")
    }

    return result
}
