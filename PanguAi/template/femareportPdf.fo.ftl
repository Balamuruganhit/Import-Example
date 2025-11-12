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
<#if femaOutputTitle?has_content >
    <fo:block font-weight="bold" font-size="20pt" space-after="20pt">FEMA ANALYSIS REPORT</fo:block>
    <fo:table table-layout="fixed"  border="1pt solid" padding="5pt" width="66cm" font-size="14pt" border-width=".1mm" >
        <fo:table-body>
            <fo:table-row >
                        <fo:table-cell background-color="rgb(126, 187, 240)" border="2pt solid black" text-align="center" font-weight="bold"  padding="4pt"><fo:block padding="4pt">Drawing:</fo:block></fo:table-cell>
                        <fo:table-cell border="2pt solid black"  text-align="center"  padding="4pt">
                            <fo:block padding="4pt">${femaOutputTitle.drawing}</fo:block>
                        </fo:table-cell>
                        <fo:table-cell background-color="rgb(126, 187, 240)" border="2pt solid black"  text-align="center" font-weight="bold" padding="4pt"><fo:block padding="4pt">Part No:</fo:block></fo:table-cell>
                        <fo:table-cell border="2pt solid black"  text-align="center" padding="4pt">
                            <fo:block padding="4pt">${femaOutputTitle.part}</fo:block>
                        </fo:table-cell>
                        <fo:table-cell background-color="rgb(126, 187, 240)"  border="2pt solid black" font-weight="bold" padding="4pt"><fo:block padding="4pt">Rev:</fo:block></fo:table-cell>
                        <fo:table-cell border="2pt solid black" padding="4pt"><fo:block padding="4pt" text-align="center">${femaOutputTitle.rev}</fo:block></fo:table-cell>
                        <fo:table-cell background-color="rgb(126, 187, 240)" border="2pt solid black" font-weight="bold" padding="4pt"><fo:block padding="4pt">FEMA No:</fo:block></fo:table-cell>
                        <fo:table-cell border="2pt solid black" padding="4pt"><fo:block padding="4pt" text-align="center">${femaOutputTitle.femaId}</fo:block></fo:table-cell>
            </fo:table-row>
            <fo:table-row >
                       <fo:table-cell background-color="rgb(126, 187, 240)" border="2pt solid black" font-weight="bold" padding="4pt"><fo:block padding="4pt">System Subsystem Components:</fo:block></fo:table-cell>
                        <fo:table-cell border="2pt solid black" padding="4pt"><fo:block padding="4pt" text-align="center">${femaOutputTitle.comp}</fo:block></fo:table-cell>
                        <fo:table-cell background-color="rgb(126, 187, 240)" border="2pt solid black" font-weight="bold" padding="4pt"><fo:block padding="4pt">Design Responsibility :</fo:block></fo:table-cell>
                        <fo:table-cell border="2pt solid black" padding="4pt" number-columns-spanned="3" text-align="center"><fo:block padding="4pt">${femaOutputTitle.design}</fo:block></fo:table-cell>
                        <fo:table-cell background-color="rgb(126, 187, 240)"  border="2pt solid black" font-weight="bold" padding="4pt"><fo:block padding="4pt">Prepared By:</fo:block></fo:table-cell>
                        <fo:table-cell border="2pt solid black" padding="4pt"><fo:block padding="4pt" text-align="center">${femaOutputTitle.prepareField}</fo:block></fo:table-cell>
            </fo:table-row>
             <fo:table-row >
                       <fo:table-cell background-color="rgb(126, 187, 240)" border="2pt solid black" font-weight="bold" padding="4pt"><fo:block>Team Members:</fo:block></fo:table-cell>
                        <fo:table-cell border="2pt solid black" number-columns-spanned="5" padding="4pt"><fo:block text-align="center">${femaOutputTitle.team}</fo:block></fo:table-cell>
                        <fo:table-cell background-color="rgb(126, 187, 240)" border="2pt solid black" font-weight="bold" padding="4pt"><fo:block>Date:</fo:block></fo:table-cell>
                        <fo:table-cell border="2pt solid black" padding="4pt"><fo:block text-align="center">${femaOutputTitle.femaDate}</fo:block></fo:table-cell>
            </fo:table-row>
        </fo:table-body>
    </fo:table>
    <fo:table table-layout="fixed" border="1pt solid" padding="5pt" width="66cm" font-size="13pt"  border-width=".1mm" >
    <fo:table-body>
            <fo:table-row >
                        <fo:table-cell border="2pt solid black" background-color="rgb(126, 187, 240)" font-weight="bold" padding="4pt"><fo:block>Item</fo:block></fo:table-cell>
                        <fo:table-cell border="2pt solid black" background-color="rgb(126, 187, 240)" font-weight="bold" padding="4pt"><fo:block>Function</fo:block></fo:table-cell>
                        <fo:table-cell border="2pt solid black" background-color="rgb(126, 187, 240)" font-weight="bold" padding="4pt"><fo:block>Requirements</fo:block></fo:table-cell>
                        <fo:table-cell border="2pt solid black" background-color="rgb(126, 187, 240)" font-weight="bold" padding="4pt"><fo:block >Potential Failure Mode</fo:block></fo:table-cell>
                        <fo:table-cell border="2pt solid black" background-color="rgb(126, 187, 240)" font-weight="bold"  padding="4pt"><fo:block>Potential Effects of Failure</fo:block></fo:table-cell>
                        <fo:table-cell border="2pt solid black" background-color="rgb(126, 187, 240)" font-weight="bold" padding="4pt"><fo:block>Severity (S)</fo:block></fo:table-cell>
                        <fo:table-cell border="2pt solid black" background-color="rgb(126, 187, 240)" font-weight="bold" padding="4pt"><fo:block >Potential Cause / Mechanism of Failure</fo:block></fo:table-cell>
                        <fo:table-cell border="2pt solid black" background-color="rgb(126, 187, 240)" font-weight="bold"  padding="4pt"><fo:block>Occurrence (O)</fo:block></fo:table-cell>
                        <fo:table-cell border="2pt solid black" background-color="rgb(126, 187, 240)" font-weight="bold" padding="4pt"><fo:block>Current Design Control</fo:block></fo:table-cell>
                        <fo:table-cell border="2pt solid black" background-color="rgb(126, 187, 240)" font-weight="bold" padding="4pt"><fo:block >Detection Control</fo:block></fo:table-cell>
                        <fo:table-cell border="2pt solid black" background-color="rgb(126, 187, 240)" font-weight="bold" padding="4pt"><fo:block>Deductions (D)</fo:block></fo:table-cell>
                        <fo:table-cell border="2pt solid black" background-color="rgb(126, 187, 240)" font-weight="bold" padding="4pt"><fo:block>RPN</fo:block></fo:table-cell>
                        <fo:table-cell border="2pt solid black" background-color="rgb(126, 187, 240)" font-weight="bold" padding="6pt"><fo:block >Recommended Action</fo:block></fo:table-cell>
                        <fo:table-cell border="2pt solid black" background-color="rgb(126, 187, 240)" font-weight="bold"  padding="4pt"><fo:block>Responsibility &amp; Target Date</fo:block></fo:table-cell>
                        <fo:table-cell border="2pt solid black" background-color="rgb(126, 187, 240)" font-weight="bold" padding="4pt"><fo:block>Action Taken</fo:block></fo:table-cell>
                        <fo:table-cell border="2pt solid black" background-color="rgb(126, 187, 240)" font-weight="bold" padding="4pt"><fo:block >Severity (S)</fo:block></fo:table-cell>
                        <fo:table-cell border="2pt solid black" background-color="rgb(126, 187, 240)" font-weight="bold" padding="4pt"><fo:block >Occurrence (O)</fo:block></fo:table-cell>
                        <fo:table-cell border="2pt solid black" background-color="rgb(126, 187, 240)" font-weight="bold" padding="4pt"><fo:block >Detection (D)</fo:block></fo:table-cell>
                        <fo:table-cell border="2pt solid black" background-color="rgb(126, 187, 240)" font-weight="bold" padding="4pt"><fo:block >RPN</fo:block></fo:table-cell>
            </fo:table-row>
            <fo:table-row >
                        <fo:table-cell number-columns-spanned="8" background-color="rgb(126, 187, 240)" border="2pt solid black" font-weight="bold" padding="4pt"><fo:block text-align="center">Function and Requirement Focus</fo:block></fo:table-cell>
                        <fo:table-cell number-columns-spanned="6" background-color="rgb(126, 187, 240)" border="2pt solid black" font-weight="bold" padding="4pt"><fo:block text-align="center">Design Process Focus:</fo:block></fo:table-cell>
                        <fo:table-cell number-columns-spanned="3" background-color="rgb(126, 187, 240)" border="2pt solid black" font-weight="bold" padding="4pt"><fo:block text-align="center">Risk Mitigation Focus</fo:block></fo:table-cell>
                        <fo:table-cell number-columns-spanned="2" background-color="rgb(126, 187, 240)" border="2pt solid black" font-weight="bold" padding="4pt"><fo:block text-align="center">Improvement Action Focus:</fo:block></fo:table-cell>            
            </fo:table-row>
            <fo:table-row >
                <fo:table-cell number-columns-spanned="3" background-color="rgb(126, 187, 240)" border="2pt solid black" font-weight="bold" padding="4pt" text-align="center"><fo:block >Section 1</fo:block></fo:table-cell>
                <fo:table-cell number-columns-spanned="3" background-color="rgb(126, 187, 240)" border="2pt solid black" font-weight="bold" padding="4pt"><fo:block text-align="center">Section 2</fo:block></fo:table-cell>
                <fo:table-cell border="2pt solid black" background-color="rgb(126, 187, 240)" font-weight="bold" padding="4pt"><fo:block text-align="center">Section 3</fo:block></fo:table-cell>
                <fo:table-cell border="2pt solid black" background-color="rgb(126, 187, 240)" font-weight="bold" padding="4pt"><fo:block ></fo:block></fo:table-cell>
                <fo:table-cell number-columns-spanned="3" background-color="rgb(126, 187, 240)" border="2pt solid black" font-weight="bold" padding="4pt"><fo:block text-align="center">Section 4</fo:block></fo:table-cell>
                <fo:table-cell number-columns-spanned="3" background-color="rgb(126, 187, 240)" border="2pt solid black" font-weight="bold" padding="4pt"><fo:block text-align="center">Section 5</fo:block></fo:table-cell>
                <fo:table-cell number-columns-spanned="5" background-color="rgb(126, 187, 240)" border="2pt solid black" font-weight="bold" padding="4pt"><fo:block text-align="center">Section 6</fo:block></fo:table-cell>
            </fo:table-row>
             
            <fo:table-row >
                       <fo:table-cell border="2pt solid black" background-color="rgb(126, 187, 240)" font-weight="bold" padding="4pt"><fo:block>What is the item that you are focusing on?</fo:block></fo:table-cell>
                        <fo:table-cell border="2pt solid black" background-color="rgb(126, 187, 240)" font-weight="bold" padding="4pt"><fo:block>What function does the item have?</fo:block></fo:table-cell>
                        <fo:table-cell border="2pt solid black" background-color="rgb(126, 187, 240)" font-weight="bold" padding="4pt"><fo:block>What are you trying to achieve (Product Requirement)?</fo:block></fo:table-cell>
                        <fo:table-cell border="2pt solid black" background-color="rgb(126, 187, 240)" font-weight="bold" padding="5pt"><fo:block >How could you get the Requirements wrong (Failure Mode)?</fo:block></fo:table-cell>
                        <fo:table-cell border="2pt solid black" background-color="rgb(126, 187, 240)" font-weight="bold"  padding="4pt"><fo:block>What could happen if it goes wrong (Potential Effects)?</fo:block></fo:table-cell>
                        <fo:table-cell border="2pt solid black" background-color="rgb(126, 187, 240)" font-weight="bold" padding="4pt"><fo:block>How bad would it be if it goes wrong (Severity Score)?</fo:block></fo:table-cell>
                        <fo:table-cell border="2pt solid black" background-color="rgb(126, 187, 240)" font-weight="bold" padding="4pt"><fo:block >What would need to fail in the design to cause the failure mode to occur (Potential Cause)?</fo:block></fo:table-cell>
                        <fo:table-cell border="2pt solid black" background-color="rgb(126, 187, 240)" font-weight="bold"  padding="4pt"><fo:block>How likely is it to go wrong (Occurrence Score)?</fo:block></fo:table-cell>
                        <fo:table-cell border="2pt solid black" background-color="rgb(126, 187, 240)" font-weight="bold" padding="4pt"><fo:block>How could this be prevented (Prevention Control)?</fo:block></fo:table-cell>
                        <fo:table-cell border="2pt solid black" background-color="rgb(126, 187, 240)" font-weight="bold" 
                        padding="4pt"><fo:block >How will you check if the cause and/or failure mode occurs (Detection Control)?</fo:block></fo:table-cell>
                        <fo:table-cell border="2pt solid black" background-color="rgb(126, 187, 240)" font-weight="bold" padding="4pt"><fo:block>How likely are you to detect the cause or failure mode if it was defective (Detection Score)?</fo:block></fo:table-cell>
                        <fo:table-cell border="2pt solid black" background-color="rgb(126, 187, 240)" font-weight="bold" padding="4pt"><fo:block>Risk Priority Number (RPN)</fo:block></fo:table-cell>
                        <fo:table-cell border="2pt solid black" background-color="rgb(126, 187, 240)" font-weight="bold" padding="4pt"><fo:block >List of actions required to mitigate key risks identified</fo:block></fo:table-cell>
                        <fo:table-cell border="2pt solid black" background-color="rgb(126, 187, 240)" font-weight="bold"  padding="4pt"><fo:block></fo:block></fo:table-cell>
                        <fo:table-cell border="2pt solid black" background-color="rgb(126, 187, 240)" font-weight="bold" padding="4pt"><fo:block></fo:block></fo:table-cell>
                        <fo:table-cell border="2pt solid black" background-color="rgb(126, 187, 240)" font-weight="bold" padding="4pt"><fo:block ></fo:block></fo:table-cell>
                        <fo:table-cell border="2pt solid black" background-color="rgb(126, 187, 240)" font-weight="bold" padding="4pt"><fo:block ></fo:block></fo:table-cell>
                        <fo:table-cell border="2pt solid black" background-color="rgb(126, 187, 240)" font-weight="bold" padding="4pt"><fo:block ></fo:block></fo:table-cell>
                        <fo:table-cell border="2pt solid black" background-color="rgb(126, 187, 240)" font-weight="bold" padding="4pt"><fo:block ></fo:block></fo:table-cell>
            </fo:table-row>
            <#list femaOutputDetails as femaOutputDetail>
            <fo:table-row>
                <fo:table-cell border="2pt solid black" background="rgb(173, 170, 170)" padding="8pt">
                    <#if femaOutputDetail.item?has_content>
                            <fo:block>${femaOutputDetail.item}</fo:block>
                        <#else>
                            <fo:block></fo:block>
                        </#if>
                </fo:table-cell>
                <fo:table-cell border="2pt solid black" background="rgb(173, 170, 170)" padding="8pt">
                    <#if femaOutputDetail.functionPart?has_content>
                            <fo:block>${femaOutputDetail.functionPart}</fo:block>
                        <#else>
                            <fo:block></fo:block>
                        </#if>
                </fo:table-cell>
                <fo:table-cell border="2pt solid black" background="rgb(173, 170, 170)" padding="8pt">
                    <#if femaOutputDetail.feverity?has_content>
                            <fo:block>${femaOutputDetail.feverity}</fo:block>
                        <#else>
                            <fo:block></fo:block>
                        </#if>
                </fo:table-cell>
                <fo:table-cell border="2pt solid black" background="rgb(173, 170, 170)" padding="8pt">
                    <#if femaOutputDetail.failureMode?has_content>
                            <fo:block>${femaOutputDetail.failureMode}</fo:block>
                        <#else>
                            <fo:block></fo:block>
                        </#if>
                </fo:table-cell>
                <fo:table-cell border="2pt solid black" background="rgb(173, 170, 170)" padding="8pt">
                    <#if femaOutputDetail.potentialEffects?has_content>
                            <fo:block>${femaOutputDetail.potentialEffects}</fo:block>
                        <#else>
                            <fo:block></fo:block>
                        </#if>
                </fo:table-cell>
                <fo:table-cell border="2pt solid black" background="rgb(173, 170, 170)" padding="8pt">
                    <#if femaOutputDetail.potentialCause?has_content>
                            <fo:block>${femaOutputDetail.occurrence}</fo:block>
                        <#else>
                            <fo:block></fo:block>
                        </#if>
                </fo:table-cell>
                <fo:table-cell border="2pt solid black" background="rgb(173, 170, 170)" padding="8pt">
                    <#if femaOutputDetail.occurrence?has_content>
                            <fo:block>${femaOutputDetail.potentialCause}</fo:block>
                        <#else>
                            <fo:block></fo:block>
                        </#if>
                </fo:table-cell>
                <fo:table-cell border="2pt solid black" background="rgb(173, 170, 170)" padding="8pt">
                    <#if femaOutputDetail.severity?has_content>
                            <fo:block>${femaOutputDetail.severity}</fo:block>
                        <#else>
                            <fo:block></fo:block>
                        </#if>
                </fo:table-cell>
                <fo:table-cell border="2pt solid black" background="rgb(173, 170, 170)" padding="8pt">
                    <#if femaOutputDetail.designControl?has_content>
                            <fo:block>${femaOutputDetail.designControl}</fo:block>
                        <#else>
                            <fo:block></fo:block>
                        </#if>
                </fo:table-cell>
                <fo:table-cell border="2pt solid black" background="rgb(173, 170, 170)" padding="8pt">
                    <#if femaOutputDetail.detectionControl?has_content>
                            <fo:block>${femaOutputDetail.detectionControl}</fo:block>
                        <#else>
                            <fo:block></fo:block>
                        </#if>
                </fo:table-cell>
                <fo:table-cell border="2pt solid black" background="rgb(173, 170, 170)" padding="8pt">
                    <#if femaOutputDetail.detection?has_content>
                            <fo:block>${femaOutputDetail.detection}</fo:block>
                        <#else>
                            <fo:block></fo:block>
                        </#if>
                </fo:table-cell>
                <fo:table-cell border="2pt solid black" background="rgb(173, 170, 170)" padding="8pt">
                    <#if femaOutputDetail.rPN?has_content>
                            <fo:block>${femaOutputDetail.rPN}</fo:block>
                        <#else>
                            <fo:block></fo:block>
                        </#if>
                </fo:table-cell>
                <fo:table-cell border="2pt solid black" background="rgb(173, 170, 170)" padding="8pt">
                    <#if femaOutputDetail.action?has_content>
                            <fo:block>${femaOutputDetail.action}</fo:block>
                        <#else>
                            <fo:block></fo:block>
                        </#if>
                </fo:table-cell>
                <fo:table-cell border="2pt solid black" background="rgb(173, 170, 170)" padding="8pt">
                    <#if femaOutputDetail.responsibility?has_content>
                            <fo:block>${femaOutputDetail.responsibility}</fo:block>
                        <#else>
                            <fo:block></fo:block>
                        </#if>
                </fo:table-cell>
                <fo:table-cell border="2pt solid black" background="rgb(173, 170, 170)" padding="8pt">
                    <#if femaOutputDetail.actionTaken?has_content>
                            <fo:block>${femaOutputDetail.actionTaken}</fo:block>
                        <#else>
                            <fo:block></fo:block>
                        </#if>
                </fo:table-cell>
                <fo:table-cell border="2pt solid black" background="rgb(173, 170, 170)" padding="8pt">
                    <#if femaOutputDetail.severity1?has_content>
                            <fo:block>${femaOutputDetail.severity1}</fo:block>
                        <#else>
                            <fo:block></fo:block>
                        </#if>
                </fo:table-cell>
                <fo:table-cell border="2pt solid black" background="rgb(173, 170, 170)" padding="8pt">
                    <#if femaOutputDetail.occurrence1?has_content>
                            <fo:block>${femaOutputDetail.occurrence1}</fo:block>
                        <#else>
                            <fo:block></fo:block>
                        </#if>
                </fo:table-cell>
                <fo:table-cell border="2pt solid black" background="rgb(173, 170, 170)" padding="8pt">
                    <#if femaOutputDetail.detection1?has_content>
                            <fo:block>${femaOutputDetail.detection1}</fo:block>
                        <#else>
                            <fo:block></fo:block>
                        </#if>
                </fo:table-cell>
                <fo:table-cell border="2pt solid black" background="rgb(173, 170, 170)" padding="8pt">
                    <#if femaOutputDetail.rPN1?has_content>
                            <fo:block>${femaOutputDetail.rPN1}</fo:block>
                        <#else>
                            <fo:block></fo:block>
                        </#if>
                </fo:table-cell>
                
            </fo:table-row>
            </#list>
    </fo:table-body>
    </fo:table>
</#if>
</#escape>