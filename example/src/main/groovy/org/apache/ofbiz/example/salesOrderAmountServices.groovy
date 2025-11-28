import org.apache.ofbiz.base.util.Debug
import org.apache.ofbiz.entity.DelegatorFactory
import org.apache.ofbiz.entity.condition.EntityCondition
import org.apache.ofbiz.entity.condition.EntityOperator
import org.apache.ofbiz.service.ServiceUtil

import java.math.BigDecimal
import java.time.ZoneId
import java.time.format.DateTimeFormatter

def ListMonthlySalesOrderTotals() {
    def delegator = DelegatorFactory.getDelegator("default")

    try {
        def condition = EntityCondition.makeCondition("orderTypeId", EntityOperator.EQUALS, "SALES_ORDER")
        def orders = delegator.findList("OrderHeader", condition, null, null, null, false)

        // Store month summary: {month: [count, total]}
        Map<String, Map> monthSummary = [:]

        orders?.each { order ->
            def created = order.getTimestamp("createdStamp")
            if (created) {
                def monthKey = created.toInstant()
                        .atZone(ZoneId.systemDefault())
                        .format(DateTimeFormatter.ofPattern("yyyy-MMM"))

                BigDecimal amount = order.getBigDecimal("grandTotal") ?: BigDecimal.ZERO

                if (!monthSummary.containsKey(monthKey)) {
                    monthSummary[monthKey] = [orderCount: 0, totalAmount: BigDecimal.ZERO]
                }

                monthSummary[monthKey].orderCount += 1
                monthSummary[monthKey].totalAmount = monthSummary[monthKey].totalAmount.add(amount)
            }
        }

        def resultList = monthSummary.collect { month, info ->
            [
                month: month,
                orderCount: info.orderCount,
                totalAmount: info.totalAmount
            ]
        }.sort { it.month }

        def result = ServiceUtil.returnSuccess()
        result.monthlySalesTotalList = resultList
        return result

    } catch (Exception e) {
        Debug.logError(e, "Error in ListMonthlySalesOrderTotals", "ListMonthlySalesOrderTotals")
        return ServiceUtil.returnError("Error fetching monthly Sales Order totals: ${e.message}")
    }
}
