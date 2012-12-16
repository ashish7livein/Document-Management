package com.documentmanagement.model.users;

import java.util.Date;
import java.util.Set;

import com.documentmanagement.model.folders.FolderDTO;

public class UserDTO {

	private Integer id;
	private Date created;
	private Date changed;
	private String password;
	private String username;
	private String lastname;
	private String firstname;
	private String occupation;
	private String email;
	private Set<FolderDTO> folders;
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
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getLastname() {
		return lastname;
	}
	public void setLastname(String lastname) {
		this.lastname = lastname;
	}
	public String getFirstname() {
		return firstname;
	}
	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}
	public String getOccupation() {
		return occupation;
	}
	public void setOccupation(String occupation) {
		this.occupation = occupation;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Set<FolderDTO> getFolders() {
		return folders;
	}
	public void setFolders(Set<FolderDTO> folders) {
		this.folders = folders;
	}
	
	
	
	
}
