import org.apache.ofbiz.base.util.Debug
import org.apache.ofbiz.entity.Delegator
import org.apache.ofbiz.entity.GenericEntityException
import org.apache.ofbiz.entity.condition.EntityCondition
import org.apache.ofbiz.entity.condition.EntityOperator
import org.apache.ofbiz.service.DispatchContext
import org.apache.ofbiz.service.ServiceUtil

def ListRequestValues() {
    Delegator delegator = dctx.getDelegator()
    def logModule = "ListRequestValues"

    try {
        // --- Total Requests ---
        def totalRequests = delegator.findList("CustRequest", null, null, null, null, false)?.size() ?: 0

        // --- Draft Requests ---
        def draftCondition = EntityCondition.makeCondition("statusId", EntityOperator.EQUALS, "CRQ_DRAFT")
        def draftRequests = delegator.findList("CustRequest", draftCondition, null, null, null, false)?.size() ?: 0

        // --- Submitted Requests ---
        def submittedCondition = EntityCondition.makeCondition("statusId", EntityOperator.EQUALS, "CRQ_SUBMITTED")
        def submittedRequests = delegator.findList("CustRequest", submittedCondition, null, null, null, false)?.size() ?: 0

        // --- Accepted Requests ---
        def acceptedCondition = EntityCondition.makeCondition("statusId", EntityOperator.EQUALS, "CRQ_ACCEPTED")
        def acceptedRequests = delegator.findList("CustRequest", acceptedCondition, null, null, null, false)?.size() ?: 0

        // --- Reviewed Requests ---
        def reviewedCondition = EntityCondition.makeCondition("statusId", EntityOperator.EQUALS, "CRQ_REVIEWED")
        def reviewedRequests = delegator.findList("CustRequest", reviewedCondition, null, null, null, false)?.size() ?: 0

        // --- Completed Requests ---
        def completedCondition = EntityCondition.makeCondition("statusId", EntityOperator.EQUALS, "CRQ_COMPLETED")
        def completedRequests = delegator.findList("CustRequest", completedCondition, null, null, null, false)?.size() ?: 0

        // --- Reopened Requests ---
        def reopenedCondition = EntityCondition.makeCondition("statusId", EntityOperator.EQUALS, "CRQ_REOPENED")
        def reopenedRequests = delegator.findList("CustRequest", reopenedCondition, null, null, null, false)?.size() ?: 0

        // --- Pending Customer Requests ---
        def pendingCondition = EntityCondition.makeCondition("statusId", EntityOperator.EQUALS, "CRQ_PENDING_CUST")
        def pendingRequests = delegator.findList("CustRequest", pendingCondition, null, null, null, false)?.size() ?: 0

        // --- Rejected Requests ---
        def rejectedCondition = EntityCondition.makeCondition("statusId", EntityOperator.EQUALS, "CRQ_REJECTED")
        def rejectedRequests = delegator.findList("CustRequest", rejectedCondition, null, null, null, false)?.size() ?: 0

        // --- Cancelled Requests ---
        def cancelledCondition = EntityCondition.makeCondition("statusId", EntityOperator.EQUALS, "CRQ_CANCELLED")
        def cancelledRequests = delegator.findList("CustRequest", cancelledCondition, null, null, null, false)?.size() ?: 0

        // --- On Process Requests ---
        def onProcessCondition = EntityCondition.makeCondition([
            EntityCondition.makeCondition("statusId", EntityOperator.NOT_IN, ["CRQ_COMPLETED", "CRQ_REJECTED", "CRQ_CANCELLED"])
        ], EntityOperator.AND)
        def onProcessRequests = delegator.findList("CustRequest", onProcessCondition, null, null, null, false)?.size() ?: 0

        // --- For Stat Box (All Counts) ---
        def countsList = [
            [label: "Total Requests", value: totalRequests],
            [label: "On Process Requests", value: onProcessRequests],
            [label: "Draft Requests", value: draftRequests],
            [label: "Submitted Requests", value: submittedRequests],
            [label: "Accepted Requests", value: acceptedRequests],
            [label: "Reviewed Requests", value: reviewedRequests],
            [label: "Completed Requests", value: completedRequests],
            [label: "Reopened Requests", value: reopenedRequests],
            [label: "Pending Customer Requests", value: pendingRequests],
            [label: "Rejected Requests", value: rejectedRequests],
            [label: "Cancelled Requests", value: cancelledRequests]
        ]

        // --- For Pie Chart (Exclude "On Process Requests") ---
        def chartList = countsList.findAll { it.label != "On Process Requests" }

        return [
            success: true,
            requestCountList: countsList,  // → Full list (used in stat boxes)
            requestChartList: chartList    // → Filtered list (used in pie chart)
        ]

    } catch (GenericEntityException e) {
        Debug.logError(e, "Error fetching request counts", logModule)
        return ServiceUtil.returnError("Error fetching request counts: ${e.message}")
    }
}
