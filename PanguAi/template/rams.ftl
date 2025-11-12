<#--
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

-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstat/1.9.5/jstat.min.js"></script>


<#if ramsOutputTitle?has_content>
  <div class="header_ram">
    <table>
      <tr>
        <td>RAMS number</td>
        <td><input type="text" value="${ramsOutputTitle.ramsNo!""}" style="background: white;
    color: black;" id="rams" disabled></td>
        <td>Revision</td>
        <td><input type="number" value="${ramsOutputTitle.revision!""}"  id="revision"></td>
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
    color: black;" value="${ramsOutputTitle.rams!""}"  id="response"></td>
        <td>Date:</td>
        <td><input type="date" style="background: white;
    color: black;" value="${date}"   id="date"></td>
      </tr>
      <tr>
        <td>Team members:</td>
        <td colspan="3"><input style="background: white;
    color: black;" type="text" value="${ramsOutputTitle.team!""}"  id="member"></td>
        <td>Approved by:</td>
        <#if date?has_content>
        <td><input type="text" style="background: white;
    color: black;" value="${ramsOutputTitle.approver!""}"  id="approver"></td>
        <#else>
          <td><input type="text" style="background: white;
    color: black;"   id="approver"></td>          
        </#if>
      </tr>
    </table>
   
  </div>
  <#else>
  <div class="header_ram">
      <table>
        <tr>
          <td>RAMS number</td>
          <td><input type="text"  id="rams"></td>
          <td>Revision</td>
          <td><input type="number"  id="revision"></td>
          <td>Product code:</td>
          <td colspan="3"><input type="text"  id="product"></td>
        </tr>
        <tr>
          <td>System: </td>
          <td><input type="text"  id="system"></td>
          <td>Sub-System: </td>
          <td><input type="text"  id="SubSystem"></td>
          <td>Sub-sub-System: </td>
          <td><input type="text"  id="subsubsystem"></td>
        </tr>
        <tr>
          <td>RAMS responsibility:</td>
          <td colspan="3"><input type="text"  id="response"></td>
          <td>Date:</td>
          <td><input type="date"  id="date"></td>
        </tr>
        <tr>
          <td>Team members:</td>
          <td colspan="3"><input type="text"  id="member"></td>
          <td>Approved by:</td>
          <td><input type="text"  id="approver"></td>
        </tr>
      </table>
    
  </div>
</#if>
<#if ramsOutputDetails?has_content>
  <#list ramsOutputDetails as ramsOut>
  <div class="main">
    <#if ramsOut.calculatorType == "empirical">
      <div class="expander_section">
          <div class="plus">
            <h3>Empirical Failure Rate Calculator</h3>
            <span class="symbol">+</span>
          </div>
          <div class="calculator">
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
                  <tr colspan="2"><td><button  id="calrms">Calculate</button></td></tr>
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
            <div class="middle">
              <p>Use this calculation to find out the failure rate and MTBF from your observed failure history. Notice how the confidence bounds move in towards the best estimate as you collect more data.  This calculation assumes you are counting failures over 
              a given time period, as is the usual case, rather than measuring the time period for a
               given number of failures.</p>
            </div>
          </div>
      </div>
    <#elseif ramsOut.calculatorType == "availability" >
      <div class="expander_section">
        <div class="plus">
          <h3>Availability</h3>
          <span class="symbol">+</span>
        </div>
        <div class="calculator">
          <div class="left">
              <table>
                <tr>
                  <td style="width: 17rem;" >Failure rate:</td>
                  <td > <input type="number" id="failure" value="${ramsOut.int2!""}" step="0.001" disabled></td>
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
                <tr><td><button id="calavail">Calculate</button></td></tr>
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
                <td>${ramsOut.out1} %</td>
              </tr>
              <tr>
                <td>Availability incl. planned mtce</td>
                <td>${ramsOut.out2} %</td> 
              </tr>
            </table>
          </div>
        </div>
      </div>
    <#elseif ramsOut.calculatorType == "reliability" >
      <div class="expander_section">
        <div class="plus">
          <h3>Reliability</h3>
          <span class="symbol">+</span>
        </div>
        <div class="calculator">
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
                <tr><td><button id="calreliab">Calculate</button></td></tr>
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
        <span class="symbol">+</span>
      </div>
      <div class="calculator">
        <div class="left">
            <table>
              <tr>
                <td style="width: 21rem;">Failure rate:</td>
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
              <tr><td><button id="calpro">Calculate</button></td></tr>
            </table>
        </div>
        <div class="right" id="output4">
          <table>
            <tr>
              <td>Result</td>
              <td></td>
            </tr>
            <tr>
              <td>Probability of ${ramsOut.int1} failures</td>
              <td>${ramsOut.out1!""} %</td>
            </tr>
            <tr>
              <td>Probability of ${ramsOut.int1} or more failures</td>
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
        <span class="symbol">+</span>
      </div>
      <div class="calculator">
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
              <tr><td><button id="calinde">Calculate</button></td></tr>
            </table>
        </div>
        <div class="right" id="output5">
          <table>
            <tr>
              <td>Result</td>
              <td></td>
            </tr>
            <tr>
              <td>Probability of ${ramsOut.int3} failures</td>
              <td>${ramsOut.out1!""} %</td>
            </tr>
            <tr>
              <td>Probability of ${ramsOut.int3} or more failures</td>
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
        <span class="symbol">+</span>
      </div>
      <div class="calculator">
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
              
            </table>
            <button id="calFinal">Calculate</button>
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
    <button id="save">Save the File</button>
  </div>
  </#if>
  </#list>
<#else>
    <div class="main">
      <div class="expander_section">
          <div class="plus">
            <div>
              <h3>Empirical Failure Rate Calculator</h3>
              <h4 style="color:white;margin:1rem;margin-left:4rem;">Calculate a failure rate and confidence limits based on your failure history</h4>
            </div>
            <span class="symbol">+</span>
          </div>
          <div class="calculator">
            <div class="left">
                <table>
                  <tr>
                    <td style="width: 23rem;">Time period for observations (years):</td>
                    <td>
                    <div class="tooltip-wrapper">
                          <input type="number" id="timePeriod" value="1" step="0.01">
                          <div class="tooltip-text">
                              Enter the time period of your failure data
                          </div>
                      </div>
                    </td>
                    <td>years</td>
                  </tr>
                  <tr>
                    <td style="width: 23rem;">Number of failures observed:</td>
                    <td>
                      <div class="tooltip-wrapper">
                          <input type="number" id="failures" value="5" step="1">
                          <div class="tooltip-text">
                            Enter the number of failures you observed in the time period
                          </div>
                      </div>
                    </td>
                  </tr>
                  <tr colspan="2"><td><button id="calrms">Calculate</button></td></tr>
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
                  <td></td>
                  <td></td>
                </tr>
                <tr>
                  <td>90% confidence interval - upper bound</td>
                  <td></td>
                  <td></td>
                </tr>
                <tr>
                  <td>90% confidence interval - lower bound</td>
                  <td></td>
                  <td></td>
                </tr>
              </table>
            </div>
             <div class="middle">
              <p>Use this calculation to find out the failure rate and MTBF from your observed failure history. Notice how the confidence bounds move in towards the best estimate as you collect more data.  This calculation assumes you are counting failures over 
              a given time period, as is the usual case, rather than measuring the time period for a
               given number of failures.</p>
            </div>
          </div>
          
      </div>
      <div class="expander_section">
        <div class="plus">
        <div>
          <h3>Availability</h3>
          <h4 style="color:white;margin:1rem;margin-left:4rem;">Calculate Availability or 'Uptime' for your equipment</h4>
            </div>
          <span class="symbol">+</span>
        </div>
        <div class="calculator">
          <div class="left">
              <table>
                <tr>
                  <td style="width: 17rem;">Failure rate:</td>
                  <td> 
                    <div class="tooltip-wrapper">
                          <input type="number" id="failure"  step="0.001" disabled>
                          <div class="tooltip-text">
                            Enter the component or system failure rate here
                          </div>
                      </div>
                  </td>
                  <td style="width: 9rem;text-align: left;">per year</td>
                </tr>
                <tr>
                  <td style="width: 17rem;">Repair time (MTTR):</td>
                  <td> 
                    <div class="tooltip-wrapper">
                          <input type="number" id="repair" value="48" step="1">
                          <div class="tooltip-text">
                            Enter the mean total time taken to get the system or component back in service each time it fails
                          </div>
                      </div>
                  </td>
                  <td style="width: 9rem;text-align: left;">hours</td>
                </tr>
                <tr>
                  <td style="width: 17rem;">Planned maintenance time:</td>
                  <td>
                    <div class="tooltip-wrapper">
                          <input type="number" id="maintenance" value="72" step="1">
                          <div class="tooltip-text">
                            Enter any down time for planned maintenance
                          </div>
                      </div>
                  </td>
                  <td>hours per year</td>
                </tr>
                <tr><td><button id="calavail">Calculate</button></td></tr>
              </table>
          </div>
          <div class="right" id="output1">
            <table>
              
              <tr>
                <td>Result</td>
                <td></td>
              </tr>
              <tr>
                <td >Availability excl. planned mtce</td>
                <td></td>
              </tr>
              <tr>
                <td>Availability incl. planned mtce</td>
                <td></td> 
              </tr>
            </table>
          </div>
          <div class="middle">
          <p>Use this calculation to find out the Availability (also known as 'Uptime') for your plant or equipment, 
          based on failure rate and MTTR (Mean Time to Repair).
            Availability can be calculated excluding or including downtime for planned maintenance.
          </p></div>
        </div>
      </div>
      <div class="expander_section">
        <div class="plus">
          <div>
          <h3>Reliability</h3>
          <h4 style="color:white;margin:1rem;margin-left:4rem;">Calculate Reliability i.e. probability of no failures in a given time period</h4>
            </div>
          <span class="symbol">+</span>
        </div>
        <div class="calculator">
          <div class="left">
              <table>
                <tr>
                  <td style="width: 17rem;">Failure rate:</td>
                  <td>
                    <div class="tooltip-wrapper">
                          <input type="number" id="failuresrate"  disabled>
                          <div class="tooltip-text">
                            Enter the component or system failure rate here
                          </div>
                      </div>
                  </td>
                  <td style="width: 9rem;text-align: left;">per year</td>
                </tr>
                <tr>
                  <td style="width: 17rem;">Time period:</td>
                  <td>
                    <div class="tooltip-wrapper">
                          <input type="number" id="time" value="5" step="1">
                          <div class="tooltip-text">
                            Enter the time period that the component or system is required to be in operation.
                          </div>
                      </div>
                  </td>
                  <td style="width: 9rem;text-align: left;">years</td>
                </tr>
                <tr><td><button id="calreliab">Calculate</button></td></tr>
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
                <td></td>
              </tr>
              <tr>
                <td>Probability of one or nore failures</td>
                <td></td>
              </tr>
            </table>
          </div>
          <div class="middle">
          <p>Use this calculation to find out the Reliability (the probability of no failures) in a given time period.  This is used for low-likelihood high-consequence 
            events to determine if the likelihood is acceptable. 
            The calculation assumes constant failure rate.</p>
          </div>
        </div>
      </div>
      <div class="expander_section">
        <div class="plus">
        <div>
          <h3>Probability of r failures in a given time period</h3>
          <h4 style="color:white;margin:1rem;margin-left:4rem;">Calculate the probability of multiple failures over time</h4>
            </div>
          <span class="symbol">+</span>
        </div>
        <div class="calculator">
          <div class="left">
              <table>
                <tr>
                  <td style="width: 21rem;">Failure rate:</td>
                  <td>
                  <div class="tooltip-wrapper">
                          <input type="number" id="rfailures" disabled step="0.01">
                          <div class="tooltip-text">
                              Enter the component or system failure rate here
                          </div>
                      </div></td>
                </tr>
                <tr>
                  <td style="width: 21rem;">Time period:</td>
                  <td>
                  <div class="tooltip-wrapper">
                          <input type="number" id="rtimePeriod" value="5" step="1">
                          <div class="tooltip-text">
                              Enter the time period that the component or system is required to be in operation. 
                            </div>
                      </div>
                      </td>
                </tr>
                <tr>
                  <td style="width: 21rem;">Number of failures of interest r:</td>
                  <td>
                  <div class="tooltip-wrapper">
                          <input type="number" id="rinterest" value="2" step="1">
                          <div class="tooltip-text">
                              Enter the number of failures of interest, known as 'r'
                          </div>
                      </div></td>
                </tr>
                <tr><td><button id="calpro">Calculate</button></td></tr>
              </table>
          </div>
          <div class="right" id="output4">
            <table>
              <tr>
                <td>Result</td>
                <td></td>
              </tr>
              <tr>
                <td>Probability of r failures</td>
                <td></td>
              </tr>
              <tr>
                <td>Probability of r or more failures</td>
                <td></td>
              </tr>
            </table>
          </div>
          <div class="middle">
          <p>Use this calculation to determine the probability of a particular number of 
          failures occuring over a given time period.  Usually, 'r or more failures' is of most relevance.  
          The calculation assumes constant failure rate.</p>
          </div>
        </div>
      </div>
      <div class="expander_section">
        <div class="plus">
        <div>
          <h3>Probability of r failures in n independent events</h3>
          <h4 style="color:white;margin:1rem;margin-left:4rem;">Calculate the probability of multiple failures in a number of events</h4>
            </div>
          <span class="symbol">+</span>
        </div>
        <div class="calculator">
          <div class="left">
              <table>
                <tr>
                  <td style="width: 21rem;">Probability of 1 failure in 1 event:</td>
                  <td>
                  <div class="tooltip-wrapper">
                          <input type="number" id="ifailures" value="0.01" step="0.01">
                          <div class="tooltip-text">
                              Enter the probability of one failure in one event; this would typically be the probability of single component failure. Must be between 0 and 1.
                          </div>
                      </div></td>
                </tr>
                <tr>
                  <td style="width: 21rem;">Number of independent events n:</td>
                  <td>
                  <div class="tooltip-wrapper">
                          <input type="number" id="itime" value="50" step="1">
                          <div class="tooltip-text">
                              Enter the number of independent events; this would typically be the number of identical components.
                          </div>
                      </div></td>
                </tr>
                <tr>
                  <td style="width: 21rem;">Number of failures of interest r:</td>
                  <td>
                  <div class="tooltip-wrapper">
                          <input type="number" id="event" value="3" step="1">
                          <div class="tooltip-text">
                              Enter the number of failures of interest (or concern).
                          </div>
                      </div>
                 </td>
                </tr>
                <tr><td><button id="calinde">Calculate</button></td></tr>
              </table>
          </div>
          <div class="right" id="output5">
            <table>
              <tr>
                <td>Result</td>
                <td></td>
              </tr>
              <tr>
                <td>Probability of r failures</td>
                <td></td>
              </tr>
              <tr>
                <td>Probability of r or more failures</td>
                <td></td>
              </tr>
            </table>
          </div>
          <div class="middle">
          <p>Use this calculation to determine the probability of a particular number of failures r out of a total number of possible failures ('events'). 
           For example, the number of events could be a number of identical components each with a given failure probability.  
           Usually, 'r or more failures' is of most relevance.  
          Events are assumed to be independent: in practice common mode failure should also be addressed.</p>
          </div>
        </div>
      </div>
      <div class="expander_section">
        <div class="plus">
        <div>
          <h3>Has Failure Rate Really Changed?</h3>
          <h4 style="color:white;margin:1rem;margin-left:4rem;">Determine the confidence in whether underlying failure rate has really changed</h4>
            </div>
          <span class="symbol">+</span>
        </div>
        <div class="calculator">
          <div class="left">
              <table>
                <tr>
                  <td style="width: 24rem;">Old number of failures per time period:</td>
                  <td><input type="number" id="RateOldPeriod" value="6" step="0.01"></td>
                </tr>
                <tr>
                  <td style="background:white;width: 24rem;">New number of failures per time period:</td>
                  <td> 
                        <div class="tooltip-wrapper">
                          <input type="number"  id="RateNewfailures" value="4" step="1">
                          <div class="tooltip-text">
                              Enter the number of events that occurred in the following time period
                          </div>
                      </div>
                  </td>
                </tr>
                
              </table>
              <button id="calFinal">Calculate</button>
          </div>
          <div class="right" id="output6">
            <table>
              <tr>
                <td>Result</td>
                <td></td>
                
              </tr>
              <tr>
                <td >Confidence that failure rate has changed</td>
                <td></td>
              </tr>
            </table>
          </div>
          <div class="middle">
          <p>When we see a reduction in failures (or safety incidents) from one period to the next we tend to 
          think that performance has improved.  Conversely, when we see an increase in failures we think performance 
          has worsened.  In practice, where the number of events is relatively small, the effects of random chance can easily mislead us.  
          This calculation shows the confidence level that a change in number of failures in a given time period truly represents a change in underlying failure rate.  
          For Engineering purposes, to really believe that the failure rate has changed we need to see a result of at least 90%.  
          Notice how the confidence increases when larger numbers are used.</p>
          </div>
        </div>
      </div>
      <button id="save" style="color:white;margin:1rem;margin-bottom:2rem;">Save the File</button>
    </div>
</#if>






