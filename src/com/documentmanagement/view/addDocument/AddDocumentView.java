package com.documentmanagement.view.addDocument;

import java.io.File;

public class AddDocumentView {
	 private File documentFile;
     private String contentType;
     private String filename;
     private String documentname;
     private String folderName;
     private String existingFolder;
     private String username;
     private String password;
     
	public String getContentType() {
		return contentType;
	}
	public void setContentType(String contentType) {
		this.contentType = contentType;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public void setDocumentFile(File documentFile) {
		this.documentFile = documentFile;
	}
	public File getDocumentFile() {
		return documentFile;
	}
	public void setDocumentname(String documentname) {
		this.documentname = documentname;
	}
	public String getDocumentname() {
		return documentname;
	}
	public void setExistingFolder(String existingFolder) {
		this.existingFolder = existingFolder;
	}
	public String getExistingFolder() {
		return existingFolder;
	}
	public void setFolderName(String folderName) {
		this.folderName = folderName;
	}
	public String getFolderName() {
		return folderName;
	}
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
	
	
	
     
     
}
