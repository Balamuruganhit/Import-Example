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

def createPartiesReport(){
    List<Map<String, Object>> partiesDetails = parameters.partiesDetail
        
        
    logInfo('Uploaded file found; processing sub-content'+partiesDetails)
    def docId=partiesDetails[-1].docId
    def genId = delegator.getNextSeqId("partiesOrganisationHeader")
    Map<String,Object> newHeader =[
        genId:genId,
        docId:partiesDetails[-1].docId,
        revision:partiesDetails[-1].revision,
        date:partiesDetails[-1].saveDate,
        previewDate:partiesDetails[-1].previewDate ,
        approve:partiesDetails[-1].approver ,
        previewer:partiesDetails[-1].previewer,
        prepared:partiesDetails[-1].preparer,
    ]
    delegator.create("partiesOrganisationHeader",newHeader)
    (0..<partiesDetails.size()-1).each{ i ->
        def parties = partiesDetails[i]
        if (parties?.expectations instanceof List) {
        parties.expectations.each { detail ->
        genId = delegator.getNextSeqId("partiesOrganisationDatas")
        Map<String ,Object> mainReportDetails=[
            genId:genId,
            docId:partiesDetails[-1].docId,
            headerType:"expectations",
            contentDetail:detail,
        ]
    delegator.create("partiesOrganisationDatas",mainReportDetails)
    }}
    if (parties?.needs instanceof List) {
        parties.needs.each { detail ->
        genId = delegator.getNextSeqId("partiesOrganisationDatas")
        Map<String ,Object> mainReportDetails=[
            genId:genId,
            docId:partiesDetails[-1].docId,
            headerType:"needs",
            contentDetail:detail,
        ]
    delegator.create("partiesOrganisationDatas",mainReportDetails)
    }}
if (parties?.interestedParty ) {
        genId = delegator.getNextSeqId("partiesOrganisationDatas")
        Map<String ,Object> mainReportDetails=[
            genId:genId,
            docId:partiesDetails[-1].docId,
            headerType:"interestedParty",
            contentDetail:parties.interestedParty,
        ]
    delegator.create("partiesOrganisationDatas",mainReportDetails)
    }
    if(parties?.internalOrExternal ) {
        genId = delegator.getNextSeqId("partiesOrganisationDatas")
        Map<String ,Object> mainReportDetails=[
            genId:genId,
            docId:partiesDetails[-1].docId,
            headerType:"internalOrExternal",
            contentDetail:parties.internalOrExternal,
        ]
    delegator.create("partiesOrganisationDatas",mainReportDetails)
    }
    
 
}
}
logInfo('Id' + parameters.parties)
doc=String.valueOf(parameters.parties)
logInfo('Id' + doc)
def partiesDetailsHeader=from('partiesOrganisationHeader').where("docId",doc).queryOne()
def rows = from('partiesOrganisationDatas').where("docId", doc).orderBy("genId").queryList()

// Step 1: Build groups by interestedParty + internalOrExternal
def groups = []
def currentGroup = null

rows.each { row ->
    switch (row.headerType) {
        case "interestedParty":
            currentGroup = [
                interestedParty   : row.contentDetail,
                internalOrExternal: null,
                needs             : [],
                expectations      : []
            ]
            groups << currentGroup
            break

        case "internalOrExternal":
            if (currentGroup) {
                currentGroup.internalOrExternal = row.contentDetail
            }
            break

        case "needs":
            if (currentGroup) {
                currentGroup.needs << row.contentDetail
            }
            break

        case "expectations":
            if (currentGroup) {
                currentGroup.expectations << row.contentDetail
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