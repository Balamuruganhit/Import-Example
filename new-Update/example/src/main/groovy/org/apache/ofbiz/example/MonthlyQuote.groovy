import org.apache.ofbiz.base.util.Debug
import org.apache.ofbiz.entity.Delegator
import org.apache.ofbiz.entity.GenericEntityException
import org.apache.ofbiz.entity.condition.EntityCondition
import org.apache.ofbiz.entity.condition.EntityOperator
import org.apache.ofbiz.service.DispatchContext
import org.apache.ofbiz.service.ServiceUtil

def ListMonthlyQuotes() {
    Delegator delegator = dctx.getDelegator()
    def logModule = "ListMonthlyQuotes"

    try {
        def currentYear = java.time.Year.now().getValue()

        def allQuotes = delegator.findList("Quote", null, null, null, null, false)
        def orderedQuotes = delegator.findList("Quote",
            EntityCondition.makeCondition("statusId", EntityOperator.EQUALS, "QUO_ORDERED"),
            null, null, null, false)

        def totalCounts = (0..<12).collect { 0 }
        def orderedCounts = (0..<12).collect { 0 }

        allQuotes.each { quote ->
            def d = quote.getTimestamp("createdStamp")
            if (d && d.toLocalDateTime().getYear() == currentYear)
                totalCounts[d.toLocalDateTime().getMonthValue() - 1]++
        }

        orderedQuotes.each { quote ->
            def d = quote.getTimestamp("createdStamp")
            if (d && d.toLocalDateTime().getYear() == currentYear)
                orderedCounts[d.toLocalDateTime().getMonthValue() - 1]++
        }

        def monthNames = [
            "January", "February", "March", "April", "May", "June",
            "July", "August", "September", "October", "November", "December"
        ]

        def monthlyQuoteList = (0..<12).collect { i ->
            [
                label: monthNames[i],
                total: totalCounts[i],
                ordered: orderedCounts[i]
            ]
        }

        Debug.logInfo("Monthly quote data: ${monthlyQuoteList}", logModule)
        return [success: true, monthlyQuoteList: monthlyQuoteList]

    } catch (GenericEntityException e) {
        Debug.logError(e, "Error fetching monthly quotes", logModule)
        return ServiceUtil.returnError("Error fetching monthly quotes: ${e.message}")
    }
}
