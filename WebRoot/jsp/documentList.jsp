<%@ page contentType="application/json" %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix="j" uri="http://www.atg.com/taglibs/json" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<j:object>
	<j:property name="totalResults" value="${fn:length(documents)}"/>
	<j:array name="results" items="${documents}" var="document">
		<j:object>
			<j:property name="documentId" value="${document.id}"/>
			<j:property name="documentName" value="${document.documentName}"/>
			<j:property name="contentType" value="${document.contentType}"/>
			<j:property name="created" value="${document.created}"/>
			<j:property name="changed" value="${document.changed}"/>	
		</j:object>
	</j:array>
</j:object>