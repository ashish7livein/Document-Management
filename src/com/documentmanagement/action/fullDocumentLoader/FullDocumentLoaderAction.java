package com.documentmanagement.action.fullDocumentLoader;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;

import com.documentmanagement.action.fullDocumentLoader.service.DocumentProjectionHandler;
import com.documentmanagement.action.util.DMActionSupport;
import com.documentmanagement.model.documents.ContentTypeEnum;
import com.documentmanagement.model.documents.DocumentDTO;
import com.documentmanagement.model.users.UserDTO;
import com.documentmanagement.service.documents.DocumentDAO;
import com.documentmanagement.service.users.UserDAO;
import com.documentmanagement.view.fullDocumentLoader.FullDocumentLoaderView;

public class FullDocumentLoaderAction extends DMActionSupport<FullDocumentLoaderView> {

	private static final long serialVersionUID = 1L;
	private DocumentDAO documentDAO;
	private DocumentProjectionHandler documentProjectionHandler;
	private UserDAO userDAO;
	public String execute(){
		final String default_directory="C:\\DocumentManagement";
		documentDAO.setProjectionHandler(documentProjectionHandler);
		DocumentDTO document = documentDAO.getbyId(view.getDocumentId());
		UserDTO user = userDAO.getByUserName(view.getUsername());
		view.setContentType(document.getContentType().getMimeType());
		File userFolder = new File(default_directory,user.getUsername());
		File folder = new File(userFolder,document.getFolder().getFoldername());
		File documentFile = new File(folder,document.getDocumentName());
		try {
			view.setInputStream(new FileInputStream(documentFile));
			view.setContentLength(documentFile.length());
		
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	public void setDocumentDAO(DocumentDAO documentDAO) {
		this.documentDAO = documentDAO;
	}
	public void setDocumentProjectionHandler(
			DocumentProjectionHandler documentProjectionHandler) {
		this.documentProjectionHandler = documentProjectionHandler;
	}
	public void setUserDAO(UserDAO userDAO) {
		this.userDAO = userDAO;
	}
	
	
}
