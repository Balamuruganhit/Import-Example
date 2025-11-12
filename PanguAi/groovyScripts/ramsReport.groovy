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


rams=parameters.rams
ramsno=parameters.ramsNo
if(ramsno){
    rams=ramsno
}

if(rams){
    fematitle=from( 'ramsheader').where('ramsNo',rams).queryOne()
    context.date=fematitle.date
    logInfo("dt"+ context.date)
    context.ramsOutputTitle=fematitle
    femaDetail=from('ramsDataNew').where('ramsNo',rams).queryList()
    context.ramsOutputDetails=femaDetail
    logInfo('It is working Fine' + fematitle)
    logInfo('It is working Fine' + femaDetail)
}
logInfo('it is working ramsreport')