import org.apache.ofbiz.entity.DelegatorFactory
import org.apache.ofbiz.entity.condition.EntityCondition
import org.apache.ofbiz.service.ServiceUtil
import org.apache.ofbiz.base.util.Debug
import java.text.SimpleDateFormat
import java.util.Calendar

def monthlyPaidSalesInvoices() {
    def delegator = DelegatorFactory.getDelegator("default")

    try {
        // Condition: SALES_INVOICE and INVOICE_PAID
        def conditions = EntityCondition.makeCondition([
            invoiceTypeId: "SALES_INVOICE",
            statusId: "INVOICE_PAID"
        ])

        // Fetch invoices
        def invoices = delegator.findList("Invoice", conditions, null, null, null, false)

        // Prepare monthly aggregation map
        def monthFormat = new SimpleDateFormat("yyyy-MM")
        def currentYear = Calendar.getInstance().get(Calendar.YEAR)
        def monthlyMap = [:].withDefault { [count: 0, invoices: []] }

        invoices.each { inv ->
            def invoiceDate = inv.getTimestamp("invoiceDate")
            if(invoiceDate) {
                def cal = Calendar.getInstance()
                cal.setTime(invoiceDate)
                if(cal.get(Calendar.YEAR) == currentYear) {  // Only current year
                    def monthKey = monthFormat.format(invoiceDate)
                    monthlyMap[monthKey].count += 1
                    monthlyMap[monthKey].invoices << [
                        invoiceId: inv.getString("invoiceId"),
                        invoiceTypeId: inv.getString("invoiceTypeId"),
                        statusId: inv.getString("statusId"),
                        invoiceDate: invoiceDate.toString()
                    ]
                }
            }
        }

        // Convert to list sorted by month
        def monthlyList = monthlyMap.collect { month, data ->
            [
                month: month,
                totalInvoices: data.count,
                invoices: data.invoices
            ]
        }.sort { it.month }

        def result = ServiceUtil.returnSuccess()
        result.monthlyInvoiceList = monthlyList
        return result

    } catch (Exception e) {
        Debug.logError(e, "Error fetching monthly paid sales invoices", "monthlyPaidSalesInvoices")
        return ServiceUtil.returnError("Error fetching invoices: ${e.message}")
    }
}
