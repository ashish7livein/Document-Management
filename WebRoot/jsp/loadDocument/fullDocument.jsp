<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>


<c:set var='url'>
	<c:url value="dm/fullDocumentLoader">
		<c:param name="documentId" value="${documentId}"/>
		<c:param name="username" value="${username}"/>
	</c:url>
</c:set>
<meta http-equiv="Content-type" content="application/msword">
<style>
.iframe{
width: 100%; height: 100%;
}

</style>


<div  id='loadDocument'>
	<iframe class='iframe'  src='${url}' ></iframe>
</div>


