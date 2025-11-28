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
      background: #0c2d7c;
      padding: 10px;
      color:white;
      margin: 0;
      height:9rem;
      vertical-align:center;
      flex-grow: 1;
         
    }

    .header-info {
      text-align: right;
      padding-left: 10px;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 10px;
      min-width: 1800px;
    }

    th, td {
      border: 1px solid #000;
      padding: 8px;
      text-align: left;
    }

    .footer {
      display: flex;
      justify-content: space-between;
      margin-top: 20px;
    }

    input {
      border: 0px;
      margin-left: 1rem;
      padding: 1rem;
      border-bottom: 1px dashed black;
    }

    input[type="date"] {
      width: 16rem;
    }

    button {
      margin-top: 3rem;
      padding: 0.6rem 1.2rem;
      font-size: 1rem;
    }

    .cell-editable {
      padding: 0.7rem;
      min-height: 30px;
      cursor: pointer;
    }

    /* Popup Editor */
    #editorModal {
  display: none;
  position: fixed;
  top: 0; left: 0;
  width: 100vw;
  height: 100vh;
  background-color: rgba(0,0,0,0.4);
  justify-content: center;
  align-items: center;
  z-index: 999;
  opacity: 0;
  transition: opacity 0.3s ease-in-out;
}

#editorModal.show {
  display: flex;
  opacity: 1;
}

#editorBox {
  background: white;
  padding: 20px;
  width: 60%;
  max-width: 600px;
  border-radius: 10px;
  display: flex;
  flex-direction: column;
  gap: 10px;
  box-shadow: 0 5px 15px rgba(0,0,0,0.3);
  transform: scale(0.9);
  animation: popupZoom 0.3s ease forwards;
}

@keyframes popupZoom {
  from {
    transform: scale(0.9);
    opacity: 0;
  }
  to {
    transform: scale(1);
    opacity: 1;
  }
}


    #editorTextarea {
      height: 200px;
      font-size: 16px;
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 5px;
      resize: vertical;
    }

    .editor-buttons {
      display: flex;
      justify-content: flex-end;
    }

    .editor-buttons button {
      padding: 8px 16px;
      background-color: #0c2d7c;
      color: white;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-size: 14px;
    }

    .scroll-wrapper {
      overflow-x: auto;
      max-width: 100%;
      scrollbar-width: none;
    }

    .scroll-wrapper::-webkit-scrollbar {
      display: none;
    }
  .loading-overlay {
    display: none; /* Hidden by default */
    position: fixed;
    top: 0; left: 0;
    width: 100vw; height: 100vh;
    background: rgba(0, 0, 0, 0.5);
    z-index: 9999;
    justify-content: center;
    align-items: center;
  }

  .loading-box {
    background: white;
    padding: 2rem;
    border-radius: 10px;
    text-align: center;
    box-shadow: 0 0 10px #00000088;
  }

  .spinner {
    border: 6px solid #f3f3f3;
    border-top: 6px solid #0c2d7c;
    border-radius: 50%;
    width: 40px;
    height: 40px;
    margin: 0 auto 1rem;
    animation: spin 1s linear infinite;
  }

  @keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
  }

  .loading-text {
    font-size: 1.2rem;
    color: #0c2d7c;
  }


  </style>


<div class="container">
  <header class="header">
    <h1 style="color:white;">Risk Register</h1>
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

  <div class="scroll-wrapper">
    <table>
      <thead>
        <tr>
          <th>Risk Id</th>
          <th>Risk Description</th>
          <th>Risk Owner</th>
          <th>Risk Category</th>
          <th>Date Identified</th>
          <th>Hazard/Cause</th>
          <th>Potential Consequence</th>
          <th>Existing Controls</th>
          <th>Effectiveness of Controls</th>
          <th>Likelihood</th>
          <th>Consequence/Severity</th>
          <th>Initial Risk Rating</th>
          <th>Additional Mitigation Actions</th>
          <th>Effectiveness of Actions Taken</th>
          <th>Residual Risk Rating</th>
          <th>Action Due Date</th>
          <th>Status</th>
          <th>Evidence/References</th>
          <th>Warranty</th>
        </tr>
      </thead>
      <tbody>
      <#if ramsOutputDetails?has_content>
      <#list ramsOutputDetails as group>
         <tr>
          
            <td><div class="cell-editable" contenteditable="true">${group.riskId!" "}</div></td>
             <td><div class="cell-editable" contenteditable="true">${group.description!" "}</div></td>
              <td><div class="cell-editable" contenteditable="true">${group.owner!" "}</div></td>
             <td><div class="cell-editable" contenteditable="true">${group.category!" "}</div></td>
              <td><div ><input type="date"  value="${group.dateIdentified!""}"/></div></td>
            <td><div class="cell-editable" contenteditable="true">${group.hazard!" "}</div></td>
            <td><div class="cell-editable" contenteditable="true">${group.consequence!" "}</div></td>
            <td><div class="cell-editable" contenteditable="true">${group.controls!" "}</div></td>
            <td><div class="cell-editable" contenteditable="true">${group.effectiveness!" "}</div></td>
           <td><select class="select-risk">
                    <option value="1" <#if group.likelihood?string == "1">selected</#if>>1</option>
                    <option value="2" <#if group.likelihood?string == "2">selected</#if>>2</option>
                    <option value="3" <#if group.likelihood?string == "3">selected</#if>>3</option>
                    <option value="4" <#if group.likelihood?string == "4">selected</#if>>4</option>
                    <option value="5" <#if group.likelihood?string == "5">selected</#if>>5</option>
                </select></td>
            <td><select class="select-risk">
                    <option value="1" <#if group.severity?string == "1">selected</#if>>1</option>
                    <option value="2" <#if group.severity?string == "2">selected</#if>>2</option>
                    <option value="3" <#if group.severity?string == "3">selected</#if>>3</option>
                    <option value="4" <#if group.severity?string == "4">selected</#if>>4</option>
                    <option value="5" <#if group.severity?string == "5">selected</#if>>5</option>
                </select></td>
            <td><div class="risk-sum" >${group.initialRiskRating!" "}</div></td>
            <td><div class="cell-editable" contenteditable="true">${group.mitigation!" "}</div></td>
            <td><div class="cell-editable" contenteditable="true">${group.actionsTaken!" "}</div></td>
            <td><div class="cell-editable" contenteditable="true">${group.residualRisk!" "}</div></td>
            <td><div ><input type="date"  value="${group.actiondate!""}"/></div></td>
            <td><select class="select-risk">
                    <option value="Open" <#if group.status?string == "Open">selected</#if>> Open</option>
                    <option value="In Progress" <#if status.severity?string == "In Progress">selected</#if>> In Progress</option>
                    <option value="Closed" <#if group.status?string == "Closed">selected</#if>> Closed</option>
                    <option value="Mitigated" <#if group.status?string == "Mitigated">selected</#if>>Mitigated</option>
                </select></td>
            <td><div class="cell-editable" contenteditable="true">${group.evidence!" "}</div></td>
          <td style="width:7rem">
            <strong>From date</strong> <input type="date"  value="${group.warrantyFrom!""}"/>
            <strong>To date</strong><input type="date"  value="${group.warrantyTo!""}"/> 
          </td>
        </tr>
        </#list>
        <#else>
         <tr>
          <#list 1..4 as i>
            <td><div class="cell-editable" contenteditable="true"></div></td>
          </#list>
          <td><div><input type="date"/></div></td>
           <#list 1..4 as i>
            <td><div class="cell-editable" contenteditable="true"></div></td>
          </#list>
            <td><select class="select-risk">
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                </select></td>
            <td><select class="select-risk">
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                </select></td>
             <td><div class="risk-sum" ></div></td>
          <#list 1..3 as i>
            <td><div class="cell-editable" contenteditable="true"></div></td>
          </#list>
          <td><div><input type="date"/></div></td>
          <td><select class="select-risk">
                    <option value="Open"> Open</option>
                    <option value="In Progress"> In Progress</option>
                    <option value="Closed"> Closed</option>
                    <option value="Mitigated">Mitigated</option>
                </select></td>
          <td><div class="cell-editable" contenteditable="true"></div></td>
          <td>
            From date<input type="date"/>
            To date<input type="date"/>
          </td>
        </tr>
        <tr>
          <#list 1..4 as i>
            <td><div class="cell-editable" contenteditable="true"></div></td>
          </#list>
          <td><div><input type="date"/></div></td>
           <#list 1..4 as i>
            <td><div class="cell-editable" contenteditable="true"></div></td>
          </#list>
            <td><select class="select-risk">
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                </select></td>
            <td><select class="select-risk">
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                </select></td>
             <td><div class="risk-sum" ></div></td>
          <#list 1..3 as i>
            <td><div class="cell-editable" contenteditable="true"></div></td>
          </#list>
          <td><div><input type="date"/></div></td>
          <td><select class="select-risk">
                    <option value="Open"> Open</option>
                    <option value="In Progress"> In Progress</option>
                    <option value="Closed"> Closed</option>
                    <option value="Mitigated">Mitigated</option>
                </select></td>
          <td><div class="cell-editable" contenteditable="true"></div></td>
          <td>
            From date<input type="date"/>
            To date<input type="date"/>
          </td>
        </tr>
        <tr>
          <#list 1..4 as i>
            <td><div class="cell-editable" contenteditable="true"></div></td>
          </#list>
          <td><div><input type="date"/></div></td>
           <#list 1..4 as i>
            <td><div class="cell-editable" contenteditable="true"></div></td>
          </#list>
            <td><select class="select-risk">
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                </select></td>
            <td><select class="select-risk">
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                </select></td>
             <td><div class="risk-sum" ></div></td>
          <#list 1..3 as i>
            <td><div class="cell-editable" contenteditable="true"></div></td>
          </#list>
          <td><div><input type="date"/></div></td>
          <td><select class="select-risk">
                    <option value="Open"> Open</option>
                    <option value="In Progress"> In Progress</option>
                    <option value="Closed"> Closed</option>
                    <option value="Mitigated">Mitigated</option>
                </select></td>
          <td><div class="cell-editable" contenteditable="true"></div></td>
          <td>
            From date<input type="date"/>
            To date<input type="date"/>
          </td>
        </tr>
      </#if>
       
      </tbody>
    </table>
  </div>

  
  <#if ramsOutputTitle?has_content>  
    <footer class="footer">
      <div>Auditee:<input  id="preparer" value="${ramsOutputTitle.prepared!""}"/></div>
      <div>Internal Auditor:<input id="previewer" value="${ramsOutputTitle.previewer!""}"/></div>
      <div>External Auditor:<input id="approver" value="${ramsOutputTitle.approve!""}"/></div>
    </footer>
    <#else>
    <footer class="footer">
      <div>Auditee:<input  id="preparer" /></div>
      <div>Internal Auditor:<input id="previewer" /></div>
      <div>External Auditor:<input id="approver" /></div>
    </footer>
    </#if>

  <button id="addRowBtn" style="color:white; font-size:1.2rem;">Add Row</button>
  <button id="SaveBtn" style="color:white; font-size:1.2rem;">Save</button>
</div>

<#--  loading  -->
<div id="loadingOverlay" class="loading-overlay">
  <div class="loading-box">
    <div class="spinner"></div>
    <div class="loading-text">Saving data...</div>
  </div>
</div>

<!-- Popup Editor -->
<div id="editorModal">
  <div id="editorBox">
    <textarea id="editorTextarea"></textarea>
    <div class="editor-buttons">
      <button onclick="closeEditor(true)">Save</button>
    </div>
  </div>
</div>
<script>
  let currentCell = null;

  function openEditor(cell) {
  currentCell = cell;
  document.getElementById('editorTextarea').value = cell.innerText.trim();
  const modal = document.getElementById('editorModal');
  modal.classList.add('show');
  setTimeout(() => {
    document.getElementById('editorTextarea').focus();
  }, 150);
}

function closeEditor(save) {
  const modal = document.getElementById('editorModal');
  const text = document.getElementById('editorTextarea').value;
  if (save && currentCell) {
    currentCell.innerText = text;
  }
  modal.classList.remove('show');
  setTimeout(() => {
    modal.style.display = 'none';
  }, 300); // match transition time
}

// Apply to each cell
document.querySelectorAll('.cell-editable').forEach(cell => {
  cell.addEventListener('click', function () {
    const modal = document.getElementById('editorModal');
    modal.style.display = 'flex';
    openEditor(this);
  });
});

// Close on outside click
document.getElementById('editorModal').addEventListener('click', function (e) {
  const editorBox = document.getElementById('editorBox');
  if (!editorBox.contains(e.target)) {
    closeEditor(true);
  }
});

document.getElementById("addRowBtn").addEventListener("click", function () {
  const tbody = document.querySelector("table tbody");
  const newRow = document.createElement("tr");

  // 1..4 editable divs
  for (let i = 0; i < 4; i++) {
    const td = document.createElement("td");
    const div = document.createElement("div");
    div.className = "cell-editable";
    div.contentEditable = "true";
    div.style.padding = "0.7rem";
    div.addEventListener("click", () => openEditor(div));
    td.appendChild(div);
    newRow.appendChild(td);
  }

  // Date input
  {
    const td = document.createElement("td");
    const div = document.createElement("div");
    const input = document.createElement("input");
    input.type = "date";
    div.appendChild(input);
    td.appendChild(div);
    newRow.appendChild(td);
  }

  // 1..4 more editable divs
  for (let i = 0; i < 4; i++) {
    const td = document.createElement("td");
    const div = document.createElement("div");
    div.className = "cell-editable";
    div.contentEditable = "true";
    div.style.padding = "0.7rem";
    div.addEventListener("click", () => openEditor(div));
    td.appendChild(div);
    newRow.appendChild(td);
  }

  // First two selects
  const dropdowns = [];
  for (let i = 0; i < 2; i++) {
    const td = document.createElement("td");
    const select = document.createElement("select");
    for (let v = 1; v <= 5; v++) {
      const option = document.createElement("option");
      option.value = v;
      option.textContent = v;
      select.appendChild(option);
    }
    dropdowns.push(select);
    td.appendChild(select);
    newRow.appendChild(td);
  }

  // Third column as a div to show sum of first two selects
  const calcTd = document.createElement("td");
  const resultDiv = document.createElement("div");
  resultDiv.className = "cell-editable";
  resultDiv.style.padding = "0.7rem";
  resultDiv.textContent = "0";
  resultDiv.addEventListener("click", () => openEditor(resultDiv));
  calcTd.appendChild(resultDiv);
  newRow.appendChild(calcTd);

  // Handle calculation when first two selects change
  function updateSumDiv() {
    const val1 = parseInt(dropdowns[0].value) || 0;
    const val2 = parseInt(dropdowns[1].value) || 0;
    resultDiv.textContent = val1 * val2;
  }
  dropdowns.forEach(sel => sel.addEventListener("change", updateSumDiv));
  updateSumDiv(); // Initial update

  // 6 more editable divs
  for (let i = 0; i < 3; i++) {
    const td = document.createElement("td");
    const div = document.createElement("div");
    div.className = "cell-editable";
    div.contentEditable = "true";
    div.style.padding = "0.7rem";
    div.addEventListener("click", () => openEditor(div));
    td.appendChild(div);
    newRow.appendChild(td);
  }
  {
    const td = document.createElement("td");
    const div = document.createElement("div");
    const input = document.createElement("input");
    input.type = "date";
    div.appendChild(input);
    td.appendChild(div);
    newRow.appendChild(td);
  }
  {
    const td = document.createElement("td");
    td.innerHTML = `<td><select class="select-risk">
                    <option value="Open"> Open</option>
                    <option value="In Progress"> In Progress</option>
                    <option value="Closed"> Closed</option>
                    <option value="Mitigated">Mitigated</option>
                </select></td>`;
    newRow.appendChild(td);
  }
  {
    const td = document.createElement("td");
    td.innerHTML = `<td><div class="cell-editable" contenteditable="true"></div></td>`;
    newRow.appendChild(td);
  }
  // Final td with two date inputs
  {
    const td = document.createElement("td");
    td.innerHTML = `From date <input type="date"> To date <input type="date">`;
    newRow.appendChild(td);
  }

  tbody.appendChild(newRow);
});
function setupRiskSelects(row) {
  const selects = row.querySelectorAll("select.select-risk");
  const resultDiv = row.querySelector("div.risk-sum");

  if (selects.length >= 2 && resultDiv) {
    const [sel1, sel2] = selects;

    function updateSum() {
      const v1 = parseInt(sel1.value) || 0;
      const v2 = parseInt(sel2.value) || 0;
      resultDiv.textContent = v1 * v2;
    }

    sel1.addEventListener("change", updateSum);
    sel2.addEventListener("change", updateSum);
    updateSum();
  }
}
document.addEventListener("DOMContentLoaded", () => {

 function updateFemaNumber(femano, rev) {
    let cleaned = femano.replace(/_R\d+$/, ""); // remove _R followed by digits at the end
    return cleaned + "_R" + rev;
}



document.getElementById("SaveBtn").addEventListener("click", function () {
  const docId = document.getElementById("docId").value.trim();
  const revision = document.getElementById("revision").value.trim();
  const saveDate = document.getElementById("saveDate").value;
  const prepareview = document.getElementById("previewer").value.trim();
  const approve = document.getElementById("approver").value.trim();
  const prepare = document.getElementById("preparer").value;
  const data = [];

  docIdNew=updateFemaNumber(docId, revision);
  const rows = document.querySelectorAll("table tbody tr");
  rows.forEach(row => {
    const rowData = {};

    const cells = row.querySelectorAll("td");
    const inputTypes = Array.from(cells).map(cell => {
      if (cell.querySelector("input[type='date']")) return "date";
      if (cell.querySelector("select")) return "select";
      if (cell.querySelector("div.cell-editable")) return "editable";
      return "text";
    });
    
    let index = 0;
    const riskId = cells[0].innerText.trim();
    // Map column values
    if(riskId){
    rowData["riskId"] = cells[0].innerText.trim();
    rowData["description"] = cells[1].innerText.trim();
    rowData["owner"] = cells[2].innerText.trim();
    
    rowData["category"] = cells[3].innerText.trim();
    
    rowData["dateIdentified"] = cells[4].querySelector("input")?.value || "";
  
    rowData["hazard"] = cells[5].innerText.trim();
    rowData["consequence"] = cells[6].innerText.trim();
    rowData["controls"] = cells[7].innerText.trim();
    rowData["effectiveness"] = cells[8].innerText.trim();

    rowData["likelihood"] = cells[9].querySelector("select")?.value || "";
    rowData["severity"] = cells[10].querySelector("select")?.value || "";
    rowData["initialRiskRating"] = cells[11].innerText.trim();  // this is auto-calculated

    rowData["mitigation"] = cells[12].innerText.trim();
    rowData["actionsTaken"] = cells[13].innerText.trim();
    rowData["residualRisk"] = cells[14].innerText.trim();
    rowData["actiondate"] = cells[15].querySelector("input")?.value || "";
    rowData["status"] = cells[16].querySelector("select")?.value || "";
    
    rowData["evidence"] = cells[17].innerText.trim();
    const fromDate = cells[18].querySelectorAll("input")[0]?.value || "";
    const toDate = cells[18].querySelectorAll("input")[1]?.value || "";

    rowData["warrantyFrom"] = fromDate;
    rowData["warrantyTo"] = toDate;

    data.push(rowData);
    }
  });

  rowDataHeader={
    docId :docIdNew,
    revision:revision,
    saveDate:saveDate,
    previewer:prepareview,
    approver:approve,
    preparer:prepare,
    type:"IRIS"
}
  console.log("running")
  console.log(docIdNew)
  console.log(docId)
   data.push(rowDataHeader);
   if (docIdNew == docId) {
        alert("The Revision number needs to be changed");
        return;
    }
  const payload = JSON.stringify({ riskRegister : data });
    document.getElementById("loadingOverlay").style.display = "flex";

      // Prepare the XHR request
      const xhr = new XMLHttpRequest();
      xhr.open("POST", "/AuditReport/control/createRiskRegister", true);
      xhr.setRequestHeader("Content-Type", "application/json");
      setTimeout
      xhr.onreadystatechange = function () {
        if (xhr.readyState === 4) {
           document.getElementById("loadingOverlay").style.display = "none";
           document.getElementById("SaveBtn").style.display="none";
           document.getElementById("addRowBtn").style.display="none";
          if (xhr.status === 200) {
           
            console.log("Success:", xhr.responseText);
            alert("Data Stored successfully.");
          } else {
            console.error("Error:", xhr.status, xhr.statusText);
            alert("Failed to submit data.");
          }
        }
      };
  
      // Send the request
      xhr.send(payload);
});})

// Apply to existing rows on page load
window.addEventListener("DOMContentLoaded", () => {
  document.querySelectorAll("table tbody tr").forEach(setupRiskSelects);
});
</script>





