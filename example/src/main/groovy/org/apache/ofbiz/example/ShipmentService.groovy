import org.apache.ofbiz.entity.DelegatorFactory
import org.apache.ofbiz.entity.condition.EntityCondition
import org.apache.ofbiz.entity.condition.EntityOperator
import org.apache.ofbiz.entity.util.EntityFindOptions
import org.apache.ofbiz.service.ServiceUtil
import org.apache.ofbiz.base.util.Debug
import java.sql.Timestamp
import java.util.Calendar

def listShipmentData(Map context) {
    def result = ServiceUtil.returnSuccess()
    def delegator = context?.delegator ?: DelegatorFactory.getDelegator("default")

    try {
        // Params
        def params = context?.parameters ?: [:]
        def page = (context?.page ?: params.page ?: "1").toInteger()
        def itemsPerPage = (context?.itemsPerPage ?: params.itemsPerPage ?: "10").toInteger()
        def searchTerm = (context?.searchTerm ?: params.searchTerm ?: "").toString().trim()
        def monthStr = (context?.month ?: params.month ?: "").toString().trim()

        Debug.logInfo("📥 Params -> page=${page}, itemsPerPage=${itemsPerPage}, search=${searchTerm}, month=${monthStr}", "ShipmentService")

        // Base condition: optional filtering
        def conditions = []

        if (searchTerm) {
            conditions.add(EntityCondition.makeCondition("shipmentId", EntityOperator.LIKE, "%${searchTerm.toUpperCase()}%"))
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

                    conditions.add(EntityCondition.makeCondition("lastUpdatedStamp", EntityOperator.GREATER_THAN_EQUAL_TO, new Timestamp(calStart.getTimeInMillis())))
                    conditions.add(EntityCondition.makeCondition("lastUpdatedStamp", EntityOperator.LESS_THAN_EQUAL_TO, new Timestamp(calEnd.getTimeInMillis())))
                }
            } catch (Exception ex) {
                Debug.logError(ex, "❌ Invalid month format: ${monthStr}", "ShipmentService")
            }
        }

        def condition = conditions ? EntityCondition.makeCondition(conditions, EntityOperator.AND) : null

        // Pagination
        def lowIndex = (page - 1) * itemsPerPage
        def findOptions = new EntityFindOptions()
        findOptions.setLimit(itemsPerPage)
        findOptions.setOffset(lowIndex)

        // Fetch Shipment records
        def shipments = delegator.findList(
            "Shipment",
            condition,
            ["shipmentId", "lastUpdatedStamp", "primaryOrderId"] as Set,
            null,
            findOptions,
            false
        )

        def totalRecords = delegator.findCountByCondition("Shipment", condition, null, null)

        // Prepare result list
        def shipmentList = shipments.collect { sh ->
            def primaryOrderId = sh.getString("primaryOrderId")

            // Fetch estimated delivery date from OrderHeaderAndItems (only ORDER_COMPLETED)
            def estimatedDeliveryDate = "N/A"
            if (primaryOrderId) {
                def orderList = delegator.findByAnd("OrderHeaderAndItems", [orderId: primaryOrderId, orderStatusId: "ORDER_COMPLETED"], null, false)
                if (orderList && orderList.size() > 0) {
                    estimatedDeliveryDate = orderList[0].getTimestamp("estimatedDeliveryDate")?.toString() ?: "N/A"
                } else {
                    // Skip shipment if order is not completed
                    return null
                }
            }

            [
                shipmentId          : sh.getString("shipmentId"),
                lastUpdatedStamp    : sh.getTimestamp("lastUpdatedStamp")?.toString(),
                primaryOrderId      : primaryOrderId ?: "N/A",
                estimatedDeliveryDate: estimatedDeliveryDate
            ]
        }.findAll { it != null } // remove nulls (shipments whose order is not completed)

        result.shipmentList = shipmentList
        result.totalRecords = shipmentList.size()
        result.currentPage = page
        result.itemsPerPage = itemsPerPage

        Debug.logInfo("✅ Sent ${shipmentList.size()} shipment records for ORDER_COMPLETED orders.", "ShipmentService")

    } catch (Exception e) {
        Debug.logError(e, "❌ Error in listShipmentData", "ShipmentService")
        return ServiceUtil.returnError("Failed to fetch shipment data: ${e.message}")
    }

    return result
}
