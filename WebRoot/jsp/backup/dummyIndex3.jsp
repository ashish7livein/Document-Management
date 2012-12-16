<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<title>Document Management</title>
<jsp:include page="../script.jsp" flush="true" />

<script>

document.observe("dom:loaded", function() {
         
  	
	$('auth').observe('submit', _loginHandler.bindAsEventListener(this));
	$('formDocument').observe('submit', _addDocument.bindAsEventListener(this));
	$('folderData').setStyle({
	    		display : 'none'
	});
	$('folderName').observe('click', _disableExistingFolder);
	$('existingFolder').observe('click', _disableFolder);
	$('documentContainer').style.display='none';
	$('uploadDocument').setStyle({
    		display : 'none',
    		width: '90%',
    		height: 'auto',
    		paddingLeft:'4%',
    		paddingRight:'4%',
    		paddingBottom:'20px',
    		paddingTop:'20px'
    });
	$('menuContainer').style.display='none';
	function _loginHandler(e) {
		_login();
		e.stop();
	}
	
	function _login () {
		$('menuContainer').store('username',$('username').value);
		$('menuContainer').store('password',$('password').value);
		
		new Ajax.Request('auth/login', {
			parameters: {
				username: $('username').value,
				password: $('password').value
			},
			onSuccess: _loginSuccessHandler.bind(this)
		});
	}
	function _showCreateDocument(){
		$('user').value = $('username').value;
		$('pass').value = $('password').value;
		if($('folderData').style.display!= 'none'){
			Effect.SlideUp('folderData',{ duration : 1.0 });
		}
		if($('documentContainer').style.display!= 'none'){
			Effect.SlideUp('documentContainer',{ duration : 1.0 });
		}
		Effect.Appear('uploadDocument',{ duration : 3.0 });
		this.style.backgroundColor='wheat';
		this.siblings()[0].style.backgroundColor='#DDD';
	}
	function _showDisplayDocument(){
	
		if($('uploadDocument').style.display!= 'none'){
			Effect.Fade('uploadDocument',{ duration : 3.0 });
		}	
		$('folderData').style.display='none';
		
		this.style.backgroundColor='wheat';
		this.siblings()[0].style.backgroundColor='#DDD';
		new Ajax.Request('auth/login', {
		parameters: {
			username: $('menuContainer').retrieve('username'),
			password: $('menuContainer').retrieve('password')
		},
		onSuccess: function(transport){
					Effect.SlideDown('folderData',{ duration: 2.0 });
					_loadUIContent(transport);
					}
		});
	
	}
    function _loginSuccessHandler (transport) {
    	if(transport.responseText=="Failure"){
    		Dialogs.load();
    		Dialogs.alert('Inavlid Username/Password');
    	}else{
	    	Effect.SlideUp('auth',{ duration: 2.0 });
	    	Effect.Appear('menuContainer',{ duration: 4.0 });
	    	Sortable.create('menuContainer',{tag: 'div'});
	    	$('menuContainer').down('.addDocument').observe('click',_showCreateDocument.bindAsEventListener($('menuContainer').down('.addDocument')));
	    	$('menuContainer').down('.displayDocument').observe('click',_showDisplayDocument.bindAsEventListener($('menuContainer').down('.displayDocument')));
	    	Effect.Appear('folderData',{ duration: 4.0 });
	    	_loadUIContent(transport);
	    }
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
		Effect.Appear('documentContainer',{ duration: 2.0 });
		$('documentContainer').update(transport.responseText);
	}
	function _loadUIContent(response){
		$('folderData').setStyle({
    		display : 'none',
    		width: '90%',
    		height: 'auto',
    		paddingLeft:'4%',
    		paddingRight:'4%',
    		paddingBottom:'20px',
    		paddingTop:'20px'
    		
    		
    	});
    	$('folderList').childElements().forEach(function(r){r.remove();});
    	//$('folderList').innerHTML=transport.responseText;
    	//Effect.Appear('folderHeader',{ duration: 4.0 });
    	var json = response.responseJSON;
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
    	
	    Sortable.create('folderList', {
					tag: 'div'});
		
		$$('.result').forEach(function(t){
    		t.down('.folderResult').style.display='none';
    		t.down('.folder').observe('click',function(e){
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
	function _disableExistingFolder(){
  		$('existingFolder').value='';
  	}
  	function _disableFolder(){
  		$('folderName').value='';
  	}
	function _addDocument(e){
		debugger;
		var documentName = $('documentname');
		var user = $('user');
		var password = $('pass');
		var documentFile = $('documentFile');
		var contentType = $('contentType');
		var folderName = $('folderName');
		var existingFolder = $('existingFolder');
		if(user.value.length>0 && password.value.length>0 && documentFile.value.length>0 && contentType.value.length>0 && (folderName.value.length>0||existingFolder.value.length)){
			$('formDocument').reset();	
			Dialogs.load();
    		Dialogs.alert('Document Saved');
		}else{
			Dialogs.load();
    		Dialogs.alert('Some feilds are missing');
			e.stop();
		}
		
		
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
	.left1{
		width:300px;
	}
	.left2{
		width:734px;
	}
	.top1{
		height:120px;
	}
	#auth{
	margin-left: 550px; 
	margin-top: 200px;
	}
	#folderContent{
	display:none;
	}
	#documentContent{
	display:none;
	}
	.folder
	{
	padding:10px 0px; 
	background:gray;
	width:100%;
	border-radius:25px;
	margin-top: 2px;
	}
	#addDocument
	{
	padding-top:10px;
	padding-bottom:10px;
	background:#DDD;
	width:100%;
	text-align:center;
	border-radius:25px;
	margin-top: 2px;
	}
	#displayDocument
	{
	padding-top:10px;
	padding-bottom:10px;
	background:#DDD;
	width:100%;
	text-align:center;
	border-radius:25px;
	margin-top: 2px;
	}
	
	
	#folderHeader .folder
	{
	padding:10px 0px; 
	background:#DDD;
	width:100%;
	border-radius:25px;
	margin-top: 2px;
	}
	.document
	{
	padding-top: 10px;
	padding-left: 0px;
	background: gray;
	width: 80%;
	border-radius: 25px;
	margin-top: 2px;
	margin-left: 20%;
	}
	#documentHeader .document
	{
	padding-top: 10px;
	padding-left: 0px;
	background: #DDD;
	width: 80%;
	border-radius: 25px;
	margin-top: 2px;
	margin-left: 20%;
	}
	#documentContainer{
	padding-left:20px;
	width: 100%;
	height: 100%;
	background-color: gray;
	overflow: scroll;
	border-radius: 15px;
	}
	#menuContainer{
	width: 100%;
	height: 100%;
	background-color: gray;
	padding-left:10px;
	border-radius: 15px;
	padding-right:10px;
	padding-top:20px;
	}
	
</style>

<body id='content'>
		<div class="lm_container">
					<div class='lm_left left1'>
						<div id="menuContainer" class="menuContainer">	
								<div id="addDocument" class="addDocument">Add Document</div>
								<div id="displayDocument" class="displayDocument">Display Document</div>
						</div>
					</div>	
					<div  class='lm_left left2'>
						<div id='uiContent'>
								<form id='auth'>
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
															<td width="170px" style="text-align:center"><b>folderId</b></td>
															<td width="170px" style="text-align:center"><b>folderName</b></td>
															<td width="170px" style="text-align:center"><b>created</b></td>
															<td width="170px" style="text-align:center"><b>changed</b></td>
														</tr>
												</table>
										</div>
									</div>
									<div id="folderList" class="folderList">
										
									</div>
								</div>
								<div id="uploadDocument">
									<form id="formDocument" action="dm/addDocument" method="post" enctype="multipart/form-data" target="upload_target">
										<table border="0" cellspacing="0" cellpadding="0">
												<tr>
												  <td>
												  		<p>DocumentName</p>
												  </td>	
												  <td>
													<input id='documentname' name='documentname' type='text' autocorrect="off" autocapitalize="off" title="document name"/>
												  </td>
												  <td>
														<input id='user' name='username' type='hidden'/>
												  </td>
												  <td>
														<input id='pass' name='password' type='hidden'/>
												  </td>
												</tr>
												<tr>
												  <td>
												  		<p>Document</p>
												  </td>	
												  <td>
													<input id='documentFile' name='documentFile' type='file' title="documentFile"/>
												  </td>
												</tr>
												<tr>
												  <td>
												  		<p>Content Type</p>
												  </td>	
												  <td>
													<select  id="contentType" name='contentType'>
	  													<option value="PDF">PDF</option>
	  												</select>
												  </td>
												</tr>
												<tr>
												  <td>
												  		<p>FolderName</p>
												  </td>	
												  <td>
													<input id='folderName' name='folderName' type='text' title="folderName"/>
												  </td>
												  <td>
												  		<p>ExistingFolder</p>
												  </td>	
												  <td>
												  	<select id="existingFolder" name='existingFolder'>
	  													<option value="folder1">folder1</option>
	  												</select>
												  </td>
												</tr>
												<tr>
												 <td>
													<button id='save' type='submit' class='primary'>
														Save
													</button>
												  </td>
												</tr>
											</table>
										</form>
										<iframe id="upload_target" name="upload_target" style="width:0;height:0;border:0px solid #fff;"></iframe>                 
								</div>
								
						</div>	
					</div>
					<div class='lm_top top1'>
						<h1 align="center"> Document Management</h1>
					</div>	
					
					<div class='lm_center'>
						<div id="documentContainer" class="documentContainer">	
							Document Container
						</div>
					</div>
						
		</div>
		<div id='folderContent'>
			<div class='result'>
					<div class='folder'>
						<table  border="0">
								<tr>
									<td class='folderId' width="170px" style="text-align:center"></td>
									<td class='folderName' width="170px" style="text-align:center"></td>
									<td class='created' width="170px" style="text-align:center"></td>
									<td class='changed' width="170px" style="text-align:center"></td>
								</tr>
						</table>
					</div>
					<div class='folderResult'>
									<div id="documentHeader">
											<div class='document'>
												<table  border="0">
														<tr>
															<td width="170px" style="text-align:center"><b>documentId</b></td>
															<td width="170px" style="text-align:center"><b>documentName</b></td>
															<td width="170px" style="text-align:center"><b>contentType</b></td>
															<td width="170px" style="text-align:center"><b>created</b></td>
															<td width="170px" style="text-align:center"><b>changed</b></td>
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
										<td width="170px" class='documentId' style="text-align:center"></td>
										<td width="170px" class='documentName' style="text-align:center"></td>
										<td width="170px" class='contentType' style="text-align:center"></td>
										<td width="170px" class='created' style="text-align:center"></td>
										<td width="170px" class='changed' style="text-align:center"></td>
									</tr>
							</table>
				</div>
			</div>	
		</div>

</body>