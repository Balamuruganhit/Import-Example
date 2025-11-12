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


def selectedRamsNoParam = parameters.ramsDetail
def selectedRamsList = selectedRamsNoParam ? selectedRamsNoParam.split(",") : []

def combinedRamsData = []

selectedRamsList.each { ramsNo ->
    // Get the RAMS Header
    def ramsHeader = from("ramsheader").where("ramsNo", ramsNo).queryOne()

    // Prepare header data
    def headerData = [
        ramsNo      : ramsNo,
        date        : ramsHeader.date,
        system      : ramsHeader.system,
        sub         : ramsHeader.subsystem,
        subsub      : ramsHeader.subsubsystem,
        product     : ramsHeader.productCode,
        rev         : ramsHeader.revision,
        rams        : ramsHeader.rams,
        approver    : ramsHeader.approver
    ]

    // Fetch related RamsNewData records
    def detailList = []
    def newDataList = from("ramsDataNew")
                        .where("ramsNo", ramsNo)
                        .queryList()

    newDataList.each { newData ->
        detailList.add([
            calculatorType : newData.calculatorType,
            int1           : newData.int1,
            int2           : newData.int2,
            int3           : newData.int3,
            out1           : newData.out1,
            out2           : newData.out2,
            out3           : newData.out3,
            out4           : newData.out4,
            out5           : newData.out5,
            out6           : newData.out6
        ])
    }

    // Combine into one object per RAMS NO
    combinedRamsData.add([
        header : headerData,
        details: detailList
    ])
}

// Pass to frontend
context.combinedRamsData = combinedRamsData

logInfo("RAMS Combined Data: ${combinedRamsData}")