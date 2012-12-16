package com.documentmanagement.action.document;

import java.util.List;

import com.documentmanagement.action.document.service.DocumentProjectionHandler;
import com.documentmanagement.action.util.DMActionSupport;
import com.documentmanagement.model.documents.DocumentDTO;
import com.documentmanagement.service.documents.DocumentDAO;
import com.documentmanagement.view.document.DocumentView;

public class DocumentAction extends DMActionSupport<DocumentView> {
	
	private static final long serialVersionUID = 1L;
	private DocumentDAO documentDAO;
	private DocumentProjectionHandler documentProjectionHandler;
	public String execute(){
		documentProjectionHandler.setFolderId(view.getFolderId());
		documentProjectionHandler.setFolderName(view.getFolderName());
		
		documentDAO.setProjectionHandler(documentProjectionHandler);
		
		List<DocumentDTO> documents = documentDAO.findAll();
		
		if(documents!=null){
			view.setDocuments(documents);
		}
		return SUCCESS;
	}
	
	

	public void setDocumentProjectionHandler(
			DocumentProjectionHandler documentProjectionHandler) {
		this.documentProjectionHandler = documentProjectionHandler;
	}



	public void setDocumentDAO(DocumentDAO documentDAO) {
		this.documentDAO = documentDAO;
	}

}
