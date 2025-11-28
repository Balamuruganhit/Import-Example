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
        .table-container {
           display: block;
           
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
            padding: 15px;
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
<#if otdDatas?has_content>
    <div class="table-container" style="margin-left:7%;margin-bottom:4rem">
    <table>
        <thead>
            <tr>
                <th class="part-number-cell">Month</th>
                <th>Order Number</th>
                <th>Quantity</th>
                <th>Date Confirmed</th>
                <th>Date Shipped</th>
                <th>No of days to Dispatch Post Order Confirmation</th>
                <th>Planned Delivery Schedule</th>
                <th>On Time Delivery Performance (%)</th>
            </tr>
        </thead>
        <tbody id="table-body">
         <#list otdDatas as data>
            <tr>
                <td>${data.month}</td>
                <td>${data.orderHeader}</td>
                <td>${data.orderItem.quantity}</td>
                <td>${data.orderDate}</td>
                <td>${data.orderItem.shipBeforeDate!""}</td>
                <td>${data.orderItem.estimatedShipDate!""}</td>
                <td>${data.orderItem.estimatedDeliveryDate!""}</td>
                <td>${data.orderItem.performaceEfficency!""}</td>
            </tr>
         </#list>      
        </tbody>
    </table>
</div>


<div class="buttons">
    <button class="pdf-btn" ><a href="<@ofbizUrl>PrintOTD?date_fld0_value=${start}&date_fld1_value=${end}&ontime=starter</@ofbizUrl>">Print PDF</a></button>
   
</div>
<#else>
    <div>No Date Found Between the Month</div>
<!-- Footer Section for "Prepared By" and "Checked By" -->
</#if>





