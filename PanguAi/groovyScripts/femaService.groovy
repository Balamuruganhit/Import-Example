/*
* Licensed to the Apache Software Foundation (ASF) under one
* or more contributor license agreements.  See the NOTICE file
* distributed with this work for additional information
* regarding copyright ownership.  The ASF licenses this file
* to you under the Apache License, Version 2.0 (the
* "License"); you may not use this file except in compliance
* with the License.  You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing,
* software distributed under the License is distributed on an
* "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
* KIND, either express or implied.  See the License for the
* specific language governing permissions and limitations
* under the License.
*/

import org.apache.ofbiz.base.util.UtilDateTime
import org.apache.ofbiz.base.util.UtilProperties
import org.apache.ofbiz.base.util.UtilValidate
import org.apache.ofbiz.entity.condition.EntityConditionBuilder
import org.apache.ofbiz.entity.GenericValue
import org.apache.ofbiz.entity.condition.EntityOperator
import org.apache.ofbiz.entity.condition.EntityCondition
import org.apache.ofbiz.entity.serialize.XmlSerializer
import org.apache.ofbiz.product.product.KeywordIndex
import org.apache.ofbiz.product.product.ProductWorker
import org.apache.ofbiz.service.*
import org.apache.ofbiz.base.util.*
import org.apache.ofbiz.entity.*
import java.sql.Timestamp
import java.util.List
import java.text.SimpleDateFormat
import java.util.Calendar
import java.sql.Date

def createFemaReport(){
    try {
     List<Map<String, Object>> femaDetails = parameters.femaDetails
    
    logInfo('Uploaded file found; processing sub-content'+femaDetails)
     
        String femaId = femaDetails[0].dfema
        String drawing = femaDetails[0].drawing
        String part = femaDetails[0].part
        String rev = femaDetails[0].rev
        String comp =femaDetails[0].comp
        String design = femaDetails[0].design
        String prepare = femaDetails[0].prepare
        String team = femaDetails[0].team
        String date= femaDetails[0].date
        Map<String, Object> newReport = [
                femaId : femaId,
                drawing : drawing,
                part : part,
                rev : rev,
                comp : comp,
                design : design,
                prepareField : prepare,
                team : team,
                femaDate : date,
             
            ]
            delegator.create("FemaTitleDetail", newReport)
    if (femaDetails.size() > 1) {
            (1..<femaDetails.size()).each { i ->
                def fematable = femaDetails[i]
                if (fematable != null && fematable instanceof Map) {
                    def genId = delegator.getNextSeqId("FemaTableDetail")
                    Map<String, Object> newTable = [
                        genId: genId,
                        femaId: femaId,
                        item: fematable.item,
                        functionPart: fematable.function,
                        feverity: fematable.achieve,
                        failureMode: fematable.FailureMode,
                        potentialEffects: fematable.PotentialEffects,
                        severity: fematable.Severity,
                        potentialCause: fematable.PotentialCause,
                        occurrence: fematable.Occurrence,
                        designControl: fematable.DesignControl,
                        detectionControl  :fematable.DetectionControl,
                        detection: fematable.Detection,
                        rPN: fematable.RPN,
                        action: fematable.Action,
                        responsibility: fematable.Responsibility,
                        actionTaken: fematable.ActionTaken,
                        severity1: fematable.Severity1,
                        occurrence1: fematable.Occurrence1,
                        detection1: fematable.Detection1,
                        rPN1: fematable.RPN1
                    ]

                    delegator.create("FemaTableDetail", newTable)
                }
            }
        }
    return success("Report details stored successfully.")
    } catch (Exception e) {
        logError("Error storing report details: ${e.message}")
        return error("Failed to store report details: ${e.message}")
    }

}

if(parameters.approver == 'update'){
if(parameters.part || parameters.comp||parameters.femaId||parameters.prepareField||parameters.date_fld0_value|| parameters.design){
    def conditions = []

        if (parameters.part) {
            conditions << EntityCondition.makeCondition("part", EntityOperator.LIKE,"%" + parameters.part+ "%")
        }
        if (parameters.comp) {
            conditions << EntityCondition.makeCondition("comp", EntityOperator.LIKE,"%" + parameters.comp+ "%")
        }
        if (parameters.prepareField) {
            conditions << EntityCondition.makeCondition("prepareField", EntityOperator.LIKE,"%" + parameters.prepareField+ "%")
        }
        if (parameters.femaId) {
            conditions << EntityCondition.makeCondition("femaId", EntityOperator.LIKE, "%" + parameters.femaId + "%")
        }
        if (parameters.design) {
            conditions << EntityCondition.makeCondition("design", EntityOperator.LIKE, "%" + parameters.design + "%")
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
    def query = from("FemaTitleDetail")
    if (condition != null) {
        query = query.where(condition)
    }
    def femaList = query.queryList()
    context.femaList = femaList
    logInfo("It will run on the condition" +femaList )
}
else{
    def query = from("FemaTitleDetail")
    def femaList = query.queryList()
    context.femaList = femaList
    logInfo("It will run out of condition")
}
}