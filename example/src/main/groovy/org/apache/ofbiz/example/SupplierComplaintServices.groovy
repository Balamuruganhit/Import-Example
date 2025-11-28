import org.apache.ofbiz.base.util.Debug
import org.apache.ofbiz.entity.DelegatorFactory
import org.apache.ofbiz.service.ServiceUtil

def Top5SuppliersByComplaint() {
    def delegator = DelegatorFactory.getDelegator("default")

    try {
        // Get all complaint records
        def complaints = delegator.findList("RootCauseAnalysisTable", null, null, null, null, false)

        // Group by supplierName and collect complaint numbers
        def grouped = complaints.groupBy { it.getString("supplierName") }
                                .collectEntries { supplier, records ->
                                    [
                                        (supplier): [
                                            total: records.size(),
                                            numbers: records.collect { it.getString("complaintNo") }.findAll { it }
                                        ]
                                    ]
                                }

        // Sort by total complaints DESC and take top 5
        def topSuppliers = grouped.entrySet()
                                  .sort { -it.value.total }
                                  .take(5)

        // Prepare the result list
        def resultList = topSuppliers.collect { entry ->
            [
                supplierName: entry.key,
                totalComplaints: entry.value.total,
                complaintNos: entry.value.numbers
            ]
        }

        def result = ServiceUtil.returnSuccess()
        result.supplierComplaintList = resultList
        return result

    } catch (Exception e) {
        Debug.logError(e, "Error fetching top 5 suppliers by complaint", "Top5SuppliersByComplaint")
        return ServiceUtil.returnError("Error fetching top 5 suppliers: ${e.message}")
    }
}
