<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<title>Document Management</title>
<jsp:include page="script.jsp" flush="true" />

<script>

document.observe("dom:loaded", function() {
         
  	
	$('auth').observe('submit', _loginHandler.bindAsEventListener(this));
	$('folderData').setStyle({
	    		display : 'none'
	});
	$('documentContainer').style.display='none';
	$('uploadDocument').setStyle({
    		display : 'none',
    		width: '80%',
    		height: 'auto',
    		paddingLeft:'10%',
    		paddingRight:'10%',
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
				username: $('menuContainer').retrieve('username'),
				password: $('menuContainer').retrieve('password')
			},
			onSuccess: _loginSuccessHandler.bind(this)
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
	    	//_populateFormDocument();
	    	_loadUIContent(transport);
	    }
	}
	function _populateFormDocument(){
		/*new Ajax.Request('',{
			onSuccess: function(transport){
					debugger;
			}
			
		});*/
	}
	function _showCreateDocument(){
		$('uploadDocument').childElements().forEach(function(f){
				f.remove();
		});
		var uploadFormContent = $('uploadFormContent').down().clone(true);
		$('uploadDocument').appendChild(uploadFormContent);
		$('uploadDocument').down('.user').value = $('menuContainer').retrieve('username');
		$('uploadDocument').down('.pass').value = $('menuContainer').retrieve('password');
		if($('folderData').style.display!= 'none'){
			Effect.SlideUp('folderData',{ duration : 1.0 });
		}
		if($('documentContainer').style.display!= 'none'){
			Effect.SlideUp('documentContainer',{ duration : 1.0 });
		}
		debugger;
		new Ajax.Request('dm/populateFormDocument',{
			parameters: {
				username: $('menuContainer').retrieve('username'),
				password: $('menuContainer').retrieve('password')
			},
			onSuccess: function(transport){
				var jsonContentTypes = transport.responseJSON.contentTypes;
				for(var i=0;i < jsonContentTypes.length;i++ ){
       		   		$('uploadDocument').down('.contentType').options[i]= new Option(jsonContentTypes[i],jsonContentTypes[i]);
          		}
          		var jsonExistingFolders = transport.responseJSON.folders;
          		for(var i=0;i < jsonExistingFolders.length;i++ ){
       		   		$('uploadDocument').down('.existingFolder').options[i]= new Option(jsonExistingFolders[i],jsonExistingFolders[i]);
          		}
			
			}
		});
		
		$('uploadDocument').down('.folderName').observe('click', function(){
			$('uploadDocument').down('.existingFolder').value="";
		});
		$('uploadDocument').down('.existingFolder').observe('click',  function(){
			$('uploadDocument').down('.folderName').value="";
		});
	
		$('uploadDocument').down().observe('submit',function(e){
			$('upload_target').childElements().forEach(function(f){
				f.remove();
			});
			var documentName = this.down('.documentname');
			var user = this.down('.user');
			var password = this.down('.pass');
			var documentFile = this.down('.documentFile');
			var contentType = this.down('.contentType');
			var folderName = this.down('.folderName');
			var existingFolder = this.down('.existingFolder');
			if(user.value.length>0 && password.value.length>0 && documentFile.value.length>0 && contentType.value.length>0 && (folderName.value.length>0||existingFolder.value.length)){
					
				Dialogs.load();
	    		Dialogs.alert('Document is being Saved');
			}else{
				
				Dialogs.load();
	    		Dialogs.alert('Some feilds are missing');
				e.stop();
			}
		});
		
		
		Effect.Appear('uploadDocument',{ duration : 3.0 });
		this.style.backgroundColor='wheat';
		this.siblings()[0].style.backgroundColor='#DDD';
	}
	function _showDisplayDocument(){
		$('uploadDocument').childElements().forEach(function(f){
				f.remove();
		});
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
	function _documentLoader(transport){
		var documentJson = transport.responseJSON;
		var results = documentJson.results;
		this.parentElement.down('.documentList').childElements().forEach(function(f){
			f.remove();
		});
		results.each(function(o){
			var documentResult =$('documentContent').down().clone(true);
    		documentResult.down('.documentName').update(o.documentName);
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
						documentId: this.retrieve('documentId'),
						username: $('menuContainer').retrieve('username')
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
    		width: '80%',
    		height: 'auto',
    		paddingLeft:'10%',
    		paddingRight:'10%',
    		paddingBottom:'20px',
    		paddingTop:'20px'
    		
    		
    	});
    	$('folderList').childElements().forEach(function(r){r.remove();});
    	//$('folderList').innerHTML=transport.responseText;
    	//Effect.Appear('folderHeader',{ duration: 4.0 });
    	var json = response.responseJSON;
    	json.results.forEach(function(o){
    		var result = $('folderContent').down().clone(true);
    		result.down('.folderName').update(o.folderName);
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
	
});

</script>
<style>
	<jsp:include page="../css/proto.menu.0.6.css" flush="true" />
	<jsp:include page="../css/dialog.css" flush="true" />
	

	#uiContent{
	position: absolute;
	width:100%;
	height:100%;
	}
	.left1{
		width:300px;
	}
	.left2{
		width:600px;
	}
	.top1{
		height:120px;
	}
	#auth{
	padding-left: 44%;
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
	width:40%;
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
	width:40%;
	border-radius:25px;
	margin-top: 2px;
	}
	.document
	{
	padding-top: 10px;
	padding-left: 0px;
	background: gray;
	width: 50%;
	border-radius: 25px;
	margin-top: 2px;
	margin-left: 20%;
	}
	#documentHeader .document
	{
	padding-top: 10px;
	padding-left: 0px;
	background: #DDD;
	width: 50%;
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
								<div id="folderData">
									<div id="folderHeader">
											<div class='folder'>
												<table  border="0">
														<tr>
															<td width="170px" style="text-align:center"><b>folders</b></td>
														</tr>
												</table>
										</div>
									</div>
									<div id="folderList" class="folderList">
										
									</div>
								</div>
								<div id="uploadDocument">
									
															      
								</div>
								
						</div>	
					</div>
					<div class='lm_top top1'>
						<h1 align="center"> Document Management</h1>
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
									<td class='folderName' width="170px" style="text-align:center"></td>
								</tr>
						</table>
					</div>
					<div class='folderResult'>
									<div id="documentHeader">
											<div class='document'>
												<table  border="0">
														<tr>
															<td width="170px" style="text-align:center"><b>document</b></td>
															<td width="170px" style="text-align:center"><b>contentType</b></td>
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
										<td width="170px" class='documentName' style="text-align:center"></td>
										<td width="170px" class='contentType' style="text-align:center"></td>
									</tr>
							</table>
				</div>
			</div>	
		</div>
		<div id='uploadFormContent' style="display:none;">
			<s:form action="dm/addDocument" method="post" enctype="multipart/form-data" target="upload_target">
				<table border="0" cellspacing="0" cellpadding="0">
						<tr>
						  <td>
						  		<p>DocumentName</p>
						  </td>	
						  <td>
							<input id='documentname' class='documentname' name='documentname' type='text' autocorrect="off" autocapitalize="off" title="document name"/>
						  </td>
						  <td>
								<input id='user' class='user' name='username' type='hidden'/>
						  </td>
						  <td>
								<input id='pass' class='pass' name='password' type='hidden'/>
						  </td>
						</tr>
						<tr>
						  <td>
						  		<p>Document</p>
						  </td>	
						  <td>
							<input id='documentFile' class='documentFile' name='documentFile' type='file' title="documentFile"/>
						  </td>
						</tr>
						<tr>
						  <td>
						  		<p>Content Type</p>
						  </td>	
						  <td>
							<select  id="contentType" class='contentType' name='contentType'>
										<option value="PDF">PDF</option>
							</select>
						  </td>
						</tr>
						<tr>
						  <td>
						  		<p>FolderName</p>
						  </td>	
						  <td>
							<input id='folderName' class='folderName' name='folderName' type='text' title="folderName"/>
						  </td>
						  <td>
						  		<p>ExistingFolder</p>
						  </td>	
						  <td>
						  	<select id="existingFolder"  class='existingFolder' name='existingFolder'>
										
									</select>
						  </td>
						</tr>
						<tr>
						 <td>
							<button id='save' type='submit' class='save'>
								Save
							</button>
						  </td>
						</tr>
					</table>
			</s:form>
			          
		</div>
		<iframe id="upload_target" name="upload_target" style="width:0;height:0;border:0px solid #fff;display:none;"></iframe> 
</body>