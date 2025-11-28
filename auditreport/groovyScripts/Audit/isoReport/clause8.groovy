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

def createDesignReport(){
    List<Map<String, Object>> partiesDetails = parameters.designsDetail
        
    logInfo('Uploaded file found; processing sub-content'+partiesDetails)
    def docId=partiesDetails[-1].docId
    Map<String,Object> newHeader =[
        docId:partiesDetails[-1].docId,
        revision:partiesDetails[-1].revision,
        date:partiesDetails[-1].saveDate,
        approve:partiesDetails[-1].approver ,
        previewer:partiesDetails[-1].previewer,
        prepared:partiesDetails[-1].preparer,
    ]
    delegator.create("DesignHeader",newHeader)
    (0..<partiesDetails.size()-1).each{ i ->
        def parties = partiesDetails[i]
   if (parties != null && parties instanceof Map) {
                    def genId = delegator.getNextSeqId("DesignDatas")
                    Map<String, Object> newTable = [
                        genId: genId,
                        docId: partiesDetails[-1].docId,
                        process:parties.process,
                        tools: parties.tools,
                        status: parties.status,
                        remark: parties.remarks
                    ]

                    delegator.create("DesignDatas", newTable)

    }}
}

if(parameters.approver == 'update'){
if(parameters.docId || parameters.revision||parameters.approve||parameters.previewer||parameters.date_fld0_value || parameters.prepared){
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
            conditions << EntityCondition.makeCondition("ramsNo", EntityOperator.LIKE, "%" + parameters.docId + "%")
        }
        if (parameters.prepared) {
            conditions << EntityCondition.makeCondition("ramsNo", EntityOperator.LIKE, "%" + parameters.prepared + "%")
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
    def query = from("DesignHeader")
    if (condition != null) {
        query = query.where(condition)
    }
    def ramsList = query.queryList()
    context.ramsList = ramsList
    logInfo("It will run on the condition" +ramsList )
}
else{
    def query = from("DesignHeader")
    def ramsList = query.queryList()
    context.ramsList = ramsList
    logInfo("It will run out of condition")
}
}

if(parameters.docId && parameters.printdoc){
    fematitle=from( 'DesignHeader').where('docId',parameters.docId).queryOne()
    context.date=fematitle.date
    logInfo("Work 2")
    logInfo("dt"+ context.date)
    context.ramsOutputTitle=fematitle
    femaDetail=from('DesignDatas').where('docId',parameters.docId).queryList()
    context.ramsOutputDetails=femaDetail
    context.printdoc=fematitle.date
}

if(parameters.docId && parameters.create){
    fematitle=from( 'DesignHeader').where('docId',parameters.docId).queryOne()
    context.date=fematitle.date
    logInfo("Work 1")
    logInfo("dt"+ context.date)
    context.ramsOutputTitle=fematitle
    femaDetail=from('DesignDatas').where('docId',parameters.docId).queryList()
    context.ramsOutputDetails=femaDetail
    context.createcontent=fematitle.date
    logInfo('It is working Fine' + fematitle)
    logInfo('It is working Fine' + femaDetail)
}