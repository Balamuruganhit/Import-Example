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
    <#if resultList?has_content >
        <fo:list-block provisional-distance-between-starts="40mm">
            <fo:list-item>
                    <fo:list-item-label><fo:block font-size="12">Report No:</fo:block></fo:list-item-label>
                    <fo:list-item-body start-indent="body-start()"><fo:block font-size="12"><#if reportNumber??> ${reportNumber}</#if></fo:block></fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
        <fo:block><fo:leader leader-length="100%" leader-pattern="rule" rule-style="solid" rule-thickness="0.1mm" color="black"/></fo:block>
         <fo:block space-after.optimum="0.3cm"></fo:block>
        <fo:table table-layout="fixed" border="1pt solid" display-align="center" border-width=".1mm" width="20.8cm">
              <fo:table-column column-width="20%"/>
              <fo:table-column column-width="5%"/>
              <fo:table-column column-width="20%"/>
              <fo:table-column column-width="40%"/>
              <fo:table-column column-width="10%"/>
            <fo:table-body>
                <fo:table-row font-weight="bold">
                        <fo:table-cell border="1pt solid black" text-align="center" padding="4.2pt"><fo:block>Question</fo:block></fo:table-cell>
                        <fo:table-cell border="1pt solid black" text-align="center" padding="4.2pt"><fo:block>Rating</fo:block></fo:table-cell>
                        <fo:table-cell border="1pt solid black" text-align="center" padding="4.2pt"><fo:block>Comment</fo:block></fo:table-cell>
                        <fo:table-cell border="1pt solid black" text-align="center" padding="4.2pt"><fo:block>Proof</fo:block></fo:table-cell>
                        <fo:table-cell border="1pt solid black" text-align="center" padding="4.2pt"><fo:block>Approver</fo:block></fo:table-cell>
                </fo:table-row>
                <#list resultList as resultList>
                        <fo:table-row>
                            <fo:table-cell border="1pt solid black" text-align="center" padding="3.2pt" border-width=".1mm">
                                <fo:block text-align="center"  white-space-collapse="false" white-space-treatment="preserve">${resultList.question!}</fo:block>
                            </fo:table-cell>
                            <fo:table-cell border="1pt solid" border-width=".1mm">
                                <fo:block text-align="center" >${resultList.rating!}</fo:block>
                            </fo:table-cell>
                            <fo:table-cell border="1pt solid" border-width=".1mm">
                                <fo:block text-align="center"  white-space-collapse="false" white-space-treatment="preserve">${resultList.comment!}</fo:block>
                            </fo:table-cell>
                            <fo:table-cell border="1pt solid" border-width=".1mm">
                                    <fo:block text-align="center">
                                            <fo:external-graphic src="data:image/png;base64,${resultList.proof!}"  content-height="scale-to-fit" height="2.00in"  content-width="2.00in" scaling="non-uniform"/>
                                    </fo:block>
                            </fo:table-cell>
                            <fo:table-cell border="1pt solid" border-width=".1mm">
                                <fo:block text-align="center">${resultList.approve!}</fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                </#list>
            </fo:table-body>
        </fo:table>
    <#else>
        <fo:block text-align="center">No record</fo:block>
    </#if>
</#escape>

