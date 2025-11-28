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
.cell-editable-table{
  padding: 0.7rem;
      min-height: 30px;
      cursor: pointer;
      te
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
#editorModalTable{
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
#editorModalTable.show {
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
#editorBoxTable {
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
    #editorTable {
      height: 200px;
      font-size: 1.3rem;
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 5px;
      resize: vertical;
      min-width: 10rem;
    }

    .editor-buttons-table {
      display: flex;
      justify-content: space-between;
    }

    .editor-buttons-table button {
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
    #turtleBtn{
        display:none;
    }
#editorTable th, td {
      border: 1px solid #ddd;
      padding: 8px;
      text-align: left;
      
    }
   #editorTable th {
      background: #f4f4f4;
      font-weight: bold;
    }
  #editorTable  tr:nth-child(even) {
      background: #fafafa;
    }
  #editorTable  tr:hover {
      background: #f1f1f1;
    }
</style>

<div class="container">
    <header class="header">
        <h1 style="color:white;">Turtle Diagram</h1>
        
        <div class="header-info">
            <div>Doc No: <input id="docId" /></div>
            <div>Rev No: <input id="revision" /></div>
            <div style="margin-top:1rem;">Date: <input type="date" id="saveDate" /></div>
        </div>
      
    </header>
    <div class="scroll-wrapper">
        <table>
            <thead>
                 <th>Supplier</th>
                <th>Input</th>
                <th>Resources</th>
                <th>Risks</th>
                <th>Content/Work Instruction</th>
                <th>Personnel</th>
                <th>oppurtunities</th>
                <th>Process</th>
                <th>KPI's</th>
                <th>Outputs</th>
                <th>Customer</th>
            </thead>
            <tbody>
                <tr>
                    <td><div class="cell-editable" contenteditable="true"></div></td>
                    <td><div class="cell-editable" contenteditable="true"></div></td>
                    <td><div class="cell-editable" contenteditable="true"></div></td>
                    <td><div class="cell-editable" contenteditable="true"></div></td>
                    <td><div class="cell-editable" contenteditable="true"></div></td>
                    <td><div class="cell-editable" contenteditable="true"></div></td>
                    <td><div class="cell-editable" contenteditable="true"></div></td>
                    <td><div class="cell-editable" contenteditable="true"></div></td>
                    <td style="width:24rem;"><div class="cell-editable-table" id="cell-editable-table" style=" text-wrap:wrap" contenteditable="true"></div></td>
                    <td><div class="cell-editable" contenteditable="true"></div></td>
                    <td><div class="cell-editable" contenteditable="true"></div></td>
                </tr>
            </tbody>
        </table>
    </div>
    <footer class="footer">
      <div>Auditee:<input  id="preparer" /></div>
      <div>Internal Auditor:<input id="previewer" /></div>
      <div>External Auditor:<input id="approver" /></div>
    </footer>
     <button id="SaveBtn" style="color:white; font-size:1.2rem;">Save</button>
     <button id="turtleBtn"><a style="color:white; font-size:1.2rem;" id="turtleNewBtn">Convert Turtle Diagram</a></button>
</div>

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

<div id="editorModalTable">
  <div id="editorBoxTable">
    <table id="editorTable">
      <thead>
        <th>KPI / Objective</th>
        <th>Target</th>
        <th>Achieved</th>
        <th>Period</th>
      </thead>
      <tbody>
      <tr>
        <td  contenteditable="true" >Hello</td>
        <td  contenteditable="true" >89</td>
        <td  contenteditable="true" >80</td>
        <td  contenteditable="true" >it will done</td>
      </tr>
      </tbody>
    </table>
    <div class="editor-buttons-table">
      <button onclick="closeEditorTable(true)">Save</button>
      <button id="addrowButton">Add Row</button>
    </div>
    
  </div>
</div>


