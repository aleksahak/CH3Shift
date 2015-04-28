<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="sreg.ResultsBean" %>
<%@ page import="java.util.HashMap" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>

<%
	response.setHeader("Cache-control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader ("Expires", 0);
%>

<html:html locale="true">
<head>

<meta http-equiv="expires" content="0"/>
<meta name="robots" content="noarchive"/>
<title><bean:message key="all.jsp.page.heading"/></title>


<SCRIPT LANGUAGE="JavaScript">
<!-- Begin


function disableFormNC() { 

messagewindow = window.open ("message_CH3Shift.jsp", "message_window_CH3Shift", "dependent=yes,menubar=yes,resizable=yes,scrollbars=yes,width=425,height=425"); 
messagewindow.moveTo(700,0); 

if (document.all || document.getElementById) {
document.body.style.cursor="wait";
for (j = 0; j < document.forms.length; j++) {
for (i = 0; i < document.forms[j].length; i++) {
var tempobj = document.forms[j].elements[i];
if (tempobj.name == "analyse" || tempobj.name=="clear" )
tempobj.disabled = true;
}
}
return true;
}
else {
return false;
   }
}

function disableFormAll(){
if (document.all || document.getElementById) {
document.body.style.cursor="wait";
for (j = 0; j < document.forms.length; j++) {
for (i = 0; i < document.forms[j].length; i++) {
var tempobj = document.forms[j].elements[i];
if (tempobj.name == "analyse" || tempobj.name == "clear" || tempobj.name=="cancel")
tempobj.disabled = true;
}
}
return true;
}
else {
return false;
   }
}


function retFalse () {
return false;
}
//  End -->
</script>

</head>

<body bgcolor="white"><p>

	<table border="0" cellpadding="2" cellspacing="10"  width="100%">
    <tr><td text="white" bgcolor="#7DC623" colspan="3">
    <table border="0" cellpadding="2" cellspacing="0" width="100%">
    <tr>
    <td width="100%">  <h1><font color="white">
    <bean:message key="all.jsp.page.heading"/>
    </font></h1>
    </td>
    <td>&nbsp;</td>
    <td nowrap></td>
    <td></td>
    </tr>
    </table>
    </td></tr>
    <tr><td>
    <hr noshade="" size="1"/>
    </td></tr>
    </table>
    
	<table border="0" cellpadding="12" cellspacing="0" width="100%">
		<tr>
			<br/>
		</tr>
	 <tr> 
		 <td align="left" colspan ="2">Structure Based Prediction of Protein Methyl Group Chemical Shifts.</td> 
	 </tr>
	 <tr> 
		 <td align="left" colspan ="2"><a href="CH3Shift_exe.tar.gz" target="_blank">Download CH3Shift</a> </td> 
	 </tr>
	 <tr> 
		 <td align="left" colspan ="2"><a href="CH3Shift_manual.pdf" target="_blank">Detailed Instructions</a> </td> 
	 </tr>

		<tr>
			<br/>
		</tr>
	
		<html:form action="enterdata.do" method="POST" enctype="multipart/form-data"  onsubmit="return disableFormNC();">
		 <tr> 
			 <td align="left" width ="20%"><html:text property="title" size="15" /></td> 
			 <td align="left" width ="75%">  <font color="red"><strong><html:errors property="title"/></strong></font> Enter the title of this trial.</td> 
			 <td align="left" width ="5%"><br/><br/></td> 
		 </tr>
		 <tr> 
			 <td align="left" width ="20%"> 
			 <html:file property="pdbname" size="40" /> 
			 <br/> 
			 <logic:present name="enterDataForm">
			 <logic:notEmpty name="enterDataForm" property="pdbname">
			 <bean:define id="ff" name="enterDataForm" property="pdbname"/> 
			 Current file: &nbsp; <bean:write name="ff" property="fileName"/> 
			 </logic:notEmpty> 
			 </logic:present> 
			 </td> 
			 <td align="left" width ="75%"><font color="red"><strong><html:errors property="pdbname"/></strong></font>Upload the protein PDB file with added hydrogen atoms.</td> 
			 <td align="left" width ="5%"><br/><br/></td> 
		 </tr>
		 <tr> 
			 <td align="left" width ="20%"><html:select property="pdbtype"  > 
				 <html:option value="complex">complex </html:option> </br> 
				 <html:option value="medium">medium </html:option> </br> 
				 <html:option value="simple">simple </html:option> </br> 
				 <html:option value="almost">almost </html:option> </br> 
			 </html:select> </td>
			 <td align="left" width ="75%"><font color="red"><strong><html:errors property="pdbtype"/></strong></font>Select the PDB file parsing option.</td> 
			 <td align="left" width ="5%"><br/><br/></td> 
		 </tr>
		 <tr> 
			 <td align="left" width ="20%"><html:text property="seqshift" size="4" /></td> 
			 <td align="left" width ="75%">  <font color="red"><strong><html:errors property="seqshift"/></strong></font> Shift the residue sequence numbers by the specified value.</td> 
			 <td align="left" width ="5%"><br/><br/></td> 
		 </tr>
		 <tr> 
			 <td align="left" width ="20%"><html:text property="examine" size="4" /></td> 
			 <td align="left" width ="75%">  <font color="red"><strong><html:errors property="examine"/></strong></font> Examine the specified conformer in the PDB file. If 0, all the conformers will be analysed and the averaged chemical shifts will be printed in the output.</td> 
			 <td align="left" width ="5%"><br/><br/></td> 
		 </tr>
		 <tr> 
			 <td align="left" width ="20%"> 
			 <html:file property="experdata" size="40" /> 
			 <br/> 
			 <logic:present name="enterDataForm">
			 <logic:notEmpty name="enterDataForm" property="experdata">
			 <bean:define id="ff" name="enterDataForm" property="experdata"/> 
			 Current file: &nbsp; <bean:write name="ff" property="fileName"/> 
			 </logic:notEmpty> 
			 </logic:present> 
			 </td> 
			 <td align="left" width ="75%"><font color="red"><strong><html:errors property="experdata"/></strong></font>Upload experimental chemical shift data file for comparison (optional).</td> 
			 <td align="left" width ="5%"><br/><br/></td> 
		 </tr>
		 <tr> 
			 <td align="left" width ="20%"><html:checkbox property="rereference" /></td> 
			 <td align="left" width ="75%">  <font color="red"><strong><html:errors property="rereference"/></strong></font> Re-reference the calculated chemical shifts via the offset finding by least squares fitting. </td> 
			 <td align="left" width ="5%"><br/><br/></td> 
		 </tr>
		 <tr> 
			 <td align="left" colspan ="3"> 
			 <h2>Output and Plotting Controllers</h2> 
			
			 </td> 
		 </tr>
		 <tr> 
			 <td align="left" width ="20%"><html:select property="outorder"  > 
				 <html:option value="byseq">byseq </html:option> </br> 
				 <html:option value="bytype">bytype </html:option> </br> 
				 <html:option value="byshift">byshift </html:option> </br> 
			 </html:select> </td>
			 <td align="left" width ="75%"><font color="red"><strong><html:errors property="outorder"/></strong></font>Select the order scheme for the results in the output file.</td> 
			 <td align="left" width ="5%"><br/><br/></td> 
		 </tr>
		 <tr> 
			 <td align="left" width ="20%"><html:text property="bias" size="2" /></td> 
			 <td align="left" width ="75%">  <font color="red"><strong><html:errors property="bias"/></strong></font> A positive number that controls the residue colour-coding output: higher values give more widely spaced colours at the high probability end of the structural quality.</td> 
			 <td align="left" width ="5%"><br/><br/></td> 
		 </tr>
		 <tr> 
			 <td align="left" colspan ="3"> 
			 <h2></h2> 
			The proton chemical shift range to visualize (in ppm).
			 </td> 
		 </tr>
		 <tr> 
			 <td align="left" width ="20%"><html:text property="xlimmin" size="4" /></td> 
			 <td align="left" width ="75%">  <font color="red"><strong><html:errors property="xlimmin"/></strong></font> Minimum value.
</td> 
			 <td align="left" width ="5%"><br/><br/></td> 
		 </tr>
		 <tr> 
			 <td align="left" width ="20%"><html:text property="xlimmax" size="4" /></td> 
			 <td align="left" width ="75%">  <font color="red"><strong><html:errors property="xlimmax"/></strong></font> Maximum value.</td> 
			 <td align="left" width ="5%"><br/><br/></td> 
		 </tr>
		 <tr> 
			 <td align="left" colspan ="3"> 
			 <h2></h2> 
			The carbon chemical shift range to visualize (in ppm).
			 </td> 
		 </tr>
		 <tr> 
			 <td align="left" width ="20%"><html:text property="ylimmin" size="4" /></td> 
			 <td align="left" width ="75%">  <font color="red"><strong><html:errors property="ylimmin"/></strong></font> Minimum value.</td> 
			 <td align="left" width ="5%"><br/><br/></td> 
		 </tr>
		 <tr> 
			 <td align="left" width ="20%"><html:text property="ylimmax" size="4" /></td> 
			 <td align="left" width ="75%">  <font color="red"><strong><html:errors property="ylimmax"/></strong></font> Maximum value.</td> 
			 <td align="left" width ="5%"><br/><br/></td> 
		 </tr>
		 <tr> 
			 <td align="left" width ="20%"><html:checkbox property="pointlabel" /></td> 
			 <td align="left" width ="75%">  <font color="red"><strong><html:errors property="pointlabel"/></strong></font> Label the NMR signals on the plot.</td> 
			 <td align="left" width ="5%"><br/><br/></td> 
		 </tr>
		 <tr> 
			 <td align="left" width ="20%"><html:checkbox property="linelabel" /></td> 
			 <td align="left" width ="75%">  <font color="red"><strong><html:errors property="linelabel"/></strong></font> Label the possible lines on the plot.</td> 
			 <td align="left" width ="5%"><br/><br/></td> 
		 </tr>
		 <tr> 
			 <td align="left" width ="20%"><html:checkbox property="plotexper" /></td> 
			 <td align="left" width ="75%">  <font color="red"><strong><html:errors property="plotexper"/></strong></font> Plot the uploaded experimental chemical shifts.</td> 
			 <td align="left" width ="5%"><br/><br/></td> 
		 </tr>
		 <tr> 
			 <td align="left" colspan ="3"> 
			 <h2></h2> 
			Plot size.
			 </td> 
		 </tr>
		 <tr> 
			 <td align="left" width ="20%"><html:text property="plotheight" size="4" /></td> 
			 <td align="left" width ="75%">  <font color="red"><strong><html:errors property="plotheight"/></strong></font> Plot height.</td> 
			 <td align="left" width ="5%"><br/><br/></td> 
		 </tr>
		 <tr> 
			 <td align="left" width ="20%"><html:text property="plotwidth" size="4" /></td> 
			 <td align="left" width ="75%">  <font color="red"><strong><html:errors property="plotwidth"/></strong></font> Plot width.</td> 
			 <td align="left" width ="5%"><br/><br/></td> 
		 </tr>
		 <tr> 
			 <td align="left" colspan ="3"> 
			 <h2></h2> 
			Color coding of the predicted chemical shifts.
			 </td> 
		 </tr>
		 <tr> 
			 <td align="left" width ="20%"><html:text property="colALA" size="8" /></td> 
			 <td align="left" width ="75%">  <font color="red"><strong><html:errors property="colALA"/></strong></font> Alanine</td> 
			 <td align="left" width ="5%"><br/><br/></td> 
		 </tr>
		 <tr> 
			 <td align="left" width ="20%"><html:text property="colVAL" size="8" /></td> 
			 <td align="left" width ="75%">  <font color="red"><strong><html:errors property="colVAL"/></strong></font> Valine</td> 
			 <td align="left" width ="5%"><br/><br/></td> 
		 </tr>
		 <tr> 
			 <td align="left" width ="20%"><html:text property="colTHR" size="8" /></td> 
			 <td align="left" width ="75%">  <font color="red"><strong><html:errors property="colTHR"/></strong></font> Threonine</td> 
			 <td align="left" width ="5%"><br/><br/></td> 
		 </tr>
		 <tr> 
			 <td align="left" width ="20%"><html:text property="colLEU" size="8" /></td> 
			 <td align="left" width ="75%">  <font color="red"><strong><html:errors property="colLEU"/></strong></font> Leucine</td> 
			 <td align="left" width ="5%"><br/><br/></td> 
		 </tr>
		 <tr> 
			 <td align="left" width ="20%"><html:text property="colILE" size="8" /></td> 
			 <td align="left" width ="75%">  <font color="red"><strong><html:errors property="colILE"/></strong></font> Isoleucine</td> 
			 <td align="left" width ="5%"><br/><br/></td> 
		 </tr>
		 <tr> 
			 <td align="left" width ="20%"><html:text property="colMET" size="8" /></td> 
			 <td align="left" width ="75%">  <font color="red"><strong><html:errors property="colMET"/></strong></font> Methionine</td> 
			 <td align="left" width ="5%"><br/><br/></td> 
		 </tr>
		 <tr> 
			 <td align="left" colspan ="3"> 
			 <h2></h2> 
			Color coding of the experimental chemical shifts.
			 </td> 
		 </tr>
		 <tr> 
			 <td align="left" width ="20%"><html:text property="expCOL" size="8" /></td> 
			 <td align="left" width ="75%">  <font color="red"><strong><html:errors property="expCOL"/></strong></font> Joint color for all the experimental data (if left blank, either the following inputs will be read on presence, or the default individual color coding scheme will be used).</td> 
			 <td align="left" width ="5%"><br/><br/></td> 
		 </tr>
		 <tr> 
			 <td align="left" width ="20%"><html:text property="colALAexp" size="8" /></td> 
			 <td align="left" width ="75%">  <font color="red"><strong><html:errors property="colALAexp"/></strong></font> Alanine</td> 
			 <td align="left" width ="5%"><br/><br/></td> 
		 </tr>
		 <tr> 
			 <td align="left" width ="20%"><html:text property="colVALexp" size="8" /></td> 
			 <td align="left" width ="75%">  <font color="red"><strong><html:errors property="colVALexp"/></strong></font> Valine</td> 
			 <td align="left" width ="5%"><br/><br/></td> 
		 </tr>
		 <tr> 
			 <td align="left" width ="20%"><html:text property="colTHRexp" size="8" /></td> 
			 <td align="left" width ="75%">  <font color="red"><strong><html:errors property="colTHRexp"/></strong></font> Threonine</td> 
			 <td align="left" width ="5%"><br/><br/></td> 
		 </tr>
		 <tr> 
			 <td align="left" width ="20%"><html:text property="colLEUexp" size="8" /></td> 
			 <td align="left" width ="75%">  <font color="red"><strong><html:errors property="colLEUexp"/></strong></font> Leucine</td> 
			 <td align="left" width ="5%"><br/><br/></td> 
		 </tr>
		 <tr> 
			 <td align="left" width ="20%"><html:text property="colILEexp" size="8" /></td> 
			 <td align="left" width ="75%">  <font color="red"><strong><html:errors property="colILEexp"/></strong></font> Isoleucine</td> 
			 <td align="left" width ="5%"><br/><br/></td> 
		 </tr>
		 <tr> 
			 <td align="left" width ="20%"><html:text property="colMETexp" size="8" /></td> 
			 <td align="left" width ="75%">  <font color="red"><strong><html:errors property="colMETexp"/></strong></font> Methionine</td> 
			 <td align="left" width ="5%"><br/><br/></td> 
		 </tr>

	<tr><td valign="top" colspan = "1">
	  <table>
	    <tr>
	      <td>
		    <html:hidden property="procFlag" value="enter"/>
  		    <html:submit property="analyse">Analyse</html:submit><br/>
  		    </html:form>
  	      </td>
  	      <td>
             &nbsp;&nbsp;&nbsp;
          </td>
  	      <td>
  	        <html:form action="cancelanalysis.do"  onsubmit="return disableFormAll();">
  	        <html:cancel property="cancel">Cancel</html:cancel><br/>
  	        </html:form>
  	      </td>
  	    </tr>
      </table>
	</td></tr>
	

	<tr><td>
		<font color="red"><strong><html:errors property="org.apache.struts.action.GLOBAL_MESSAGE"/></strong></font>
		<font color="green"><strong><html:errors property="warning"/></strong></font>
	</td></tr>
		
	<logic:present name="inputdata" scope="session">
    	<logic:notEmpty name="inputdata" property="success" scope="session">
    		
    	<tr><td>
    		<hr noshade="" size="1"/>
    	</td></tr>
    	  	
    	
    	
	 <logic:notEmpty name="inputdata" property="submitID"> 
	 <tr><td> 
	<h2>Current Results Files</h2> 
	</td></tr> 
	 <bean:define id="currentSubmitID" name="inputdata" property="submitID" type="String"/> 
	 </table> 
	 <table border="0" cellpadding="12" cellspacing="0" width="100%"> 
	 <tr> 
	 <td colspan="1" align="left" valign="top"> <object type="text/plain"  data="displayfile.do?subid=<%= currentSubmitID %>&amp;ctype=txt&amp;file=out.txt" width="650" height="700"></object> </td> 

	 </tr>
	 <tr> 
	 <td colspan="1" align="left" valign="top"> <object type="image/jpeg" data="displayfile.do?subid=<%= currentSubmitID %>&amp;ctype=jpg&amp;file=hsqc.jpg"  width="550" height="550"></object> </td> 

	 </tr>
	 </table> 
	 </logic:notEmpty> 

<table border="0" cellpadding="12" cellspacing="0" width="100%">   	
    	    
    	<tr><td>
			<h2>Results Pages</h2>
		</td></tr>
		<logic:notEmpty name="inputdata" property="subList" scope="session">
		<logic:iterate id="sub"  name="inputdata"  indexId="ind" property="subList" type="ResultsBean">
		<bean:define id="listSubID" name="sub" property="submitID" type="String"/>
    	<tr>
    		<td align="left" width=30%>
             	<html:link forward="Results" paramId="resSubID" paramName="listSubID" target="_blank"> Results for submission: <bean:write name="sub" property="submitID"/> </html:link>
             	<br/>
        	</td>
        	<td align="left" width=70%>
        		Parameter values:&nbsp;
        		<logic:iterate id="params"  name="sub"  indexId="pind" property="parList">
  	           		<bean:write name="params" property="key"/>&nbsp;=&nbsp;
  	           		<logic:notEmpty name="params" property="value">
  	           		<bean:write name="params" property="value"/>
  	           		</logic:notEmpty>
  	           		<logic:empty name="params" property="value">
  	           		""
  	           		</logic:empty>
  	           		<%  int ip = pind.intValue();
            			String ipos = Integer.toString(ip);%>
  	           		<logic:notEqual name="inputdata" property="numParams" value="<%= ipos%>">,&nbsp;</logic:notEqual>
  	           		<logic:equal name="inputdata" property="numParams" value="<%= ipos%>">.&nbsp;</logic:equal>
  	        	</logic:iterate>
  	        	
  	        	<br/>
  	        	<logic:iterate id="zlist"  name="sub"  property="zpList">
  	        		<bean:write name="zlist" property="key"/>&nbsp;(files unzipped):<br/>
  	        		<bean:define id="fnames" name="zlist" property="value"/>
  	        		<logic:iterate id="fn"  name="fnames">
  	        			<bean:write name="fn"/>&nbsp;&nbsp;
  	        		</logic:iterate>
  	        		<br/>
  	        	</logic:iterate>
  	        	
  	    	</td>
        </tr>
        </logic:iterate>
        </logic:notEmpty>
        
        <tr><td colspan = "2">
            <br/>
            <html:form action="clearpage.do"  onsubmit="return disableFormAll();">
            <html:hidden property="procFlag" value="clear"/>
	        <html:submit property="clear">Clear Page</html:submit> 
            </html:form>
     	</td></tr>
        
        
    	</logic:notEmpty>
	</logic:present>
	
  
</table>

</body>
</html:html>
