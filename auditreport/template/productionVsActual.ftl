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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.6.0/jspdf.plugin.autotable.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
    <style>
        .table-container {
            overflow-x: auto;
            position: relative;
        }
        textarea{
            resize: none;
        }
        table {
            width:90%;
            border-collapse: collapse;
            text-align: center;
            table-layout: fixed;
            border: 1px solid black;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 0px;
            text-align: center;
        }
        thead th{
            padding:8px;
        }
        th {
            background-color: #f4f4f4;
            position: sticky;
            top: 0;
            z-index: 2;
        }
        .part-number-cell {
            position: sticky;
            left: 0;
            background-color: white;
            z-index: 3;
            vertical-align: middle;
            font-weight: bold;
        }
        .footer-section {
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
        }
        .footer-section input {
            width: 200px;
            padding: 5px;
            border: 1px solid #ccc;
        }
        .buttons {
            margin-top: 10px;
        }
        .buttons button {
            padding: 10px;
            margin-right: 10px;
            cursor: pointer;
            border: none;
            color: white;
        }
        .pdf-btn {
            background-color: blue;
        }
        .excel-btn {
            background-color: green;
        }
        .actual{
            padding:0px;
            width:60%;
        }
        .planned{
            padding:0px;
            width:60%
        }
        .remark{
            width:80%
        }
        .month{
            width:89%;
        }
        
       
    </style>
<#if femaList?has_content>
    <div class="table-container">
    <table>
        <thead>
            <tr>
                <th class="part-number-cell">Part Number</th>
                <th>Month</th>
                <th>Planned Production</th>
                <th>Actual Production</th>
                <th>Efficiency (%)</th>
                <th>Target Achieved (>=85%)? yes/No</th>
                <th>Remark</th>
            </tr>
        </thead>
        <tbody id="table-body">
            <!-- Merged Part Number Cell -->
            
           <#list femaList as data>
  <#assign entrySize = data.entries?size>
  <#list data.entries as detailData>
    <#if detailData_index == 0>
      <tr>
        <td class="part-number-cell" rowspan="${entrySize}">
          <textarea name="part" style="width: 80%;">${data.productId}</textarea>
        </td>
    <#else>
      <tr>
    </#if>
        <td><input type="date" name="date" class="month" value="${detailData.lastUpdatedDate}" /></td>
        <td><input type="number" name="planned" class="planned" value="${detailData.quantityRejected}" oninput="calculateEfficiency(${data_index}_${detailData_index})" /></td>
        <td><input type="number" name="actual" class="actual" value="${detailData.quantityProduced!detailData.quantityRejected}" oninput="calculateEfficiency(${data_index}_${detailData_index})" /></td>
        <td class="efficiency"></td>
        <td class="target"></td>
        <td><textarea class="remark" rows="2"></textarea></td>
      </tr>
  </#list>
</#list>
                            
                    
        </tbody>
    </table>
</div>

<!-- Footer Section for "Prepared By" and "Checked By" -->
<div class="footer-section">
    <label>Prepared By: <input type="text" id="preparedBy"></label>
    <label>Checked By: <input type="text" id="checkedBy"></label>
</div>

<div class="buttons">
    <button class="pdf-btn" onclick="exportToPDF()">Export to PDF</button>
    <button class="excel-btn" onclick="exportToExcel()">Export to Excel</button>
</div>
<#else>
    <div>No Data Found Between the Date</div>
</#if>



