import org.apache.ofbiz.entity.DelegatorFactory
import org.apache.ofbiz.entity.condition.EntityCondition
import org.apache.ofbiz.entity.condition.EntityOperator
import org.apache.ofbiz.entity.util.EntityFindOptions
import org.apache.ofbiz.service.ServiceUtil
import org.apache.ofbiz.base.util.Debug

def listQuantityProducedData(Map context) {
    def result = ServiceUtil.returnSuccess()
    def delegator = context?.delegator ?: DelegatorFactory.getDelegator("default")

    try {
        // ✅ Safely extract params (handle null context)
        def params = context?.parameters ?: [:]
        def pageStr = context?.page ?: params.page ?: "1"
        def itemsStr = context?.itemsPerPage ?: params.itemsPerPage ?: "10"
        def searchTerm = (context?.searchTerm ?: params.searchTerm ?: "").toString().trim()

        def page = pageStr.isInteger() ? pageStr.toInteger() : 1
        def itemsPerPage = itemsStr.isInteger() ? itemsStr.toInteger() : 10

        Debug.logInfo("📥 Params -> page=${page}, itemsPerPage=${itemsPerPage}, search=${searchTerm}", "WorkEffortStatsServices")

        // ✅ Build base condition
        def conditions = [
            EntityCondition.makeCondition("workEffortTypeId", EntityOperator.EQUALS, "PROD_ORDER_TASK"),
            EntityCondition.makeCondition("currentStatusId", EntityOperator.EQUALS, "PRUN_CLOSED")
        ]

        if (searchTerm) {
            def likeCond = EntityCondition.makeCondition("workEffortId", EntityOperator.LIKE, "%${searchTerm.toUpperCase()}%")
            conditions.add(likeCond)
        }

        def condition = EntityCondition.makeCondition(conditions, EntityOperator.AND)

        // ✅ Pagination setup
        def viewIndex = Math.max(page - 1, 0)
        def lowIndex = viewIndex * itemsPerPage
        def findOptions = new EntityFindOptions()
        findOptions.setLimit(itemsPerPage)
        findOptions.setOffset(lowIndex)

        // ✅ Fetch paginated list
        def workEfforts = delegator.findList(
            "WorkEffort",
            condition,
            ["workEffortId", "workEffortParentId", "quantityToProduce", "quantityProduced"] as Set,
            null,
            findOptions,
            false
        )

        def totalRecords = delegator.findCountByCondition("WorkEffort", condition, null, null)

        // ✅ Transform data
        def workEffortList = workEfforts.collect { we ->
            [
                workEffortId      : we.getString("workEffortParentId") ?: we.getString("workEffortId"),
                quantityToProduce : (we.getBigDecimal("quantityToProduce") ?: 0).toString(),
                quantityProduced  : (we.getBigDecimal("quantityProduced") ?: 0).toString()
            ]
        }

        // ✅ Assign both top-level and nested return values
        result.workEffortList = workEffortList
        result.totalRecords = totalRecords
        result.currentPage = page
        result.itemsPerPage = itemsPerPage

        Debug.logInfo("✅ Sent ${workEffortList.size()} records back to client.", "WorkEffortStatsServices")

    } catch (Exception e) {
        Debug.logError(e, "❌ Error in listQuantityProducedData", "WorkEffortStatsServices")
        return ServiceUtil.returnError("Failed to fetch data: ${e.message}")
    }

    return result
}
