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
import org.apache.ofbiz.entity.serialize.XmlSerializer
import org.apache.ofbiz.product.product.KeywordIndex
import org.apache.ofbiz.product.product.ProductWorker
import org.apache.ofbiz.service.*
import org.apache.ofbiz.base.util.*
import org.apache.ofbiz.entity.*
import java.sql.Timestamp
import java.util.List

// Initialize the map to store results
Map reportContentMap = [:]


// Retrieve all records from the ReportContent entity
List reportContents = select("genId","reportId", "question", "rating", "comment", "approve","proofBase64").from("ReportContent").where("reportId", reportId).orderBy("genId").queryList()


// Iterate through the records and process the data
reportContents.each { reportContent ->
            // Initialize a map for each report
            Map reportData = [:]
            
            // Fetch the required fields from the ReportContent entity
            reportData.put("genId", reportContent.get("genId"))
            reportData.put("reportId", reportContent.get("reportId"))
            reportData.put("question", reportContent.getString("question"))
            reportData.put("rating", reportContent.get("rating"))
            reportData.put("approve", reportContent.getString("approve"))
            reportData.put("comment", reportContent.getString("comment"))

            // Process image data (if available) and convert to Base64
            def imageBlob = reportContent.getBytes("proofBase64")
            def imageBase64 = imageBlob ? Base64.encoder.encodeToString(imageBlob) : ""
            reportData.put("proof", imageBase64)

            // Optionally, process other data based on your needs (like calculations or categories)
            // Example: You could add categories or balances if needed, similar to your postedTransactionTotalsMap logic
            
            // Store the processed report data into the map (using reportId or another unique identifier)
            reportContentMap.put(reportContent.get("genId"), reportData)
}

// Convert the result into a list of report data
context.reportNumber=reportId
context.resultList = reportContentMap.values().toList()
context.responseMessage = "success"

