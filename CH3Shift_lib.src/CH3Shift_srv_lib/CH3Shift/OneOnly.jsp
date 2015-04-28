<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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


</head>
<body bgcolor="white"><p>


<table border="0" cellpadding="2" cellspacing="10" width="100%">
	<tr><td text="white" bgcolor="#CC3300" colspan="3">
		<table border="0" cellpadding="2" cellspacing="0" width="100%">
			<tr>
				<td width="100%">  <h1><font color="white"><bean:message key="all.jsp.page.heading"/></font></h1></td>
				<td>&nbsp;</td>
				<td nowrap></td>
				<td></td>
			</tr>
			</table>
			</td></tr>
			<tr><td>
			<hr noshade="" size="1"/></td></tr>
</table>



<table border="0" cellpadding="12" cellspacing="10" width="100%">
 	<tr><td bgcolor=#FFFDDA valign="top" colspan="2">
		<table>
			<tr><td colspan = "2">
				
					<h2>Already running CH3Shift ?</h2>
			</td></tr>
			
			<tr><td colspan = "2">
			<br/>
			The server thinks you may have open another browser window that is running 'CH3Shift'.  
			Running two copies of 'CH3Shift' simultaneously will not work.<br/><br/>

			The server may be mistaken, you may have closed the browser window running 'CH3Shift' and the server hasn't noticed this yet, 
			in which case, please press "Run new copy of CH3Shift"<br/><br/>

			But if the server is correct and you have another browser window open that is running 'CH3Shift', 
			either close the other browser window, first making sure you have saved all the results you need onto your local disk, 
			and press "Run new copy of CH3Shift",
			or alternatively close this browser window and continue working with the old copy of 'CH3Shift'.
			<br/><br/>
         	</td></tr>
			
			<tr><td colspan = "2">
				<table>
         			<tr>
         				<td colspan = "1">
         				    <html:form action="continue.do">
  	        				<html:submit>Run new copy of CH3Shift</html:submit>
         					</html:form>
         				</td>
         			</tr>
         		</table>
			</td></tr>

			<tr><td colspan = "2">
				<font color="red"><strong><html:errors/></strong></font><br/>
			</td></tr>

			<tr><td colspan = "2">
				<br/><br/><br/>
			</td></tr>
		</table>
	</td>
</tr>

</table>
</body>
</html:html>

	
