<style>


    .app-container {
    max-width: 1200px;
    margin: auto;
    padding: 20px;
    }

    .app-header {
    text-align: center;
    background-color: #0078d7;
    color: #fff;
    padding: 20px 10px;
    border-radius: 8px 8px 0 0;
    }

    .form-wrapper {
    background: #fff;
    padding: 30px;
    border-radius: 0 0 8px 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    .card {
    margin-bottom: 25px;
    padding: 20px;
    background: #f7f9fc;
    border-radius: 6px;
    box-shadow: 0 0 3px rgba(0, 0, 0, 0.08);
    }

    .card-title {
    margin-bottom: 15px;
    font-size: 18px;
    border-bottom: 1px solid #ccc;
    padding-bottom: 5px;
    }

    .grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
    gap: 16px;
    }

    .form-group {
    display: flex;
    flex-direction: column;
    }

    .full {
    grid-column: span 2;
    }

    input, select, textarea {
    padding: 8px;
    font-size: 14px;
    border: 1px solid #aaa;
    border-radius: 4px;
    background-color: #fff;
    }

    textarea {
    resize: vertical;
    }

    .form-actions {
    text-align: right;
    margin-top: 20px;
    }

    .btn {
    padding: 10px 20px;
    font-size: 14px;
    border: none;
    border-radius: 5px;
    margin-left: 10px;
    cursor: pointer;
    }

    .btn-primary {
    background-color: #0078d7;
    color: #fff;
    }

    .btn-secondary {
    background-color: #ccc;
    color: #000;
    }
    .form-group select{
        font-size:12px;
    }
    .dataDv{
      width
    }
</style>
  <div class="app-container">
    <header class="app-header">
      <h1>FRACAS Report</h1>
    </header>
    <#if ramsOutputTitle?has_content>
      <main class="form-wrapper">
      <!-- Section: Complaint Details -->
      <section class="card">
        <h2 class="card-title">Complaint Details</h2>
        <div class="grid">
          <div class="form-group"><label>Complaint Number</label><input type="text"  value=${ramsOutputTitle.complaintNumber!" "}></div>
          <div class="form-group"><label>Complaint Date</label><input type="text"  value=${ramsOutputTitle.complaintDate!" "}></div>
          <div class="form-group"><label>Customer Name</label><input type="text"  value=${ramsOutputTitle.customerName!" "}></div>
          <div class="form-group"><label>System</label><input type="text"  value=${ramsOutputTitle.system!" "}></div>
          <div class="form-group"><label>Sub-system</label><input type="text"  value=${ramsOutputTitle.subSystem!" "}></div>
          <div class="form-group"><label>Sub-sub-system</label><input type="text"  value=${ramsOutputTitle.subSubSystem!" "}></div>
          <div class="form-group"><label>Warranty Date (Start)</label><input type="date"  value=${ramsOutputTitle.startWarranty!" "}></div>
          <div class="form-group"><label>Warranty Date (End)</label><input type="date"  value=${ramsOutputTitle.endWarranty!" "}></div>
          <div class="form-group"><label>Customer Zone</label><input type="text"  value=${ramsOutputTitle.customerZone!" "}></div>
          <div class="form-group"><label>Product is Prototype</label><input type="text"  value=${ramsOutputTitle.prototype!" "}>
          </div>
          <div class="form-group"><label>Part No</label><input type="text"  value=${ramsOutputTitle.partNumber!" "}></div>
          <div class="form-group"><label>Fracas Report No</label><input type="text"  value=${ramsOutputTitle.reportNumber!" "}></div>
          <div class="form-group"><label>Drawing/Revision No</label><input type="text"  value=${ramsOutputTitle.revision!" "}></div>
          <div class="form-group"><label>Part Description</label><input type="text"  value=${ramsOutputTitle.partdescription!" "}></div>
          <div class="form-group"><label>Create Date</label><input type="text"  value=${ramsOutputTitle.createDate!" "}></div>
        </div>
      </section>

      <!-- Section: Failure Analysis -->
      <section class="card">
        <h2 class="card-title">Failure Analysis</h2>
        <div class="grid">
          <div class="form-group full"><label>Failure Type</label><input type="text"  value=${ramsOutputTitle.failureType!" "}></div>
          <div class="form-group full"><label>Failure Nature</label><input type="text"  value=${ramsOutputTitle.failureNature!" "}></div>
          <div class="form-group"><label>Targeted Closure Date</label><input type="text"  value=${ramsOutputTitle.closureDate!" "}></div>
          <div class="form-group"><label>Complaint Status</label><input type="text"  value=${ramsOutputTitle.status!" "}></div>
          <div class="form-group full"><label>Root Cause</label><textarea rows="2" name="rootCauses">${ramsOutputTitle.rootCauses!" "}</textarea></div>
          <div class="form-group full"><label>Corrective Action to Be Done</label><textarea rows="2" name="rootCauses">${ramsOutputTitle.action!" "}</textarea></div>
          <div class="form-group full"><label>Problem Reported (Generation Point)</label><textarea rows="2" name="rootCauses">${ramsOutputTitle.problemReported!" "}</textarea></div>
          <div class="form-group full"><label>Defect Observed (Escape Point)</label><textarea rows="2" name="rootCauses">${ramsOutputTitle.defectObserved!" "}</textarea></div>
          <div class="form-group full"><label>Corrective Action</label><textarea rows="2" name="rootCauses">${ramsOutputTitle.correctiveAction!" "}</textarea></div>
          <div class="form-group"><label>Actual Closure Date</label><input type="date"  value=${ramsOutputTitle.actualDate!" "}></div>
          <div class="form-group full"><label>R&D Action</label><textarea rows="2" name="rootCauses">${ramsOutputTitle.RDAction!" "}</textarea></div>
          <div class="form-group"><label>Cost Implication</label><textarea rows="2" name="rootCauses">${ramsOutputTitle.costImplication!" "}</textarea></div>
        </div>
      </section>

      <!-- Section: Responsibility -->
      <section class="card">
        <h2 class="card-title">Responsible Persons</h2>
        <div class="grid">
          <div class="form-group"><label>Responsible Person 1</label><input type="text"  value=${ramsOutputTitle.response1!" "}></div>
          <div class="form-group"><label>Responsible Person 2</label><input type="text"  value=${ramsOutputTitle.response2!" "}></div>
          <div class="form-group"><label>Approved By</label><input type="text"  value=${ramsOutputTitle.approver!" "}></div>
        </div>
      </section>

      <!-- Save/Cancel Buttons -->
      <div class="form-actions">
        <button ><a style="color:white; font-size:1.2rem;" href="fracasReport?reportNumber=${ramsOutputTitle.complaintNumber}">Print Document</a></button>

      </div>
    </main>
    <#else>
<form name="questionAddForm" action="<@ofbizUrl>Createfracas</@ofbizUrl>" method="post">
    <main class="form-wrapper">
      <!-- Section: Complaint Details -->
      <section class="card">
        <h2 class="card-title">Complaint Details</h2>
        <div class="grid">
          <div class="form-group"><label>Complaint Number</label><input type="text" name="complaintNumber"></div>
          <div class="form-group"><label>Complaint Date</label><input type="date" name="complaintDate"></div>
          <div class="form-group"><label>Customer Name</label><input type="text" name="customerName"></div>
          <div class="form-group"><label>System</label><input type="text" name="system"></div>
          <div class="form-group"><label>Sub-system</label><input type="text" name="subSystem"></div>
          <div class="form-group"><label>Sub-sub-system</label><input type="text" name="subSubSystem"></div>
          <div class="form-group"><label>Warranty Date (Start)</label><input type="date" name="startWarranty"></div>
          <div class="form-group"><label>Warranty Date (End)</label><input type="date" name="endWarranty"></div>
          <div class="form-group"><label>Customer Zone</label><input type="text" name="customerZone"></div>
          <div class="form-group"><label>Product is Prototype</label>
            <select name="prototype"><option>YES</option><option>NO</option></select>
          </div>
          <div class="form-group"><label>Part No</label><input type="text"  name="partNumber"></div>
          <div class="form-group"><label>Fracas Report No</label><input type="text"  name="reportNumber"></div>
          <div class="form-group"><label>Drawing/Revision No</label><input type="text"  name="revision"></div>
          <div class="form-group"><label>Part Description</label><input type="text"  name="partdescription"></div>
          <div class="form-group"><label>Create Date</label><input type="date"  name="createDate"></div>
        </div>
      </section>

      <!-- Section: Failure Analysis -->
      <section class="card">
        <h2 class="card-title">Failure Analysis</h2>
        <div class="grid">
          <div class="form-group full"><label>Failure Type</label><input type="text" name="failureType"></div>
          <div class="form-group full"><label>Failure Nature</label><input type="text" name="failureNature"></div>
          <div class="form-group"><label>Targeted Closure Date</label><input type="date" name="closureDate"></div>
          <div class="form-group"><label>Complaint Status</label><input type="text" name="status"></div>
          <div class="form-group full"><label>Root Cause</label><textarea rows="2" name="rootCauses"></textarea></div>
          <div class="form-group full"><label>Corrective Action to Be Done</label><textarea rows="2" name="action"></textarea></div>
          <div class="form-group full"><label>Problem Reported (Generation Point)</label><textarea rows="2" name="problemReported"></textarea></div>
          <div class="form-group full"><label>Defect Observed (Escape Point)</label><textarea rows="2" name="defectObserved"></textarea></div>
          <div class="form-group full"><label>Corrective Action</label><textarea rows="2" name="correctiveAction"></textarea></div>
          <div class="form-group"><label>Actual Closure Date</label><input type="date" name="actualDate"></div>
          <div class="form-group full"><label>R&D Action</label><textarea rows="2" name="RDAction"></textarea></div>
          <div class="form-group"><label>Cost Implication</label><input type="text" name="costImplication"></div>
        </div>
      </section>

      <!-- Section: Responsibility -->
      <section class="card">
        <h2 class="card-title">Responsible Persons</h2>
        <div class="grid">
          <div class="form-group"><label>Responsible Person 1</label><input type="text" name="response1"></div>
          <div class="form-group"><label>Responsible Person 2</label><input type="text" name="response2"></div>
          <div class="form-group"><label>Approved By</label><input type="text" name="approver"></div>
        </div>
      </section>

      <!-- Save/Cancel Buttons -->
      <div class="form-actions">
       
        <input class="btn btn-primary" type="submit"/>
      </div>
    </main>
    </form>
      </#if>
  </div>


