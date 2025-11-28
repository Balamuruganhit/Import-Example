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


def createOrganisationReport(){
    List<Map<String, Object>> partiesDetails = parameters.OrganisationDetail
        
        
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
    delegator.create("OrganisationHeader",newHeader)
    (0..<partiesDetails.size()-1).each{ i ->
        def parties = partiesDetails[i]
    if (parties?.mitigation instanceof List) {
        parties.mitigation.each { detail ->
        genId = delegator.getNextSeqId("OrganisationDatas")
        Map<String ,Object> mainReportDetails=[
            genId:genId,
            docId:partiesDetails[-1].docId,
            headerType:"Mitigation",
            contentDetail:detail,
        ]
    delegator.create("OrganisationDatas",mainReportDetails)
    }}
    if (parties?.objective instanceof List) {
        parties.objective.each { detail ->
        genId = delegator.getNextSeqId("OrganisationDatas")
        Map<String ,Object> mainReportDetails=[
            genId:genId,
            docId:partiesDetails[-1].docId,
            headerType:"objective",
            contentDetail:detail,
        ]
    delegator.create("OrganisationDatas",mainReportDetails)
    }}
    if (parties?.riskDescription instanceof List) {
        parties.riskDescription.each { detail ->
        genId = delegator.getNextSeqId("OrganisationDatas")
        Map<String ,Object> mainReportDetails=[
            genId:genId,
            docId:partiesDetails[-1].docId,
            headerType:"riskDescription",
            contentDetail:detail,
        ]
    delegator.create("OrganisationDatas",mainReportDetails)
    }}
if (parties?.riskValue ) {
        genId = delegator.getNextSeqId("OrganisationDatas")
        Map<String ,Object> mainReportDetails=[
            genId:genId,
            docId:partiesDetails[-1].docId,
            headerType:"riskValue",
            contentDetail:parties.riskValue,
        ]
    delegator.create("OrganisationDatas",mainReportDetails)
    }
    if(parties?.issue ) {
        genId = delegator.getNextSeqId("OrganisationDatas")
        Map<String ,Object> mainReportDetails=[
            genId:genId,
            docId:partiesDetails[-1].docId,
            headerType:"issue",
            contentDetail:parties.issue,
        ]
    delegator.create("OrganisationDatas",mainReportDetails)
    }
    
 
}
}

logInfo('Id' + parameters.organisation)
doc=String.valueOf(parameters.organisation)
logInfo('Id' + doc)
def partiesDetailsHeader=from('OrganisationHeader').where("docId",doc).queryOne()
def rows = from('OrganisationDatas').where("docId", doc).orderBy("genId").queryList()

// Step 1: Build groups by interestedParty + internalOrExternal
def groups = []
def currentGroup = null

rows.each { row ->
    switch (row.headerType) {
        case "issue":
            currentGroup = [
                issue   : row.contentDetail,
                riskValue: null,
                riskDescription             : [],
                mitigation      : [],
                objective:[],

            ]
            groups << currentGroup
            break

        case "riskValue":
            if (currentGroup) {
                currentGroup.riskValue = row.contentDetail
            }
            break

        case "riskDescription":
            if (currentGroup) {
                currentGroup.riskDescription << row.contentDetail
            }
            break

        case "Mitigation":
            if (currentGroup) {
                currentGroup.mitigation << row.contentDetail
            }
            break
        case "objective":
            if (currentGroup) {
                currentGroup.objective << row.contentDetail
            }
            break
        default:
            // ignore other types if any
            break
    }
}

logInfo("Grouped data: ${groups}")
context.data=groups
context.header=partiesDetailsHeader
