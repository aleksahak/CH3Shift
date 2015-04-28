<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="sreg.ResultsBean" %>
<%@ page import="java.util.HashMap" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>

<%
	response.setHeader("Cache-control", "no-store");
	response.setHeader("Pragma", "no-cache");
%>

<html:html locale="true">

<head>
	<meta http-equiv="expires" content="0"/>
	<meta name="robots" content="noarchive"/>
	<title><bean:message key="all.jsp.page.heading"/></title>
	
	<SCRIPT LANGUAGE="JavaScript">

<!-- Begin


function disableFormAll() {
if (document.all || document.getElementById) {
document.body.style.cursor="wait";
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

	
	<bean:parameter id="pageSubID" name="resSubID"/>
	<% java.util.HashMap parMap = new java.util.HashMap(); %>

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
   
    <tr><td>
	<table border="0" cellpadding="12" cellspacing="10" width="100%">
	
	<logic:present name="inputdata" scope="session">
	<logic:notEmpty name="inputdata" property="success" scope="session">
	<logic:notEmpty name="inputdata" property="subList" scope="session">
	<logic:iterate id="sub"  name="inputdata" indexId="ind" property="subList" type="ResultsBean">
	<bean:define id="listSubmitID" name="sub" property="submitID" type="String"/>
	<logic:equal name="listSubmitID" value="<%= pageSubID %>">
	<% parMap.put("subid", pageSubID); 
	   parMap.put("ctype", "none");%>
	   
	<tr><td colspan="3">
		<h2>Results for submission: <bean:write name="sub" property="submitID"/> </h2>
	</td></tr>
	
	<tr>
		<td align="left" colspan="1" width=20%>
    		<logic:iterate id="resultslistline"  name="sub" property="resList" type="String">
    		    <% parMap.put("file", resultslistline);
    		       parMap.put("action", "downloadfile");
    		       pageContext.setAttribute("map", parMap); %>
             	<html:link action="checkid.do" name="map" ><bean:write name="resultslistline"/> </html:link>
             	<br/>
         	</logic:iterate>
		</td>
		
		<td align="left" colspan="1" width=80%>
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
	
	<tr><td colspan="3">
    		<logic:notEmpty name="sub" property="warningMessage">
        		<font color="green"><strong>Warning:&nbsp;&nbsp;<bean:write name="sub" property="warningMessage"/></stong></font><br/>
    		</logic:notEmpty>
	</td></tr>
	
	<tr><td colspan="3">
        Download this Results web page with the:
        <% parMap.put("file", "results");
    	   parMap.put("action", "downloadpage");
    	   pageContext.setAttribute("map", parMap); %>
        &nbsp;&nbsp;<html:link action="checkid.do" name="map">Results only </html:link>
        <% parMap.put("file", "all");
    	   pageContext.setAttribute("map", parMap); %>
        &nbsp;&nbsp;<html:link action="checkid.do" name="map">Results and Data </html:link>&nbsp;&nbsp; (May take a while to respond for large files. Please click once only)<br/>
    </td></tr>
	
	<tr><td colspan="3">
		
		
	
	 <table border="0" cellpadding="12" cellspacing="0" width="100%"> 
	 <tr> 
	 <td colspan="1" align="left" valign="top"> <object type="text/plain"  data="checkid.do?action=displayfile&amp;subid=<%= listSubmitID %>&amp;ctype=txt&amp;file=out.txt" width="650" height="700"></object> </td> 

	 </tr>
	 <tr> 
	 <td colspan="1" align="left" valign="top"> <object type="image/jpeg" data="checkid.do?action=displayfile&amp;subid=<%= listSubmitID %>&amp;ctype=jpg&amp;file=hsqc.jpg"  width="550" height="550"></object> </td> 

	 </tr>
	 </table> 
	
	
	</td></tr>
	</logic:equal>
	</logic:iterate>
	</logic:notEmpty>
	</logic:notEmpty>
	</logic:present>

    
	</table>
	</td></tr>
</table>

</body>
</html:html>
