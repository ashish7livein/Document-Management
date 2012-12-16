<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<title>Document Management</title>
<jsp:include page="../script.jsp" flush="true" />

<script>

document.observe("dom:loaded", function() {
  
  $('auth').observe('submit', _loginHandler.bindAsEventListener(this));
  $('folderData').setStyle({
    		display : 'none'
    		});
  $('documentContainer').style.display='none';
	function _loginHandler(e) {
		_login();
		e.stop();
	}
	
	function _login () {
		new Ajax.Request('auth/login', {
			parameters: {
				username: $('username').value,
				password: $('password').value
			},
			onSuccess: _loginSuccessHandler.bind(this)
		});
	}
	
    function _loginSuccessHandler (transport) {
    	if(transport.responseText=="Failure"){
    		Dialogs.load();
    		Dialogs.alert('Inavlid Username/Password');
    	}else{
    	$('auth').disable();
    	Effect.SlideUp('auth',{ duration: 2.0 });
    	$('folderData').setStyle({
    		display : 'none',
    		width: '44%',
    		height: 'auto',
    		paddingLeft:'30%',
    		paddingRight:'20%',
    		paddingBottom:'50px'
    		
    	});
    	
    	//$('folderList').innerHTML=transport.responseText;
    	//Effect.Appear('folderHeader',{ duration: 4.0 });
    	var json = transport.responseJSON;
    	
    	json.results.forEach(function(o){
    		var result = $('folderContent').down().clone(true);
    		result.down('.folderId').update(o.folderId);
    		result.down('.folderName').update(o.folderName);
    		result.down('.created').update(o.created);
    		result.down('.changed').update(o.changed);
    		result.down('.folder').store('folderId',o.folderId);
    		result.down('.folder').store('folderName',o.folderName);   		
    		$('folderList').appendChild(result);
    		
    	});
    	
    	$('folderContent').remove();
    	
    	Effect.Appear('folderData',{ duration: 4.0 });
    	Sortable.create('folderList', {
				tag: 'div'});
    	
    	}
    	
    	
    	$$('.result').forEach(function(t){
    		t.down('.folderResult').style.display='none';
    		t.down('.folder').observe('click',function(e){
    			debugger;
    			if($('documentContainer').style.display!='none'){
 		   			Effect.Fade('documentContainer',{ duration: 1.0 });
 				}	
    			this.parentElement.siblings().forEach(function(s){
    				s.down('.folderResult').style.display='none';
    				s.down('.folder').setStyle({
    					backgroundColor: 'gray'
    				});
    			});
    			this.setStyle({
    				backgroundColor: 'wheat'
    			});
    			new Ajax.Request('dm/documents', {
					parameters: {
						folderId: this.retrieve('folderId'),
						folderName: this.retrieve('folderName')
					},
					onSuccess: _documentLoader.bind(this)
				});
    		});
    	});
	}
	function _documentLoader(transport){
								
								var documentJson = transport.responseJSON;
								var results = documentJson.results;
								this.parentElement.down('.documentList').childElements().forEach(function(f){
									f.remove();
								});
								results.each(function(o){
									var documentResult =$('documentContent').down().clone(true);
						    		documentResult.down('.documentId').update(o.documentId);
						    		documentResult.down('.documentName').update(o.documentName);
						    		documentResult.down('.created').update(o.created);
						    		documentResult.down('.changed').update(o.changed);
						    		documentResult.down('.contentType').update(o.contentType);
						    		documentResult.down('.document').store('documentId',o.documentId);
						    		documentResult.down('.document').store('documentName',o.documentName);   		
						    		this.parentElement.down('.documentList').appendChild(documentResult);
								},this);
								
								var folderResult = this.parentElement.down('.folderResult');
				    			Effect.SlideDown(folderResult,{ duration: 2.0 });
				    			Sortable.create(this.parentElement.down('.documentList'), {
								tag: 'div'});
								
								this.parentElement.select('.documentResult').forEach(function(t){
									t.down('.document').observe('click',function(e){
										this.parentElement.siblings().forEach(function(s){
						    				s.down('.document').setStyle({
						    					backgroundColor: 'gray'
						    				});
						    			});
										this.setStyle({
											backgroundColor: 'wheat'
										});
										debugger;
										new Ajax.Request('dm/loadDocument', {
											parameters: {
												documentId: this.retrieve('documentId')
											},
											onSuccess: _documentUpdater.bind(this)
										});
										
										
									});
								
								});
								
								
	}
	function _documentUpdater(transport){
		debugger;
		Effect.Appear('documentContainer',{ duration: 2.0 });
		$('documentContainer').update(transport.responseText);
	}
	

});

</script>
<style>
	<jsp:include page="../../css/proto.menu.0.6.css" flush="true" />
	<jsp:include page="../../css/dialog.css" flush="true" />
	#uiContent{
	position: absolute;
	width:100%;
	height:100%;
	}
	#folderContent{
	display:none;
	}
	#documentContent{
	display:none;
	}
	.folder
	{
	padding:10px 40px; 
	background:gray;
	width:91%;
	border-radius:25px;
	margin-top: 2px;
	}
	#folderHeader .folder
	{
	padding:10px 40px; 
	background:#DDD;
	width:91%;
	border-radius:25px;
	margin-top: 2px;
	}
	.document
	{
	padding-top: 10px;
	padding-left: 100px;
	background: gray;
	width: 78%;
	border-radius: 25px;
	margin-top: 2px;
	margin-left: 10%;
	}
	#documentHeader .document
	{
	padding-top: 10px;
	padding-left: 80px;
	background: #DDD;
	width: 80%;
	border-radius: 25px;
	margin-top: 2px;
	margin-left: 10%;
	}
</style>

<body id='content'>
		<div class="lm_container">
						<div  class='lm_center'>
							<div id='uiContent'>
							
								<form id='auth' style="margin-left: 850px; margin-top: 100px;">
										<table class='auth'  border="0" cellspacing="0" cellpadding="0">
										   
											<tr>
											  <td>
											  		<p>UserName</p>
											  </td>	
											  <td>
												<input id='username' name='username' type='text' autocorrect="off" autocapitalize="off" title="user name"/>
											  </td>
											</tr>
											<tr>
											  <td>
											  		<p>Password</p>
											  </td>	
											  <td>
												<input id='password' name='password' type='password' title="password"/>
											  </td>
											</tr>
											<tr>
											 <td>
												<button type='submit' class='primary'>
													Login
												</button>
											  </td>
											</tr>
										</table>
								</form>
								<div id="folderData">
									<div id="folderHeader">
											<div class='folder'>
												<table  border="0">
														<tr>
															<td width="170px"><b>folderId</b></td>
															<td width="170px"><b>folderName</b></td>
															<td width="170px"><b>created</b></td>
															<td width="170px"><b>changed</b></td>
														</tr>
												</table>
										</div>
									</div>
									<div id="folderList">
										
									</div>
								</div>
								<div id="documentContainer" style="background: #DDD;border:1px solid black;width:44%;height:50%;overflow:scroll;border-radius:10px;margin-left: 30%;margin-right: 30%">
									Document is loaded here
									
								</div>	
							</div>	
							
						</div>
					<div class='lm_top'>
						<h1 align="center"> Document Management</h1>
					</div>	
		
		</div>
		<div id='folderContent'>
			<div class='result'>
					<div class='folder'>
						<table  border="0">
								<tr>
									<td class='folderId' width="170px"></td>
									<td class='folderName' width="170px"></td>
									<td class='created' width="170px"></td>
									<td class='changed' width="170px"></td>
								</tr>
						</table>
					</div>
					<div class='folderResult'>
									<div id="documentHeader">
											<div class='document'>
												<table  border="0">
														<tr>
															<td width="170px"><b>documentId</b></td>
															<td width="170px"><b>documentName</b></td>
															<td width="170px"><b>contentType</b></td>
															<td width="170px"><b>created</b></td>
															<td width="170px"><b>changed</b></td>
														</tr>
												</table>
											</div>
									</div>
									<div id="documentList" class="documentList">
									
									
									</div>
					</div>
			</div>
		</div>
		
		<div id='documentContent'>
			<div class='documentResult'>
				<div class='document'>
							<table  border="0">
									<tr>
										<td width="170px" class='documentId'></td>
										<td width="170px" class='documentName'></td>
										<td width="170px" class='contentType'></td>
										<td width="170px" class='created'></td>
										<td width="170px" class='changed'></td>
									</tr>
							</table>
				</div>
			</div>	
		</div>

</body>