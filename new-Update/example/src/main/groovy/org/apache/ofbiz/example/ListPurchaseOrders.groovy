import org.apache.ofbiz.entity.DelegatorFactory
import org.apache.ofbiz.entity.condition.EntityCondition
import org.apache.ofbiz.entity.condition.EntityOperator
import org.apache.ofbiz.service.ServiceUtil
import org.apache.ofbiz.base.util.Debug

def ListPurchaseOrders() {
    def result = ServiceUtil.returnSuccess()
    def delegator = DelegatorFactory.getDelegator("default")
    try {
        def condition = EntityCondition.makeCondition("orderTypeId", EntityOperator.EQUALS, "PURCHASE_ORDER")
        def orders = delegator.findList("OrderHeader", condition, null, null, null, false)
        def orderIds = orders.collect { it.orderId }
        result.orderIds = orderIds
        Debug.logInfo("✅ Purchase Orders: ${orderIds.size()}", "Example")
    } catch (Exception e) {
        Debug.logError(e, "❌ Error in ListPurchaseOrders", "Example")
        return ServiceUtil.returnError("Error fetching purchase orders: ${e.message}")
    }
    return result
}
