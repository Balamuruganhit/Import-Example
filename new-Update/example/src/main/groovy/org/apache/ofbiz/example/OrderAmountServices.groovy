import org.apache.ofbiz.base.util.Debug
import org.apache.ofbiz.entity.DelegatorFactory
import org.apache.ofbiz.entity.condition.EntityCondition
import org.apache.ofbiz.entity.condition.EntityOperator
import org.apache.ofbiz.service.ServiceUtil
import java.math.BigDecimal

def ListOrderAmounts() {
    def delegator = DelegatorFactory.getDelegator("default")

    try {
        def salesCondition = EntityCondition.makeCondition("orderTypeId", EntityOperator.EQUALS, "SALES_ORDER")
        def salesOrders = delegator.findList("OrderHeader", salesCondition, null, null, null, false)
        BigDecimal totalSalesAmount = salesOrders?.sum { it.getBigDecimal("grandTotal") ?: BigDecimal.ZERO } ?: BigDecimal.ZERO

        def purchaseCondition = EntityCondition.makeCondition("orderTypeId", EntityOperator.EQUALS, "PURCHASE_ORDER")
        def purchaseOrders = delegator.findList("OrderHeader", purchaseCondition, null, null, null, false)
        BigDecimal totalPurchaseAmount = purchaseOrders?.sum { it.getBigDecimal("grandTotal") ?: BigDecimal.ZERO } ?: BigDecimal.ZERO

        def amountsList = [
            [label: "Total Sales Order Amount(INR)", value: totalSalesAmount],
            [label: "Total Purchase Order Amount(INR)", value: totalPurchaseAmount]
        ]

        def result = ServiceUtil.returnSuccess()
        result.orderAmountList = amountsList
        return result

    } catch (Exception e) {
        Debug.logError(e, "Error fetching order amounts", "ListOrderAmounts")
        return ServiceUtil.returnError("Error fetching order amounts: ${e.message}")
    }
}
