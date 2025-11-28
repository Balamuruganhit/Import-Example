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
 <fo:block font-size="14pt" font-weight="bold" text-align="center" space-after="10pt" background-color="#b0d4f1" padding="5pt">
      Design &amp; Development
      </fo:block>

      <fo:block space-after="5pt">
        <fo:inline font-weight="bold">Ref No: </fo:inline>${ramsOutputTitle.docId!""}
      </fo:block>
      <fo:block space-after="5pt">
        <fo:inline font-weight="bold">Rev No: </fo:inline>${ramsOutputTitle.revision!""}
      </fo:block>
      <fo:block space-after="10pt">
        <fo:inline font-weight="bold">Date: </fo:inline>${ramsOutputTitle.date!""}
      </fo:block>
<#if ramsOutputDetails?has_content>
 
  <fo:table space-after="10pt" table-layout="fixed" text-align="center" display-align="center" width="100%" border="solid 0.5pt black" font-size="10pt">
    
    
    <fo:table-header>
      <fo:table-row>
        <fo:table-cell border="1pt solid black"><fo:block font-weight="bold">Process/Activity</fo:block></fo:table-cell>
        <fo:table-cell border="1pt solid black"><fo:block font-weight="bold">Applicable Tools/Standards</fo:block></fo:table-cell>
        <fo:table-cell border="1pt solid black"><fo:block font-weight="bold">Status</fo:block></fo:table-cell>
        <fo:table-cell border="1pt solid black"><fo:block font-weight="bold">Remarks</fo:block></fo:table-cell>
      </fo:table-row>
    </fo:table-header>
        <fo:table-body>
    <#list ramsOutputDetails as group>
      <fo:table-row >
        <fo:table-cell border="1pt solid black"><fo:block>${group.process!" "}</fo:block></fo:table-cell>
        <fo:table-cell border="1pt solid black"><fo:block>${group.tools!" "}</fo:block></fo:table-cell>
        <fo:table-cell border="1pt solid black"><fo:block>${group.status!" "}</fo:block></fo:table-cell>
        <fo:table-cell border="1pt solid black"><fo:block>${group.remark!" "}</fo:block></fo:table-cell>
      </fo:table-row>
    </#list>
    </fo:table-body>
    </fo:table>

</#if>

</#escape>