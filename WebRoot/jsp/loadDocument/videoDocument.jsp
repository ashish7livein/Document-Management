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
	.video{
		width: 100%; height: 70%;	overflow: scroll;
		
	}
#loadDocument{height:100%; width:100%; }
</style>
<div  id='loadDocument'>
	<object class="video" controls="controls">
		<param name="allowFullScreen" value="true"/> 
		<param name="wmode" value="transparent"/> 
		<embed src="${url}" width="100%" height="100%" allowFullScreen="false" type="video/mpeg" wmode="transparent"/> 
	</object>
</div>