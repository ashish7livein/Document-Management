package com.documentmanagement.action.addDcoument;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.channels.FileChannel;
import java.util.Set;
import java.util.UUID;


import com.documentmanagement.action.addDcoument.service.DocumentProjectionHandler;
import com.documentmanagement.action.addDcoument.service.FolderProjectionHandler;
import com.documentmanagement.action.util.DMActionSupport;
import com.documentmanagement.model.documents.ContentTypeEnum;
import com.documentmanagement.model.documents.DocumentDTO;
import com.documentmanagement.model.folders.FolderDTO;
import com.documentmanagement.model.users.UserDTO;
import com.documentmanagement.service.documents.DocumentDAO;
import com.documentmanagement.service.folders.FolderDAO;
import com.documentmanagement.service.users.UserDAO;
import com.documentmanagement.view.addDocument.AddDocumentView;

public class AddDocumentAction extends DMActionSupport<AddDocumentView> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private FolderDAO folderDAO;
	private DocumentDAO documentDAO;
	private UserDAO userDAO;
	private FolderProjectionHandler folderProjectionHandler;
	private DocumentProjectionHandler documentProjectionHandler;
	public String execute() throws IOException{
		
		final String default_directory="C:\\DocumentManagement";
		String folderName;
		if(view.getFolderName().length()>0){
			folderName = view.getFolderName();
		}
		else{
			folderName = view.getExistingFolder();
		}
			
		UserDTO user = userDAO.getByUserNameAndPassWord(view.getUsername(), view.getPassword());
		folderProjectionHandler.setUserName(view.getUsername());
		folderDAO.setProjectionHandler(folderProjectionHandler);
		FolderDTO folder = folderDAO.getByName(folderName);
		documentProjectionHandler.setFolderName(folderName);
		documentDAO.setProjectionHandler(documentProjectionHandler);
		DocumentDTO checkDocument = documentDAO.getbyName(view.getDocumentname());
		documentDAO.setProjectionHandler(null);

		if(folder!=null){
			DocumentDTO document = new DocumentDTO();
			document.setContentType(ContentTypeEnum.valueOf(view.getContentType()));
			document.setAbstraction("fileSystem");
			document.setDocumentName(view.getDocumentname());
			if(checkDocument!=null){
				UUID unique = UUID.randomUUID();	
				document.setDocumentName(unique.toString());
				view.setDocumentname(unique.toString());
			}
			document.setFolder(folder);
			documentDAO.save(document);
		}else{
			folderDAO.setProjectionHandler(null);
			FolderDTO newFolder = new FolderDTO();
			newFolder.setFoldername(folderName);
			newFolder.setUser(user);
			newFolder = folderDAO.save(newFolder);
			DocumentDTO document = new DocumentDTO();
			document.setContentType(ContentTypeEnum.valueOf(view.getContentType()));
			document.setAbstraction("fileSystem");
			document.setDocumentName(view.getDocumentname());
			document.setFolder(newFolder);
			documentDAO.save(document);
		}
		
		FileChannel source = null;
	    FileChannel destination = null;
	    try {
	        source = new FileInputStream(view.getDocumentFile()).getChannel();
	        File userFolder = new File(default_directory,user.getUsername());
	        if(!userFolder.exists()){
	        	userFolder.mkdirs();
	        }
	        File folderDirectory =new  File(userFolder,folderName);
	        if(!folderDirectory.exists()){
	        	folderDirectory.mkdirs();
	        }
	        destination = new FileOutputStream(new File(folderDirectory,view.getDocumentname())).getChannel();
	        destination.transferFrom(source, 0, source.size());
	    }
	    finally {
	        if(source != null) {
	            source.close();
	        }
	        if(destination != null) {
	            destination.close();
	        }
	    }
		
		return SUCCESS;
	}
	public void setDocumentDAO(DocumentDAO documentDAO) {
		this.documentDAO = documentDAO;
	}
	public void setFolderDAO(FolderDAO folderDAO) {
		this.folderDAO = folderDAO;
	}
	public void setUserDAO(UserDAO userDAO) {
		this.userDAO = userDAO;
	}
	public void setFolderProjectionHandler(
			FolderProjectionHandler folderProjectionHandler) {
		this.folderProjectionHandler = folderProjectionHandler;
	}
	public void setDocumentProjectionHandler(
			DocumentProjectionHandler documentProjectionHandler) {
		this.documentProjectionHandler = documentProjectionHandler;
	}
	
	
}
