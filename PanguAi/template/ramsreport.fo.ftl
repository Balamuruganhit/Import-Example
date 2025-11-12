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
    <#if ramsOutputTitle?has_content>
    <fo:block font-weight="bold" font-size="12pt" space-after="20pt">RAMS ANALYSIS REPORT</fo:block>
        <fo:table table-layout="fixed"  border="1pt solid" padding="5pt"   border-width=".1mm" >
            <fo:table-body>
                <fo:table-row >
                        <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">Rams No:</fo:block></fo:table-cell>
                        <fo:table-cell border="1pt solid black" padding="3.4pt">
                            <fo:block number-columns-spanned="3" >${ramsOutputTitle.ramsNo}</fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block>Product Code:</fo:block></fo:table-cell>
                        <fo:table-cell border="1pt solid black" padding="3.4pt">
                            
                            
                                <fo:block>${ramsOutputTitle.productCode}</fo:block>
                            
                        </fo:table-cell>
                        <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block>Date:</fo:block></fo:table-cell>
                        <fo:table-cell border="1pt solid black" padding="3.4pt">
                            <fo:block>${ramsOutputTitle.date}</fo:block>
                        </fo:table-cell>
            </fo:table-row>
            <fo:table-row >
                        <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">System:</fo:block></fo:table-cell>
                        <fo:table-cell border="1pt solid black" padding="3.4pt">
                            <fo:block number-columns-spanned="3" >${ramsOutputTitle.system}</fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block>Sub-System:</fo:block></fo:table-cell>
                        <fo:table-cell border="1pt solid black" padding="3.4pt">
                            
                            
                                <fo:block>${ramsOutputTitle.subsystem}</fo:block>
                            
                        </fo:table-cell>
                        <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block>Sub-Sub-System:</fo:block></fo:table-cell>
                        <fo:table-cell border="1pt solid black" padding="3.4pt">
                            <fo:block>${ramsOutputTitle.subsubsystem}</fo:block>
                        </fo:table-cell>
            </fo:table-row>
            <fo:table-row >
                        <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">RAMS Responsibility:</fo:block></fo:table-cell>
                        <fo:table-cell border="1pt solid black" padding="3.4pt">
                            <fo:block number-columns-spanned="3" >${ramsOutputTitle.rams}</fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block>Team members:</fo:block></fo:table-cell>
                        <fo:table-cell border="1pt solid black" padding="3.4pt">
                            
                            
                                <fo:block>${ramsOutputTitle.team}</fo:block>
                            
                        </fo:table-cell>
                        <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block>Approved by:</fo:block></fo:table-cell>
                        <fo:table-cell border="1pt solid black" padding="3.4pt">
                            <fo:block>${ramsOutputTitle.approver}</fo:block>
                        </fo:table-cell>
            </fo:table-row>
            </fo:table-body>
        </fo:table>
        <#list ramsOutputDetails as ramsOut>
        <#if ramsOut.calculatorType == "empirical">
        <fo:table border="1pt solid black" padding="5pt" table-layout="fixed">
            <fo:table-header>
                <fo:table-row font-weight="bold" >
                    <fo:table-cell number-columns-spanned="5" border="1pt solid black" padding="7pt" text-align="center" background-color="#808080"><fo:block>Empirical Failure Rate Calculator</fo:block></fo:table-cell>
                </fo:table-row>
            </fo:table-header>
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt" width="4cm"><fo:block padding="3.4pt"></fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt"></fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt" width="4cm"><fo:block padding="3.4pt"></fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">Failure Rate</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">Equivalent MTBFs</fo:block></fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">Time period for observations </fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">${ramsOut.int1} years</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">Best estimate of failure rate</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">${ramsOut.out1} per year</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">${ramsOut.out2} hours</fo:block></fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">Number of failures observed </fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">${ramsOut.int2}</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">90% confidence interval - upper bound</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">${ramsOut.out3} per year</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">${ramsOut.out4} hours</fo:block></fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt"></fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt"></fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">90% confidence interval - lower bound</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">${ramsOut.out5} per year</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">${ramsOut.out6} hours</fo:block></fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
        <#elseif ramsOut.calculatorType == "availability" >
        <fo:table border="1pt solid black" padding="5pt" table-layout="fixed">
            <fo:table-header>
                <fo:table-row font-weight="bold" >
                    <fo:table-cell number-columns-spanned="4" border="1pt solid black" padding="7pt" text-align="center" background-color="#808080"><fo:block>Availability</fo:block></fo:table-cell>
                </fo:table-row>
            </fo:table-header>
            <fo:table-body>
                <fo:table-row width="100%">
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt" width="8cm"><fo:block padding="3.4pt"></fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt"></fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt" width="6cm"><fo:block padding="3.4pt">Results</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">MTBFs =${ramsOut.out3} hrs</fo:block></fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">Failure rate</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">${ramsOut.int2} per year</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">Availability excl. planned mtce</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">${ramsOut.out1} %</fo:block></fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">Repair time (MTTR)</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">${ramsOut.int1} hours</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">Availability incl. planned mtce</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">${ramsOut.out2} %</fo:block></fo:table-cell>
                   
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">Planned maintenance time</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">${ramsOut.int3} hours per year</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt"></fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt"></fo:block></fo:table-cell>
                    
                </fo:table-row>
            </fo:table-body>
        </fo:table>
        <#elseif ramsOut.calculatorType == "reliability" >
        <fo:table border="1pt solid black" padding="5pt" table-layout="fixed">
            <fo:table-header>
                <fo:table-row font-weight="bold" >
                    <fo:table-cell number-columns-spanned="4" border="1pt solid black" padding="7pt" text-align="center" background-color="#808080"><fo:block>Reliability</fo:block></fo:table-cell>
                </fo:table-row>
            </fo:table-header>
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt" width="8cm"><fo:block padding="3.4pt"></fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt"></fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">Results</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt"></fo:block></fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">Failure rate</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">${ramsOut.int2} per year</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">Probability of no failures</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">${ramsOut.out1} %</fo:block></fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">Time period</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">${ramsOut.int1} years</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">Probability of one or nore failures</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">${ramsOut.out2} %</fo:block></fo:table-cell>
                </fo:table-row>
                
            </fo:table-body>
        </fo:table>
        <#elseif ramsOut.calculatorType == "dependpro" >
        <fo:table border="1pt solid black" padding="5pt" table-layout="fixed">
            <fo:table-header>
                <fo:table-row font-weight="bold" >
                    <fo:table-cell number-columns-spanned="4" border="1pt solid black" padding="7pt" text-align="center" background-color="#808080"><fo:block>Probability of r failures in a given time period</fo:block></fo:table-cell>
                </fo:table-row>
            </fo:table-header>
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt" ><fo:block padding="3.4pt"></fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt"></fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt" ><fo:block padding="3.4pt">Results</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt"></fo:block></fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">Failure rate</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">${ramsOut.int2}</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">Probability of r failures</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">${ramsOut.out1} %</fo:block></fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">Time period</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">${ramsOut.int1}</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">Probability of r or more failures</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">${ramsOut.out2} %</fo:block></fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">Number of failures of interest r</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">${ramsOut.int3}</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt"></fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt"></fo:block></fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
        <#elseif ramsOut.calculatorType == "indepro" >
        <fo:block visibility="hidden" font-size="50pt"> it is test</fo:block>
        <fo:table border="1pt solid black" padding="5pt" table-layout="fixed">
            <fo:table-header>
                <fo:table-row font-weight="bold" >
                    <fo:table-cell number-columns-spanned="4" border="1pt solid black" padding="7pt" text-align="center" background-color="#808080"><fo:block>Probability of r failures in n independent events</fo:block></fo:table-cell>
                </fo:table-row>
            </fo:table-header>
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt" ><fo:block padding="3.4pt"></fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt"></fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">Results</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt"></fo:block></fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">Probability of 1 failure in 1 event</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">${ramsOut.int2}</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">Probability of r failures</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">${ramsOut.out1} %</fo:block></fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">Number of independent events n</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">${ramsOut.int1}</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">Probability of r or more failures</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">${ramsOut.out2} %</fo:block></fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">Number of failures of interest r:</fo:block></fo:table-cell>>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">${ramsOut.int3}</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt"></fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt"></fo:block></fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
        <#elseif ramsOut.calculatorType == "final" >
        <fo:table border="1pt solid black" padding="5pt"   table-layout="fixed">
            <fo:table-header>
                <fo:table-row font-weight="bold" >
                    <fo:table-cell number-columns-spanned="4" border="1pt solid black" padding="7pt" text-align="center" background-color="#808080"><fo:block>Has Failure Rate Really Changed?</fo:block></fo:table-cell>
                </fo:table-row>
            </fo:table-header>
             
            <fo:table-body >
                <fo:table-row>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt" ><fo:block padding="3.4pt" ></fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt"></fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt" ><fo:block padding="3.4pt" >Results</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt" ></fo:block></fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">Old number of failures per time period</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">${ramsOut.int1}</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">Confidence that failure rate has changed</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">${ramsOut.out1} %</fo:block></fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">New number of failures per time period</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">${ramsOut.int2}</fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt"></fo:block></fo:table-cell>
                    <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt"></fo:block></fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
        </#if>
        </#list>
    </#if>
</#escape>