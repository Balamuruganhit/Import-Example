import org.apache.ofbiz.entity.DelegatorFactory
import org.apache.ofbiz.service.ServiceUtil
import org.apache.ofbiz.base.util.Debug

def countFracasComplaints(Map context) {
    def result = ServiceUtil.returnSuccess()
    def delegator = context?.delegator ?: DelegatorFactory.getDelegator("default")

    try {
        // Count total complaints in fracasDetails
        def totalComplaints = delegator.findCountByCondition("fracasDetails", null, null, null)
        result.totalComplaints = totalComplaints

        Debug.logInfo("Total complaints: ${totalComplaints}", "FracasService")

    } catch (Exception e) {
        Debug.logError(e, " Error counting fracas complaints", "FracasService")
        return ServiceUtil.returnError("Failed to count fracas complaints: ${e.message}")
    }

    return result
}
