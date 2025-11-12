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


console.log("it is working")
document.addEventListener("DOMContentLoaded", () => {
  console.log("hello")
  const headers = document.querySelectorAll('.plus');

  headers.forEach(header => {
    header.addEventListener('click', () => {
      const section = header.parentElement;
      const isActive = section.classList.contains('active');

      if (isActive) {
        section.classList.remove('active');
        header.querySelector('.symbol').textContent = '+';
      } else {
        section.classList.add('active');
        header.querySelector('.symbol').textContent = '–';
      }
    });
  });

  console.log("hello")
  let failureRate=0;
  var saveCounter=0;
  const but=document.getElementById('calrms')
  const calreliab=document.getElementById('calreliab')
  const calavail=document.getElementById('calavail')
  const calpro=document.getElementById('calpro')
  const calinde=document.getElementById('calinde')
  const calfinal=document.getElementById('calFinal')
  var store=[]
  function updateRamsNumber(ramsno, rev) {
    let cleaned = ramsno.replace(/_R\d+$/, ""); // remove _R followed by digits at the end
    return cleaned + "_R" + rev;
}
 if(calavail){
  calavail.addEventListener('click',()=>{
    console.log("hello avauil")
      var ifailure= document.getElementById('failure').value;
      console.log(ifailure)
      if(ifailure == 0){
         ifailure= failureRate.toFixed(8);
      }

      //parseInt(document.getElementById('failure').value);
      const irepair=parseInt(document.getElementById('repair').value);
      const imaintenance=parseInt(document.getElementById('maintenance').value);
       
        if (isNaN(ifailure) || isNaN(irepair) ||isNaN(imaintenance)) {
          alert("Please enter valid input values.");
          return;
        }
    
        const hoursPerYear = 8766;
        console.log(ifailure,irepair,imaintenance)
        // Best estimate of failure rate (per year)
        
        const mtbf1 = hoursPerYear / ifailure;
        console.log(mtbf1)
        // Confidence bounds using Chi-square
        const sum=mtbf1 + irepair
        console.log(sum)
        var excl = ((mtbf1)/sum)*100
        console.log(excl)
        const add = (imaintenance/ hoursPerYear)*100;
        console.log(`add ${add}`)
        var incl = excl - add ;
        console.log(incl)
        const resultData={
          name:"availability",
          int1:irepair,
          int3:imaintenance,
          int2:ifailure,
          out1:excl,
          out2:incl,
          out3:mtbf1.toFixed(3)
        }
        store.push(resultData)
        // Display results
        document.getElementById("output1").innerHTML = `
              
          <table>
            
            <tr>
              <td>Result</td>
              <td>MTBFs = ${mtbf1.toFixed(0)}hrs</td>
            </tr>
            <tr>
              <td>Availability excl. planned mtce</td>
              <td>${excl.toFixed(2)} %</td>
            </tr>
            <tr>
              <td>Availability incl. planned mtce</td>
              <td>${incl.toFixed(2)} %</td> 
            </tr>
          </table>
        `;
      
    })
    }
    if(calreliab){
      calreliab.addEventListener('click',()=>{
        console.log(failureRate)
          const ifailureRate = document.getElementById("failuresrate").value;
          const timeStr = document.getElementById("time").value.trim();
          if(ifailureRate == 0){
             ifailureRate =failureRate.toFixed(2); 
          }
          const itime = parseFloat(timeStr.replace(',', '.'));

           
            if (isNaN(ifailureRate) || isNaN(itime) ) {
              alert("Please enter valid input values.");
              return;
            }
        
            const prob = Math.exp(-ifailureRate * itime)*100
            const mor= 100- prob
            console.log(ifailureRate,itime)
            console.log(prob)
            const resultData = 
               {
                name:"reliability",
                int1: itime,
                int2: parseFloat(ifailureRate),
                out1: prob.toFixed(2),
                out2: mor.toFixed(2),
            };
            store.push(resultData)
            console.log(resultData)
            document.getElementById("output2").innerHTML = `
             
              <table>
          <tr>
            <td>Result</td>
            <td></td>
          </tr>
          <tr>
            <td>Probability of no failures</td>
            <td>${prob.toFixed(2)} %</td>
          </tr>
          <tr>
            <td>Probability of one or nore failures</td>
            <td>${mor.toFixed(2)} %</td>
          </tr>
        </table>
            `;
          
        })
        }
  if(but){
      but.addEventListener('click',()=>{
        console.log("hello rmsmain")
        var ifailure= document.getElementById('failure');
        var failureRateStr = document.getElementById("failuresrate");
        var rfailureRate = document.getElementById("rfailures")
        const timePeriod = parseFloat(document.getElementById("timePeriod").value);
          const failures = parseInt(document.getElementById("failures").value);
         
          if (isNaN(timePeriod) || isNaN(failures) || timePeriod <= 0 || failures < 0) {
            alert("Please enter valid input values.");
            return;
          }
      
          const hoursPerYear = 8766;
      
          // Best estimate of failure rate (per year)
          
          const mtbf = timePeriod / failures;
      
          // Confidence bounds using Chi-square
          const alpha = 0.10;
          const actual=jStat.chisquare.inv(0.5, (2 * failures)+2);
          const lowerChi = jStat.chisquare.inv(0.05, (2 * failures)+2);
          const upperChi = jStat.chisquare.inv(0.95, (2 * failures)+2);
      
          const actualBand= (2 * timePeriod * hoursPerYear) / actual;
          const lowerBound =(2 * timePeriod * hoursPerYear) /  lowerChi;
          const upperBound = (2 * timePeriod * hoursPerYear) / upperChi ;
      
          const failLower = hoursPerYear / lowerBound;
          const failUpper =  hoursPerYear / upperBound;
          failureRate =  hoursPerYear / actualBand;
          ifailure.value=failureRate.toFixed(2)
          failureRateStr.value=failureRate.toFixed(2)
          rfailureRate.value=failureRate.toFixed(2)
          console.log(ifailure.value,failureRateStr.value)
          const resultData={
            name:"empirical",
            int2:failures,
            int1:timePeriod,
            out1:failureRate.toFixed(2),
            out2:actualBand.toFixed(0),
            out3:failUpper.toFixed(2),
            out4:upperBound.toFixed(0),
            out5:failLower.toFixed(2),
            out6:lowerBound.toFixed(0),
          }
          store.push(resultData)
      
          // Display results
          document.getElementById("output").innerHTML = `
            <table>
              <tr>
                <td>Result</td>
                <td>Failure Rate</td>
                <td><div class="tooltip-wrapper">
                          Equivalent MTBFs
                          <div class="tooltip-text">
                              MTBF = Mean Time Between Failures
                          </div>
                      </div></td>
              </tr>
              <tr>
                <td>Best estimate of failure rate</td>
                <td><strong>${failureRate.toFixed(2)}</strong> <div class="tooltip-wrapper">
                          per year
                          <div class="tooltip-text">
                              This is the median, or central best estmate of failure rate

                          </div>
                      </div></td>
                <td><strong>${actualBand.toFixed(0)}</strong> hours</td>
              </tr>
              <tr>
                <td>90% confidence interval - upper bound</td>
                <td>${failUpper.toFixed(2)} <div class="tooltip-wrapper">
                          per year
                          <div class="tooltip-text">
                              95% probability that failure rate is less than this value
                          </div>
                      </div></td>
                <td>${upperBound.toFixed(0)} hours</td>
              </tr>
              <tr>
                <td>90% confidence interval - lower bound</td>
                <td>${failLower.toFixed(2)} <div class="tooltip-wrapper">
                          per year
                          <div class="tooltip-text">
                              95% probability that failure rate is more than this value
                          </div>
                      </div></td>
                <td>${lowerBound.toFixed(0)} hours</td>
              </tr>
            </table>
          `;
        
      })
      }
      if(calpro){
        calpro.addEventListener('click',()=>{
              const rtimePeriod = parseFloat(document.getElementById("rtimePeriod").value);
              const rinterest = parseFloat(document.getElementById("rinterest").value);
              const rfailureRate = document.getElementById("rfailures").value;
              if(rfailureRate == 0){
                rfailureRate = failureRate.toFixed(2);
              }
              
            
          
              // Exact factorial using gamma function for large x
            function factorial(n) {
              if (n < 0) return NaN;
              if (n === 0 || n === 1) return 1;
              let result = 1;
              for (let i = 2; i <= n; i++) result *= i;
              return result;
            }

            function poissonPMF(x, lambda) {
              if (x < 0 || lambda < 0) return 0;
              console.log("calling")
              return (Math.pow(lambda, x) * Math.exp(-lambda)) / factorial(x);
            }
            function poissonCDF(x, lambda) {
              let sum = 0;
              for (let k = 0; k <= x; k++) {
                sum += poissonPMF(k, lambda);
              }
              return sum;
            }
            
            function poissonProbability(B8, B6, B7) {
              const lambda = B6 * B7;
            
              if (B8 === 0) {
                return 1;
              } else {
                return 1 - poissonCDF(B8 - 1, lambda);
              }
            }
            
          console.log(rtimePeriod,rfailureRate,rinterest)
            // Example usage:
          
            const B8 = rinterest;           // x
            const B6 = rfailureRate;         // failure rate
            const B7 = rtimePeriod;          // time
            var lambda = B6 * B7;
            console.log(B6)
            const result = poissonPMF(B8, lambda);
            console.log("P(X = x):", result.toFixed(4)*100);
            const result1 = poissonProbability(B8, B6, B7);
            console.log(`P(X ≥ ${B8}) =`, result1.toFixed(8));
            const resultData={
              name:"dependpro",
              int1:rtimePeriod,
              int2:rfailureRate,
              int3:rinterest,
              out1:result.toFixed(5)*100,
              out2:result1.toFixed(5)*100,
            }
            store.push(resultData)
            console.log(resultData)
            document.getElementById("output4").innerHTML = `
            
              <table>
            <tr>
              <td>Result</td>
              <td></td>
            </tr>
            <tr>
              <td>Probability of ${rinterest} failures</td>
              <td>${result.toFixed(5)*100} %</td>
            </tr>
            <tr>
              <td>Probability of ${rinterest} or more failures</td>
              <td>${result1.toFixed(5)*100} %</td>
            </tr>
          </table>
            `;
            
          })
  }
  if(calinde){
    calinde.addEventListener('click',()=>{
      const itimePeriod = parseFloat(document.getElementById("itime").value);
      const event = parseFloat(document.getElementById("event").value);
      const ifailureRateStr = document.getElementById("ifailures").value.trim();
      var infailureRate = parseFloat(ifailureRateStr.replace(',', '.'));
       if(infailureRate ==0){
         infailureRate = failureRate.toFixed(2);
       }
        
    
        function factorial(n) {
          if (n === 0 || n === 1) return 1;
          let result = 1;
          for (let i = 2; i <= n; i++) result *= i;
          return result;
        }
        
        function binomialCoefficient(n, k) {
          return factorial(n) / (factorial(k) * factorial(n - k));
        }
        
        function binomialPMF(x, n, p) {
          if (p < 0 || p > 1 || x < 0 || x > n) return 0;
          return binomialCoefficient(n, x) * Math.pow(p, x) * Math.pow(1 - p, n - x);
        }
        
        function binomialDIST(x, n, p, cumulative) {
          if (cumulative) {
            let sum = 0;
            for (let k = 0; k <= x; k++) {
              sum += binomialPMF(k, n, p);
            }
            return sum;
          } else {
            return binomialPMF(x, n, p);
          }
        }
        console.log(event,itimePeriod,infailureRate)
        // Example values:
        const x = event;       // B21
        const n = infailureRate;      // B20
        const p = itimePeriod;     // B19
        
        const exact = (binomialDIST(x, n, p, false))*100;
        const cumulative =(1- binomialDIST(x - 1, n, p, true))*100;
        
        console.log(`P(X = ${x})        = ${exact.toFixed(8)}`);
        console.log(`P(X ≤ ${x})       = ${cumulative.toFixed(8)}`);
        
        const resultData={
          name:"indepro",
          int1:itimePeriod,
          int2:event,
          int3:infailureRate,
          out1:exact.toFixed(2),
          out2:cumulative.toFixed(2)
        }
        store.push(resultData)
        // Display results
        document.getElementById("output5").innerHTML = `
          <table>
            <tr>
              <td>Result</td>
              <td></td>
            </tr>
            <tr>
              <td>Probability of ${event} failures</td>
              <td>${exact.toFixed(2)} %</td>
            </tr>
            <tr>
              <td>Probability of ${event} or more failures</td>
              <td>${cumulative.toFixed(2)}%</td>
            </tr>
          </table>
        `;
      
    })
}
if(calfinal){
  calfinal.addEventListener('click',()=>{
      const ioldRate=parseInt(document.getElementById('RateOldPeriod').value);
      const inewRate=parseInt(document.getElementById('RateNewfailures').value);
      const expected = ioldRate;  // B6
      const observed = inewRate;   // B7

      const testStat = Math.pow(expected - observed, 2) / expected; // ((B6 - B7)^2)/B6
      const degreesOfFreedom = 1;

      const cumulativeP = jStat.chisquare.cdf(testStat, degreesOfFreedom);

      
      console.log("Cumulative p-value:", cumulativeP.toFixed(6));
      var finalOut=(cumulativeP*100).toFixed(1)
      const resultData={
        name:"final",
        int1:ioldRate,
        int2:inewRate,
        out1:finalOut,
      }
      store.push(resultData)
      document.getElementById("output6").innerHTML = `
          
        <table>
            <tr>
              <td>Result</td>
              <td></td>
              
            </tr>
            <tr>
              <td>Confidence that failure rate has changed</td>
              <td>
              <div class="tooltip-wrapper">
                          ${finalOut}%
                          <div class="tooltip-text">
                              This returns the probability that the observation is not just due to random chance with an unchanged failure rate.
                          </div>
                      </div></td>
            </tr>
          </table>
        `; 
        
       
    })
    console.log(store)
    document.getElementById('save').addEventListener("click", async (event) => {
      const savebutton=document.getElementById('save')
      savebutton.classList.add('remover')
      const ramsno=document.getElementById('rams').value.trim();
      const rev=document.getElementById('revision').value;
      let ramsNumber = updateRamsNumber(ramsno, rev);
      const ramsInfo = {
        ramsNumber: ramsNumber,
        revision:document.getElementById('revision').value,
        productCode: document.getElementById('product').value.trim(),
        system: document.getElementById('system').value.trim(),
        subSystem: document.getElementById('SubSystem').value.trim(),
        subSubSystem: document.getElementById('subsubsystem').value.trim(),
        ramsResponsibility: document.getElementById('response').value.trim(),
        date: document.getElementById('date').value, // Already in YYYY-MM-DD format
        teamMembers: document.getElementById('member').value.trim(),
        approvedBy: document.getElementById('approver').value.trim()
      };
      store.push(ramsInfo)
      const lastUniqueByName = Array.from(
          store.reduce((map, item) => map.set(item.name, item), new Map()).values()
        );
        console.log(lastUniqueByName)
      if (store.length === 0) {
          alert("No data to submit.");
          return;
      }
      const payload = JSON.stringify({ ramsDetail : lastUniqueByName });
  
      // Prepare the XHR request
      const xhr = new XMLHttpRequest();
      xhr.open("POST", "/PanguAi/control/createRam", true);
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
}

})