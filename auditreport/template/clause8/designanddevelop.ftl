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
input[type="file"]{
    margin:0px;
    border:0px;
}
.widthReducer{
  width:3rem;
}
</style>


<div class="container">
    <header class="header">
      <h1>Design & Development</h1>
      <#if ramsOutputTitle?has_content>
      <div class="header-info">
        <div>Ref No: <input id="docId" value="${ramsOutputTitle.docId!""}"/></div>
        <div>Rev No: <input id="revision" value="${ramsOutputTitle.revision!""}"/></div>
        <div style="margin-top:1rem;">Date: <input type="date" id="saveDate" value="${ramsOutputTitle.date!""}"/></div>
      </div>
      <#else>
            <div class="header-info">
        <div>Ref No: <input id="docId" /></div>
        <div>Rev No: <input id="revision" /></div>
        <div style="margin-top:1rem;">Date: <input type="date" id="saveDate" /></div>
      </div>
      </#if>
    </header>

<#if ramsOutputDetails?has_content>
  <table id="processTable">
      <thead>
        <tr>
          <th>Process/Activity</th>
          <th>Applicable Tools/Standards</th>
          <th>Status</th>
          <th>Remarks</th>
        </tr>
      </thead>
      <tbody>
      <#list ramsOutputDetails as group>
        <tr>
          <td>${group.process!" "}</td>
          <td contenteditable="true">${group.tools!" "}</td>
          <td>${group.status!" "}</td>
          <td>${group.remark!" "}</td>
          <td contenteditable="true"></td>
        </tr>
        </#list>
      </tbody>
    </table>
<#else>
      <table id="processTable">
          <thead>
            <tr>
              <th>Process/Activity</th>
              <th>Applicable Tools/Standards</th>
              <th>Status</th>
              <th>Remarks</th>
              <th class="widthReducer"></th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>PDR</td>
              <td contenteditable="true">MIL, RTCA DO, ASTM</td>
              <td>
                <select id="select" name="status">
                    <option value="Complete">Complete</option>
                    <option value="In Progress">In Progress</option>
                    <option value="Not Started">Not Started</option>
                </select>
              </td>
              <td contenteditable="true">
                
              </td>
              <td><input type="file"/></td>
            </tr>
            <tr>
              <td>CDR</td>
              <td contenteditable="true">MIL, RTCA DO, ASTM</td>
              <td>
                <select id="select" name="status">
                    <option value="Complete">Complete</option>
                    <option value="In Progress">In Progress</option>
                    <option value="Not Started">Not Started</option>
                </select>
              </td >
              <td contenteditable="true">
              </td>
               <td><input type="file"/></td>
            </tr>
            <tr>
              <td>Design Failure Mode Error Analysis (DFMEA)</td>
              <td contenteditable="true">MIL, RTCA DO, ASTM</td>
              <td>
                <select id="select" name="status">
                    <option value="Complete">Complete</option>
                    <option value="In Progress">In Progress</option>
                    <option value="Not Started">Not Started</option>
                </select>
              </td>
              <td contenteditable="true">
                
              </td>
               <td><input type="file"/></td>
            </tr>
            <tr>
              <td>Failure Mode Error Analysis Corrective Action (FMECA)</td>
              <td contenteditable="true"></td>
              <td>
                <select id="select" name="status">
                    <option value="Complete">Complete</option>
                    <option value="In Progress">In Progress</option>
                    <option value="Not Started">Not Started</option>
                </select>
              </td>
              <td contenteditable="true">
                
              </td>
               <td><input type="file"/></td>
            </tr>
            <tr>
              <td>Reliablity Availability Maintainability Safety (RAMS) Analysis</td>
              <td contenteditable="true">MIL, RTCA DO, ASTM</td>
              <td>
                <select id="select" name="status">
                    <option value="Complete">Complete</option>
                    <option value="In Progress">In Progress</option>
                    <option value="Not Started">Not Started</option>
                </select>
              </td>
              <td contenteditable="true">
                
              </td>
               <td><input type="file"/></td>
            </tr>
          </tbody>
      </table>
</#if>
    
 <#if ramsOutputTitle?has_content>  
    <footer class="footer">
      <div>Prepared By:<input  id="preparer" value="${ramsOutputTitle.prepared!""}"/></div>
      <div>Previewer By:<input id="previewer" value="${ramsOutputTitle.previewer!""}"/></div>
      <div>Approved By:<input id="approver" value="${ramsOutputTitle.approve!""}"/></div>
    </footer>
    <#else>
    <footer class="footer">
      <div>Prepared By:<input  id="preparer" /></div>
      <div>Previewer By:<input id="previewer" /></div>
      <div>Approved By:<input id="approver" /></div>
    </footer>
    </#if> 
    <#if printdoc?has_content>
          <button ><a style="color:black" href="ReportPdfDesign?printdoc=done&docId=${ramsOutputTitle.docId}">Print Document</a></button>
    <#elseif createcontent?has_content>
      <button id="addRowBtn">Add Row</button>
      <button id="SaveBtn">Save</button>
    </#if>
    
  </div>