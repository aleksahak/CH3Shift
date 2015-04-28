<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>

<html>

	<head>
		<meta http-equiv="Refresh" content=5>
		<title><bean:message key="popup.jsp.title"/></title>
	</head>

	<body>
		 <logic:present name="inputdata" scope="session">
		 		<logic:notEmpty name="inputdata" scope="session" property="pirdy">
					<object type="text/plain" data="displaypinfo.do" width="400" height="400"></object>
				</logic:notEmpty>
		</logic:present>
	</body>
	
</html>


