
import org.apache.ofbiz.base.util.UtilDateTime
import org.apache.ofbiz.base.util.UtilProperties
import org.apache.ofbiz.base.util.UtilValidate
import org.apache.ofbiz.entity.condition.EntityConditionBuilder
import org.apache.ofbiz.entity.GenericValue
import org.apache.ofbiz.entity.serialize.XmlSerializer
import org.apache.ofbiz.product.product.KeywordIndex
import org.apache.ofbiz.product.product.ProductWorker
import org.apache.ofbiz.service.*
import org.apache.ofbiz.base.util.*
import org.apache.ofbiz.entity.*
import java.sql.Timestamp
import java.util.List
import java.text.SimpleDateFormat

def selectedRamsNoParam = parameters.fracasDetail
def selectedRamsList = selectedRamsNoParam ? selectedRamsNoParam.split(",") : []
logInfo('Data' + selectedRamsList)
def combinedRamsData = []
logInfo('it is working fracasreport')
selectedRamsList.each { ramsNo ->
    // Get the RAMS Header
    logInfo('it is working fracasreport')
    def ramsHeader = from("fracasDetails").where("reportNumber", ramsNo).queryOne()
// Combine into one object per RAMS NO
    combinedRamsData.add(ramsHeader)
}
logInfo('it is working fracasreport out')
def i=0
combinedRamsData.each{data ->
        if(data.complaintNumber)
                { //Eliminate the the Dummy Value
                def sdf = new SimpleDateFormat("yyyy-MM-dd")
                def complaintDateStr = data.getString("complaintDate")
                
                def complaintDateStrEnd=null
                if(i==0){
                    complaintDateStrEnd = combinedRamsData[i].getString("complaintDate")
                }else{
                complaintDateStrEnd = combinedRamsData[i-1].getString("complaintDate")
                // Parse the strings into Date objects
                }
                def startDate = sdf.parse(complaintDateStr)
                def endDate = sdf.parse(complaintDateStrEnd)
                
                // Calculate the difference in milliseconds
                def diffInMillis = endDate.time - startDate.time

                // Convert to days
                def diffInDays = diffInMillis / (1000 * 60 * 60 * 24)
                
                finalOut=Math.abs(diffInDays * 24)
                
                if(data.actualDate){//Run if the Actual date Found
                        def actualDateeStr = data.getString("actualDate")
                        endDate = sdf.parse(actualDateeStr)
                        diffInMillis = endDate.time - startDate.time
                        logInfo("It will run on the condition 4")
                        // Convert to days
                        diffInDays = diffInMillis / (1000 * 60 * 60 * 24)
                        
                        finalOut=Math.abs(diffInDays * 24)
                        data.set('prototype',finalOut)
                    }
                i++
            }
    
}
// Pass to frontend
context.combinedRamsData = combinedRamsData

logInfo("RAMS Combined Data: ${combinedRamsData}")