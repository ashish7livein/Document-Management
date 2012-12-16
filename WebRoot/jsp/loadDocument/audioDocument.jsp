<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="j" uri="http://www.atg.com/taglibs/json" %>


<c:set var='url'>
	<c:url value="dm/fullDocumentLoader">
		<c:param name="documentId" value="${documentId}"/>
		<c:param name="username" value="${username}"/>
	</c:url>
</c:set>
<style>
	.audio{
		width: 100%; height: 50%;
	}
	#loadDocument{height:600px; width:600px; overflow: auto;}
</style>

<div  id='loadDocument'>
	<audio class="audio" controls="controls">
		<source src="${url}" type="audio/mp3" />
	</audio>
</div>