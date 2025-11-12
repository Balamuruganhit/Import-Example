
  <div class="header_ram">
    <table>
      <tr>
        <td>RAMS number</td>
        <td><input type="text" value="${ramsOutputTitle.ramsNo!""}" style="background: white;
    color: black;" id="rams" disabled></td>
        <td>Product code:</td>
        <td colspan="3"><input type="text" style="background: white;
    color: black;" value="${ramsOutputTitle.productCode!""}" disabled id="product"></td>
      </tr>
      <tr>
        <td>System: </td>
        <td><input type="text" style="background: white;
    color: black;" value="${ramsOutputTitle.system!""}" disabled id="system"></td>
        <td>Sub-System:  </td>
        <td><input type="text" style="background: white;
    color: black;" value="${ramsOutputTitle.subsystem!""}" disabled id="SubSystem"></td>
        <td>Sub-sub-System: </td>
        <td><input type="text" style="background: white;
    color: black;" value="${ramsOutputTitle.subsubsystem!""}" disabled  id="subsubsystem"></td>
      </tr>
      <tr>
        <td>RAMS responsibility:</td>
        <td colspan="3"><input type="text" style="background: white;
    color: black;" value="${ramsOutputTitle.rams!""}" disabled id="response"></td>
        <td>Date:</td>
        <td><input type="date" style="background: white;
    color: black;" value="${date!""}" disabled  id="date"></td>
      </tr>
      <tr>
        <td>Team members:</td>
        <td colspan="3"><input style="background: white;
    color: black;" type="text" value="${ramsOutputTitle.team!""}" disabled id="member"></td>
        <td>Approved by:</td>
        <#if date?has_content>
        <td><input type="text" style="background: white;
    color: black;" value="${ramsOutputTitle.approver!""}" disabled id="approver"></td>
        <#else>
          <td><input type="text" style="background: white;
    color: black;" disabled  id="approver"></td>          
        </#if>
      </tr>
    </table>
   
  </div>
  <#list ramsOutputDetails as ramsOut>
  <div class="main">
    <#if ramsOut.calculatorType == "empirical">
      <div class="expander_section">
          <div class="plus">
            <h3>Empirical Failure Rate Calculator</h3>
            
          </div>
          <div class="calculator" style="display: flex;
    align-items: center;
    justify-content: space-around;">
            <div class="left">
                <table>
                  <tr>
                    <td style="width: 23rem;">Time period for observations (years):</td>
                    <td><input type="number" id="timePeriod" value="${ramsOut.int1!""}" step="0.01"></td>
                    <td>years</td>
                  </tr>
                  <tr>
                    <td style="width: 23rem;">Number of failures observed:</td>
                    <td><input type="number" id="failures" value="${ramsOut.int2!""}" step="1"></td>
                  </tr>
                  <tr colspan="2"><td><button style="display:none" id="calrms">Calculate</button></td></tr>
                </table>
            </div>
            <div class="right" id="output">
              <table>
                <tr>
                  <td>Result</td>
                  <td>Failure Rate</td>
                  <td>Equivalent MTBFs</td>
                </tr>
                <tr>
                  <td>Best estimate of failure rate</td>
                  <td>${ramsOut.out1!""} per year</td>
                  <td>${ramsOut.out2!""} hours</td>
                </tr>
                <tr>
                  <td>90% confidence interval - upper bound</td>
                  <td>${ramsOut.out3!""} per year</td>
                  <td>${ramsOut.out4!""} hours</td>
                </tr>
                <tr>
                  <td>90% confidence interval - lower bound</td>
                  <td>${ramsOut.out5!""} per year</td>
                  <td>${ramsOut.out6!""} hours</td>
                </tr>
              </table>
            </div>
          </div>
      </div>
    <#elseif ramsOut.calculatorType == "availability" >
      <div class="expander_section">
        <div class="plus">
          <h3>Availability</h3>
          
        </div>
        <div class="calculator" style="display: flex;
    align-items: center;
    justify-content: space-around;">
          <div class="left">
              <table>
                <tr>
                  <td style="width: 17rem;">Failure rate:</td>
                  <td> <input type="number" id="failure" value="${ramsOut.int2!""}" step="0.001" disabled></td>
                  <td style="width: 9rem;text-align: left;">per year</td>
                </tr>
                <tr>
                  <td style="width: 17rem;">Repair time (MTTR):</td>
                  <td> <input type="number" id="repair" value="${ramsOut.int1!""}" step="1"></td>
                  <td style="width: 9rem;text-align: left;">hours</td>
                </tr>
                <tr>
                  <td style="width: 17rem;">Planned maintenance time:</td>
                  <td><input type="number" id="maintenance" value="${ramsOut.int3!""}" step="1"></td>
                  <td style="width: 9rem;text-align: left;">hours per year</td>
                </tr>
                <tr><td><button style="display:none" id="calavail">Calculate</button></td></tr>
              </table>
          </div>
          <div class="right" id="output1">
            <table>
              
              <tr>
                <td>Result</td>
                <td></td>
              </tr>
              <tr>
                <td>Availability excl. planned mtce</td>
                <td>${ramsOut.out1!""} %</td>
              </tr>
              <tr>
                <td>Availability incl. planned mtce</td>
                <td>${ramsOut.out2!""} %</td> 
              </tr>
            </table>
          </div>
        </div>
      </div>
    <#elseif ramsOut.calculatorType == "reliability" >
      <div class="expander_section">
        <div class="plus">
          <h3>Reliability</h3>
          
        </div>
        <div class="calculator" style="display: flex;
    align-items: center;
    justify-content: space-around;">
          <div class="left">
              <table>
                <tr>
                  <td style="width: 17rem;">Failure rate:</td>
                  <td><input type="number" value="${ramsOut.int2!""}" id="failuresrate"  disabled></td>
                  <td style="width: 9rem;text-align: left;">per year</td>
                </tr>
                <tr>
                  <td style="width: 17rem;">Time period:</td>
                  <td><input type="number" id="time" value="${ramsOut.int1!""}" step="1"></td>
                  <td style="width: 9rem;text-align: left;">years</td>
                </tr>
                <tr><td><button style="display:none" id="calreliab">Calculate</button></td></tr>
              </table>
          </div>
          <div class="right" id="output2">
            <table>
              <tr>
                <td>Result</td>
                <td></td>
              </tr>
              <tr>
                <td>Probability of no failures</td>
                <td>${ramsOut.out1!""} %</td>
              </tr>
              <tr>
                <td>Probability of one or nore failures</td>
                <td>${ramsOut.out2!""} %</td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    <#elseif ramsOut.calculatorType == "dependpro" >
    <div class="expander_section">
      <div class="plus">
        <h3>Probability of r failures in a given time period</h3>
       
      </div>
      <div class="calculator" style="display: flex;
    align-items: center;
    justify-content: space-around;">
        <div class="left">
            <table>
              <tr>
                <td  style="width: 21rem;">Failure rate:</td>
                <td><input type="number" value="${ramsOut.int2!""}" id="rfailures" disabled step="0.01"></td>
              </tr>
              <tr>
                <td style="width: 21rem;">Time period:</td>
                <td><input type="number" id="rtimePeriod" value="${ramsOut.int1!""}" step="1"></td>
              </tr>
              <tr>
                <td style="width: 21rem;">Number of failures of interest r:</td>
                <td><input type="number" id="rinterest" value="${ramsOut.int3!""}" step="1"></td>
              </tr>
              <tr><td><button style="display:none" id="calpro">Calculate</button></td></tr>
            </table>
        </div>
        <div class="right" id="output4">
          <table>
            <tr>
              <td>Result</td>
              <td></td>
            </tr>
            <tr>
              <td>Probability of ${ramsOut.int1!""} failures</td>
              <td>${ramsOut.out1!""} %</td>
            </tr>
            <tr>
              <td>Probability of ${ramsOut.int1!""} or more failures</td>
              <td>${ramsOut.out2!""} %</td>
            </tr>
          </table>
        </div>
      </div>
    </div>
    <#elseif ramsOut.calculatorType == "indepro" >
    <div class="expander_section">
      <div class="plus">
        <h3>Probability of r failures in n independent events</h3>
        
      </div>
      <div class="calculator" style="display: flex;
    align-items: center;
    justify-content: space-around;">
        <div class="left">
            <table>
              <tr>
                <td style="width: 21rem;">Probability of 1 failure in 1 event:</td>
                <td><input type="number" id="ifailures" value="${ramsOut.int2!""}" step="0.01"></td>
              </tr>
              <tr>
                <td style="width: 21rem;">Number of independent events n:</td>
                <td><input type="number" id="itime" value="${ramsOut.int1!""}" step="1"></td>
              </tr>
              <tr>
                <td style="width: 21rem;">Number of failures of interest r:</td>
                <td><input type="number" id="event" value="${ramsOut.int3!""}" step="1"></td>
              </tr>
              <tr><td><button style="display:none" id="calinde">Calculate</button></td></tr>
            </table>
        </div>
        <div class="right" id="output5">
          <table>
            <tr>
              <td>Result</td>
              <td></td>
            </tr>
            <tr>
              <td>Probability of ${ramsOut.int3!""} failures</td>
              <td>${ramsOut.out1!""} %</td>
            </tr>
            <tr>
              <td>Probability of ${ramsOut.int3!""} or more failures</td>
              <td>${ramsOut.out2!""} %</td>
            </tr>
          </table>
        </div>
      </div>
    </div>
    <#elseif ramsOut.calculatorType == "final" >
    <div class="expander_section">
      <div class="plus">
        <h3>Has Failure Rate Really Changed?</h3>
        
      </div>
      <div class="calculator" style="display: flex;
    align-items: center;
    justify-content: space-around;">
        <div class="left">
            <table>
              <tr>
                <td style="width: 24rem;">Old number of failures per time period:</td>
                <td><input type="number" id="RateOldPeriod" value="${ramsOut.int1!""}" step="0.01"></td>
              </tr>
              <tr>
                <td style="background:white;width: 24rem;">New number of failures per time period:</td>
                <td><input type="number" id="RateNewfailures" value="${ramsOut.int2!""}" step="1"></td>
              </tr>
              <tr><td><button style="display:none" id="calFinal">Calculate</button></td></tr>
            </table>
            
        </div>
        <div class="right" id="output6">
          <table>
            <tr>
              <td>Result</td>
              <td></td>
              
            </tr>
            <tr>
              <td>Confidence that failure rate has changed</td>
              <td>${ramsOut.out1!""} %</td>
            </tr>
          </table>
        </div>
      </div>
    </div>
    
  </div>
  </#if>
  
  </#list>
  <button style="margin:1rem;margin-bottom:2rem;"><a style="color:white" href="ReportRams.pdf?rams=${ramsOutputTitle.ramsNo}">Print Document</a></button>
