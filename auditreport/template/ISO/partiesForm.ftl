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
<style>
.container {
  border: 1px solid #000;
  padding: 20px;
  max-width: 120rem;
  margin: auto;
  background: white;
}

.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  border-bottom: 2px solid #000;
  padding-bottom: 10px;
}

.header h1 {
  background: #3699ff;
  padding: 10px;
  margin: 0;
  flex-grow: 1;
}

.header-info {
  text-align: right;
  padding-left: 10px;
}

.sub-header {
  display: flex;
  justify-content: space-between;
  margin: 10px 0;
}

table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 10px;
}

th, td {
  border: 1px solid #000;
  vertical-align: top;
  padding: 8px;
  text-align: left;
}

ul {
  margin: 0;
  padding-left: 18px;
}

.footer {
  display: flex;
  justify-content: space-between;
  margin-top: 20px;
}
input{
    border:0px;
    margin-left:1rem;
    padding:1rem;
    border-bottom:1px dashed black;
}
input[type="date"]{
    width:16rem;
}
button{
    margin-top:3rem;
}
</style>


<div class="container">
    <header class="header">
      <h1>Needs & Expectations of Interested Parties</h1>
      <#if header?has_content>
      <div class="header-info">
        <div>Ref No: <input id="docId" value="${header.docId!""}"/></div>
        <div>Rev No: <input id="revision" value="${header.revision!""}"/></div>
        <div style="margin-top:1rem;">Date: <input type="date" id="saveDate" value="${header.date!""}"/></div>
      </div>
      <#else>
            <div class="header-info">
        <div>Ref No: <input id="docId" /></div>
        <div>Rev No: <input id="revision" /></div>
        <div style="margin-top:1rem;">Date: <input type="date" id="saveDate" /></div>
      </div>
      </#if>
    </header>
  <#if header?has_content>
    <div class="sub-header">
      <div>Next review Date: <input type="date" id="previewDate" value="${header.previewDate!""}"/></div>
    </div>
   <#else>
    <div class="sub-header">
      <div>Next review Date: <input type="date" id="previewDate" /></div>
    </div>
   </#if>
<#if data?has_content>
  <table>
      <thead>
        <tr>
          <th>Interested Party</th>
          <th>Internal or External</th>
          <th>Needs</th>
          <th>Expectations</th>
          <th style="width:10rem"></th>
          <th style="width:5rem"></th>
        </tr>
      </thead>
      <tbody>
      <#list data as group>
        <tr>
          <td>${group.interestedParty!" "}</td>
          <td>${group.internalOrExternal!" "}</td>
          <td>
            <ul>
            <#list group.needs as need>
              <li>${need}</li>
            </#list>  
            </ul>
          </td>
          <td>
            <ul>
              <#list group.expectations as expectation>
              <li>${expectation}</li>
            </#list>
            </ul>
          </td>
          <td></td>
          <td></td>
        </tr>
        </#list>
      </tbody>
    </table>
<#else>
      <table>
          <thead>
            <tr>
              <th>Interested Party</th>
              <th>Internal or External</th>
              <th>Needs</th>
              <th>Expectations</th>
              <th></th>
              <th></th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>Customers</td>
              <td>External</td>
              <td>
                <ul>
                  <li>Ontime delivery</li>
                  <li>Good Packing condition</li>
                  <li>Ontime technical support</li>
                  <li>Customised product as per requirements</li>
                </ul>
              </td>
              <td>
                <ul>
                  <li>Maximise new and customised product development</li>
                  <li>Strengthen inhouse design capabilities</li>
                  <li>Ontime response</li>
                  <li>Zero customer complaint</li>
                  <li>Emphasising stringent</li>
                </ul>
              </td>
              <td></td>
              <td></td>
            </tr>
            <tr>
              <td>Supplier</td>
              <td>External</td>
              <td>
                <ul>
                  <li>Clear purchase specifications</li>
                  <li>Clear Delivery schedules</li>
                </ul>
              </td>
              <td>
                <ul>
                  <li>Commitment for long term business</li>
                  <li>Long term relationship</li>
                  <li>Prompt intimation of rejections and claims</li>
                  <li>On time payment</li>
                </ul>
              </td>
              <td></td>
              <td></td>
            </tr>
            <tr>
              <td>Service Providers (Transporters)</td>
              <td>External</td>
              <td>
                <ul>
                  <li>Clear documentation</li>
                  <li>Excise invoice</li>
                  <li>E-Sugam</li>
                  <li>Road permit, if applicable</li>
                </ul>
              </td>
              <td>
                <ul>
                  <li>Waiting time to be less</li>
                  <li>On time payment</li>
                </ul>
              </td>
              <td></td>
              <td></td>
            </tr>
            <tr>
              <td>Visitors</td>
              <td>External</td>
              <td>
                <ul>
                  <li>Good & Safe environment</li>
                  <li>Better identification of Areas & Contact details</li>
                </ul>
              </td>
              <td><ul><li>Safe environment</li></ul></td>
              <td></td>
              <td></td>
            </tr>
            <tr>
              <td>Employees (marketing)</td>
              <td>Internal</td>
              <td>
                <ul>
                  <li>Clear customer requirements</li>
                  <li>Good working environment</li>
                  <li>Good product knowledge</li>
                  <li>Clear company Policies</li>
                  <li>On-job training</li>
                  <li>Fair & Transparent administration</li>
                </ul>
              </td>
              <td>
                <ul>
                  <li>Good Salary & Benefits</li>
                  <li>Good and Transparent admin policies</li>
                </ul>
              </td>
              <td style="width:10rem"></td>
              <td style="width:5rem"></td>
            </tr>
          </tbody>
      </table>
</#if>
    
 <#if header?has_content>  
    <footer class="footer">
      <div>Prepared By:<input  id="preparer" value="${header.prepared!""}"/></div>
      <div>Previewer By:<input id="previewer" value="${header.previewer!""}"/></div>
      <div>Approved By:<input id="approver" value="${header.approve!""}"/></div>
    </footer>
    <#else>
    <footer class="footer">
      <div>Prepared By:<input  id="preparer" /></div>
      <div>Previewer By:<input id="previewer" /></div>
      <div>Approved By:<input id="approver" /></div>
    </footer>
    </#if> 
    <#if data?has_content>
          <button ><a style="color:black" href="ReportPdfparties?parties=${header.docId}">Print Document</a></button>
    <#else>
      <button id="addRowBtn">Add Row</button>
      <button id="SaveBtn">Save</button>
    </#if>
    
  </div>