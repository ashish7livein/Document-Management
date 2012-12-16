package com.documentmanagement.view.document;

import java.util.List;

import com.documentmanagement.model.documents.DocumentDTO;

public class DocumentView {

	private Integer folderId;
	private String folderName;
	private List<DocumentDTO> documents;
	public Integer getFolderId() {
		return folderId;
	}
	public void setFolderId(Integer folderId) {
		this.folderId = folderId;
	}
	public String getFolderName() {
		return folderName;
	}
	public void setFolderName(String folderName) {
		this.folderName = folderName;
	}
	public void setDocuments(List<DocumentDTO> documents) {
		this.documents = documents;
	}
	public List<DocumentDTO> getDocuments() {
		return documents;
	}
	
}
