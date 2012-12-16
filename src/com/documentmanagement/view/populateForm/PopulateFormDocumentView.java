package com.documentmanagement.view.populateForm;

import java.util.Set;

import com.documentmanagement.model.folders.FolderDTO;

public class PopulateFormDocumentView {

	
	private String username;
	private String password;
	private Set<FolderDTO> folders;
	private Set<String> contentTypes;
	public void setPassword(String password) {
		this.password = password;
	}
	public String getPassword() {
		return password;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getUsername() {
		return username;
	}
	public void setFolders(Set<FolderDTO> folders) {
		this.folders = folders;
	}
	public Set<FolderDTO> getFolders() {
		return folders;
	}
	public void setContentTypes(Set<String> contentTypes) {
		this.contentTypes = contentTypes;
	}
	public Set<String> getContentTypes() {
		return contentTypes;
	}
	
	
}
