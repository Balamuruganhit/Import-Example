import org.apache.ofbiz.base.util.Debug
import org.apache.ofbiz.entity.Delegator
import org.apache.ofbiz.entity.GenericEntityException
import org.apache.ofbiz.entity.condition.EntityCondition
import org.apache.ofbiz.entity.condition.EntityOperator
import org.apache.ofbiz.service.DispatchContext
import org.apache.ofbiz.service.ServiceUtil

def ListWorkOrderValues() {
    Delegator delegator = dctx.getDelegator()
    def resultMap = [:]

    try {
        // 1️⃣ Total Work Orders
        def totalCount = delegator.findList("WorkOrderHeader", null, null, null, null, false)?.size() ?: 0

        // 2️⃣ Work Orders Created
        def createdCond = EntityCondition.makeCondition("statusId", EntityOperator.EQUALS, "WO_CREATED")
        def createdCount = delegator.findList("WorkOrderHeader", createdCond, null, null, null, false)?.size() ?: 0

        // 3️⃣ Work Orders Approved
        def approvedCond = EntityCondition.makeCondition("statusId", EntityOperator.EQUALS, "WO_APPROVED")
        def approvedCount = delegator.findList("WorkOrderHeader", approvedCond, null, null, null, false)?.size() ?: 0

        // 4️⃣ Work Orders Completed
        def completedCond = EntityCondition.makeCondition("statusId", EntityOperator.EQUALS, "WO_COMPLETED")
        def completedCount = delegator.findList("WorkOrderHeader", completedCond, null, null, null, false)?.size() ?: 0

        // Combine into a single list for UI or API response
        def workOrderCounts = [
            [label: "Total Work Orders", value: totalCount],
            [label: "Created", value: createdCount],
            [label: "Approved", value: approvedCount],
            [label: "Completed", value: completedCount]
        ]

        resultMap = [success: true, workOrderCountList: workOrderCounts]
    } catch (GenericEntityException e) {
        Debug.logError(e, "Error fetching work order counts", "ListWorkOrderValues")
        resultMap = ServiceUtil.returnError("Error fetching work order counts: ${e.message}")
    }

    return resultMap
}
