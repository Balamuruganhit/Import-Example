
document.addEventListener("DOMContentLoaded", () => {

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
    function openTableEditor(cell) {
        currentCell = cell;
        console.log(cell)
        document.getElementById('editorTable').value = cell.innerText.trim();
        const modal = document.getElementById('editorModalTable');
        modal.classList.add('show');
        console.log(modal)
        setTimeout(() => {
            document.getElementById('editorTable').focus();
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
    document.getElementById('addrowButton').addEventListener('click',function addrRow(){
        const dataTable = document.getElementById('editorTable')
            const newRow = `
        <tr>
            <td  contenteditable="true" ></td>
            <td  contenteditable="true" ></td>
            <td  contenteditable="true" ></td>
            <td  contenteditable="true" ></td>
        </tr>
    `;
    dataTable.innerHTML += newRow;
    });
    function closeEditorTable(save) {
        const modal = document.getElementById('editorModalTable');
        const text = document.getElementById('editorTable').value;
        let data = [];
        const table = document.getElementById("editorTable");
       let i=0;
        for (let row of table.rows) {
        let rowData = [];
        if(i > 0){
        // Loop through cells in each row
        if(row.cells[0].textContent !=""){
        for (let cell of row.cells) {

            rowData.push(cell.textContent.trim());
        }
        data.push(rowData);}}
        i++;
    }
        console.log(data)
        document.getElementById("cell-editable-table").textContent = JSON.stringify(data, null, 2);
         console.log(document.getElementById("cell-editable-table").textContent)
       
        modal.classList.remove('show');
        setTimeout(() => {
            modal.style.display = 'none';
        }, 300); // match transition time
    }
        document.getElementById('cell-editable-table').addEventListener('click', function () {
            console.log("working")    
            const modal = document.getElementById('editorModalTable');
                modal.style.display = 'flex';
                openTableEditor(this);
            });
// Apply to each cell
    document.querySelectorAll('.cell-editable').forEach(cell => {
        cell.addEventListener('click', function () {
            const modal = document.getElementById('editorModal');
            modal.style.display = 'flex';
            openEditor(this);
        });
    });
    document.getElementById('editorModal').addEventListener('click', function (e) {
        const editorBox = document.getElementById('editorBox');
        if (!editorBox.contains(e.target)) {
            closeEditor(true);
        }
    });
     document.getElementById('editorModalTable').addEventListener('click', function (e) {
        const editorBoxTable = document.getElementById('editorBoxTable');
        if (!editorBoxTable.contains(e.target)) {
            closeEditorTable(true);
        }
    });

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
        console.log('inside work')
            docIdNew=updateFemaNumber(docId, revision);
            const rows = document.querySelector("table tbody tr");
           
           
                console.log(rows)
                const rowData = {};
                const cells = rows.querySelectorAll("td");
                const inputTypes = Array.from(cells).map(cell => {
                if (cell.querySelector("div.cell-editable")) return "editable";
                return "text";
                });
                    rowData["supplier"] = cells[0].textContent.trim();
                    rowData["input"] = cells[1].textContent.trim();
                    rowData["resources"] = cells[2].textContent.trim();
                    rowData["risk"] = cells[3].textContent.trim();
                    rowData["content"] = cells[4].textContent.trim();
                    rowData["personnel"] = cells[5].textContent.trim();
                    rowData["oppurtunities"] = cells[6].textContent.trim();
                    rowData["process"] = cells[7].textContent.trim();
                    rowData["kpi"] = cells[8].textContent.trim();
                    rowData["output"] = cells[9].textContent.trim();
                    rowData["customer"] = cells[10].textContent.trim();
                    data.push(rowData);
         

            rowDataHeader={
                docId :docIdNew,
                revision:revision,
                saveDate:saveDate,
                previewer:prepareview,
                approver:approve,
                preparer:prepare,
                type:"TURTLE"
            }
            console.log("running")
            console.log(docIdNew)
            console.log(docId)
            data.push(rowDataHeader);
            console.log(data)
            if (docIdNew == docId) {
                    alert("The Revision number needs to be changed");
                    return;
                }
            const payload = JSON.stringify({ TurtleDetails : data });
                document.getElementById("loadingOverlay").style.display = "flex";

                // Prepare the XHR request
                const xhr = new XMLHttpRequest();
                xhr.open("POST", "/AuditReport/control/createTurtleDoc", true);
                xhr.setRequestHeader("Content-Type", "application/json");
                setTimeout
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4) {
                    document.getElementById("loadingOverlay").style.display = "none";
                    document.getElementById("SaveBtn").style.display="none";
                    document.getElementById("turtleBtn").style.display="block";
                    document.getElementById("turtleNewBtn").href=`TurtleReport?printdoc=done&docId=${docIdNew}`
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
    })