package com.documentmanagement.action.loadDocument;

import com.documentmanagement.action.util.DMActionSupport;
import com.documentmanagement.model.documents.DocumentDTO;
import com.documentmanagement.service.documents.DocumentDAO;
import com.documentmanagement.view.loadDocument.LoadDocumentView;

public class LoadDocumentAction extends DMActionSupport<LoadDocumentView>{

	private static final long serialVersionUID = 1L;
	private DocumentDAO documentDAO;
	public String execute(){
		DocumentDTO document = documentDAO.getbyId(view.getDocumentId());
		String resultString = document.getContentType().getResultString();
		return resultString;
	}
	public void setDocumentDAO(DocumentDAO documentDAO) {
		this.documentDAO = documentDAO;
	}
	
}
