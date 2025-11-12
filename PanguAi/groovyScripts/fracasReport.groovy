import org.apache.ofbiz.base.util.UtilDateTime
import org.apache.ofbiz.base.util.UtilProperties
import org.apache.ofbiz.entity.condition.EntityCondition
import org.apache.ofbiz.entity.condition.EntityOperator
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

if(parameters.approver == 'updateMulti'){
if(parameters.toDate && parameters.fromDate){
    def conditions = []
    def condition=null
           
            try {
                def sdf = new SimpleDateFormat("yyyy-MM-dd")
                sdf.setLenient(false) // enforce strict format parsing
                def utilDate = sdf.parse(parameters.fromDate.trim())
                def startTimestamp = new Timestamp(utilDate.getTime())
                def utilEndDate = sdf.parse(parameters.toDate.trim())
                def endTimestamp = new Timestamp(utilEndDate.getTime())

                logInfo("Searching between: ${startTimestamp} and ${endTimestamp}")
                
                // Add to query condition
                conditions << EntityCondition.makeCondition([
                    EntityCondition.makeCondition("lastUpdatedStamp", EntityOperator.GREATER_THAN_EQUAL_TO, startTimestamp),
                    EntityCondition.makeCondition("lastUpdatedStamp", EntityOperator.LESS_THAN, endTimestamp)
                ], EntityOperator.AND)
            } catch (Exception e) {
                logError("Failed to parse date_fld0_value: ${parameters.fromDate}, Error: ${e.message}")
            }
        if (conditions) {
            condition = EntityCondition.makeCondition(conditions, EntityOperator.AND)
    }

// Now query only with .where(condition) if condition is not null:
    logInfo("It will run on the condition 1")
    def query = from("fracasDetails")
    if (condition != null) {
        query = query.where(condition)
    }
    def ramsList = query.queryList()
    FracasCalulation(ramsList)
}
else{
    def query = from("fracasDetails")
    def ramsList = query.queryList()
    FracasCalulation(ramsList)
    logInfo("It will run out of condition 5")
}
}



if(parameters.approver == 'update'){
if(parameters.system || parameters.subSystem||parameters.subSubSystem||parameters.partNumber||parameters.startWarrantyDate || parameters.prototype||parameters.fromDate){
    def conditions = []
    def condition=null

        if (parameters.system) {
            conditions << EntityCondition.makeCondition("system", EntityOperator.LIKE,"%" + parameters.system+ "%")
        }
        if (parameters.subSystem) {
            conditions << EntityCondition.makeCondition("subsystem", EntityOperator.LIKE,"%" + parameters.subSystem+ "%")
        }
        if (parameters.subSubSystem) {
            conditions << EntityCondition.makeCondition("subsubsystem", EntityOperator.LIKE,"%" + parameters.subSubSystem+ "%")
        }
        if (parameters.partNumber) {
            conditions << EntityCondition.makeCondition("partNumber", EntityOperator.LIKE, "%" + parameters.partNumber + "%")
        }
        // if (parameters.prototype) {
        //     conditions << EntityCondition.makeCondition("prototype", EntityOperator.LIKE, "%" + parameters.prototype + "%")
        // }
         
        if (parameters.startWarrantyDate) {
            try {
                def sdf = new SimpleDateFormat("yyyy-MM-dd")
                sdf.setLenient(false) // enforce strict format parsing
                def utilDate = sdf.parse(parameters.startWarrantyDate.trim())
                def startTimestamp = new Timestamp(utilDate.getTime())
                Calendar cal = Calendar.getInstance()
                cal.setTime(utilDate)
                cal.add(Calendar.DAY_OF_MONTH, 1)
                def endTimestamp = new Timestamp(cal.getTimeInMillis())

                logInfo("Searching between: ${startTimestamp} and ${endTimestamp}")
                
                // Add to query condition
                conditions << EntityCondition.makeCondition([
                    EntityCondition.makeCondition("startWarranty", EntityOperator.GREATER_THAN_EQUAL_TO, startTimestamp),
                    EntityCondition.makeCondition("endWarranty", EntityOperator.LESS_THAN, endTimestamp)
                ], EntityOperator.AND)
            } catch (Exception e) {
                logError("Failed to parse date_fld0_value: ${parameters.date_fld0_value}, Error: ${e.message}")
            }
            if (parameters.fromDate) {
            try {
                def sdf = new SimpleDateFormat("yyyy-MM-dd")
                sdf.setLenient(false) // enforce strict format parsing
                def utilDate = sdf.parse(parameters.fromDate.trim())
                def startTimestamp = new Timestamp(utilDate.getTime())
                Calendar cal = Calendar.getInstance()
                cal.setTime(utilDate)
                cal.add(Calendar.DAY_OF_MONTH, 1)
                def endTimestamp = new Timestamp(cal.getTimeInMillis())

                logInfo("Searching between: ${startTimestamp} and ${endTimestamp}")
                
                // Add to query condition
                conditions << EntityCondition.makeCondition([
                    EntityCondition.makeCondition("lastUpdatedStamp", EntityOperator.GREATER_THAN_EQUAL_TO, startTimestamp),
                    EntityCondition.makeCondition("lastUpdatedStamp", EntityOperator.LESS_THAN, endTimestamp)
                ], EntityOperator.AND)
            } catch (Exception e) {
                logError("Failed to parse date_fld0_value: ${parameters.date_fld0_value}, Error: ${e.message}")
            }
        }
        }

        if (conditions) {
            condition = EntityCondition.makeCondition(conditions, EntityOperator.AND)
    }

// Now query only with .where(condition) if condition is not null:
    logInfo("It will run on the condition 1")
    def query = from("fracasDetails")
    if (condition != null) {
        query = query.where(condition)
    }
    def ramsList = query.queryList()
    FracasCalulation(ramsList)
}
else{
    def query = from("fracasDetails")
    def ramsList = query.queryList()
    FracasCalulation(ramsList)
    logInfo("It will run out of condition 5")
}
}


fracasNo=parameters.reportNumber
logInfo("report no"+fracasNo)
if(fracasNo){
    fematitle=from( 'fracasDetails').where('complaintNumber',fracasNo).queryOne()
    context.fracasReport=fematitle
    logInfo('It is working Fine' + fematitle)
}
logInfo('it is working fracasreport')

def FracasCalulation(List ramsList){
    def i=0
    def combinedRamsData = []
    logInfo("It will run on the condition 2")
    ramsList.each{data ->
            if(data.complaintNumber)
                { //Eliminate the the Dummy Value
                    def sdf = new SimpleDateFormat("yyyy-MM-dd")
                    logInfo("It will run on the condition 3")
                    def complaintDateStr = data.getString("complaintDate")
                    def complaintDateStrEnd=null
                    if(i==0){
                        complaintDateStrEnd = ramsList[i].getString("complaintDate")
                    }else{
                        complaintDateStrEnd = ramsList[i-1].getString("complaintDate")
                        // Parse the strings into Date objects
                    }
                    logInfo("It will run on the condition test" + data.complaintNumber)
                    def startDate = sdf.parse(complaintDateStr)
                    def endDate = sdf.parse(complaintDateStrEnd)
                    logInfo("Start" +startDate)
                    logInfo("End" +endDate)
                    logInfo("It will run on the condition test pre")
                    // Calculate the difference in milliseconds
                    def diffInMillis = endDate.time - startDate.time
                    logInfo("It will run on the condition test pre" +diffInMillis)
                    logInfo("It will run on the condition test2")
                    // Convert to days
                    def diffInDays = diffInMillis / (1000 * 60 * 60 * 24)
                    logInfo("End" +diffInDays)
                    finalOut=Math.abs(diffInDays * 24)
                    logInfo("End" +finalOut)
                    logInfo("It will run on the condition test1")
                    data.set("revision",finalOut)
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
                    combinedRamsData.add(data)
                }
        }
    context.ramsList = combinedRamsData
    logInfo("It will run on the condition 5" +ramsList )
}