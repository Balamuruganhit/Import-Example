import org.apache.ofbiz.base.util.Debug
import org.apache.ofbiz.entity.Delegator
import org.apache.ofbiz.entity.GenericEntityException
import org.apache.ofbiz.entity.condition.EntityCondition
import org.apache.ofbiz.entity.condition.EntityOperator
import org.apache.ofbiz.service.ServiceUtil

def ListOrderValues() {
    Delegator delegator = dctx.getDelegator()

    try {
        // --- Total Orders ---
        def totalOrders = delegator.findList("OrderHeader", null, null, null, null, false)?.size() ?: 0

        // --- Sales Orders ---
        def salesCondition = EntityCondition.makeCondition("orderTypeId", EntityOperator.EQUALS, "SALES_ORDER")
        def salesOrders = delegator.findList("OrderHeader", salesCondition, null, null, null, false)

        def completedSalesOrders = salesOrders.findAll { it.statusId == "ORDER_COMPLETED" }.size()
        def onProcessSalesOrders = salesOrders.findAll { it.statusId != "ORDER_COMPLETED" }.size()
        def totalSalesOrders = salesOrders.size()

        // --- Purchase Orders ---
        def purchaseCondition = EntityCondition.makeCondition("orderTypeId", EntityOperator.EQUALS, "PURCHASE_ORDER")
        def purchaseOrders = delegator.findList("OrderHeader", purchaseCondition, null, null, null, false)

        def completedPurchaseOrders = purchaseOrders.findAll { it.statusId == "ORDER_COMPLETED" }.size()
        def onProcessPurchaseOrders = purchaseOrders.findAll { it.statusId != "ORDER_COMPLETED" }.size()
        def totalPurchaseOrders = purchaseOrders.size()

        // --- Combine Results ---
        def countsList = [
            [label: "Total Orders", value: totalOrders],
            [label: "Sales Orders", value: totalSalesOrders],
            [label: "Completed Sales Orders", value: completedSalesOrders],
            [label: "On Process Sales Orders", value: onProcessSalesOrders],
            [label: "Purchase Orders", value: totalPurchaseOrders],
            [label: "Completed Purchase Orders", value: completedPurchaseOrders],
            [label: "On Process Purchase Orders", value: onProcessPurchaseOrders]
        ]

        return [success: true, orderCountList: countsList]
    } catch (GenericEntityException e) {
        Debug.logError(e, "Error fetching order counts", "ListOrderValues")
        return ServiceUtil.returnError("Error fetching order counts: ${e.message}")
    }
}
