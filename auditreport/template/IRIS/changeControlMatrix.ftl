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
      height:11rem;
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
<#assign i=0/>

<div class="container">
  <header class="header">
    <h1 style="color:white;">CHANGE CONTROL MATRIX </h1>
    <#if ramsOutputTitle?has_content>
      <div class="header-info">
        <div>Doc No: <input id="docId" value="${ramsOutputTitle.docId!""}"/></div>
        <div>Rev No: <input id="revision" value="${ramsOutputTitle.revision!""}"/></div>
        <div>Issue No: <input id="issueNo" value="${ramsOutputTitle.issueNumber!""}"/></div>
        <div style="margin-top:1rem;">Date: <input type="date" id="saveDate" value="${ramsOutputTitle.date!""}"/></div>
      </div>
      <#else>
            <div class="header-info">
        <div>Doc No: <input id="docId" /></div>
        <div>Issue No: <input id="issueNo" /></div>
        <div>Rev No: <input id="revision" /></div>
        <div style="margin-top:1rem;">Date: <input type="date" id="saveDate" /></div>
      </div>
      </#if>
  </header>

  <div class="scroll-wrapper">
    <table>
      <thead>
        <tr>
          <th>SI No</th>
          <th>Change Initiated by / Origin of change</th>
          <th>Change impact to </th>
          <th>Method of initiation </th>
          <th>Reviewed by </th>
          <th>Approval Authority</th>
          <th>Mode of change Communication</th>
          <th>Actions to be considered </th>
          <th>Implementation & effectiveness monitoring Responsibility</th>
          <th>Status Review frequency</th>
        </tr>
      </thead>
      <#if ramsOutputDetails?has_content>
        <tbody>
        
          <#list ramsOutputDetails as group>
          <#assign i = i + 1>
          <tr >
              <td ><div>${i}</div></td>
              <td ><div>${group.changeInitiated!" "}</div></td>
              <td ><div>${group.changeImpact!" "}</div></td>
              <td ><div>${group.methodOfInitiation!" "}</div></td>
              <td ><div>${group.reviewed!" "}</div></td>
              <td ><div>${group.approvalAuthority!" "}</div></td>
              <td ><div>${group.modeCommunication!" "}</div></td>
              <td ><div>${group.actions!" "}</div></td>
              <td ><div>${group.implementation!" "}</div></td>
              <td ><div>${group.status!" "}</div></td>
          </tr>
          </#list>
        </tbody>
      <#else>
      <tbody>
      
         <tr>
            <td><div  >1</div></td>
            <td><div  >Changes to the QMS</div></td>
            <td><div  >QMS</div></td>
            <td><div >Document change request </div></td>
            <td><div  >MR</div></td>
            <td><div  >MR</div></td>
            <td><div class="cell-editable" contenteditable="true">Copy of change note mailed to all concerned </div></td>
            <td><div class="cell-editable" contenteditable="true">Risk / Impact associated with changes <br/>

            Continuous monitoring <br/>

            Initiate rev / issue changes in documents 
            </div></td>
            <td><div class="cell-editable" contenteditable="true">MR</div></td>
            <td><div class="cell-editable" contenteditable="true">MRM</div></td>   
        </tr>
        <tr>
            <td><div  >2</div></td>
            <td><div  >Changes related to knowledge </div></td>
            <td><div  >Knowledge obsolescence </div></td>
            <td><div  >HR change note</div></td>
            <td><div  >HR & HODs</div></td>
            <td><div  >Process owners/ CEO/COO</div></td>
            <td><div class="cell-editable" contenteditable="true">Copy of Skill matrix mailed to all concerned <br/>

            Update the succession plan 
            </div></td>
                        <td><div class="cell-editable" contenteditable="true">Risk / Impact associated with changes <br/>

            New employees skill to be continuously monitored by HODs  <br/>

            Accountability change includes Internal rejection, in process rejection, failures / abnormality occurrences, 
            </div></td>
            <td><div class="cell-editable" contenteditable="true">Head HR/ HODs </div></td>
            <td><div class="cell-editable" contenteditable="true">Once in a month or during MRM </div></td>   
        </tr>
        <tr>
            <td><div >3</div></td>
            <td><div >Changes to new product development / Project Management</div></td>
            <td><div >Product quality and safety</div></td>
            <td><div >ECN</div></td>
            <td><div >Project manager (PM), QA, Eng. Mfg.</div></td>
            <td><div >Head Engineering Or CCB (Change Control Board)</div></td>
            <td><div class="cell-editable" contenteditable="true">Copy of Project review minutes circulated to all concerned by mail also to acknowledgement from stake holders towards understanding  </div></td>
            <td><div class="cell-editable" contenteditable="true">Risk / Impact associated with changes w.r.t Q, Q, OTD & PS<br/>

            Form- Fit- Function- Performance analysis <br/>

            Simulation <br/>

            Drawing approval from customer <br/>

            Monitor on cost implication Proto approval from customer <br/>

            Cost impact analysis <br/>

            Update the change register 
            </div></td>
                        <td><div class="cell-editable" contenteditable="true">Eng. Head</div></td>
                        <td><div class="cell-editable" contenteditable="true">Project Review Meeting <br/>

            During gate review 
            </div></td>   
        </tr>
        <tr>
            <td><div >4</div></td>
            <td><div >Changes related to requirements for products by customers (8.2.4)</div></td>
            <td><div >Product quality and safety</div></td>
            <td><div >ECN</div></td>
            <td><div >BD/ MKT, QA, PM, </div></td>
            <td><div >Head BD </div></td>
            <td><div class="cell-editable" contenteditable="true">Circulate changes and obtain acknowledgement from stake holders <br/>

                Communicate changes during daily meeting 
                </div></td>
                            <td><div class="cell-editable" contenteditable="true">Preform re- feasibility analysis with Risk / Impact associated with changes <br/>

                Amended Manufacturing build book<br/>

                Cost impact analysis <br/>
                </div></td>
            <td><div class="cell-editable" contenteditable="true">BD</div></td>
            <td><div class="cell-editable" contenteditable="true">Daily review meeting</div></td>   
        </tr>
        <tr>
            <td><div>5</div></td>
            <td><div >Changes related to process – floor plan, new process introduction, optimizing the existing process, changes in special process, change in procedures / SOPs </div></td>
            <td><div >Process and product  </div></td>
            <td><div >ECN / Process change note </div></td>
            <td><div >Pro. Head</div></td>
            <td><div >Head Eng.Or CCB</div></td>
            <td><div class="cell-editable" contenteditable="true">Intimate customers on changes and obtain their approval if required <br/>

            Communicate changes during daily meeting<br/>

            Also communicate through mail to all stakeholders 
 
            </div></td>
                        <td><div class="cell-editable" contenteditable="true">Risk / Impact associated with changes w.r.t Q, Q, OTD & PS<br/>

            Determine impact to configuration change / base line documents <br/>

            Perform re-PFD, PFMEA, CP, RC, WI, Check lists, <br/>

            Perform special process re- validation <br/>

            Establish through FAI approval from internal and customer 
            </div></td>
                        <td><div class="cell-editable" contenteditable="true">Head Engg. <br/>

            QA
            </div></td>
            <td><div class="cell-editable" contenteditable="true">Daily  review meeting</div></td>   
        </tr>
        <tr>
            <td><div >6</div></td>
            <td><div >Changes related to Supplier RM, layout, process and process (supplier 6 M change)</div></td>
            <td><div >Product quality and safety</div></td>
            <td><div >Process Change Note / Layout change note  / Spl. Process Parameter change note From suppliers </div></td>
            <td><div >Purchase In-charge</div></td>
            <td><div >SQA </div></td>
            <td><div class="cell-editable" contenteditable="true">Intimate customers on changes at suppliers and obtain their approval if required <br/>Communicate changes during daily meeting<br/>Also communicate through mail to all stakeholders</div></td>
            <td><div class="cell-editable" contenteditable="true">Risk / Impact associated with changes w.r.t Q, Q, OTD & PS<br/>Determine impact to configuration change / base line documents <br/>Obtain suppliers reviewed -PFD, PFMEA, CP, RC, WI, Check lists, <br/>Cost impact analysis <br/>Perform special process re- validation as applicable  <br/>Establish through FAI approval from internal and customer</div></td>
            <td><div class="cell-editable" contenteditable="true">Purchase In-charge</div></td>
            <td><div class="cell-editable" contenteditable="true">Daily review meeting <br/> with supplier </div></td>   
        </tr>
        <tr>
                            <td><div  >7</div></td>
                            <td><div  >Drawing / specification Engineering changes (Internal - organization /External from customer / supplier)</div></td>
                            <td><div  >Product quality and safety</div></td>
                            <td><div  >ECN </div></td>
                            <td><div >Head Eng.  </div></td>
                            <td><div  >Head D&D SQA Or CFT</div></td>
                            <td><div class="cell-editable" contenteditable="true">Intimate customers on changes and obtain their approval if required <br/>

                Communicate changes during daily meeting<br/>

                Also communicate through mail to all stakeholders 
                
                </div></td>
                            <td><div class="cell-editable" contenteditable="true">Risk / Impact associated with changes w.r.t Q, Q, OTD & Product safety,<br/>

                Determine impact to configuration change / base line documents <br/>


                Reestablish PFD, DFMEA, PFMEA, CP, RC, WI, Check lists, <br/>

                Submit FAI for customer approval  
                
                </div></td>
            <td><div class="cell-editable" contenteditable="true">Head D&D</div></td>
            <td><div class="cell-editable" contenteditable="true">Daily  review meeting</div></td>   
        </tr>
         <tr>
            <td><div  >8</div></td>
            <td><div  >Change from failure </div></td>
            <td><div  >Product safety & quality </div></td>
            <td><div >ECN  </div></td>
            <td><div  >Head Eng. <br/>QA <br/>CFT</div></td>
            <td><div  >Head Eng. </div></td>
            <td><div class="cell-editable" contenteditable="true">Intimate customers on changes and obtain their approval if required <br/>Communicate changes during daily meeting<br/> Also communicate through mail to all stakeholders </div></td>
            <td><div class="cell-editable" contenteditable="true">Risk / Impact associated with changes w.r.t Q, Q, OTD & PS<br/>

                    Determine impact to configuration change / base line documents <br/>

                    Perform re-PFD, PFMEA, CP, RC, WI, Check lists, <br/>

                    Perform special process re- validation <br/>
                    Establish through FAI approval from internal and customer 

                    </div></td>
                <td><div class="cell-editable" contenteditable="true">Head Engg. 

                QA
                </div></td>
            <td><div class="cell-editable" contenteditable="true">MRM</div></td>   
        </tr>
      </tbody>
      </#if>
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
    console.log("it working")
  if (save && currentCell) {
    // Split by full stop or double space
    var items = text.split(/\.|\s{2,}/);
     var items = text.split(/\.|\s{2,}/);
    var formattedText = "<ul>";

    for (var i = 0; i < items.length; i++) {
      var item = items[i].trim();
      if (item.length > 0) {
        formattedText += "<li>" + item + "</li>";
      }
    }
    formattedText += "</ul>";

    currentCell.innerHTML  = formattedText;
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
let rowNo=9;
document.getElementById("addRowBtn").addEventListener("click", function () {
  const tbody = document.querySelector("table tbody");
  const newRow = document.createElement("tr");
    {
        const td = document.createElement("td");
        const div = document.createElement("div"); 
        div.style.padding = "0.7rem";
        div.contentEditable = "false";
        div.innerText=rowNo++;
        td.appendChild(div);
        newRow.appendChild(td);
    }
  // 6 more editable divs
  for (let i = 0; i < 9; i++) {
    const td = document.createElement("td");
    const div = document.createElement("div");
    div.className = "cell-editable";
    div.contentEditable = "true";
    div.style.padding = "0.7rem";
    div.addEventListener("click", () => openEditor(div));
    td.appendChild(div);
    newRow.appendChild(td);
    console.log("working in  editable")
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
  const issueNo = document.getElementById("issueNo").value.trim();
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
    console.log("Row cells:", cells.length, row);
    console.log(cells)
    const inputTypes = Array.from(cells).map(cell => {
      if (cell.querySelector("div.cell-editable")) return "editable";
      return "text";
    });
    rowData["changeInitiated"]    = cells[1]?.innerText.trim() || "";
    rowData["changeImpact"]       = cells[2]?.innerText.trim() || "";   
    rowData["methodOfInitiation"] = cells[3]?.innerText.trim() || "";   
    rowData["reviewed"]           = cells[4]?.innerText.trim() || ""; 
    rowData["approvalAuthority"]  = cells[5]?.innerText.trim() || "";
    rowData["modeCommunication"]  = cells[6]?.innerText.trim() || "";
    rowData["actions"]            = cells[7]?.innerText.trim() || "";
    rowData["implementation"]     = cells[8]?.innerText.trim() || "";
    rowData["status"]             = cells[9]?.innerText.trim() || "";
    data.push(rowData);
  });

  rowDataHeader={
    docId :docIdNew,
    issue:issueNo,
    revision:revision,
    saveDate:saveDate,
    previewer:prepareview,
    approver:approve,
    preparer:prepare,
    type:"CONTROLMATRIX"
}
  console.log("running")
  console.log(docIdNew)
  console.log(data)
   data.push(rowDataHeader);
   
   if (docIdNew == docId) {
        alert("The Revision number needs to be changed");
        return;
    }
    if(docId.length == 0){
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





