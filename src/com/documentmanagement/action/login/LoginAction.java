package com.documentmanagement.action.login;

import java.util.List;
import java.util.Set;

import javax.annotation.PostConstruct;

import com.documentmanagement.action.util.DMActionSupport;
import com.documentmanagement.model.folders.FolderDTO;
import com.documentmanagement.model.users.UserDTO;
import com.documentmanagement.service.folders.FolderDAO;
import com.documentmanagement.service.users.UserDAO;
import com.documentmanagement.view.login.LoginView;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class LoginAction extends DMActionSupport<LoginView> {

	private static final long serialVersionUID = 1L;
	private UserDAO userDAO;
	private FolderDAO folderDAO;
	public String execute(){
		
		UserDTO user = userDAO.getByUserNameAndPassWord(view.getUsername(), view.getPassword());
		if(user==null){
			return "failure";
		}
		view.setFolders(user.getFolders());
		return SUCCESS;
	}

	
	public void setUserDAO(UserDAO userDAO) {
		this.userDAO = userDAO;
	}


	public void setFolderDAO(FolderDAO folderDAO) {
		this.folderDAO = folderDAO;
	}

}
