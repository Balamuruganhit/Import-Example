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
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>



<style>
        
        table {
            width: 100%;
            display: table-cell;
            border-collapse: collapse;
        }
        th, td {
            border: 2px solid black;
            padding: 8px;
            text-align: center;
            font-size: 12px;
            font-weight:bolder;
            
        }
        th {
            background-color:#153d9d;
            color:white;
        }
        .header-table td {
            font-weight: bold;
            text-align: left;
            border: none;
            padding: 5px;
        }
        .colorAdd{
            background:rgb(173, 170, 170);
        }
        .HeightSetter td{
            height:8rem;
        }
        .input{
            width:10rem;
            height:5rem;
            resize:none;
        }
        .biggerInput{
            width:40rem;
            height:5rem;
            resize:none;
        }
        .inputSize{
            width:90%;
            resize:none;
        }
       
        .input1{
            width:8rem;
            height: 9rem;
            resize:none;
        }
        textarea::-webkit-scrollbar {
            display: none; /* Hides scrollbar in WebKit browsers */
            }
        .input12{
            width:3rem;
            height: 2rem;
            resize:none;
            margin-bottom:10px;
        }
        .HeightSetter textarea{
            resize:none;
        }
        
       .flex{
        display:flex;
        flex-direction:column;
       }
       .setter{
        width:20rem
       }
       #generate{
        margin-top:1rem;
       }
       #addButton{
        width:7rem;
        height:5rem;
        margin-top:1rem;
       }
       .printbutton:hover{
        color:black;
        border:1px solid black;
        a{
            color:black !important;
        }
       }
       
</style>


    <center>
        <h2><b>DESIGN</b></h2>
        <br/>
        <h2>FAILURE MODE AND EFFECT ANALYSIS</h2>
        <br/>
        <h2>(D-FMEA)</h2>
        <br/>
    </center>
<div class="flex">
    <table class="mytable"  id="firstTable" >
        <tr class="detail">
            <th class="bolderHeader" colspan="3">Drawing</th>
            <#if femaOutputTitle?has_content >
            <td colspan="2"><input type="text" style="width: 10rem;height: 3rem;"  value="${femaOutputTitle.drawing!""}"/></td>
            <#else>
                <td colspan="2"><input type="text"/></td>
            </#if>
            <th colspan="3">Part Name:</th>
            <#if femaOutputTitle?has_content >
            <td colspan="5" style="padding:0px;"><input type="text" style="width: 48rem;height: 3rem;" value="${femaOutputTitle.part!""}"/></td>
            <#else>
                <td colspan="5" style="padding:0px;"><input type="text"/></td>
            </#if>
            
            <th >Rev:</th>
            <#if femaOutputTitle?has_content >
            <td colspan="2"><input type="text" style="width: 10rem;height: 3rem;" value="${femaOutputTitle.rev!""}"/></td>
            <#else>
                <td colspan="2"><input type="text"/></td>
            </#if>
            <th>DFMEA Number</th>
            <#if femaOutputTitle?has_content >
            <td colspan="2"><input style="width: 15rem;height: 3rem;" type="text" value="${femaOutputTitle.femaId!""}"/></td>
            <#else>
                <td colspan="2"><input type="text"/></td>
            </#if>
        </tr>
        <tr class="detail">
            <th colspan="3">System Subsystem Components:</th>
             <#if femaOutputTitle?has_content >
            <td colspan="2"><textarea class="input" value="${femaOutputTitle.comp}" type="text">${femaOutputTitle.comp!""}</textarea></td>
            <#else>
            <td colspan="2"><textarea class="input" type="text"></textarea></td>
            </#if>
            <th colspan="3">Design Responsibility:</th>
            <#if femaOutputTitle?has_content >
            <td colspan="5"><textarea class="biggerInput" value="${femaOutputTitle.design}"  type="text">${femaOutputTitle.design!""}</textarea></td>
            <#else>
            <td colspan="5"><textarea class="biggerInput"  type="text"></textarea></td>
            </#if>
            <th>Prepared By:<br>Approved By:</th>
            <#if femaOutputTitle?has_content >
            <td colspan="5"><textarea class="input" style="width:90%" value="" type="text">${femaOutputTitle.prepareField!""}</textarea>
            <#else>
            <td colspan="5"><textarea class="input" style="width:90%" type="text"></textarea>
            </#if>
            </td>
        </tr>
        <tr class="detail">
            <th colspan="3">Team Members</th>
            <#if femaOutputTitle?has_content >
            <td colspan="12"><textarea class="inputSize"  type="text">${femaOutputTitle.team!""}</textarea></td>
            <#else>
            <td colspan="12"><textarea class="inputSize" type="text"></textarea></td>
            </#if>
            <th>Date:</th>
            <#if femaOutputTitle?has_content >
            <td colspan="3"><input type="Date" value="${femaOutputTitle.femaDate!""}"/></td>
            <#else>
            <td colspan="3"><input type="Date"/></td>
            </#if>
        </tr> 
    
    
    
    
       <tr class="change">
            <th >Item</th>
            <th>Function</th>
            <th >Requirements</th>
            <th >Potential Failure Mode</th>
            <th >Potential Effects of Failure</th>
            <th >Severity (S)</th>
            <th >Potential Cause / Mechanism of Failure</th>
            <th>Occurrence (O)</th>
            <th >Current Design Control</th>
            <th >Detection Control</th>
            <th>Deductions (D)</th>
            <th>RPN</th>
            <th>Recommended Action</th>
            <th>Responsibility & Target Date</th>
            <th>Action Taken</th>
            <th>Severity (S)</th>
            <th>Occurrence (O)</th>
            <th>Detection (D)</th>
            <th>RPN</th>
        </tr>
        <tr>
            <th colspan="8">Function and Requirement Focus:</th>
            <th colspan="6">Design Process Focus:</th>
              <th colspan="3">Risk Mitigation Focus</th>
            <th colspan="5">Improvement Action Focus:</th>
            
        </tr>
        <tr>
            <th colspan="3">Section 1</th>
            <th colspan="3">Section 2</th>
            <th colspan="1">Section 3</th>
            <th></th>
            <th colspan="3">Section 4</th>
            <th colspan="3">Section 5</th>
            <th colspan="5">Section 6</th>
            
           
        </tr>
        <tr class="colorAdd">
            <td>What is the item that you are focusing on?</td>
            <td>What function does the item have?</td>
            <td>What are you trying to achieve (Product Requirement)?</td>
            <td>How could you get the requirements wrong (Failure Mode)?</td>
            <td>What could happen if it goes wrong (Potential Effects)?</td>
            <td>How bad would it be if it goes wrong (Severity Score)?</td>
            <td>What would need to fail in the design to cause the failure mode to occur (Potential Cause)?</td>
            <td>How likely is it to go wrong (Occurrence Score)?</td>
            <td>How could this be prevented (Prevention Control)?</td>
            <td>How will you check if the cause and/or failure mode occurs (Detection Control)?</td>
            <td>How likely are you to detect the cause or failure mode if it was defective (Detection Score)?</td>
            <td>Risk Priority Number (RPN)</td>
            <td>List of actions required to mitigate key risks identified</td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            
        </tr>
        <#if femaOutputDetails ?has_content >
        <#list femaOutputDetails as taskDetail>
        
        <tr class="HeightSetter">
            <td rowspan="6">
            <#if taskDetail?has_content >
           <textarea class="input1" type="text">${taskDetail.item!""}</textarea></td>
            <#else>
                <textarea class="input1" type="text"></textarea></td>
            </#if></td>
            <td rowspan="6">
            <#if taskDetail?has_content >
           <textarea class="input1" type="text">${taskDetail.functionPart!""}</textarea></td>
            <#else>
                <textarea class="input1" type="text"></textarea></td>
            </#if></td>
            <td rowspan="6">
            <#if taskDetail?has_content >
           <textarea class="input1" type="text">${taskDetail.achieve!""}</textarea></td>
            <#else>
                <textarea class="input1" type="text"></textarea></td>
            </#if></td>
            <td rowspan="6">
            <#if taskDetail?has_content >
           <textarea class="input1" type="text">${taskDetail.failureMode!""}</textarea></td>
            <#else>
                <textarea class="input1" type="text"></textarea></td>
            </#if></td>
           <td rowspan="6">
            <#if taskDetail?has_content >
           <textarea class="input1" type="text">${taskDetail.potentialEffects!""}</textarea></td>
            <#else>
                <textarea class="input1" type="text"></textarea></td>
            </#if></td>
            <td rowspan="6"><#if taskDetail?has_content >
                <input class="input12" type="text" id="finalValue" value="${taskDetail.severity!""}" />            
            <#else>
                <input class="input12" type="text" id="finalValue" />            
            </#if></td>
            <td rowspan="6">
            <#if taskDetail?has_content >
                <textarea class="input1" type="text">${taskDetail.potentialCause!""}</textarea></td>
            <#else>
                <textarea class="input1" type="text"></textarea></td>
            </#if></td>
             <td rowspan="6"><#if taskDetail?has_content >
                <input class="input12" type="text" id="finalValue" value="${taskDetail.occurrence!""}" disabled/>            
            <#else>
                <input class="input12" type="text" id="finalValue" disabled/>            
            </#if></td>
            <td rowspan="6">
            <#if taskDetail?has_content >
                <textarea class="input1" type="text">${taskDetail.designControl!""}</textarea></td>
            <#else>
                <textarea class="input1" type="text"></textarea></td>
            </#if>
            <td rowspan="6">
            <#if taskDetail?has_content >
                <textarea class="input1" type="text">${taskDetail.detectionControl!""}</textarea></td>
            <#else>
                <textarea class="input1" type="text"></textarea></td>
            </#if></td>
             <td rowspan="6"><#if taskDetail?has_content >
                <input class="input12" type="text" id="finalValue" value="${taskDetail.detection!""}" disabled/>            
            <#else>
                <input class="input12" type="text" id="finalValue" disabled/>            
            </#if></td>
            <td rowspan="6"><#if taskDetail?has_content >
                <input class="input12" type="text" id="finalValue" value="${taskDetail.rPN!""}" disabled/>            
            <#else>
                <input class="input12" type="text" id="finalValue" disabled/>            
            </#if></td>            
           <td rowspan="6">
            <#if taskDetail?has_content >
           <textarea class="input1" type="text">${taskDetail.action!""}</textarea></td>
            <#else>
                <textarea class="input1 setter" type="text"></textarea></td>
            </#if></td>
           <td rowspan="6">
            <#if taskDetail?has_content >
                <textarea class="input1" type="text">${taskDetail.responsibility!""}</textarea></td>
            <#else>
                <textarea class="input1 setter" type="text"></textarea></td>
            </#if></td>
            <td rowspan="6">
            <#if taskDetail?has_content >
                <textarea class="input1" type="text">${taskDetail.actionTaken!""}</textarea></td>
            <#else>
                <textarea class="input1 setter" type="text"></textarea></td>
            </#if></td>
            <td rowspan="6"><#if taskDetail?has_content >
                <input class="input12" type="text" id="finalValue" value="${taskDetail.severity1!""}" disabled/>            
            <#else>
                <input class="input12" type="text" id="finalValue" disabled/>            
            </#if></td>
            <td rowspan="6"><#if taskDetail?has_content >
                <input class="input12" type="text" id="finalValue" value="${taskDetail.occurrence1!""}" disabled/>            
            <#else>
                <input class="input12" type="text" id="finalValue" disabled/>            
            </#if></td>
            <td rowspan="6"><#if taskDetail?has_content >
                <input class="input12" type="text" id="finalValue" value="${taskDetail.detection1!""}" disabled/>            
            <#else>
                <input class="input12" type="text" id="finalValue" disabled/>            
            </#if></td>
            <td rowspan="6"><#if taskDetail?has_content >
                <input class="input12" type="text" id="finalValue" value="${taskDetail.rPN1!""}" disabled/>            
            <#else>
                <input class="input12" type="text" id="finalValue" disabled/>            
            </#if></td>
        </tr>
       </#list>
       <#else>
         <tr class="HeightSetter">
            <td rowspan="6"><textarea class="input1" type="text"></textarea></td>
            <td rowspan="6"><textarea class="input1" type="text"></textarea></td>
            <td rowspan="6"><textarea class="input1" type="text"></textarea></td>
            <td rowspan="6"><textarea class="input1" type="text"></textarea></td>
            <td rowspan="6"><textarea class="input1" type="text"></textarea></td>
            <td rowspan="6"><select class="select1">
                <#list 1..10 as i> 
                    <option value="${i}">${i}</option>
                </#list>  
            </select></td>
            <td rowspan="6"><textarea class="input1" type="text"></textarea></td>
            <td rowspan="6"><select class="select2">
                <#list 1..10 as i> 
                    <option value="${i}">${i}</option>
                </#list>  
            </select></td>
            <td rowspan="6"><textarea class="input1" type="text"></textarea></td>
            <td rowspan="6"><textarea class="input1" type="text"></textarea></td>
            <td rowspan="6"><select class="select3">
                <#list 1..10 as i> 
                    <option value="${i}">${i}</option>
                </#list>  
            </select></td>
            <td rowspan="6"><input class="input12 result" type="text"  disabled/><button class="button_submit">Calculate</button></td>
            
            <td rowspan="6"><textarea class="input1 setter" type="text"></textarea></td>
            <td rowspan="6"><textarea class="input1 setter" type="text"></textarea></td>
            <td><textarea class="input1 setter" type="text"></textarea></td>
            <td><select class="select4">
                <#list 1..10 as i> 
                    <option value="${i}">${i}</option>
                </#list>  
            </select></td>
            <td><select class="select5">
                <#list 1..10 as i> 
                    <option value="${i}">${i}</option>
                </#list>  
            </select></td>
            <td><select class="select6">
                <#list 1..10 as i> 
                    <option value="${i}">${i}</option>
                </#list>  
            </select></td>
            <td><input class="input12 result2" type="text"  disabled/><button class="button_submit2">Calculate</button></td>
        </tr>
       </#if>
    </table>
    
    
    </div>
    <br/>
  <button style="margin:1rem;margin-bottom:2rem;" class="printbutton"><a style="color:white" href="Report.pdf?femaId=${femaOutputTitle.femaId}">Print Document</a></button>

