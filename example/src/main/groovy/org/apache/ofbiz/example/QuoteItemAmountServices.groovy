import org.apache.ofbiz.base.util.Debug
import org.apache.ofbiz.entity.DelegatorFactory
import org.apache.ofbiz.service.ServiceUtil
import java.math.BigDecimal

def ListQuoteItemAmounts() {
    def delegator = dctx?.getDelegator() ?: DelegatorFactory.getDelegator("default")

    try {
        // Fetch all QuoteItems
        def quoteItems = delegator.findList("QuoteItem", null, null, null, null, false)

        // Calculate total amount (quoteUnitPrice * quantity)
        BigDecimal totalAmount = quoteItems?.sum { 
            def unitPrice = it.getBigDecimal("quoteUnitPrice") ?: BigDecimal.ZERO
            def quantity = it.getBigDecimal("quantity") ?: BigDecimal.ZERO
            unitPrice * quantity
        } ?: BigDecimal.ZERO

        def result = ServiceUtil.returnSuccess()
        result.totalQuoteAmount = totalAmount
        return result

    } catch (Exception e) {
        Debug.logError(e, "Error fetching quote item amounts", "ListQuoteItemAmounts")
        return ServiceUtil.returnError("Error fetching quote item amounts: ${e.message}")
    }
}