document.addEventListener("DOMContentLoaded", () => {
    document.querySelectorAll('table tbody tr').forEach(row => {
    const needsCell = row.cells[2];
    const expectationsCell = row.cells[3];

    function replaceListWithTextarea(cell) {
      const items = Array.from(cell.querySelectorAll('li'));
      const text = items.map(li => li.textContent.trim()).join('<br/>');

      

      cell.innerHTML = `<div contenteditable="true">${text}</div>`; // Remove <ul><li> structure
      
    }

    replaceListWithTextarea(needsCell);
    replaceListWithTextarea(expectationsCell);
  });
  // Select all rows in tbody (excluding header row)
  document.getElementById('SaveBtn').addEventListener('click', function () {
  const rows = document.querySelectorAll('table tbody tr');
  const tableData = [];
  const inputs = document.querySelectorAll('input')
  const inputData={};
  rows.forEach(row => {
    const cells = row.querySelectorAll('td');
    const party = cells[0]?.innerText.trim();
    const type = cells[1]?.innerText.trim();

    // Extract <li> items from the 3rd and 4th cell
  const needsTextarea = cells[2].innerText.trim();
  const expectationsTextarea = cells[3].innerText.trim();

  const needs = needsTextarea?.split('\n') || [];
  const expectations = expectationsTextarea?.split('\n') || [];
    tableData.push({
      interestedParty: party,
      internalOrExternal: type,
      needs: needs,
      expectations: expectations
    });
  });
  inputs.forEach(input =>{
    var leftValue=input.id
    var rightValue = input.value.trim()
    inputData[leftValue] = rightValue;
  })
  tableData.push(inputData)
  console.log(tableData);
  const payload = JSON.stringify({ partiesDetail : tableData });
  
      // Prepare the XHR request
      const xhr = new XMLHttpRequest();
      xhr.open("POST", "/AuditReport/control/createParties", true);
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
  const tbody = document.querySelector('table tbody');
  const newRow = document.createElement('tr');

  newRow.innerHTML = `
    <td contenteditable="true">New Party</td>
    <td contenteditable="true">Internal/External</td>
    <td  contenteditable="true"></td>
    <td  contenteditable="true"></td>
    <td  contenteditable="true"></td>
    <td  contenteditable="true"></td>
  `;

  tbody.appendChild(newRow);
});
})
  
