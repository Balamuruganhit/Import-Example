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
        <div>Issue No: <input id="issueNo" value="${ramsOutputTitle.issueNumber!""}"/></div>
        <div>Rev No: <input id="revision" value="${ramsOutputTitle.revision!""}"/></div>
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

  
 <button ><a style="color:white; font-size:1.2rem;" href="ChangeControlReport?printdoc=done&docId=${ramsOutputTitle.docId}">Print Document</a></button>
</div>








