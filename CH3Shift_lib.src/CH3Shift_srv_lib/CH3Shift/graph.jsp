<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>

<html>

	<head>
		<meta http-equiv="Refresh" content=grefrate>
		<title><bean:message key="graphical.jsp.title"/></title>
	</head>

	<body>
		 <logic:present name="inputdata" scope="session">
		 		<logic:notEmpty name="inputdata" scope="session" property="gpirdy">
					<object type="image/jpeg" data="displaygpinfo.do" width="gpiWidth" height="gpiHeight"></object>
				</logic:notEmpty>
		</logic:present>
	</body>
	
</html>


