
<#escape x as x?xml>
            <fo:block font-size="14pt" font-weight="bold" text-align="center" background-color="#0c2d7c" color="white" padding="8pt">
                FRACAS REPORT
            </fo:block>
            <#if fracasReport?has_content >
            <fo:table table-layout="fixed" width="100%" border-collapse="separate" border-spacing="2pt" space-before="10pt">
                <fo:table-column column-width="15%"/>
                <fo:table-column column-width="18.33%"/>
                <fo:table-column column-width="15%"/>
                <fo:table-column column-width="18.33%"/>
                <fo:table-column column-width="15%"/>
                <fo:table-column column-width="18.33%"/>
                
                <fo:table-body>
                    <fo:table-row>
                        <fo:table-cell padding="4pt" background-color="#0c2d7c" color="white"><fo:block font-weight="bold">Complaint Number</fo:block></fo:table-cell>
                        <fo:table-cell padding="4pt" border="1px solid #ccc"><fo:block>${(fracasReport.complaintNumber)!"-"}</fo:block></fo:table-cell>
                        <fo:table-cell padding="4pt" background-color="#0c2d7c" color="white"><fo:block font-weight="bold">Complaint Date</fo:block></fo:table-cell>
                        <fo:table-cell padding="4pt" border="1px solid #ccc"><fo:block>${(fracasReport.complaintDate)!"-"}</fo:block></fo:table-cell>
                        <fo:table-cell padding="4pt" background-color="#0c2d7c" color="white"><fo:block font-weight="bold">Customer Name</fo:block></fo:table-cell>
                        <fo:table-cell padding="4pt" border="1px solid #ccc"><fo:block>${(fracasReport.customerName)!"-"}</fo:block></fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell padding="4pt" background-color="#0c2d7c" color="white"><fo:block font-weight="bold">System</fo:block></fo:table-cell>
                        <fo:table-cell padding="4pt" border="1px solid #ccc"><fo:block>${(fracasReport.system)!"-"}</fo:block></fo:table-cell>
                        <fo:table-cell padding="4pt" background-color="#0c2d7c" color="white"><fo:block font-weight="bold">Sub-system</fo:block></fo:table-cell>
                        <fo:table-cell padding="4pt" border="1px solid #ccc"><fo:block>${(fracasReport.subSystem)!"-"}</fo:block></fo:table-cell>
                        <fo:table-cell padding="4pt" background-color="#0c2d7c" color="white"><fo:block font-weight="bold">Sub-sub-system</fo:block></fo:table-cell>
                        <fo:table-cell padding="4pt" border="1px solid #ccc"><fo:block>${(fracasReport.subSubSystem)!"-"}</fo:block></fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell padding="4pt" background-color="#0c2d7c" color="white"><fo:block font-weight="bold">Warranty (Start)</fo:block></fo:table-cell>
                        <fo:table-cell padding="4pt" border="1px solid #ccc"><fo:block>${(fracasReport.startWarranty)!"-"}</fo:block></fo:table-cell>
                        <fo:table-cell padding="4pt" background-color="#0c2d7c" color="white"><fo:block font-weight="bold">Warranty (End)</fo:block></fo:table-cell>
                        <fo:table-cell padding="4pt" border="1px solid #ccc"><fo:block>${(fracasReport.endWarranty)!"-"}</fo:block></fo:table-cell>
                        <fo:table-cell padding="4pt" background-color="#0c2d7c" color="white"><fo:block font-weight="bold">Customer Zone</fo:block></fo:table-cell>
                        <fo:table-cell padding="4pt" border="1px solid #ccc"><fo:block>${(fracasReport.customerZone)!"-"}</fo:block></fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell padding="4pt" background-color="#0c2d7c" color="white"><fo:block font-weight="bold">Prototype</fo:block></fo:table-cell>
                        <fo:table-cell padding="4pt" border="1px solid #ccc"><fo:block>${(fracasReport.prototype)!"-"}</fo:block></fo:table-cell>
                        <fo:table-cell padding="4pt" background-color="#0c2d7c" color="white"><fo:block font-weight="bold">Part No</fo:block></fo:table-cell>
                        <fo:table-cell padding="4pt" border="1px solid #ccc"><fo:block>${(fracasReport.partNumber)!"-"}</fo:block></fo:table-cell>
                        <fo:table-cell padding="4pt" background-color="#0c2d7c" color="white"><fo:block font-weight="bold">Report No</fo:block></fo:table-cell>
                        <fo:table-cell padding="4pt" border="1px solid #ccc"><fo:block>${(fracasReport.reportNumber)!"-"}</fo:block></fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell padding="4pt" background-color="#0c2d7c" color="white"><fo:block font-weight="bold">Drawing/Rev No</fo:block></fo:table-cell>
                        <fo:table-cell padding="4pt" border="1px solid #ccc"><fo:block>${(fracasReport.revision)!"-"}</fo:block></fo:table-cell>
                        <fo:table-cell padding="4pt" background-color="#0c2d7c" color="white"><fo:block font-weight="bold">Part Description</fo:block></fo:table-cell>
                        <fo:table-cell padding="4pt" border="1px solid #ccc"><fo:block>${(fracasReport.partdescription)!"-"}</fo:block></fo:table-cell>
                        <fo:table-cell padding="4pt" background-color="#0c2d7c" color="white"><fo:block font-weight="bold">Create Date</fo:block></fo:table-cell>
                        <fo:table-cell padding="4pt" border="1px solid #ccc"><fo:block>${(fracasReport.createDate)!"-"}</fo:block></fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>

            <fo:table table-layout="fixed" width="100%" border-collapse="separate" border-spacing="2pt" space-before="10pt">
                <fo:table-column column-width="25%"/>
                <fo:table-column column-width="75%"/>
                <fo:table-body>
                    <fo:table-row>
                        <fo:table-cell padding="4pt" background-color="#0c2d7c" color="white" text-align="center" vertical-align="middle"><fo:block font-weight="bold">FAILURE_TYPE</fo:block></fo:table-cell>
                        <fo:table-cell padding="4pt" border="1px solid #ccc"><fo:block>${(fracasAnalysis.failureType)!"-"}</fo:block></fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell padding="4pt" background-color="#0c2d7c" color="white" text-align="center" vertical-align="middle"><fo:block font-weight="bold">FAILURE_NATURE</fo:block></fo:table-cell>
                        <fo:table-cell padding="4pt" border="1px solid #ccc"><fo:block>${(fracasAnalysis.failureNature)!"-"}</fo:block></fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell padding="4pt" background-color="#0c2d7c" color="white" text-align="center" vertical-align="middle"><fo:block font-weight="bold">TARGETTED_CLOSURE_DATE</fo:block></fo:table-cell>
                        <fo:table-cell padding="4pt" border="1px solid #ccc"><fo:block>${(fracasAnalysis.closureDate)!"-"}</fo:block></fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell padding="4pt" background-color="#0c2d7c" color="white" text-align="center" vertical-align="middle"><fo:block font-weight="bold">COMPLAINT_STATUS</fo:block></fo:table-cell>
                        <fo:table-cell padding="4pt" border="1px solid #ccc"><fo:block>${(fracasAnalysis.status)!"-"}</fo:block></fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell padding="4pt" background-color="#0c2d7c" color="white" text-align="center" vertical-align="middle"><fo:block font-weight="bold">ROOT_CAUSE</fo:block></fo:table-cell>
                        <fo:table-cell padding="4pt" border="1px solid #ccc"><fo:block>${(fracasAnalysis.rootCauses)!"-"}</fo:block></fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell padding="4pt" background-color="#0c2d7c" color="white" text-align="center" vertical-align="middle"><fo:block font-weight="bold">CORRECTIVE_ACTION TO BE DONE</fo:block></fo:table-cell>
                        <fo:table-cell padding="4pt" border="1px solid #ccc"><fo:block>${(fracasAnalysis.action)!"-"}</fo:block></fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell padding="4pt" background-color="#0c2d7c" color="white" text-align="center" vertical-align="middle"><fo:block font-weight="bold">PROBLEM_REPORTED</fo:block></fo:table-cell>
                        <fo:table-cell padding="4pt" border="1px solid #ccc"><fo:block>${(fracasAnalysis.problemReported)!"-"}</fo:block></fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell padding="4pt" background-color="#0c2d7c" color="white" text-align="center" vertical-align="middle"><fo:block font-weight="bold">DEFECT_OBSERVED</fo:block></fo:table-cell>
                        <fo:table-cell padding="4pt" border="1px solid #ccc"><fo:block>${(fracasAnalysis.defectObserved)!"-"}</fo:block></fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell padding="4pt" background-color="#0c2d7c" color="white" text-align="center" vertical-align="middle"><fo:block font-weight="bold">CORRECTIVE_ACTION</fo:block></fo:table-cell>
                        <fo:table-cell padding="4pt" border="1px solid #ccc"><fo:block>${(fracasAnalysis.correctiveAction)!"-"}</fo:block></fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell padding="4pt" background-color="#0c2d7c" color="white" text-align="center" vertical-align="middle"><fo:block font-weight="bold">ACTUAL_CLOSURE_DATE</fo:block></fo:table-cell>
                        <fo:table-cell padding="4pt" border="1px solid #ccc"><fo:block>${(fracasAnalysis.actualDate)!"-"}</fo:block></fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell padding="4pt" background-color="#0c2d7c" color="white" text-align="center" vertical-align="middle"><fo:block font-weight="bold">R&amp;D Action</fo:block></fo:table-cell>
                        <fo:table-cell padding="4pt" border="1px solid #ccc"><fo:block>${(fracasAnalysis.RDAction)!"-"}</fo:block></fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell padding="4pt" background-color="#0c2d7c" color="white" text-align="center" vertical-align="middle"><fo:block font-weight="bold">Cost Implication</fo:block></fo:table-cell>
                        <fo:table-cell padding="4pt" border="1px solid #ccc"><fo:block>${(fracasAnalysis.costImplication)!"-"}</fo:block></fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
            
            <fo:table table-layout="fixed" width="100%" border-collapse="separate" border-spacing="2pt" space-before="10pt">
                <fo:table-column column-width="20%"/>
                <fo:table-column column-width="30%"/>
                <fo:table-column column-width="20%"/>
                <fo:table-column column-width="30%"/>
                 <fo:table-body>
                    <fo:table-row>
                        <fo:table-cell padding="4pt" background-color="#0c2d7c" color="white"><fo:block font-weight="bold">RESPONSIBLE PERSON 1</fo:block></fo:table-cell>
                        <fo:table-cell padding="4pt" border="1px solid #ccc"><fo:block>${(fracasReport.response1)!"-"}</fo:block></fo:table-cell>
                        <fo:table-cell padding="4pt" background-color="#0c2d7c" color="white"><fo:block font-weight="bold">RESPONSIBLE PERSON 2</fo:block></fo:table-cell>
                        <fo:table-cell padding="4pt" border="1px solid #ccc"><fo:block>${(fracasReport.response2)!"-"}</fo:block></fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell number-columns-spanned="3" padding="4pt" text-align="right" vertical-align="middle" background-color="#0c2d7c" color="white"><fo:block font-weight="bold">APPROVED BY</fo:block></fo:table-cell>
                        <fo:table-cell padding="4pt" border="1px solid #ccc"><fo:block>${(fracasReport.approver)!"-"}</fo:block></fo:table-cell>
                    </fo:table-row>
                 </fo:table-body>
               </fo:table>
            </#if>
</#escape>