import org.apache.ofbiz.entity.DelegatorFactory
import org.apache.ofbiz.entity.condition.EntityCondition
import org.apache.ofbiz.entity.condition.EntityOperator
import org.apache.ofbiz.entity.util.EntityFindOptions
import org.apache.ofbiz.service.ServiceUtil
import org.apache.ofbiz.base.util.Debug
import java.sql.Timestamp
import java.util.Calendar

def listQuantityProducedData(Map context) {
    def result = ServiceUtil.returnSuccess()
    def delegator = context?.delegator ?: DelegatorFactory.getDelegator("default")

    try {
        // Params
        def params = context?.parameters ?: [:]
        def page = (context?.page ?: params.page ?: "1").toInteger()
        def itemsPerPage = (context?.itemsPerPage ?: params.itemsPerPage ?: "10").toInteger()
        def searchTerm = (context?.searchTerm ?: params.searchTerm ?: "").toString().trim()
        def monthStr = (context?.month ?: params.month ?: "").toString().trim()

        Debug.logInfo("📥 Params -> page=${page}, itemsPerPage=${itemsPerPage}, search=${searchTerm}, month=${monthStr}", "WorkEffortStatsServices")

        // Base condition: PROD_ORDER_TASK and closed
        def conditions = [
            EntityCondition.makeCondition("workEffortTypeId", EntityOperator.EQUALS, "PROD_ORDER_HEADER"),
            EntityCondition.makeCondition("currentStatusId", EntityOperator.EQUALS, "PRUN_CREATED")
        ]

        if (searchTerm) {
            conditions.add(EntityCondition.makeCondition("workEffortId", EntityOperator.LIKE, "%${searchTerm.toUpperCase()}%"))
        }

        if (monthStr) {
            try {
                def parts = monthStr.split("-")
                if (parts.length == 2) {
                    int year = parts[0].toInteger()
                    int month = parts[1].toInteger() - 1
                    Calendar calStart = Calendar.getInstance()
                    calStart.set(year, month, 1, 0, 0, 0)
                    calStart.set(Calendar.MILLISECOND, 0)
                    Calendar calEnd = Calendar.getInstance()
                    calEnd.set(year, month, calStart.getActualMaximum(Calendar.DAY_OF_MONTH), 23, 59, 59)
                    calEnd.set(Calendar.MILLISECOND, 999)

                    conditions.add(EntityCondition.makeCondition("createdStamp", EntityOperator.GREATER_THAN_EQUAL_TO, new Timestamp(calStart.getTimeInMillis())))
                    conditions.add(EntityCondition.makeCondition("createdStamp", EntityOperator.LESS_THAN_EQUAL_TO, new Timestamp(calEnd.getTimeInMillis())))
                }
            } catch (Exception ex) {
                Debug.logError(ex, "❌ Invalid month format: ${monthStr}", "WorkEffortStatsServices")
            }
        }

        def condition = EntityCondition.makeCondition(conditions, EntityOperator.AND)

        // Pagination
        def lowIndex = (page - 1) * itemsPerPage
        def findOptions = new EntityFindOptions()
        findOptions.setLimit(itemsPerPage)
        findOptions.setOffset(lowIndex)

        // Fetch WorkEffort TASK records
        def workEfforts = delegator.findList(
            "WorkEffort",
            condition,
            ["workEffortId", "workEffortParentId", "quantityToProduce", "quantityProduced", "createdStamp"] as Set,
            null,
            findOptions,
            false
        )

        def totalRecords = delegator.findCountByCondition("WorkEffort", condition, null, null)

        // Prepare result list with product internal name and planned vs actual
        def workEffortList = workEfforts.collect { we ->
            // Fetch corresponding WorkEffortGoodStandard
            def wesList = delegator.findByAnd("WorkEffortGoodStandard", [workEffortId: we.workEffortId], null, false)
            def productId = wesList ? wesList[0].getString("productId") : null

            // Fetch product internal name
            def productInternalName = null
            if (productId) {
                def product = delegator.findOne("Product", [productId: productId], false)
                productInternalName = product ? product.getString("internalName") : "N/A"
            } else {
                productInternalName = "N/A"
            }

            // Fetch parent WorkEffort header for planned quantity
            def header = delegator.findOne("WorkEffort", [workEffortId: we.workEffortParentId], false)
            def plannedQty = header ? (header.getBigDecimal("quantityToProduce") ?: 0) : 0

            [ 
                productId        : productId,
                productName      : productInternalName,
                workEffortId     : we.getString("workEffortId"),    
                quantityPlanned  : (we.getBigDecimal("quantityToProduce") ?: 0).toString(),
                quantityActual   : (we.getBigDecimal("quantityProduced") ?: 0).toString(),
                createdStamp     : we.getTimestamp("createdStamp")?.toString()
            ]
        }

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



