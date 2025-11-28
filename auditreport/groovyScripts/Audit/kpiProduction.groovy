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

if(parameters.plan){
if(parameters.productId || parameters.date_fld0_value){
    def conditions = []

        if (parameters.productId) {
            conditions << EntityCondition.makeCondition("productId", EntityOperator.LIKE,"%" + parameters.productId+ "%")
        }
        if (parameters.date_fld0_value) {
            
            try {
                def sdf = new SimpleDateFormat("yyyy-MM-dd")
                sdf.setLenient(false) // enforce strict format parsing
                def utilDate = sdf.parse(parameters.date_fld0_value.trim())
                def startTimestamp = new Timestamp(utilDate.getTime())
                
                    def endUtilDate = sdf.parse(parameters.date_fld1_value.trim())
                    def endTimestamp = new Timestamp(endUtilDate.getTime())  
               
                

                logInfo("Searching between: ${startTimestamp} and ${endTimestamp}")
                
                // Add to query condition
                conditions << EntityCondition.makeCondition([
                    EntityCondition.makeCondition("estimatedCompletionDate", EntityOperator.GREATER_THAN_EQUAL_TO, startTimestamp),
                    EntityCondition.makeCondition("estimatedCompletionDate", EntityOperator.LESS_THAN, endTimestamp)
                ], EntityOperator.AND)
                
            } catch (Exception e) {
                logError("Failed to parse date_fld0_value: ${parameters.date_fld0_value}, Error: ${e.message}")
            }
        }
        conditions.add (EntityCondition.makeCondition('workEffortTypeId',EntityOperator.EQUALS,"PROD_ORDER_HEADER"))
         conditions << EntityCondition.makeCondition([
                    EntityCondition.makeCondition("currentStatusId", EntityOperator.GREATER_THAN_EQUAL_TO, "PRUN_COMPLETED"),
                    EntityCondition.makeCondition("currentStatusId", EntityOperator.LESS_THAN, "PRUN_CLOSED")
                ], EntityOperator.OR)
                

        if (conditions) {
            condition = EntityCondition.makeCondition(conditions, EntityOperator.AND)
    }

// Now query only with .where(condition) if condition is not null:
    def query = from("WorkEffortProductGoods")
    if (condition != null) {
        query = query.where(condition)
    }
    def femaList = query.queryList()
def groupedMap = [:]

// Define date formatter
def dateFormatter = new SimpleDateFormat("yyyy-MM-dd")

// Transform each record to include only the required fields
femaList.each { item ->
    def productId = item.productId

    def entry = [
        quantityProduced : item.quantityProduced ,
        quantityRejected : item.quantityToProduce ,
        lastUpdatedDate  : item.estimatedCompletionDate ? dateFormatter.format(item.estimatedCompletionDate) : null
    ]

    if (!groupedMap.containsKey(productId)) {
        groupedMap[productId] = []
    }

    groupedMap[productId] << entry
}
def outputList = groupedMap.collect { productId, entries ->
    [
        productId: productId,
        entries  : entries
    ]
}

context.femaList = outputList
logInfo("Filtered FEMA List: ${outputList}")
}

}

if(parameters.ontime){
    def conditions = []
    if (parameters.date_fld0_value && parameters.date_fld1_value) {
    try {
        context.start=parameters.date_fld0_value
            context.end=parameters.date_fld1_value
        def sdf = new SimpleDateFormat("yyyy-MM")
        sdf.setLenient(false)

        def startDate = sdf.parse(parameters.date_fld0_value.trim())
        def endDate = sdf.parse(parameters.date_fld1_value.trim())

        // Start timestamp: yyyy-MM-01 00:00:00.000
        Calendar startCal = Calendar.getInstance()
        startCal.setTime(startDate)
        startCal.set(Calendar.DAY_OF_MONTH, 1)
        startCal.set(Calendar.HOUR_OF_DAY, 0)
        startCal.set(Calendar.MINUTE, 0)
        startCal.set(Calendar.SECOND, 0)
        startCal.set(Calendar.MILLISECOND, 0)
        Timestamp startTimestamp = new Timestamp(startCal.getTimeInMillis())

        // End timestamp: last day of end month at 23:59:59.999
        Calendar endCal = Calendar.getInstance()
        endCal.setTime(endDate)
        endCal.set(Calendar.DAY_OF_MONTH, endCal.getActualMaximum(Calendar.DAY_OF_MONTH))
        endCal.set(Calendar.HOUR_OF_DAY, 23)
        endCal.set(Calendar.MINUTE, 59)
        endCal.set(Calendar.SECOND, 59)
        endCal.set(Calendar.MILLISECOND, 999)
        Timestamp endTimestamp = new Timestamp(endCal.getTimeInMillis())

        logInfo("Filtering orders between: ${startTimestamp} and ${endTimestamp}")

        // Ensure conditions is initialized
       
           
        

        conditions << EntityCondition.makeCondition([
            EntityCondition.makeCondition("orderDate", EntityOperator.GREATER_THAN_EQUAL_TO, startTimestamp),
            EntityCondition.makeCondition("orderDate", EntityOperator.LESS_THAN_EQUAL_TO, endTimestamp)
        ], EntityOperator.AND)

    } catch (Exception e) {
        logError("Date parsing failed: ${e.message}")
    }

    if (!conditions) {
        conditions = []
    }

    conditions.add(EntityCondition.makeCondition('orderTypeId', EntityOperator.EQUALS, "SALES_ORDER"))
}

// Query OrderHeader
def query = from("OrderHeader")
if (conditions) {
    query = query.where(conditions)


def femaList = query.queryList()
def orderDataList = []
def dateFormatter = new SimpleDateFormat("yyyy-MM")
def dateFormatterDay = new SimpleDateFormat("yyyy-MM-dd")
femaList.each { orderHeader ->
    def orderItem = from("OrderItem")
        .where("orderId", orderHeader.orderId)
        .queryFirst()
     logInfo("Estimate Delivery date" + orderItem)
    def shipmentInfo = from('Shipment').where([primaryOrderId:orderHeader.orderId,statusId:"SHIPMENT_DELIVERED"]).queryFirst()
    def daysDiff  = null
    def actualdiff=null
    def performaceEfficency= null
    if(shipmentInfo){
       
    if(orderHeader.orderDate && orderItem.estimatedDeliveryDate){
        def orderDate = orderHeader.orderDate
    def estimatedDeliveryDate = orderItem.estimatedDeliveryDate

    long millisDiff = estimatedDeliveryDate.time - orderDate.time
    daysDiff = (millisDiff / (1000 * 60 * 60 * 24)) as long
    logInfo("Date difference in here days: ${daysDiff}")
    
    }
    logInfo("Work here" + shipmentInfo)
    if(orderHeader.orderDate && shipmentInfo.lastModifiedDate){
        def orderDate = orderHeader.orderDate
    def estimatedShipDate = shipmentInfo.lastModifiedDate

    long millisDiff = estimatedShipDate.time - orderDate.time
    actualdiff = (millisDiff / (1000 * 60 * 60 * 24)) as long
    logInfo("Date difference in days: ${actualdiff}")
    
    }
    if(actualdiff && daysDiff){
        performaceEfficency=((daysDiff)/actualdiff)*100

    }
    }
     if (orderItem) {
      orderDataList << [
            orderHeader: orderHeader.orderId,
            month: dateFormatter.format(orderHeader.orderDate),
            orderDate:dateFormatterDay.format(orderHeader.orderDate),
            orderItem: [
                quantity:orderItem.quantity,
                estimatedDeliveryDate:daysDiff,
                estimatedShipDate: actualdiff,
                shipBeforeDate: (orderItem.shipBeforeDate instanceof Date)
                    ? dateFormatterDay.format(orderItem.shipBeforeDate)
                    : '',
                performaceEfficency:performaceEfficency,
                
            ]
        ]
        logInfo("output for orderItem" + orderDataList)
    }
}
context.otdDatas=orderDataList
logInfo("output for orderItem" + orderDataList)
}

}
