package com.documentmanagement.model.folders;

import java.util.Date;
import java.util.Set;

import com.documentmanagement.model.documents.DocumentDTO;
import com.documentmanagement.model.users.UserDTO;

public class FolderDTO {

	private Integer id;
	private Date created;
	private Date changed;
	private String foldername;
	private UserDTO user;
	private Set<DocumentDTO> documents;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Date getCreated() {
		return created;
	}
	public void setCreated(Date created) {
		this.created = created;
	}
	public Date getChanged() {
		return changed;
	}
	public void setChanged(Date changed) {
		this.changed = changed;
	}
	public String getFoldername() {
		return foldername;
	}
	public void setFoldername(String foldername) {
		this.foldername = foldername;
	}
	public UserDTO getUser() {
		return user;
	}
	public void setUser(UserDTO user) {
		this.user = user;
	}
	public void setDocuments(Set<DocumentDTO> documents) {
		this.documents = documents;
	}
	public Set<DocumentDTO> getDocuments() {
		return documents;
	}
	
	
}
