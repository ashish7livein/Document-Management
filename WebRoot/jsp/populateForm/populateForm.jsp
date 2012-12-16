<%@ page contentType="application/json" %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix="j" uri="http://www.atg.com/taglibs/json" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<j:object>
	<j:array name="folders" items="${folders}" var="folder">
			<j:property value="${folder.foldername}"/>
	</j:array>
	<j:array name="contentTypes" items="${contentTypes}" var="contentType">
			<j:property value="${contentType}"/>
		</j:array>
</j:object>