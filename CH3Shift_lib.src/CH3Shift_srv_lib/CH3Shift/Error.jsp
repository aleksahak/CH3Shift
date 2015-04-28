<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.apache.struts.util.MessageResources" %>
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
for (j = 0; j < document.forms.length; j++) {
for (i = 0; i < document.forms[j].length; i++) {
var tempobj = document.forms[j].elements[i];
if (tempobj.type.toLowerCase() == "submit" || tempobj.type.toLowerCase() == "reset")
tempobj.disabled = true;
}
}
return true;
}
else {
return false;
   }
}


//  End -->
</script>


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
				<h2><bean:message key="Error.jsp.prompt.file"/></h2>
			</td></tr>
			
			<tr><td colspan = "2">
            <br/>Sorry, but you cannot use the browser's back, forward or reload buttons. Please use the <br/>
                 buttons provided on the web page to navigate through the application.
             <br/><br/>
         	</td></tr>

			<html:form action="continue.do" enctype="multipart/form-data"  onsubmit="return disableFormAll();">
  			
  					
			<tr><td colspan = "2">
				<table>
         			<tr>
         				<td colspan = "1">
  	        				<html:submit>Continue</html:submit>
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

	