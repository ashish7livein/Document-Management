<%@ taglib prefix="s" uri="/struts-tags" %>

	<s:if test="hasActionErrors()">
		   <div class="errors">
		      <s:actionerror/>
		   </div>
	</s:if>
 