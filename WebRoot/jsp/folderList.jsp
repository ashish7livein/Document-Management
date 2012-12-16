<%@ page contentType="application/json" %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix="j" uri="http://www.atg.com/taglibs/json" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<j:object>
	<j:property name="totalResults" value="${fn:length(folders)}"/>
	<j:array name="results" items="${folders}" var="folder">
		<j:object>
			<j:property name="folderId" value="${folder.id}"/>
			<j:property name="folderName" value="${folder.foldername}"/>
			<j:property name="created" value="${folder.created}"/>
			<j:property name="changed" value="${folder.changed}"/>	
		</j:object>
	</j:array>
</j:object>