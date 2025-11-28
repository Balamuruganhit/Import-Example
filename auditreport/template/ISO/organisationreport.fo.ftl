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
        Needs &amp; Expectations of Interested Parties
      </fo:block>

      <fo:block space-after="5pt">
        <fo:inline font-weight="bold">Ref No: </fo:inline>${header.docId!""}
      </fo:block>
      <fo:block space-after="5pt">
        <fo:inline font-weight="bold">Rev No: </fo:inline>${header.revision!""}
      </fo:block>
      <fo:block space-after="10pt">
        <fo:inline font-weight="bold">Date: </fo:inline>${header.date!""}
      </fo:block>
<#if data?has_content>
 <fo:block font-size="9pt" font-weight="bold" text-align="center" space-after="10pt" background-color="#b0d4f1" padding="5pt">
       Internal Issues Register
      </fo:block>
  <fo:table space-after="10pt" table-layout="fixed" text-align="center" display-align="center" width="100%" border="solid 0.5pt black" font-size="10pt">
    <fo:table-column column-width="3cm"/>
    <fo:table-column column-width="3cm"/>
    <fo:table-column column-width="2cm"/>
    <fo:table-column column-width="5cm"/>
    <fo:table-column column-width="5cm"/>
    <fo:table-column column-width="2cm"/>
    
    <fo:table-header>
      <fo:table-row>
        <fo:table-cell border="1pt solid black"><fo:block font-weight="bold">Issues</fo:block></fo:table-cell>
        <fo:table-cell border="1pt solid black"><fo:block font-weight="bold">Description of risk</fo:block></fo:table-cell>
        <fo:table-cell border="1pt solid black"><fo:block font-weight="bold">Risk Value</fo:block></fo:table-cell>
        <fo:table-cell border="1pt solid black"><fo:block font-weight="bold">Opportunities / Mitigation</fo:block></fo:table-cell>
        <fo:table-cell border="1pt solid black"><fo:block font-weight="bold">Objective</fo:block></fo:table-cell>
        <fo:table-cell border="1pt solid black"><fo:block/></fo:table-cell>
      </fo:table-row>
    </fo:table-header>
        <fo:table-body>
    <#list data[0..4] as group>
      <fo:table-row >
        <fo:table-cell border="1pt solid black"><fo:block>${group.issue!" "}</fo:block></fo:table-cell>
        <fo:table-cell border="1pt solid black" padding-left="5pt">
          <fo:block text-align="left" >
          <#list group.riskDescription as riskDescription>
            &#x2022; ${riskDescription}<fo:block/>
          </#list>
          </fo:block>
        </fo:table-cell>
        <fo:table-cell border="1pt solid black"><fo:block>${group.riskValue!" "}</fo:block></fo:table-cell>
        <fo:table-cell border="1pt solid black" padding-left="5pt">
          <fo:block text-align="left">
          <#list group.mitigation as mitigation>
            &#x2022; ${mitigation}<fo:block/>
          </#list>
          </fo:block>
        </fo:table-cell>
        <fo:table-cell border="1pt solid black" padding-left="5pt">
            <fo:block text-align="left">
            <#list group.objective as objective>
                &#x2022; ${objective}<fo:block/>
            </#list>
            </fo:block>
        </fo:table-cell>
        <fo:table-cell border="1pt solid black"><fo:block/></fo:table-cell>
      </fo:table-row>
    </#list>
    </fo:table-body>
    </fo:table>
    <fo:block font-size="9pt" font-weight="bold" text-align="center" space-after="10pt" background-color="#b0d4f1" padding="5pt">
       External Issues Register
      </fo:block>
  <fo:table space-after="10pt" table-layout="fixed" text-align="center" display-align="center" width="100%" border="solid 0.5pt black" font-size="10pt">
    <fo:table-column column-width="3cm"/>
    <fo:table-column column-width="3cm"/>
    <fo:table-column column-width="2cm"/>
    <fo:table-column column-width="5cm"/>
    <fo:table-column column-width="5cm"/>
    <fo:table-column column-width="2cm"/>
    
    <fo:table-header>
      <fo:table-row>
        <fo:table-cell border="1pt solid black"><fo:block font-weight="bold">Issues</fo:block></fo:table-cell>
        <fo:table-cell border="1pt solid black"><fo:block font-weight="bold">Description of risk</fo:block></fo:table-cell>
        <fo:table-cell border="1pt solid black"><fo:block font-weight="bold">Risk Value</fo:block></fo:table-cell>
        <fo:table-cell border="1pt solid black"><fo:block font-weight="bold">Opportunities / Mitigation</fo:block></fo:table-cell>
        <fo:table-cell border="1pt solid black"><fo:block font-weight="bold">Objective</fo:block></fo:table-cell>
        <fo:table-cell border="1pt solid black"><fo:block/></fo:table-cell>
      </fo:table-row>
    </fo:table-header>
        <fo:table-body>
    <#list data[5..] as group>
      <fo:table-row >
        <fo:table-cell border="1pt solid black"><fo:block>${group.issue!" "}</fo:block></fo:table-cell>
        <fo:table-cell border="1pt solid black" padding-left="5pt">
          <fo:block text-align="left" >
          <#list group.riskDescription as riskDescription>
            &#x2022; ${riskDescription}<fo:block/>
          </#list>
          </fo:block>
        </fo:table-cell>
        <fo:table-cell border="1pt solid black"><fo:block>${group.riskValue!" "}</fo:block></fo:table-cell>
        <fo:table-cell border="1pt solid black" padding-left="5pt">
          <fo:block text-align="left">
          <#list group.mitigation as mitigation>
            &#x2022; ${mitigation}<fo:block/>
          </#list>
          </fo:block>
        </fo:table-cell>
        <fo:table-cell border="1pt solid black" padding-left="5pt">
            <fo:block text-align="left">
            <#list group.objective as objective>
                &#x2022; ${objective}<fo:block/>
            </#list>
            </fo:block>
        </fo:table-cell>
        <fo:table-cell border="1pt solid black"><fo:block/></fo:table-cell>
      </fo:table-row>
    </#list>
    </fo:table-body>
    </fo:table>
    <fo:block font-size="14pt" font-weight="bold" text-align="center" space-after="10pt" padding="5pt">
       
      </fo:block>
  <fo:table table-layout="fixed" width="100%" font-size="10pt" margin-top="10pt">
  <fo:table-column column-width="30%"/>
  <fo:table-column column-width="30%"/>
  <fo:table-column column-width="30%"/>
  <fo:table-body>
    <fo:table-row>
      <fo:table-cell>
        <fo:block text-align="left">Prepared By: ${header.prepared}</fo:block>
      </fo:table-cell>
      <fo:table-cell>
        <fo:block text-align="center">Preview By:${header.previewer} </fo:block>
      </fo:table-cell>
      <fo:table-cell>
        <fo:block text-align="right">Approved By: ${header.approve}</fo:block>
      </fo:table-cell>
    </fo:table-row>
  </fo:table-body>
</fo:table>
</#if>

</#escape>