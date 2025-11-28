import org.apache.ofbiz.base.util.Debug
import org.apache.ofbiz.entity.Delegator
import org.apache.ofbiz.entity.GenericEntityException
import org.apache.ofbiz.entity.condition.EntityCondition
import org.apache.ofbiz.entity.condition.EntityOperator
import org.apache.ofbiz.service.DispatchContext
import org.apache.ofbiz.service.ServiceUtil

def ListQuoteValues() {
    Delegator delegator = dctx.getDelegator()

    try {
        // --- Total Quotes ---
        def totalQuotes = delegator.findList("Quote", null, null, null, null, false)?.size() ?: 0

        // --- Created Quotes ---
        def createdCondition = EntityCondition.makeCondition("statusId", EntityOperator.EQUALS, "QUO_CREATED")
        def createdQuotes = delegator.findList("Quote", createdCondition, null, null, null, false)?.size() ?: 0

        // --- Approved Quotes ---
        def approvedCondition = EntityCondition.makeCondition("statusId", EntityOperator.EQUALS, "QUO_APPROVED")
        def approvedQuotes = delegator.findList("Quote", approvedCondition, null, null, null, false)?.size() ?: 0

        // --- Ordered Quotes ---
        def orderedCondition = EntityCondition.makeCondition("statusId", EntityOperator.EQUALS, "QUO_ORDERED")
        def orderedQuotes = delegator.findList("Quote", orderedCondition, null, null, null, false)?.size() ?: 0

        // --- Rejected Quotes ---
        def rejectedCondition = EntityCondition.makeCondition("statusId", EntityOperator.EQUALS, "QUO_REJECTED")
        def rejectedQuotes = delegator.findList("Quote", rejectedCondition, null, null, null, false)?.size() ?: 0

        // --- Combine Results ---
        def countsList = [
            [label: "Total Quotes", value: totalQuotes],
            [label: "Created Quotes", value: createdQuotes],
            [label: "Approved Quotes", value: approvedQuotes],
            [label: "Ordered Quotes", value: orderedQuotes],
            [label: "Rejected Quotes", value: rejectedQuotes]
        ]

        return [success: true, quoteCountList: countsList]

    } catch (GenericEntityException e) {
        Debug.logError(e, "Error fetching quote counts", "ListQuoteValues")
        return ServiceUtil.returnError("Error fetching quote counts: ${e.message}")
    }
}
