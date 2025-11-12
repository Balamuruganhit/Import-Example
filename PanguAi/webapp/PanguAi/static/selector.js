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
const selectedRamsNo = [];
const buttonSubmit=document.getElementById('print');
console.log(buttonSubmit)
console.log("it from selector")
  document.querySelectorAll('input[type="checkbox"]').forEach((checkbox) => {
    checkbox.addEventListener('change', function () {
      const ramsNo = this.closest('tr').querySelector('td').textContent.trim();

      if (this.checked) {
        if (!selectedRamsNo.includes(ramsNo)) {
          selectedRamsNo.push(ramsNo);
        }
      } else {
        const index = selectedRamsNo.indexOf(ramsNo);
        if (index > -1) {
          selectedRamsNo.splice(index, 1);
        }
      }

      console.log(selectedRamsNo); // for debugging
    });
  });
  if(window.location.pathname =="/PanguAi/control/findfracas"){
      console.log("working")
  console.log(window.location.pathname)}
  buttonSubmit.addEventListener('click', (event) => {
    event.preventDefault(); // prevent default button action (like form submission)

    console.log("Clicked Print");
    console.log(selectedRamsNo);

    if (selectedRamsNo.length === 0) {
        alert("Please select at least one RAMS item.");
        return;
    }

    const joinedRams = selectedRamsNo.join(',');
    let targetUrl;
    console.log(joinedRams)
    if(window.location.pathname =="/PanguAi/control/findfracas"){
      console.log("working")
      targetUrl = `/PanguAi/control/MasterReportFracas?fracasDetail=${encodeURIComponent(joinedRams)}`;
    }else{
      targetUrl = `/PanguAi/control/MasterReport?ramsDetail=${encodeURIComponent(joinedRams)}`;
    }
    // Option 1: redirect the user
    window.location.href = targetUrl;

    // Option 2 (if it's a link you want to modify dynamically):
    // document.getElementById('reportLink').href = targetUrl;
});
});