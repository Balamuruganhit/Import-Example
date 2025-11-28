/*
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements. See the NOTICE file
distributed with this work for additional information
regarding copyright ownership. The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied. See the License for the
specific language governing permissions and limitations
under the License.
*/

document.addEventListener("DOMContentLoaded", () => {
  const dataTable = document.getElementById("data-table-body");
  const submitButton = document.getElementById("submit-button");
  const addButton = document.getElementById("add-button");
  const datalist = document.getElementById('listReport');
  const commentField = document.getElementById('comment');
  const charCount = document.getElementById('charCount');
  const reportCount = document.getElementById('reportCount');
  const reportField = document.getElementById('reportId');
  const uniqueValues = new Set();
  let formDataArray = [];
  let defaultImg="data:image/jpeg;base64,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";


  console.log(reportField);
  datalist.innerHTML = '';

  // Character limit validation
  reportField.addEventListener('input', function () { 
    const currentLengthId = reportField.value.length;
    reportCount.textContent = `${currentLengthId}/20`;

    // Apply red border if limit exceeded, otherwise remove it
    reportField.style.border = currentLengthId > 20 ? '2px solid red' : '';
  });

  commentField.addEventListener('input', function () {
    const currentLength = commentField.value.length;
    charCount.textContent = `${currentLength}/250`;

    // Apply red border if limit exceeded, otherwise remove it
    commentField.style.border = currentLength > 250 ? '2px solid red' : '';
  });

  // Add Button Logic
  addButton.addEventListener("click", (event) => {
    event.preventDefault();
    const reportId = document.getElementById("reportId").value;
    const question = document.getElementById("question").value;
    const rating = document.getElementById("rating").value;
    const comment = document.getElementById("comment").value;
    const proofInput = document.getElementById("proof");
    const approve = document.getElementById("approve").value;
    const commentLength = commentField.value.length;
    const reportLength = reportField.value.length;
    
    // Handle File Upload
    const proofFile = proofInput.files[0];
    console.log(proofFile)
    if (reportLength > 20) {
        alert('ReportId should not exceed 20 AlphaNumeric.');
        reportField.style.border = '2px solid red'; // Ensure red border on submit
        return;
    }

    if (commentLength > 250) {
        alert('Comment should not exceed 250 characters.');
        commentField.style.border = '2px solid red'; // Ensure red border on submit
        return;
    }

    if (!reportId || !question || !rating || !comment || !approve) {
        alert("All fields are required except Proof.");
        return;
    }

    if (proofFile && proofFile.size > 2 * 1024 * 1024) { // 2MB size limit
        alert("Proof file size exceeds the limit of 2MB.");
        return;
    }

    // Read file only if it's provided
    if (proofFile) {
        const reader = new FileReader();
        reader.onload = function (e) {
            const proofData = e.target.result; // Base64 encoded string
            // Add row to table
            addRowToTable(reportId, question, rating, comment, proofData, approve);
        };
        reader.readAsDataURL(proofFile); // Read file as Base64
    } else {
        // If no file, pass an empty string for proof
        addRowToTable(reportId, question, rating, comment, defaultImg, approve);
    }
  });

  // Function to add row to table
  function addRowToTable(reportId, question, rating, comment, proofData, approve) {
    const newRow = `
        <tr class="alternate-row">
            <td id="listId">${reportId}</td>
            <td>${question}</td>
            <td>${rating}</td>
            <td>${comment}</td>
            <td>${proofData ? `<img src="${proofData}" alt="Proof" style="width: 50px; height: 50px;" />` : "No Proof"}</td>
            <td>${approve}</td>
            <td><button class="delete-btn">Delete</button></td>
        </tr>
    `;
    dataTable.innerHTML += newRow;

    // Store data in array
    formDataArray.push({
        reportId: reportId,
        question: question,
        rating: rating,
        comment: comment,
        proof: proofData, // Will be empty if no proof is uploaded
        approve: approve,
    });

    // Reset Form
    reportCount.textContent = `${0}/20`;
    charCount.textContent = `${0}/250`;
    document.getElementById("AddReportDetail").reset();
    if (uniqueValues.has(reportId)) {
      return;
    }

    // Add Report ID to the datalist
    uniqueValues.add(reportId);
    const option = document.createElement('option');
    option.value = reportId;
    datalist.appendChild(option);
  }

  // Delete Row Logic
  dataTable.addEventListener("click", (event) => {
    if (event.target.classList.contains("delete-btn")) {
      const rowIndex = event.target.closest("tr").rowIndex - 1; // Get the row index of the clicked delete button (excluding the header row)
      // Remove from the array
      formDataArray.splice(rowIndex, 1);
      // Remove from the table (UI)
      event.target.closest("tr").remove();
    }
  });

  // Submit Button Logic
  submitButton.addEventListener("click", async (event) => {
    event.preventDefault();
    if (formDataArray.length === 0) {
        alert("No data to submit.");
        return;
    }
    const payload = JSON.stringify({ reportDetails : formDataArray });

    // Prepare the XHR request
    const xhr = new XMLHttpRequest();
    xhr.open("POST", "/AuditReport/control/createReportDetail", true);
    xhr.setRequestHeader("Content-Type", "application/json");

    xhr.onreadystatechange = function () {
      if (xhr.readyState === 4) {
        if (xhr.status === 200) {
          console.log("Success:", xhr.responseText);
          alert("Data submitted successfully.");
          formDataArray = []; // Clear the array after successful submission
          dataTable.innerHTML = ""; // Clear the table
        } else {
          console.error("Error:", xhr.status, xhr.statusText);
          alert("Failed to submit data.");
        }
      }
    };

    // Send the request
    xhr.send(payload);
  });

});
