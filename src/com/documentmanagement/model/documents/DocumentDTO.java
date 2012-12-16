package com.documentmanagement.model.documents;

import java.util.Date;

import com.documentmanagement.model.folders.FolderDTO;

public class DocumentDTO {

	private Integer id;
	private Date created;
	private Date changed;
	private String documentName;
	private ContentTypeEnum contentType;
	private FolderDTO folder;
	private String abstraction;
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
	public String getDocumentName() {
		return documentName;
	}
	public void setDocumentName(String documentName) {
		this.documentName = documentName;
	}
	public ContentTypeEnum getContentType() {
		return contentType;
	}
	public void setContentType(ContentTypeEnum contentType) {
		this.contentType = contentType;
	}
	public FolderDTO getFolder() {
		return folder;
	}
	public void setFolder(FolderDTO folder) {
		this.folder = folder;
	}
	public String getAbstraction() {
		return abstraction;
	}
	public void setAbstraction(String abstraction) {
		this.abstraction = abstraction;
	}
	
	
}
