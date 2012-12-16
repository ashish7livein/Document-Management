package com.documentmanagement.action.document.service;

import com.documentmanagement.service.util.ProjectionHandler;

public interface DocumentProjectionHandler extends ProjectionHandler {
	public void setFolderId(Integer folderId);
	public void setFolderName(String folderName) ;
}
