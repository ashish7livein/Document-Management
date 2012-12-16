package com.documentmanagement.view.login;

import java.util.Set;

import com.documentmanagement.model.folders.FolderDTO;

public class LoginView {

	private String username;
	private String password;
	private Set<FolderDTO> folders;
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public void setFolders(Set<FolderDTO> folders) {
		this.folders = folders;
	}
	public Set<FolderDTO> getFolders() {
		return folders;
	}
	
}
