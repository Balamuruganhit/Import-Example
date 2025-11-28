import org.apache.ofbiz.base.util.Debug
import org.apache.ofbiz.entity.DelegatorFactory
import org.apache.ofbiz.service.ServiceUtil

def Top5FailuresByComplaint() {
    def delegator = DelegatorFactory.getDelegator("default")

    try {
        def complaints = delegator.findList("RootCauseAnalysisTable", null, null, null, null, false)

        def grouped = complaints.groupBy { it.getString("failureType") }
                .collectEntries { failure, records ->
                    [
                        (failure): [
                            total   : records.size(),
                            numbers : records.collect {
                                it.getString("complaintNo")
                            }.findAll { it },
                            dates   : records.collect {
                                def dateVal = it.get("complaintDate")  // FIXED
                                return dateVal ? dateVal.toString() : null
                            }.findAll { it }
                        ]
                    ]
                }

        def topFailures = grouped.entrySet()
                .sort { -it.value.total }
                .take(5)

        def resultList = topFailures.collect { entry ->
            [
                failureType     : entry.key,
                totalComplaints : entry.value.total,
                complaintNos    : entry.value.numbers,
                complaintDates  : entry.value.dates
            ]
        }

        def result = ServiceUtil.returnSuccess()
        result.failureComplaintList = resultList
        return result

    } catch (Exception e) {
        Debug.logError(e, "Error fetching Top 5 Failures/Complaints", "Top5FailuresByComplaint")
        return ServiceUtil.returnError("Error fetching Top 5 Failures/Complaints: ${e.message}")
    }
}
