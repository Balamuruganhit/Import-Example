<#escape x as x?xml>
 <fo:block font-size="20pt" height="50pt" font-weight="bold" text-align="center" space-after="10pt" background-color="#0c2d7c" color="white" padding="5pt">
      CHANGE CONTROL MATRIX
      </fo:block>

      <fo:block space-after="5pt" font-size="14pt">
        <fo:inline font-weight="bold" font-size="14pt">Doc No: </fo:inline>${ramsOutputTitle.docId!""}
      </fo:block>
      <fo:block space-after="5pt" font-size="14pt">
        <fo:inline font-weight="bold" font-size="14pt">Issue No: </fo:inline>${ramsOutputTitle.issueNumber!""}
      </fo:block>
      <fo:block space-after="5pt" font-size="14pt">
        <fo:inline font-weight="bold" font-size="14pt">Rev No: </fo:inline>${ramsOutputTitle.revision!""}
      </fo:block>
      <fo:block space-after="10pt" font-size="14pt">
        <fo:inline font-weight="bold" font-size="14pt">Date:</fo:inline> ${ramsOutputTitle.date!""}
      </fo:block>
<#if ramsOutputDetails?has_content>
 
  <fo:table space-after="10pt" table-layout="fixed" text-align="center" display-align="center" width="100%" border="solid 0.5pt black" font-size="14pt">
    
    
    <fo:table-header>
      <fo:table-row>
          <fo:table-cell border="1pt solid black"><fo:block font-weight="bold">SI No</fo:block></fo:table-cell>
          <fo:table-cell border="1pt solid black"><fo:block font-weight="bold">Change Initiated by / Origin of change</fo:block></fo:table-cell>
          <fo:table-cell border="1pt solid black"><fo:block font-weight="bold">Change impact to</fo:block></fo:table-cell>
          <fo:table-cell border="1pt solid black"><fo:block font-weight="bold">Method of initiation</fo:block></fo:table-cell>
          <fo:table-cell border="1pt solid black"><fo:block font-weight="bold">Reviewed by</fo:block></fo:table-cell>
          <fo:table-cell border="1pt solid black"><fo:block font-weight="bold">Approval Authority</fo:block></fo:table-cell>
          <fo:table-cell border="1pt solid black"><fo:block font-weight="bold">Mode of change Communication</fo:block></fo:table-cell>
          <fo:table-cell border="1pt solid black"><fo:block font-weight="bold">Actions to be considered</fo:block></fo:table-cell>
          <fo:table-cell border="1pt solid black"><fo:block font-weight="bold">Implementation &amp; effectiveness monitoring Responsibility</fo:block></fo:table-cell>
          <fo:table-cell border="1pt solid black"><fo:block font-weight="bold">Status Review frequency</fo:block></fo:table-cell>
      </fo:table-row>
    </fo:table-header>
        <fo:table-body>
       <#assign i = 0>
    <#list ramsOutputDetails as group>
    <#assign i = i + 1>
      <fo:table-row >
            <fo:table-cell border="1pt solid black"><fo:block>${i}</fo:block></fo:table-cell>
            <fo:table-cell border="1pt solid black"><fo:block>${group.changeInitiated!" "}</fo:block></fo:table-cell>
            <fo:table-cell border="1pt solid black"><fo:block>${group.changeImpact!" "}</fo:block></fo:table-cell>
            <fo:table-cell border="1pt solid black"><fo:block>${group.methodOfInitiation!" "}</fo:block></fo:table-cell>
            <fo:table-cell border="1pt solid black"><fo:block>${group.reviewed!" "}</fo:block></fo:table-cell>
           <fo:table-cell border="1pt solid black"><fo:block>${group.approvalAuthority!" "}</fo:block></fo:table-cell>
           <fo:table-cell border="1pt solid black" padding="5pt"><fo:block text-align="left" linefeed-treatment="preserve" white-space-collapse="false">${group.modeCommunication!" "}</fo:block></fo:table-cell>
           <fo:table-cell border="1pt solid black" padding="5pt"><fo:block  text-align="left" linefeed-treatment="preserve" white-space-collapse="false">${group.actions!" "}</fo:block></fo:table-cell>
           <fo:table-cell border="1pt solid black" padding="5pt"><fo:block text-align="left" linefeed-treatment="preserve" white-space-collapse="false">${group.implementation!" "}</fo:block></fo:table-cell>
           <fo:table-cell border="1pt solid black" padding="5pt"><fo:block text-align="left" linefeed-treatment="preserve" white-space-collapse="false">${group.status!" "}</fo:block></fo:table-cell>
      </fo:table-row>
    </#list>
    </fo:table-body>
    </fo:table>
    <fo:table table-layout="fixed" width="100%" font-size="15pt" margin-top="30pt">
      <fo:table-column column-width="30%"/>
      <fo:table-column column-width="30%"/>
      <fo:table-column column-width="30%"/>
      <fo:table-body>
        <fo:table-row>
          <fo:table-cell>
            <fo:block text-align="left">Auditee: ${ramsOutputTitle.prepared!""}</fo:block>
          </fo:table-cell>
          <fo:table-cell>
            <fo:block text-align="center">Internal Auditor:${ramsOutputTitle.previewer!""} </fo:block>
          </fo:table-cell>
          <fo:table-cell>
            <fo:block text-align="right">External Auditor: ${ramsOutputTitle.approve!""}</fo:block>
          </fo:table-cell>
        </fo:table-row>
      </fo:table-body>
  </fo:table>
</#if>

</#escape>