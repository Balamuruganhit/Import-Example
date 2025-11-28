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
      <h1>Internal & External Issues Register</h1>
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
<#if data?has_content>
    <div style="text-align:center; font-size:20px;height:3rem; background-color:#3c8beed9; width:100%;">Internal Issues Register</div>

  <table>
      <thead>
        <tr>
          <th>Issues</th>
          <th>Description of risk</th>
          <th>Risk Value</th>
          <th >Opportunities / Mitigation </th>
          <th >Objective</th>
          <th style="width:10rem"></th>
        </tr>
      </thead>
      <tbody>
      <#list data[0..4] as group>
        
        <tr>
          <td>${group.issue!" "}</td>
          <td>
            <ul>
            <#list group.riskDescription as riskDescription>
              <li>${riskDescription}</li>
            </#list>  
            </ul>
          </td>
          <td>${group.riskValue!" "}</td>
          
          <td>
            <ul>
              <#list group.mitigation as mitigation>
              <li>${mitigation}</li>
            </#list>
            </ul>
          </td>
          <td>
          <ul>
              <#list group.objective as objective>
              <li>${objective}</li>
            </#list>
            </ul></td>
          <td></td>
        </tr>
        </#list>
      </tbody>
    </table> 
    <div style="text-align:center; font-size:20px;height:3rem; background-color:#3c8beed9; width:100%;">External Issues Register</div>
<table>
      <tbody>
      <#list data[5..] as group>
        
        <tr>
          <td>${group.issue!" "}</td>
          <td>
            <ul>
            <#list group.riskDescription as riskDescription>
              <li>${riskDescription}</li>
            </#list>  
            </ul>
          </td>
          <td>${group.riskValue!" "}</td>
          
          <td>
            <ul>
              <#list group.mitigation as mitigation>
              <li>${mitigation}</li>
            </#list>
            </ul>
          </td>
          <td >
          <ul>
              <#list group.objective as objective>
              <li>${objective}</li>
            </#list>
            </ul></td>
          <td style="width:10rem"></td>
        </tr>
        </#list>
      </tbody>
    </table>

<#else>
<div style="text-align:center; font-size:20px;height:3rem; background-color:#3c8beed9; width:100%;">Internal Issues Register</div>
      <table>
          <thead>
            <tr>
                <th>Issues</th>
                <th>Description of risk</th>
                <th>Risk Value</th>
                <th >Opportunities / Mitigation </th>
                <th >Objective</th>
                <th style="width:10rem"></th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>Manpower Attrition</td>
              <td><ul>
                  <li>Delay in achieving production targets</li>
                  <li>Increase in recruitment costs</li>
                </ul></td>
              <td>
                <select id="risk">
                    <option value="High">High</option>
                    <option value="Medium">Medium</option>
                    <option value="Low">Low</option>
                </select>
              </td>
              <td>
                <ul>
                  <li>Timely amendment of policies related to labour & welfare</li>
                  <li>Continuous training and monitor the workforce closely and satisfy their needs without any delay.</li>
                </ul>
              </td>
              <td><div contenteditable="true"></div></td>
              <td></td>
            </tr>
            <tr>
              <td>Employees attitude & behavior </td>
              <td><ul>
                  <li>Lack in personality training</li>
                </ul></td>
              <td>
                <select id="risk">
                    <option value="High">High</option>
                    <option value="Medium">Medium</option>
                    <option value="Low">Low</option>
                </select>
              </td>
              <td>
                <ul>
                  <li>Closely monitor the workforce related to the factors of personal traits and imparts training.</li>
                  <li>Periodical review.</li>
                </ul>
              </td>
              <td><div contenteditable="true"></div></td>
              <td ></td>
            </tr>
            <tr>
              <td>Trends in remuneration & benefits offered by others sectors</td>
              <td><ul>
                  <li>Increase in employee retention costs.</li>
                </ul></td>
              <td>
                <select id="risk">
                    <option value="High">High</option>
                    <option value="Medium">Medium</option>
                    <option value="Low">Low</option>
                </select>
              </td>
              <td>
                <ul>
                  <li>Research on the monetary benefited provided to employees in other factors in the same field and proposes amended remuneration for management approval.</li>
                </ul>
              </td>
              <td><div contenteditable="true"></div></td>
              <td></td>
            </tr>
            <tr>
              <td>Environment parameters changes</td>
              <td><ul>
                  <li>Energy / Noise / Smoke / Dust / Safety</li>
                </ul></td>
              <td>
                <select id="risk">
                    <option value="High">High</option>
                    <option value="Medium">Medium</option>
                    <option value="Low">Low</option>
                </select>
              </td>
              <td>
                <ul>
                  <li>Continuously Monitored & under Controlled</li>
                </ul>
              </td>
              <td><div contenteditable="true"></div></td>
              <td ></td>
            </tr>
            <tr>
              <td>Covid-19 infection</td>
              <td><ul>
                  <li>Illness</li>
                </ul></td>
              <td>
                <select id="risk">
                    <option value="High">High</option>
                    <option value="Medium">Medium</option>
                    <option value="Low">Low</option>
                </select>
              </td>
              <td>
                <ul>
                  <li>100% Vaccination, Instructions displayed to wear mask, Hand washing, social distance maintaining</li>
                </ul>
              </td>
              <td><div contenteditable="true"></div></td>
              <td ></td>
            </tr>
            
            <tr>
              <td>Local competitors can offer similar products with low cost</td>
              <td><ul>
                  <li>Competition will increase and profit margin could reduce</li>
                </ul></td>
              <td>
                <select id="risk">
                    <option value="High">High</option>
                    <option value="Medium">Medium</option>
                    <option value="Low">Low</option>
                </select>
              </td>
              <td>
                <ul>
                  <li>Location and use brand name guaranteed quality and durability to introduce the product</li>
                </ul>
              </td>
              <td><div contenteditable="true"></div></td>
              <td ></td>
            </tr>
            <tr>
              <td>Limited product Range</td>
              <td><ul>
                  <li>Customer requirements will not be fulfilled, chance of losing business in high</li>
                </ul></td>
              <td>
                <select id="risk">
                    <option value="High">High</option>
                    <option value="Medium">Medium</option>
                    <option value="Low">Low</option>
                </select>
              </td>
              <td>
                <ul>
                  <li>Study / Analyse market requirements and develop wide range of Products according to needs.</li>
                </ul>
              </td>
              <td><div contenteditable="true"></div></td>
              <td ></td>
            </tr>
            <tr>
              <td>Limited flexibility in pricing </td>
              <td><ul>
                  <li>Losing the order / Competition will increase and competition will increase, and profit margin could reduce</li>
                </ul></td>
              <td>
                <select id="risk">
                    <option value="High">High</option>
                    <option value="Medium">Medium</option>
                    <option value="Low">Low</option>
                </select>
              </td>
              <td>
                <ul>
                  <li>Alternate source, use brand name guarantee quality & durability to introduce the product.</li>
                </ul>
              </td>
              <td><div contenteditable="true"></div></td>
              <td ></td>
            </tr>
            <tr>
              <td>Not concentrating on all segment</td>
              <td><ul>
                  <li>Can’t develop and get into new verticals. No exponential growth and losing additional opportunity</li>
                </ul></td>
              <td>
                <select id="risk">
                    <option value="High">High</option>
                    <option value="Medium">Medium</option>
                    <option value="Low">Low</option>
                </select>
              </td>
              <td>
                <ul>
                  <li>Introduce a concept of developing a new product on segment basis</li>
                </ul>
              </td>
              <td><div contenteditable="true"></div></td>
              <td ></td>
            </tr>
            <tr>
              <td>Long lead times for Some products </td>
              <td><ul>
                  <li>Chances of losing the order, may affect in branding</li>
                </ul></td>
              <td>
                <select id="risk">
                    <option value="High">High</option>
                    <option value="Medium">Medium</option>
                    <option value="Low">Low</option>
                </select>
              </td>
              <td>
                <ul>
                  <li>Understand customer requirements in advance</li>
                </ul>
              </td>
              <td><div contenteditable="true"></div></td>
              <td ></td>
            </tr>
            <tr>
              <td>Low Volume order</td>
              <td><ul>
                  <li>Pricing flexibility can’t be offered to customer, can’t compete in the market</li>
                </ul></td>
              <td>
                <select id="risk">
                    <option value="High">High</option>
                    <option value="Medium">Medium</option>
                    <option value="Low">Low</option>
                </select>
              </td>
              <td>
                <ul>
                  <li>Find the alternative sources who provide low cost with minimal quantities</li>
                </ul>
              </td>
              <td><div contenteditable="true"></div></td>
              <td ></td>
            </tr>
            <tr>
              <td>Direct purchase </td>
              <td><ul>
                  <li>Less margin and can’t purchase the material</li>
                </ul></td>
              <td>
                <select id="risk">
                    <option value="High">High</option>
                    <option value="Medium">Medium</option>
                    <option value="Low">Low</option>
                </select>
              </td>
              <td>
                <ul>
                  <li>Find affordable suppliers</li>
                </ul>
              </td>
              <td><div contenteditable="true"></div></td>
              <td ></td>
            </tr>
            <tr>
              <td>Change in government policies</td>
              <td><ul>
                  <li>Difficult to get approvals from concerned departments against the revised policies</li>
                </ul></td>
              <td>
                <select id="risk">
                    <option value="High">High</option>
                    <option value="Medium">Medium</option>
                    <option value="Low">Low</option>
                </select>
              </td>
              <td>
                <ul>
                  <li>As per the new / revised policies approvals should be obtained</li>
                </ul>
              </td>
              <td><div contenteditable="true"></div></td>
              <td ></td>
            </tr>
            <tr>
              <td>Government introduces new legislation.e.g., labour laws, tax policies, environmental laws</td>
              <td><ul>
                  <li>Increase in cost to meet all the requirements</li>
                </ul></td>
              <td>
                <select id="risk">
                    <option value="High">High</option>
                    <option value="Medium">Medium</option>
                    <option value="Low">Low</option>
                </select>
              </td>
              <td>
                <ul>
                  <li>Prepare the budget as per the new / revised legislation, in such a way that it will not affect the smooth operation of existing business and try to meet all the applicable laws</li>
                    <li>Look for automation wherever possible.</li>
                </ul>
              </td>
              <td><div contenteditable="true"></div></td>
              <td ></td>
            </tr>
            <tr>
              <td>Foreign exchange fluctuation</td>
              <td><ul>
                  <li>Product cost get increase / decrease effects in profit margin</li>

                </ul></td>
              <td>
                <select id="risk">
                    <option value="High">High</option>
                    <option value="Medium">Medium</option>
                    <option value="Low">Low</option>
                </select>
              </td>
              <td>
                <ul>
                  <li>Monitor volatile variation </li>
                </ul>
              </td>
              <td><div contenteditable="true"></div></td>
              <td ></td>
            </tr>
            <tr>
              <td>Corporate group decision</td>
              <td><ul>
                  <li>Sudden changes in policies.</li>
                  
                </ul></td>
              <td>
                <select id="risk">
                    <option value="High">High</option>
                    <option value="Medium">Medium</option>
                    <option value="Low">Low</option>
                </select>
              </td>
              <td>
                <ul>
                  <li>Communicating about the new policies and changes and admin policies accordingly</li>
                </ul>
              </td>
              <td><div contenteditable="true"></div></td>
              <td></td>
            </tr>
            <tr>
              <td>Environmental Parameters changes at work area</td>
              <td><ul>
                  <li>Energy / Noise / Smoke / dust safety</li>
                  
                </ul></td>
              <td>
                <select id="risk">
                    <option value="High">High</option>
                    <option value="Medium">Medium</option>
                    <option value="Low">Low</option>
                </select>
              </td>
              <td>
                <ul>
                  <li>Continuous monitoring & under controlled.</li>
                </ul>
              </td>
              <td><div contenteditable="true"></div></td>
              <td ></td>
            </tr>
            <tr>
              <td>Covid-19 infection</td>
              <td><ul>
                  <li>Illness & spread to employees</li>
                </ul></td>
              <td>
                <select id="risk">
                    <option value="High">High</option>
                    <option value="Medium">Medium</option>
                    <option value="Low">Low</option>
                </select>
              </td>
              <td>
                <ul>
                  <li>100% Vaccination., Instruction displayed for using mask, Hand washing, social distance maintain.</li>
                </ul>
              </td>
              <td><div contenteditable="true"></div></td>
              <td ></td>
            </tr>
            
          </tbody>
      </table>
<div style="text-align:center; font-size:20px;height:3rem; background-color:#3c8beed9; width:100%;">External Issues Register</div>
      <table>
          <thead>
            <tr>
                <th>Issues</th>
                <th>Description of risk</th>
                <th>Risk Value</th>
                <th >Opportunities / Mitigation </th>
                <th >Objective</th>
                <th style="width:10rem"></th>
            </tr>
          </thead>
          <tbody>
          <tr>
              <td>Delay of materials from supplier / Lack of availability</td>
              <td><ul>
                  <li>Delay of OTD and affects business</li>
                  
                </ul></td>
              <td>
                <select id="risk">
                    <option value="High">High</option>
                    <option value="Medium">Medium</option>
                    <option value="Low">Low</option>
                </select>
              </td>
              <td>
                <ul>
                  <li>No. of supplier qualification need to be increased and alternative suppliers are identified.</li>
                </ul>
              </td>
              <td><div contenteditable="true"></div></td>
              <td ></td>
            </tr>
            <tr>
              <td>Lack of company safety & Emergency preparedness by Visitor’s</td>
              <td><ul>
                  <li>If in case of emergency, Evacuation is difficult.</li>
                </ul></td>
              <td>
                <select id="risk">
                    <option value="High">High</option>
                    <option value="Medium">Medium</option>
                    <option value="Low">Low</option>
                </select>
              </td>
              <td>
                <ul>
                  <li>Emergency assembly point displayed, and Safety induction instructions given to all visitors/Customers.</li>
                </ul>
              </td>
              <td><div contenteditable="true"></div></td>
              <td ></td>
            </tr>
            <tr>
              <td>Local competitors can offer similar products with low cost</td>
              <td><ul>
                  <li>Competition will increase and profit margin could reduce</li>
                </ul></td>
              <td>
                <select id="risk">
                    <option value="High">High</option>
                    <option value="Medium">Medium</option>
                    <option value="Low">Low</option>
                </select>
              </td>
              <td>
                <ul>
                  <li>Location and use brand name guaranteed quality and durability to introduce the product</li>
                </ul>
              </td>
              <td><div contenteditable="true"></div></td>
              <td ></td>
            </tr>
            <tr>
              <td>Limited product Range</td>
              <td><ul>
                  <li>Customer requirements will not be fulfilled, chance of losing business in high</li>
                </ul></td>
              <td>
                <select id="risk">
                    <option value="High">High</option>
                    <option value="Medium">Medium</option>
                    <option value="Low">Low</option>
                </select>
              </td>
              <td>
                <ul>
                  <li>Study / Analyse market requirements and develop wide range of Products according to needs.</li>
                </ul>
              </td>
              <td><div contenteditable="true"></div></td>
              <td ></td>
            </tr>
            <tr>
              <td>Limited flexibility in pricing </td>
              <td><ul>
                  <li>Losing the order / Competition will increase and competition will increase, and profit margin could reduce</li>
                </ul></td>
              <td>
                <select id="risk">
                    <option value="High">High</option>
                    <option value="Medium">Medium</option>
                    <option value="Low">Low</option>
                </select>
              </td>
              <td>
                <ul>
                  <li>Alternate source, use brand name guarantee quality & durability to introduce the product.</li>
                </ul>
              </td>
              <td><div contenteditable="true"></div></td>
              <td ></td>
            </tr>
            <tr>
              <td>Not concentrating on all segment</td>
              <td><ul>
                  <li>Can’t develop and get into new verticals. No exponential growth and losing additional opportunity</li>
                </ul></td>
              <td>
                <select id="risk">
                    <option value="High">High</option>
                    <option value="Medium">Medium</option>
                    <option value="Low">Low</option>
                </select>
              </td>
              <td>
                <ul>
                  <li>Introduce a concept of developing a new product on segment basis</li>
                </ul>
              </td>
              <td><div contenteditable="true"></div></td>
              <td ></td>
            </tr>
            <tr>
              <td>Long lead times for Some products </td>
              <td><ul>
                  <li>Chances of losing the order, may affect in branding</li>
                </ul></td>
              <td>
                <select id="risk">
                    <option value="High">High</option>
                    <option value="Medium">Medium</option>
                    <option value="Low">Low</option>
                </select>
              </td>
              <td>
                <ul>
                  <li>Understand customer requirements in advance</li>
                </ul>
              </td>
              <td><div contenteditable="true"></div></td>
              <td ></td>
            </tr>
            <tr>
              <td>Low Volume order</td>
              <td><ul>
                  <li>Pricing flexibility can’t be offered to customer, can’t compete in the market</li>
                </ul></td>
              <td>
                <select id="risk">
                    <option value="High">High</option>
                    <option value="Medium">Medium</option>
                    <option value="Low">Low</option>
                </select>
              </td>
              <td>
                <ul>
                  <li>Find the alternative sources who provide low cost with minimal quantities</li>
                </ul>
              </td>
              <td><div contenteditable="true"></div></td>
              <td ></td>
            </tr>
            <tr>
              <td>Direct purchase </td>
              <td><ul>
                  <li>Less margin and can’t purchase the material</li>
                </ul></td>
              <td>
                <select id="risk">
                    <option value="High">High</option>
                    <option value="Medium">Medium</option>
                    <option value="Low">Low</option>
                </select>
              </td>
              <td>
                <ul>
                  <li>Find affordable suppliers</li>
                </ul>
              </td>
              <td><div contenteditable="true"></div></td>
              <td ></td>
            </tr>
            <tr>
              <td>Change in government policies</td>
              <td><ul>
                  <li>Difficult to get approvals from concerned departments against the revised policies</li>
                </ul></td>
              <td>
                <select id="risk">
                    <option value="High">High</option>
                    <option value="Medium">Medium</option>
                    <option value="Low">Low</option>
                </select>
              </td>
              <td>
                <ul>
                  <li>As per the new / revised policies approvals should be obtained</li>
                </ul>
              </td>
              <td><div contenteditable="true"></div></td>
              <td ></td>
            </tr>
            <tr>
              <td>Government introduces new legislation.e.g., labour laws, tax policies, environmental laws</td>
              <td><ul>
                  <li>Increase in cost to meet all the requirements</li>
                </ul></td>
              <td>
                <select id="risk">
                    <option value="High">High</option>
                    <option value="Medium">Medium</option>
                    <option value="Low">Low</option>
                </select>
              </td>
              <td>
                <ul>
                  <li>Prepare the budget as per the new / revised legislation, in such a way that it will not affect the smooth operation of existing business and try to meet all the applicable laws</li>
                    <li>Look for automation wherever possible.</li>
                </ul>
              </td>
              <td><div contenteditable="true"></div></td>
              <td ></td>
            </tr>
            <tr>
              <td>Foreign exchange fluctuation</td>
              <td><ul>
                  <li>Product cost get increase / decrease effects in profit margin</li>

                </ul></td>
              <td>
                <select id="risk">
                    <option value="High">High</option>
                    <option value="Medium">Medium</option>
                    <option value="Low">Low</option>
                </select>
              </td>
              <td>
                <ul>
                  <li>Monitor volatile variation </li>
                </ul>
              </td>
              <td><div contenteditable="true"></div></td>
              <td ></td>
            </tr>
            <tr>
              <td>Corporate group decision</td>
              <td><ul>
                  <li>Sudden changes in policies.</li>
                  
                </ul></td>
              <td>
                <select id="risk">
                    <option value="High">High</option>
                    <option value="Medium">Medium</option>
                    <option value="Low">Low</option>
                </select>
              </td>
              <td>
                <ul>
                  <li>Communicating about the new policies and changes and admin policies accordingly</li>
                </ul>
              </td>
              <td><div contenteditable="true"></div></td>
              <td></td>
            </tr>
            <tr>
              <td>Environmental Parameters changes at work area</td>
              <td><ul>
                  <li>Energy / Noise / Smoke / dust safety</li>
                  
                </ul></td>
              <td>
                <select id="risk">
                    <option value="High">High</option>
                    <option value="Medium">Medium</option>
                    <option value="Low">Low</option>
                </select>
              </td>
              <td>
                <ul>
                  <li>Continuous monitoring & under controlled.</li>
                </ul>
              </td>
              <td><div contenteditable="true"></div></td>
              <td ></td>
            </tr>
            <tr>
              <td>Covid-19 infection</td>
              <td><ul>
                  <li>Illness & spread to employees</li>
                </ul></td>
              <td>
                <select id="risk">
                    <option value="High">High</option>
                    <option value="Medium">Medium</option>
                    <option value="Low">Low</option>
                </select>
              </td>
              <td>
                <ul>
                  <li>100% Vaccination., Instruction displayed for using mask, Hand washing, social distance maintain.</li>
                </ul>
              </td>
              <td><div contenteditable="true"></div></td>
              <td ></td>
            </tr>
            <tr>
              <td>Delay of materials from supplier / Lack of availability</td>
              <td><ul>
                  <li>Delay of OTD and affects business</li>
                  
                </ul></td>
              <td>
                <select id="risk">
                    <option value="High">High</option>
                    <option value="Medium">Medium</option>
                    <option value="Low">Low</option>
                </select>
              </td>
              <td>
                <ul>
                  <li>No. of supplier qualification need to be increased and alternative suppliers are identified.</li>
                </ul>
              </td>
              <td><div contenteditable="true"></div></td>
              <td ></td>
            </tr>
            <tr>
              <td>Lack of company safety & Emergency preparedness by Visitor’s</td>
              <td><ul>
                  <li>If in case of emergency, Evacuation is difficult.</li>
                </ul></td>
              <td>
                <select id="risk">
                    <option value="High">High</option>
                    <option value="Medium">Medium</option>
                    <option value="Low">Low</option>
                </select>
              </td>
              <td>
                <ul>
                  <li>Emergency assembly point displayed, and Safety induction instructions given to all visitors/Customers.</li>
                </ul>
              </td>
              <td><div contenteditable="true"></div></td>
              <td ></td>
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
          <button ><a style="color:black" href="ReportPdfOrganisation?organisation=${header.docId}">Print Document</a></button>
    <#else>
      <button id="addRowBtn">Add Row</button>
      <button id="SaveBtn">Save</button>
    </#if>
    
  </div>