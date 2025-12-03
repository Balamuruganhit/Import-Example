import org.apache.ofbiz.entity.DelegatorFactory
import org.apache.ofbiz.service.ServiceUtil
import org.apache.ofbiz.base.util.Debug
import java.text.SimpleDateFormat
import java.util.Calendar

def monthlyQuantityOnHand() {
    def delegator = DelegatorFactory.getDelegator("default")

    try {
        // Fetch all inventory items
        def inventoryItems = delegator.findList("InventoryItem", null, null, null, null, false)

        def monthFormat = new SimpleDateFormat("MMM") // Jan, Feb, ...
        def calendar = Calendar.getInstance()
        def currentYear = calendar.get(Calendar.YEAR)
        def lastYear = currentYear - 1

        // Map: year -> month -> quantity
        def monthlyMap = [:].withDefault { [:].withDefault { 0 } }

        // Aggregate quantities
        inventoryItems.each { item ->
            def receiveStamp = item.getTimestamp("datetimeReceived")
            if (!receiveStamp) return

            calendar.setTime(receiveStamp)
            def yearVal = calendar.get(Calendar.YEAR)

            if (yearVal == currentYear || yearVal == lastYear) {
                def monthKey = monthFormat.format(receiveStamp)
                def qty = item.getBigDecimal("quantityOnHandTotal") ?: 0
                monthlyMap[yearVal][monthKey] += qty
            }
        }

        // Ensure all months exist
        def months = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
        [lastYear, currentYear].each { yr ->
            months.each { m ->
                monthlyMap[yr].putIfAbsent(m, 0)
            }
        }

        // Convert map to sorted list
        def monthlyList = []
        [lastYear, currentYear].each { yr ->
            months.each { m ->
                monthlyList << [
                    year: yr,
                    month: m,
                    totalQuantity: monthlyMap[yr][m]
                ]
            }
        }

        def result = ServiceUtil.returnSuccess()
        result.monthlyQohList = monthlyList
        return result

    } catch (Exception e) {
        Debug.logError(e, "Error fetching monthly quantity on hand", "monthlyQuantityOnHand")
        return ServiceUtil.returnError("Error fetching inventory quantities: ${e.message}")
    }
}
