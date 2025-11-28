
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

if(parameters.approver == 'update'){
if(parameters.docId || parameters.revision||parameters.approve||parameters.previewer||parameters.date_fld0_value || parameters.prepared || parameters.typer){
    def conditions = []

        if (parameters.revision) {
            conditions << EntityCondition.makeCondition("system", EntityOperator.LIKE,"%" + parameters.revision+ "%")
        }
        if (parameters.approve) {
            conditions << EntityCondition.makeCondition("subsystem", EntityOperator.LIKE,"%" + parameters.approve+ "%")
        }
        if (parameters.previewer) {
            conditions << EntityCondition.makeCondition("subsubsystem", EntityOperator.LIKE,"%" + parameters.previewer+ "%")
        }
        if (parameters.docId) {
            conditions << EntityCondition.makeCondition("docId", EntityOperator.LIKE, "%" + parameters.docId + "%")
        }
        if (parameters.prepared) {
            conditions << EntityCondition.makeCondition("prepared", EntityOperator.LIKE, "%" + parameters.prepared + "%")
        }
        if(parameters.typer){
            conditions << EntityCondition.makeCondition("typeHeader", EntityOperator.LIKE, "%" + parameters.typer + "%")
        }
        if (parameters.date_fld0_value) {
            try {
                def sdf = new SimpleDateFormat("yyyy-MM-dd")
                sdf.setLenient(false) // enforce strict format parsing
                def utilDate = sdf.parse(parameters.date_fld0_value.trim())
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

        if (conditions) {
            condition = EntityCondition.makeCondition(conditions, EntityOperator.AND)
    }

// Now query only with .where(condition) if condition is not null:

    def query = from("ControlMatrix")
    if (condition != null) {
        query = query.where(condition)
    }
    def ramsList = query.queryList()
    context.ramsList = ramsList
    logInfo("It will run on the condition" +ramsList )
}
else{
    def query = from("ChangeMatrixData")
    def ramsList = query.queryList()
    context.ramsList = ramsList
    logInfo("It will run out of condition")
}
}

if(parameters.docId && parameters.printdoc){
    fematitle=from( 'ControlMatrix').where('docId',parameters.docId).queryOne()
    context.date=fematitle.date
    logInfo("Work 2")
    logInfo("dt"+ context.date)
    context.ramsOutputTitle=fematitle
    femaDetail=from('ChangeMatrixData').where('docId',parameters.docId).queryList()
    logInfo("dt"+ femaDetail)
    context.ramsOutputDetails=femaDetail
    context.printdoc=fematitle.date
}
if(parameters.docId && parameters.create){
    fematitle=from( 'ControlMatrix').where('docId',parameters.docId).queryOne()
    logInfo("Work 1")
    logInfo("dt"+ context.date)
    context.ramsOutputTitle=fematitle
    femaDetail=from('ChangeMatrixData').where('docId',parameters.docId).queryList()
    context.ramsOutputDetails=femaDetail
    logInfo('It is working Fine' + fematitle)
    logInfo('It is working Fine' + femaDetail)
}