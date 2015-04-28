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
            
	<table border="0" cellpadding="12" cellspacing="10" width="100%">
	
	
	   
	<tr><td>
		<h2>Results for submission:  </h2>
	</td></tr>
	
	<tr><td>
	    <br/><br/>
		<h3><bean:message key="Page.gone.prompt"/></h3>
	</td></tr>
	
	</table>

</body>
</html:html>
	