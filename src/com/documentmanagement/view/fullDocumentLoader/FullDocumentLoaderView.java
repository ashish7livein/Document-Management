package com.documentmanagement.view.fullDocumentLoader;

import java.io.InputStream;

public class FullDocumentLoaderView {

	private Integer documentId;
	private String contentType;
	private Long contentLength;
	private InputStream inputStream;
	private Integer bufferSize;
	private Boolean allowCaching;
	private String contentCharSet;
	private String filePath;
	private String controls;
	private String username;
	public String getContentType() {
		return contentType;
	}
	public void setContentType(String contentType) {
		this.contentType = contentType;
	}
	public Long getContentLength() {
		return contentLength;
	}
	public void setContentLength(Long contentLength) {
		this.contentLength = contentLength;
	}
	public InputStream getInputStream() {
		return inputStream;
	}
	public void setInputStream(InputStream inputStream) {
		this.inputStream = inputStream;
	}
	public Integer getBufferSize() {
		return bufferSize;
	}
	public void setBufferSize(Integer bufferSize) {
		this.bufferSize = bufferSize;
	}
	public Boolean getAllowCaching() {
		return allowCaching;
	}
	public void setAllowCaching(Boolean allowCaching) {
		this.allowCaching = allowCaching;
	}
	public String getContentCharSet() {
		return contentCharSet;
	}
	public void setContentCharSet(String contentCharSet) {
		this.contentCharSet = contentCharSet;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getControls() {
		return controls;
	}
	public void setControls(String controls) {
		this.controls = controls;
	}
	public void setDocumentId(Integer documentId) {
		this.documentId = documentId;
	}
	public Integer getDocumentId() {
		return documentId;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getUsername() {
		return username;
	}
	
}
