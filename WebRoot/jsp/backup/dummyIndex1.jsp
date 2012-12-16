<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>

<title>Login</title>
<jsp:include page="../script.jsp" flush="true" />
<style>
	<jsp:include page="../../css/proto.menu.0.6.css" flush="true" />
	<jsp:include page="../../css/dialog.css" flush="true" />
	#uiContent{
	position: absolute;
	width:100%;
	height:100%;
	}
	.folder
	{
	padding:10px 40px; 
	background:#dddddd;
	width:100%;
	border-radius:25px;
	margin-top: 2px;
	}
	.document
	{
	padding: 10px 40px;
	background: #DDD;
	width: 70%;
	border-radius: 25px;
	margin-top: 2px;
	margin-left: 30%;
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
								<div id="folderList">
									
									<div class='result'>
										<div class='folder'>Folder1</div>
										<div class='folderResult'>
											<div class='document'>This is a document</div>
											<div class='document'>This is a document</div>
											<div class='document'>This is a document</div>
											<div class='document'>This is a document</div>
										</div>
									</div>
									<div class='result'>
										<div class='folder'>Folder2</div>
										<div class='folderResult'>
											<div class='document'>This is a document</div>
											<div class='document'>This is a document</div>
											<div class='document'>This is a document</div>
											<div class='document'>This is a document</div>
										</div>
									</div>
									<div class='result'>
										<div class='folder'>Folder3</div>
										<div class='folderResult'>
											<div class='document'>This is a document</div>
											<div class='document'>This is a document</div>
											<div class='document'>This is a document</div>
											<div class='document'>This is a document</div>
										</div>
									</div>
									<div class='result'>
										<div class='folder'>Folder4</div>
										<div class='folderResult'>
											<div class='document'>This is a document</div>
											<div class='document'>This is a document</div>
											<div class='document'>This is a document</div>
											<div class='document'>This is a document</div>
										</div>
									</div>
									
								</div>
								
							</div>	
					</div>
					<div class='lm_top'>
						<h1 align="center"> Document Management</h1>
					</div>	
		
		</div>

<script type="text/javascript">
$('auth').observe('submit', this._loginHandler.bindAsEventListener(this));
$('folderList').setStyle({
    		display : 'none'
    		});
	function _loginHandler  (e) {
		this._login();
		e.stop();
	}
	
	function _login () {
		new Ajax.Request('auth/login', {
			parameters: {
				username: $('username').value,
				password: $('password').value
			},
			onSuccess: this._loginSuccessHandler.bind(this),
			onFailure: this._loginUnauthorized.bind(this)
		});
	}
	
    function _loginSuccessHandler (transport) {
    	debugger;
    	if(transport.responseText=="Failure"){
    		Dialogs.load();
    		Dialogs.alert('Inavlid Username/Password');
    	}else{
    	Effect.Fold('auth',{ duration: 4.0 });
    	$('folderList').setStyle({
    		display : 'none',
    		width: '60%',
    		height: '100%',
    		paddingLeft:'20%',
    		paddingRight:'20%'
    	});
    	
    	//$('folderList').innerHTML=transport.responseText;
    	
    	Effect.Appear('folderList',{ duration: 4.0 });
    	Sortable.create('folderList', {
				tag: 'div'});
    	
    	}
    	$$('.result').forEach(function(t){
    		t.down('.folderResult').style.display='none';
    		t.observe('click',function(){
    			this.siblings().forEach(function(s){
    				s.down('.folderResult').style.display='none';
    				s.down('.folder').setStyle({
    					backgroundColor: 'gray'
    				});
    			});
    			this.down('.folder').setStyle({
    				backgroundColor: 'wheat'
    			});
    			var folderResult = this.down('.folderResult');
    			Effect.Appear(folderResult,{ duration: 3.0 });
    			Sortable.create(folderResult, {
				tag: 'div'});
    	
    		});
    	});
	}
	
	function _loginUnauthorized(transport) {
		
	}

</script>

</body>