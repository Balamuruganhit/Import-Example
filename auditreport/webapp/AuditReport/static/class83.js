document.addEventListener("DOMContentLoaded", () => {
     console.log('working')
  // Select all rows in tbody (excluding header row)
  document.getElementById('SaveBtn').addEventListener('click', function () {
    const table = document.getElementById('processTable');
    const docId = document.getElementById("docId").value.trim();
  const revision = document.getElementById("revision").value.trim();
  const saveDate = document.getElementById("saveDate").value;
  const prepareview = document.getElementById("previewer").value.trim();
  const approve = document.getElementById("approver").value.trim();
  const prepare = document.getElementById("preparer").value;


  const rows = table.querySelectorAll('tbody tr');
  const dataArray = [];

  rows.forEach(row => {
    const process = row.cells[0].innerText.trim();
    const tools = row.cells[1].innerText.trim();
    const status = row.cells[2].querySelector('select').value;
    const remarks = row.cells[3].innerText.trim();

    const rowData = {
      process: process,
      tools: tools,
      status: status,
      remarks: remarks,
    };

    dataArray.push(rowData);
   
    });
rowData={
    docId :docId,
    revision:revision,
    saveDate:saveDate,
    previewer:prepareview,
    approver:approve,
    preparer:prepare,
}
dataArray.push(rowData);
 console.log(dataArray)
  const payload = JSON.stringify({ designsDetail : dataArray });
  
      // Prepare the XHR request
      const xhr = new XMLHttpRequest();
      xhr.open("POST", "/AuditReport/control/createDesign", true);
      xhr.setRequestHeader("Content-Type", "application/json");
  
      xhr.onreadystatechange = function () {
        if (xhr.readyState === 4) {
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
});
    document.getElementById('addRowBtn').addEventListener('click', function () {
  const table = document.getElementById('processTable');

  const tbody = table.querySelector('table tbody');
  const newRow = document.createElement('tr');

  newRow.innerHTML = `
              <td></td>
              <td contenteditable="true"></td>
              <td>
                <select id="select" name="status">
                    <option value="Complete">Complete</option>
                    <option value="In Progress">In Progress</option>
                    <option value="Not Started">Not Started</option>
                </select>
              </td>
              <td contenteditable="true">  
              </td>
              <td><input type="file"/></td>
  `;

  tbody.appendChild(newRow);
});
})
  
