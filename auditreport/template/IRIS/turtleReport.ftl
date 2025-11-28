<script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>


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

   

    .footer {
      display: flex;
      justify-content: space-between;
      margin-top: 20px;
      font-size:1.3rem;
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

    .grid-container {
      display: grid;
      grid-template-columns: minmax(4rem , 15rem) minmax(4rem , auto) minmax(4rem , auto) minmax(4rem , auto) minmax(4rem , 15rem);
      margin:auto;
      
      gap: 20px;
      background-color: #fff;
      padding: 20px;
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
      grid-template-areas: "lg-sb-lf tp-lf tp-md tp-rg lg-sb-rg"
                           "lg-sb-lf md-lf md-md md-rg lg-sb-rg"
                           "lg-sb-lf bt-lf bt-md bt-rg lg-sb-rg";
    }
    #lg-sb-lf{
        grid-area: lg-sb-lf;
    }
    #tp-lf{
        grid-area:tp-lf;
    }
    #tp-md{
        grid-area:tp-md;
    }
    #tp-rg{
        grid-area:tp-rg;
    }
    #lg-sb-rg{
        grid-area:lg-sb-rg;
    }
    #md-lf{
        grid-area:md-lf;
    }
    #md-md{
        grid-area:md-md;
    }
    #md-rg{
        grid-area:md-rg;
    }
    #bt-lf{
        grid-area:bt-lf;
    }
    #bt-md{
        grid-area:bt-md;
    }
    #bt-rg{
        grid-area:bt-rg;
    }

    .box {
      background-color: white;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      color: black;
      border:4px solid #0c2d7c;
      font-weight: bold;
      border-radius: 8px;
      font-size: 1.2rem;
      letter-spacing:1px ;
     overflow-wrap: break-word;
    }
    .hexagon {
      
      background-color: #284893ff;
      clip-path: polygon(
        25% 0%, 75% 0%,
        100% 50%,
        75% 100%, 25% 100%,
        0% 50%
      );
      display: flex;
      align-items: center;
      flex-direction: column;
      justify-content: center;
      color:#e0e0e0;
      font-weight: bold;
      padding:2rem;
    }
     .arrow {
      position: absolute;
      height: 2px;
      background: black;
      transform-origin: 0 0;
    }

    .arrow::after {
      content: "";
      position: absolute;
      right: 0;
      top: -5px;
      border-top: 6px solid transparent;
      border-bottom: 6px solid transparent;
      border-left: 10px solid black;
    }
    td,
th {
  border: 3px solid #0c2d7c;
  padding: 5px 2px;
}
table {
    font-size:0.9rem;
  border-collapse: collapse;
}

  </style>

  <div id="printableContent">
  <div class="container">
    <header class="header">
        <h1 style="color:white;">Turtle Diagram</h1>
        
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
     <#list ramsOutputDetails as group>
     <div id="kpiDataDiv" style="display:none;">${group.kpi!" "}
</div>

  <div class="grid-container">
  <div id="supplier" class="arrow"></div>
 <div id="input" class="arrow"></div>
 <div id="resources" class="arrow"></div>
 <div id="risk" class="arrow"></div>
 <div id="personel" class="arrow"></div>
 <div id="work" class="arrow"></div>
 <div id="oppur" class="arrow"></div>
 <div id="kpi" class="arrow"></div>
 <div id="output" class="arrow lefter"></div>
 <div id="customer" class="arrow lefter" ></div>
 
    <div class="box" id="lg-sb-lf">
        <h4  style="font-size:1.4rem;padding-top:1rem;color:black;color:black;">Supplier</h4>
        <div style="padding: 1rem;margin: 1rem 0rem;border: 3px solid #0c2d7c;"  class="cell-editable">${group.supplier!" "}</div>
    </div>
    <div class="box" id="tp-lf"><h4 style="font-size:1.4rem;padding-top:1rem;color:black;">Resources</h4>
<div style="padding: 1rem;margin: 1rem 0rem;border: 3px solid #0c2d7c;"  class="cell-editable">${group.resources!" "}</div>    </div>
    <div class="box" id="tp-md"><h4 style="font-size:1.4rem;padding-top:1rem;color:black;">Risk</h4>
<div style="padding: 1rem;margin: 1rem 0rem;border: 3px solid #0c2d7c;"  class="cell-editable">${group.risk!" "}</div>    </div>
    <div class="box" id="tp-rg"><h4 style="font-size:1.4rem;padding-top:1rem;color:black;">Personnel</h4>
<div style="padding: 1rem;margin: 1rem 0rem;border: 3px solid #0c2d7c;"  class="cell-editable">${group.personnel!" "}</div>    </div>
    <div class="box" id="md-lf"><h4 style="font-size:1.4rem;padding-top:1rem;color:black;">Inputs</h4>
<div style="padding: 1rem;margin: 1rem 0rem;border: 3px solid #0c2d7c;"  class="cell-editable">${group.inputData!" "}</div>    </div>
    <div class="box hexagon" id="md-md"><h4 style="font-size:1.4rem;padding-top:1rem;color:white;">Process</h4>
<div style="padding: 1rem;margin: 1rem 0rem;border: 3px solid #0c2d7c;"  class="cell-editable">${group.process!" "}</div>
    </div>
    <div class="box" id="md-rg"><h4 style="font-size:1.4rem;padding-top:1rem;color:black;">Outputs</h4>
<div style="padding: 1rem;margin: 1rem 0rem;border: 3px solid #0c2d7c;"  class="cell-editable" >${group.outputData!" "}</div>    </div>
    <div class="box" id="bt-lf"><h4 style="font-size:1.4rem;padding-top:1rem;color:black;">Content/Work Instruction</h4>
<div style="padding: 1rem;margin: 1rem 0rem;border: 3px solid #0c2d7c;"  class="cell-editable">${group.content!" "}</div>    </div>
    <div class="box" id="bt-md"><h4 style="font-size:1.4rem;padding-top:1rem;color:black;">Opportunites</h4>
<div style="padding: 1rem;margin: 1rem 0rem;border: 3px solid #0c2d7c;"  class="cell-editable">${group.oppurtunities!" "}</div>    </div>
    <div class="box" id="bt-rg"><h4>KPI 's</h4>      
        <table id="kpiTable">
            <thead>
                <th>KPI / Objective</th>
                <th>Target</th>
                <th>Achieved</th>
                <th>Period</th>
            </thead>
            <tbody>
                
            </tbody>
        </table>  
    </div>
    <div class="box" id="lg-sb-rg"><h4 style="font-size:1.4rem;padding-top:1rem;color:black;">Customer</h4>
<div style="padding: 1rem;margin: 1rem 0rem;border: 3px solid #0c2d7c;"  class="cell-editable">${group.customer!" "}</div>    </div>
</#list>
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
     
     
</div>
</div>
<button id="SaveBtn" style="color:white; font-size:1.2rem;">Print</button>
<script>
  // Get the data from the div
  let rawData = document.getElementById("kpiDataDiv").innerText.trim();
  try {
  data = JSON.parse(rawData);
  console.log("Parsed JSON:", data);
} catch (e) {
  console.warn("Invalid JSON, skipping parse.");
  // Optional: fallback to raw string
  rawData=null
}

  if(rawData){
     console.log("it is run here")
  // Parse it into an array
      const data = JSON.parse(rawData);
    console.log(data)
      const tbody = document.querySelector("#kpiTable tbody");
      tbody.innerHTML = "";

      // Loop and insert rows
      data.forEach(rowArray => {
        const row = document.createElement("tr");
        rowArray.forEach(cellData => {
          const cell = document.createElement("td");
          cell.classList.add("cell-editable");
          cell.setAttribute("contenteditable", "true");
          cell.textContent = cellData;
          row.appendChild(cell);
        });
        tbody.appendChild(row);
      });
  }
document.getElementById("SaveBtn").addEventListener("click", () => {
  // Recalculate arrow positions first
 
  // Then export
  const element = document.getElementById("printableContent");
  const { jsPDF } = window.jspdf;

  html2canvas(element, {
  scale: 2, // LOWER SCALE = LOWER SIZE
  useCORS: true
}).then((canvas) => {
  const imgData = canvas.toDataURL("image/jpeg", 0.9); // JPEG & lower quality (0.6)
  const pdf = new jsPDF("l", "mm", "a4");

  const pdfWidth = pdf.internal.pageSize.getWidth();
  const pdfHeight = pdf.internal.pageSize.getHeight();

  const imgWidth = canvas.width;
  const imgHeight = canvas.height;
  const ratio = Math.min(pdfWidth / imgWidth, pdfHeight / imgHeight);

  pdf.addImage(imgData, "JPEG", 0, 0, imgWidth * ratio, imgHeight * ratio);
  pdf.save("turtle-diagram.pdf");
});
});



  
</script>
