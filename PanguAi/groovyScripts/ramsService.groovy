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
import org.apache.ofbiz.entity.condition.EntityOperator
import org.apache.ofbiz.entity.condition.EntityCondition
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
import java.util.Calendar
import java.sql.Date
def createRam(){
    List<Map<String, Object>> ramsDetails = parameters.ramsDetail
        
        
    logInfo('Uploaded file found; processing sub-content'+ramsDetails)
    def ramsNo=ramsDetails[-1].ramsNumber
    Map<String,Object> newHeader =[
        ramsNo:ramsDetails[-1].ramsNumber,
        revision:ramsDetails[-1].revision,
        productCode:ramsDetails[-1].productCode,
        system:ramsDetails[-1].system ,
        subsystem:ramsDetails[-1].subSystem ,
        subsubsystem:ramsDetails[-1].subSubSystem,
        rams:ramsDetails[-1].ramsResponsibility,
        date:ramsDetails[-1].date ,
        team:ramsDetails[-1].teamMembers,
        approver:ramsDetails[-1].approvedBy,
    ]
    delegator.create("ramsheader",newHeader)
    (0..<ramsDetails.size()-1).each{ i ->
        def rams = ramsDetails[i]
        def genId = delegator.getNextSeqId("ramsDataNew")
        Map<String ,Object> mainReportDetails=[
            genId:genId,
            ramsNo:ramsNo,
            calculatorType:rams.name,
            int1:rams.int1,
            int2:rams.int2,
            int3:rams.int3,
            out1:rams.out1,
            out2:rams.out2,
            out3:rams.out3,
            out4:rams.out4,
            out5:rams.out5,
            out6:rams.out6,
        ]
    delegator.create("ramsDataNew",mainReportDetails)
    logInfo('Uploaded file found; processing sub-content'+mainReportDetails)
    }
    
        
}

if(parameters.approver == 'update'){
if(parameters.system || parameters.subSystem||parameters.subSubSystem||parameters.ramsno||parameters.date_fld0_value){
    def conditions = []

        if (parameters.system) {
            conditions << EntityCondition.makeCondition("system", EntityOperator.LIKE,"%" + parameters.system+ "%")
        }
        if (parameters.subSystem) {
            conditions << EntityCondition.makeCondition("subsystem", EntityOperator.LIKE,"%" + parameters.subSystem+ "%")
        }
        if (parameters.subSubSystem) {
            conditions << EntityCondition.makeCondition("subsubsystem", EntityOperator.LIKE,"%" + parameters.subSubSystem+ "%")
        }
        if (parameters.ramsno) {
            conditions << EntityCondition.makeCondition("ramsNo", EntityOperator.LIKE, "%" + parameters.ramsno + "%")
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
    def query = from("ramsheader")
    if (condition != null) {
        query = query.where(condition)
    }
    def ramsList = query.queryList()
    context.ramsList = ramsList
    logInfo("It will run on the condition" +ramsList )
}
else{
    def query = from("ramsheader")
    def ramsList = query.queryList()
    context.ramsList = ramsList
    logInfo("It will run out of condition")
}
}

def findRams(){
    Map result = success()
    ramsNo=parameters.ramsNo
    ramsHeader=from('ramsheader').where('ramsNo',ramsNo).queryOne()
    ramsDetails=from('ramsDataNew').where('ramsNo',ramsNo).queryList()
    logInfo('header' + ramsHeader)
    logInfo('details' + ramsDetails)
    context.ramsNO=ramsNo
    result.successMessage = UtilProperties.getMessage("PanguAiUiLabels", "delete", parameters.locale)
    ramsDetails.each { it.remove() }
    ramsHeader.remove()
    return result
}