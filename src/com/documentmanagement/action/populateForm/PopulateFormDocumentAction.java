package com.documentmanagement.action.populateForm;

import java.util.HashSet;
import java.util.Set;

import com.documentmanagement.action.util.DMActionSupport;
import com.documentmanagement.model.documents.ContentTypeEnum;
import com.documentmanagement.model.users.UserDTO;
import com.documentmanagement.service.users.UserDAO;
import com.documentmanagement.view.populateForm.PopulateFormDocumentView;

public class PopulateFormDocumentAction extends DMActionSupport<PopulateFormDocumentView>{
	private static final long serialVersionUID = 1L;
	private UserDAO userDAO;
	public String execute(){
		UserDTO user = userDAO.getByUserNameAndPassWord(view.getUsername(), view.getPassword());
		view.setFolders(user.getFolders());
		Set<String> contentTypes = new HashSet<String>();
		for (ContentTypeEnum content : ContentTypeEnum.values()) {
			contentTypes.add(content.getId());
		}
		view.setContentTypes(contentTypes);
		return SUCCESS;
		
	}
	public void setUserDAO(UserDAO userDAO) {
		this.userDAO = userDAO;
	}
	public UserDAO getUserDAO() {
		return userDAO;
	}
	
	
}
