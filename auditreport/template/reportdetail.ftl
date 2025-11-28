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
<form class="basic-form" id="AddReportDetail" name="AddReportDetail"  enctype="multipart/form-data">
  <table>
    <tbody>
      <tr>
      <td class="label"><label>${uiLabelMap.AuditReportNo}</label></td>
      <td> <input type="text" id="reportId"  name="reportId" list="listReport" autocomplete="off"/>
            <datalist id="listReport"></datalist>
            <lable value="change" style="
                    height: 1rem;
                    /* width: 1rem; */
                    display: inline;
                    position: relative;
                    
                ">The Charater contains:</lable>
          <small id="reportCount" style="
              position: relative">0/20</small>
        </td>
    </tr>
      <tr>
        <td class="label"><label>${uiLabelMap.FormFieldTitle_Question}</label></td>
        <td>
            <select name="question" id="question">
                <#list questions as question>
                    <option value="${question.question!}">${question.question!}</option>
                </#list>
                <option selected="" value="">Select the question</option>
            </select>
        </td>
      </tr>
      <tr>
        <td class="label"><label>${uiLabelMap.AuditReportRating}</label></td>
        <td> <input type="text" id="rating" name="rating" autocomplete="off"/></td>
      </tr>
      
      <tr>
        <td class="label"><label>${uiLabelMap.AuditReportComment}</label></td>
        <td><textarea name="comment" id="comment" rows="4" cols="15"></textarea>
        <lable value="change" style="
                  height: 1rem;
                  /* width: 1rem; */
                  display: inline;
                  position: relative;
                  right: -63rem;
              ">The Charater contains: </lable>
        <small id="charCount" style="
            position: relative;
            right: -63rem;
        ">0/250</small></td>
      </tr>
      <tr>
        <td class="label"><label>${uiLabelMap.AuditReportProof}</label></td>
        <td><input type="file" size="20" id="proof" name="proof"accept=".png,.gif,.jpg,.jpeg,.tiff,.tif"/></td>
      </tr>
    	<td class="label"><label>${uiLabelMap.AuditReportApprove}</label></td>
        <td> <input type="text" id="approve" name="approve" autocomplete="off"/></td>
      </tr>
      <tr>
        <td class="label"/>
        <td><button id="add-button">Add</button></td>
        <td><button id="submit-button" style="position: absolute;
                      right: 20rem;">Submit</button></td>
      </tr>
    </tbody>
  </table>
</form>
<table class="basic-table light-grid hover-bar">
    <thead>
        <tr class="header-row-2">
            <th>Report ID</th>
            <th>Question</th>
            <th>Rating</th>
            <th>Comment</th>
            <th>Proof</th>
            <th>Approver Name</th>
            <th>Button</th>
        </tr>
    </thead>
    <tbody id="data-table-body"></tbody>
</table>

