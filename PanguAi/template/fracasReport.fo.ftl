
<#escape x as x?xml>
<fo:block>It is working</fo:block>
<#if ramsOutputTitle?has_content >
    <fo:table table-layout="fixed" border="1pt solid" padding="5pt" border-width=".1mm" >
        <fo:table-body>
            <fo:table-row >
                        <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">Complaint Number:</fo:block></fo:table-cell>
                        <fo:table-cell border="1pt solid black" padding="3.4pt"><fo:block number-columns-spanned="3" >${ramsOutputTitle.complaintNumber!""}</fo:block></fo:table-cell>
                        <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block>Complaint Date:</fo:block></fo:table-cell>
                        <fo:table-cell border="1pt solid black" padding="3.4pt">
                            <fo:block>${ramsOutputTitle.complaintDate!""}</fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block>Customer Name:</fo:block></fo:table-cell>
                        <fo:table-cell border="1pt solid black" padding="3.4pt">
                      
                            <fo:block>${ramsOutputTitle.customerName!""}</fo:block>
                       </fo:table-cell>
            </fo:table-row>
             <fo:table-row >
                        <fo:table-cell border="1pt solid black" padding="3.4pt" font-weight="bold"><fo:block>System:</fo:block></fo:table-cell>
                        <fo:table-cell border="1pt solid black" padding="3.4pt">
                            <fo:block >${ramsOutputTitle.system!""}</fo:block>
                       </fo:table-cell>
                        <fo:table-cell border="1pt solid black" padding="3.4pt" font-weight="bold"><fo:block>Sub-system:</fo:block></fo:table-cell>
                        <fo:table-cell border="1pt solid black" padding="3.4pt">
                            <fo:block >${ramsOutputTitle.subSystem!""}</fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="1pt solid black" padding="3.4pt" font-weight="bold"><fo:block>Sub-sub-system:</fo:block></fo:table-cell>
                        <fo:table-cell border="1pt solid black" padding="3.4pt">
                                <fo:block >${ramsOutputTitle.subSubSystem!""}</fo:block>
                        </fo:table-cell>
            </fo:table-row>
            <fo:table-row >
                        <fo:table-cell border="1pt solid black" padding="3.4pt" font-weight="bold"><fo:block>Warranty Date (Start):</fo:block></fo:table-cell>
                        <fo:table-cell border="1pt solid black" padding="3.4pt">
                            <fo:block >${ramsOutputTitle.startWarranty!""}</fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="1pt solid black" padding="3.4pt" font-weight="bold"><fo:block>Warranty Date (End):</fo:block></fo:table-cell>
                        <fo:table-cell border="1pt solid black" padding="3.4pt">
                            <fo:block >${ramsOutputTitle.endWarranty!""}</fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="1pt solid black" padding="3.4pt" font-weight="bold"><fo:block>Customer Zone:</fo:block></fo:table-cell>
                        <fo:table-cell border="1pt solid black" padding="3.4pt" number-columns-spanned="3">
                            <fo:block >${ramsOutputTitle.customerZone!""}</fo:block>
                        </fo:table-cell>
            </fo:table-row>
            <fo:table-row >
                        
                        <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block>Product is Prototype</fo:block></fo:table-cell>
                        <fo:table-cell border="1pt solid black" padding="3.4pt" >
                                <fo:block  padding="3.4pt">${ramsOutputTitle.prototype!""}</fo:block>
                        </fo:table-cell>
                        <fo:table-cell font-weight="bold" border="1pt solid black" padding="3.4pt"><fo:block>Part No:</fo:block></fo:table-cell>
                        <fo:table-cell border="1pt solid black" padding="3.4pt">
                            <fo:block >${ramsOutputTitle.partNumber!""}</fo:block>
                        </fo:table-cell>
                        <fo:table-cell font-weight="bold" border="1pt solid black" padding="3.4pt"><fo:block>Fracas Report No:</fo:block></fo:table-cell>
                        <fo:table-cell border="1pt solid black" padding="3.4pt" >
                                <fo:block >${ramsOutputTitle.reportNumber!""}</fo:block>
                        </fo:table-cell>
            </fo:table-row>
            <fo:table-row >
                        <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block>Drawing/Revision No</fo:block></fo:table-cell>
                        <fo:table-cell border="1pt solid black" padding="3.4pt" >
                                <fo:block  padding="3.4pt">${ramsOutputTitle.revision!""}</fo:block>
                            </fo:table-cell>
                        <fo:table-cell font-weight="bold" border="1pt solid black" padding="3.4pt"><fo:block>Part Description:</fo:block></fo:table-cell>
                        <fo:table-cell border="1pt solid black" padding="3.4pt">
                            <fo:block >${ramsOutputTitle.partdescription!""}</fo:block>
                       </fo:table-cell>
                        <fo:table-cell font-weight="bold" border="1pt solid black" padding="3.4pt"><fo:block>Create Date:</fo:block></fo:table-cell>
                        <fo:table-cell border="1pt solid black" padding="3.4pt" >
                                <fo:block >${ramsOutputTitle.createDate!""}</fo:block>
                             </fo:table-cell>
                        
            </fo:table-row>
        </fo:table-body>
    </fo:table>
    <fo:table table-layout="fixed" border="1pt solid" padding="5pt" border-width=".1mm" >
        <fo:table-body>
            <fo:table-row >
                        <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block padding="3.4pt">Failure Type:</fo:block></fo:table-cell>
                        <fo:table-cell border="1pt solid black" padding="3.4pt" number-columns-spanned="3" ><fo:block >${ramsOutputTitle.failureType!""}</fo:block></fo:table-cell>
                        <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block>Failure Nature:</fo:block></fo:table-cell>
                        <fo:table-cell border="1pt solid black" padding="3.4pt" number-columns-spanned="3" >
                            <fo:block>${ramsOutputTitle.failureNature!""}</fo:block>
                        </fo:table-cell>
            </fo:table-row>
             <fo:table-row >
                        <fo:table-cell border="1pt solid black" padding="3.4pt" font-weight="bold"><fo:block>Targeted Closure Date:</fo:block></fo:table-cell>
                        <fo:table-cell border="1pt solid black" padding="3.4pt">
                            <fo:block >${ramsOutputTitle.closureDate!""}</fo:block>
                       </fo:table-cell>
                        <fo:table-cell border="1pt solid black" padding="3.4pt" font-weight="bold"><fo:block>Complaint Status:</fo:block></fo:table-cell>
                        <fo:table-cell border="1pt solid black" padding="3.4pt">
                            <fo:block >${ramsOutputTitle.status!""}</fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="1pt solid black" padding="3.4pt" font-weight="bold"><fo:block>Actual Closure Date:</fo:block></fo:table-cell>
                        <fo:table-cell border="1pt solid black" padding="3.4pt">
                                <fo:block >${ramsOutputTitle.actualDate!""}</fo:block>
                        </fo:table-cell>
            </fo:table-row>
            <fo:table-row >
                        <fo:table-cell border="1pt solid black" padding="3.4pt" font-weight="bold"><fo:block>Corrective Action to Be Done:</fo:block></fo:table-cell>
                        <fo:table-cell border="1pt solid black" padding="3.4pt" number-columns-spanned="3">
                            <fo:block >${ramsOutputTitle.action!""}</fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="1pt solid black" padding="3.4pt" font-weight="bold"><fo:block>Problem Reported (Generation Point)):</fo:block></fo:table-cell>
                        <fo:table-cell border="1pt solid black" padding="3.4pt" number-columns-spanned="3">
                            <fo:block >${ramsOutputTitle.problemReported!""}</fo:block>
                        </fo:table-cell>
                        
            </fo:table-row>
            <fo:table-row >
                        
                        <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block>Defect Observed (Escape Point)</fo:block></fo:table-cell>
                        <fo:table-cell border="1pt solid black" padding="3.4pt" number-columns-spanned="3">
                                <fo:block  padding="3.4pt">${ramsOutputTitle.defectObserved!""}</fo:block>
                        </fo:table-cell>
                        <fo:table-cell font-weight="bold" border="1pt solid black" padding="3.4pt"><fo:block>Corrective Action</fo:block></fo:table-cell>
                        <fo:table-cell border="1pt solid black" padding="3.4pt"number-columns-spanned="3">
                            <fo:block >${ramsOutputTitle.correctiveAction!""}</fo:block>
                       </fo:table-cell>
                        
            </fo:table-row>
            <fo:table-row >
                        <fo:table-cell border="1pt solid black" font-weight="bold" padding="3.4pt"><fo:block>R&D Action:</fo:block></fo:table-cell>
                        <fo:table-cell border="1pt solid black" padding="3.4pt" number-columns-spanned="3">
                                <fo:block  padding="3.4pt">${ramsOutputTitle.RDAction!""}</fo:block>
                            </fo:table-cell>
                        <fo:table-cell font-weight="bold" border="1pt solid black" padding="3.4pt"><fo:block>Cost Implication:</fo:block></fo:table-cell>
                        <fo:table-cell border="1pt solid black" padding="3.4pt" number-columns-spanned="3">
                            <fo:block >${ramsOutputTitle.costImplication!""}</fo:block>
                       </fo:table-cell>
            </fo:table-row>
        </fo:table-body>
    </fo:table>
    <fo:table table-layout="fixed" border="1pt solid" padding="5pt" border-width=".1mm" >
        <fo:table-body>
            
             <fo:table-row >
                        <fo:table-cell border="1pt solid black" padding="3.4pt" font-weight="bold"><fo:block>Responsible Person 1:</fo:block></fo:table-cell>
                        <fo:table-cell border="1pt solid black" padding="3.4pt">
                            <fo:block >${ramsOutputTitle.response1!""}</fo:block>
                       </fo:table-cell>
                        <fo:table-cell border="1pt solid black" padding="3.4pt" font-weight="bold"><fo:block>Responsible Person 2:</fo:block></fo:table-cell>
                        <fo:table-cell border="1pt solid black" padding="3.4pt">
                            <fo:block >${ramsOutputTitle.response2!""}</fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="1pt solid black" padding="3.4pt" font-weight="bold"><fo:block>Approved By:</fo:block></fo:table-cell>
                        <fo:table-cell border="1pt solid black" padding="3.4pt">
                                <fo:block >${ramsOutputTitle.approver!""}</fo:block>
                        </fo:table-cell>
            </fo:table-row>
           
        </fo:table-body>
    </fo:table>
    
</#if>
</#escape>