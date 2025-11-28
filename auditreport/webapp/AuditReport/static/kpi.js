/*.

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
*/
document.addEventListener("DOMContentLoaded", () => {
    console.log("hi")
    const rows = document.getElementsByClassName("planned");
        for (let i = 0; i < rows.length; i++) {
        calculateEfficiency(i);
        }
 
    function calculateEfficiency(index) {
        console.log("It is calculated")
        const planned = document.getElementsByClassName("planned")[index].value;
        const actual = document.getElementsByClassName("actual")[index].value;
        const efficiencyCell = document.getElementsByClassName("efficiency")[index];
        const targetCell = document.getElementsByClassName("target")[index];

        const plannedValue = parseFloat(planned) || 0;
        const actualValue = parseFloat(actual) || 1; // Avoid division by zero

        if (plannedValue > 0) {
            const efficiency = ( actualValue/ plannedValue) * 100;
            efficiencyCell.textContent = efficiency.toFixed(2);
            targetCell.textContent = efficiency >= 85 ? "Yes" : "No";
        } else {
            efficiencyCell.textContent = "";
            targetCell.textContent = "";
        }
    }

   

    function exportToExcel() {
        let table = document.querySelector("table");
        let ws = XLSX.utils.table_to_sheet(table);
        let wb = XLSX.utils.book_new();
        XLSX.utils.book_append_sheet(wb, ws, "Sheet1");

        // Append "Prepared By" & "Checked By" at the bottom of the Excel sheet
        let preparedBy = document.getElementById("preparedBy").value;
        let checkedBy = document.getElementById("checkedBy").value;
        XLSX.utils.sheet_add_aoa(ws, [["Prepared By:", preparedBy], ["Checked By:", checkedBy]], { origin: -1 });

        XLSX.writeFile(wb, "table.xlsx");
    }
   });
  async function exportToPDF() {
    const { jsPDF } = window.jspdf;
    const doc = new jsPDF();

    doc.setFontSize(14);
    doc.text("Production Plan Vs Actual Plan ERP Report", 14, 15);

    const tableBody = [];

    let currentPartNumber = "";

    const rows = document.querySelectorAll("#table-body tr");

    rows.forEach((row) => {
      const cells = row.querySelectorAll("td");
      const rowData = [];

      // Check if this row has a part number cell
      const partNumberCell = cells[0];
      const partInput = partNumberCell.querySelector("textarea");
      if (partInput) {
        currentPartNumber = partInput.value.trim(); // Update current product ID
        rowData.push(currentPartNumber);
      } else {
        rowData.push(currentPartNumber); // Repeat for non-rowspan rows
      }

      // Now get the rest of the fields (skip first cell if part number was already added)
      const startIndex = partInput ? 1 : 0;

      for (let i = startIndex; i < cells.length; i++) {
        const cell = cells[i];
        const input = cell.querySelector("input, textarea");
        if (input) {
          rowData.push(input.value || input.textContent.trim());
        } else {
          rowData.push(cell.textContent.trim());
        }
      }

      tableBody.push(rowData);
    });

    doc.autoTable({
      startY: 20,
      head: [["Part Number", "Month", "Planned", "Actual", "Efficiency", "Target", "Remark"]],
      body: tableBody,
      styles: {
        halign: "center",
        valign: "middle",
        fontSize: 10
      },
      headStyles: {
        fillColor: [52, 73, 235],
        textColor: 255,
        fontStyle: 'bold'
      },
      theme: 'striped'
    });

    const finalY = doc.lastAutoTable.finalY || 30;
    const preparedBy = document.getElementById("preparedBy")?.value || "";
    const checkedBy = document.getElementById("checkedBy")?.value || "";

    doc.setFontSize(12);
    doc.text(`Prepared By: ${preparedBy}`, 14, finalY + 10);
    doc.text(`Checked By: ${checkedBy}`, 14, finalY + 20);

    doc.save("KPI_Report.pdf");
  }

