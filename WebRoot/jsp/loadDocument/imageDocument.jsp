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
#loadDocument #documentImage{
	height:100%;
	width:100%;
	overflow: scroll;
}



#loadDocument{height:100%; width:100%; }
</style>


<div  id='loadDocument'>
	<img height='auto' width='auto' id="documentImage"  src='${url}' />
</div>