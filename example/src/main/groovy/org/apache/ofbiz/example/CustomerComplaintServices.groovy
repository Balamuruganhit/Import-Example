import org.apache.ofbiz.base.util.Debug
import org.apache.ofbiz.entity.DelegatorFactory
import org.apache.ofbiz.service.ServiceUtil

def Top5CustomersByComplaint() {
    def delegator = DelegatorFactory.getDelegator("default")

    try {
        // Get all complaint records
        def complaints = delegator.findList("RootCauseAnalysisTable", null, null, null, null, false)

        // Group by customerName and collect complaint numbers
        def grouped = complaints.groupBy { it.getString("customerName") }
                                .collectEntries { customer, records ->
                                    [
                                        (customer): [
                                            total: records.size(),
                                            numbers: records.collect { it.getString("complaintNo") }.findAll { it }

                                        ]
                                    ]
                                }

        // Sort by total complaints DESC and take top 5
        def topCustomers = grouped.entrySet()
                                  .sort { -it.value.total }
                                  .take(5)

        // Prepare the output list
        def resultList = topCustomers.collect { entry ->
            [
                customerName: entry.key,
                totalComplaints: entry.value.total,
                complaintNos: entry.value.numbers
            ]
        }

        def result = ServiceUtil.returnSuccess()
        result.customerComplaintList = resultList
        return result

    } catch (Exception e) {
        Debug.logError(e, "Error fetching top 5 customers by complaint", "Top5CustomersByComplaint")
        return ServiceUtil.returnError("Error fetching top 5 customers: ${e.message}")
    }
}
