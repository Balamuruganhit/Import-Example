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
      <fo:block space-after="10pt">
        <fo:inline font-weight="bold">Next Review Date: </fo:inline>${header.previewDate!""}
      </fo:block>
      <#if data?has_content>
  <fo:table space-after="10pt" table-layout="fixed" text-align="center" display-align="center" width="100%" border="solid 0.5pt black" font-size="10pt">
    <fo:table-column column-width="3cm"/>
    <fo:table-column column-width="3cm"/>
    <fo:table-column column-width="5cm"/>
    <fo:table-column column-width="5cm"/>
    <fo:table-column column-width="2cm"/>
    <fo:table-column column-width="2cm"/>
    
    <fo:table-header>
      <fo:table-row>
        <fo:table-cell border="1pt solid black"><fo:block font-weight="bold">Interested Party</fo:block></fo:table-cell>
        <fo:table-cell border="1pt solid black"><fo:block font-weight="bold">Internal or External</fo:block></fo:table-cell>
        <fo:table-cell border="1pt solid black"><fo:block font-weight="bold">Needs</fo:block></fo:table-cell>
        <fo:table-cell border="1pt solid black"><fo:block font-weight="bold">Expectations</fo:block></fo:table-cell>
        <fo:table-cell border="1pt solid black"><fo:block/></fo:table-cell>
        <fo:table-cell border="1pt solid black"><fo:block/></fo:table-cell>
      </fo:table-row>
    </fo:table-header>
        <fo:table-body>
    <#list data as group>
      <fo:table-row >
        <fo:table-cell border="1pt solid black"><fo:block>${group.interestedParty!" "}</fo:block></fo:table-cell>
        <fo:table-cell border="1pt solid black"><fo:block>${group.internalOrExternal!" "}</fo:block></fo:table-cell>

        <fo:table-cell border="1pt solid black" padding-left="5pt">
          <fo:block text-align="left" >
          <#list group.needs as need>
            &#x2022; ${need}<fo:block/>
          </#list>
          </fo:block>
        </fo:table-cell>

        <fo:table-cell border="1pt solid black" padding-left="5pt">
          <fo:block text-align="left">
          <#list group.expectations as expectation>
            &#x2022; ${expectation}<fo:block/>
          </#list>
          </fo:block>
        </fo:table-cell>

        <fo:table-cell border="1pt solid black"><fo:block/></fo:table-cell>
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