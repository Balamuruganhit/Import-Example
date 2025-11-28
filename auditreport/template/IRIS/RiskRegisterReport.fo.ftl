<#--
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
-->

<#escape x as x?xml>
 <fo:block font-size="20pt" height="50pt" font-weight="bold" text-align="center" space-after="10pt" background-color="#0c2d7c" color="white" padding="5pt">
      Risk Register
      </fo:block>

      <fo:block space-after="5pt" font-size="14pt">
        <fo:inline font-weight="bold" font-size="14pt">Ref No: </fo:inline>${ramsOutputTitle.docId!""}
      </fo:block>
      <fo:block space-after="5pt" font-size="14pt">
        <fo:inline font-weight="bold" font-size="14pt">Rev No: </fo:inline>${ramsOutputTitle.revision!""}
      </fo:block>
      <fo:block space-after="10pt" font-size="14pt">
        <fo:inline font-weight="bold" font-size="14pt">Date:</fo:inline> ${ramsOutputTitle.date!""}
      </fo:block>
<#if ramsOutputDetails?has_content>
 
  <fo:table space-after="10pt" table-layout="fixed" text-align="center" display-align="center" width="100%" border="solid 0.5pt black" font-size="14pt">
    
    
    <fo:table-header>
      <fo:table-row>
          <fo:table-cell border="1pt solid black"><fo:block font-weight="bold">Risk Id</fo:block></fo:table-cell>
          <fo:table-cell border="1pt solid black"><fo:block font-weight="bold">Risk Description</fo:block></fo:table-cell>
          <fo:table-cell border="1pt solid black"><fo:block font-weight="bold">Risk Owner</fo:block></fo:table-cell>
          <fo:table-cell border="1pt solid black"><fo:block font-weight="bold">Risk Category</fo:block></fo:table-cell>
          <fo:table-cell border="1pt solid black"><fo:block font-weight="bold">Date Identified</fo:block></fo:table-cell>
          <fo:table-cell border="1pt solid black"><fo:block font-weight="bold">Hazard/Cause</fo:block></fo:table-cell>
          <fo:table-cell border="1pt solid black"><fo:block font-weight="bold">Potential Consequence</fo:block></fo:table-cell>
          <fo:table-cell border="1pt solid black"><fo:block font-weight="bold">Existing Controls</fo:block></fo:table-cell>
          <fo:table-cell border="1pt solid black"><fo:block font-weight="bold">Effectiveness of Controls</fo:block></fo:table-cell>
          <fo:table-cell border="1pt solid black"><fo:block font-weight="bold">Likelihood</fo:block></fo:table-cell>
          <fo:table-cell border="1pt solid black"><fo:block font-weight="bold">Consequence/Severity</fo:block></fo:table-cell>
          <fo:table-cell border="1pt solid black"><fo:block font-weight="bold">Initial Risk Rating</fo:block></fo:table-cell>
          <fo:table-cell border="1pt solid black"><fo:block font-weight="bold">Additional Mitigation Actions</fo:block></fo:table-cell>
          <fo:table-cell border="1pt solid black"><fo:block font-weight="bold">Effectiveness of Actions Taken</fo:block></fo:table-cell>
          <fo:table-cell border="1pt solid black"><fo:block font-weight="bold">Residual Risk Rating</fo:block></fo:table-cell>
          <fo:table-cell border="1pt solid black"><fo:block font-weight="bold">Action Due Date</fo:block></fo:table-cell>
          <fo:table-cell border="1pt solid black"><fo:block font-weight="bold">Status</fo:block></fo:table-cell>
          <fo:table-cell border="1pt solid black"><fo:block font-weight="bold">Evidence/References</fo:block></fo:table-cell>
          <fo:table-cell border="1pt solid black"><fo:block font-weight="bold">Warranty</fo:block></fo:table-cell>
      </fo:table-row>
    </fo:table-header>
        <fo:table-body>
    <#list ramsOutputDetails as group>
      <fo:table-row >
        <fo:table-cell border="1pt solid black"><fo:block>${group.riskId!" "}</fo:block></fo:table-cell>
            <fo:table-cell border="1pt solid black"><fo:block>${group.description!" "}</fo:block></fo:table-cell>
             <fo:table-cell border="1pt solid black"><fo:block>${group.owner!" "}</fo:block></fo:table-cell>
            <fo:table-cell border="1pt solid black"><fo:block>${group.category!" "}</fo:block></fo:table-cell>
             <fo:table-cell border="1pt solid black"><fo:block>${group.dateIdentified!" "}</fo:block></fo:table-cell>
           <fo:table-cell border="1pt solid black"><fo:block>${group.hazard!" "}</fo:block></fo:table-cell>
           <fo:table-cell border="1pt solid black"><fo:block>${group.consequence!" "}</fo:block></fo:table-cell>
           <fo:table-cell border="1pt solid black"><fo:block>${group.controls!" "}</fo:block></fo:table-cell>
           <fo:table-cell border="1pt solid black"><fo:block>${group.effectiveness!" "}</fo:block></fo:table-cell>
           <fo:table-cell border="1pt solid black"><fo:block>${group.likelihood!" "}</fo:block></fo:table-cell>
           <fo:table-cell border="1pt solid black"><fo:block>${group.severity!" "}</fo:block></fo:table-cell>
           <fo:table-cell border="1pt solid black"><fo:block>${group.initialRiskRating!" "}</fo:block></fo:table-cell>
           <fo:table-cell border="1pt solid black"><fo:block>${group.mitigation!" "}</fo:block></fo:table-cell>
           <fo:table-cell border="1pt solid black"><fo:block>${group.actionsTaken!" "}</fo:block></fo:table-cell>
           <fo:table-cell border="1pt solid black"><fo:block>${group.residualRisk!" "}</fo:block></fo:table-cell>
           <fo:table-cell border="1pt solid black"><fo:block>${group.actiondate!" "}</fo:block></fo:table-cell>
           <fo:table-cell border="1pt solid black"><fo:block>${group.status!" "}</fo:block></fo:table-cell>
           <fo:table-cell border="1pt solid black"><fo:block>${group.evidence!" "}</fo:block></fo:table-cell>
          <fo:table-cell border="1pt solid black"><fo:block>
            From date ${group.warrantyFrom}<fo:block space-after="5pt" font-size="14pt"></fo:block>
            To date ${group.warrantyTo}
          </fo:block></fo:table-cell>
      </fo:table-row>
    </#list>
    </fo:table-body>
    </fo:table>
    <fo:table table-layout="fixed" width="100%" font-size="15pt" margin-top="30pt" >
      <fo:table-column column-width="30%"/>
      <fo:table-column column-width="30%"/>
      <fo:table-column column-width="30%"/>
      <fo:table-body>
        <fo:table-row>
          <fo:table-cell>
            <fo:block text-align="left">Auditee: ${ramsOutputTitle.prepared}</fo:block>
          </fo:table-cell>
          <fo:table-cell>
            <fo:block text-align="center">Internal Auditor:${ramsOutputTitle.previewer} </fo:block>
          </fo:table-cell>
          <fo:table-cell>
            <fo:block text-align="right">External Auditor: ${ramsOutputTitle.approve}</fo:block>
          </fo:table-cell>
        </fo:table-row>
      </fo:table-body>
  </fo:table>
</#if>

</#escape>