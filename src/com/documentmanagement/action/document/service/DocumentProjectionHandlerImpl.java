package com.documentmanagement.action.document.service;

import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

public class DocumentProjectionHandlerImpl implements DocumentProjectionHandler {
	private Integer folderId;
	private String folderName;

	
	public void setFolderId(Integer folderId) {
		this.folderId = folderId;
	}
	public void setFolderName(String folderName) {
		this.folderName = folderName;
	}
	@Override
	public DetachedCriteria getProjection(DetachedCriteria criteria) {
		criteria.createAlias("folder", "f", CriteriaSpecification.LEFT_JOIN);
		
		criteria.add(Restrictions.eq("f.id", folderId));
		criteria.add(Restrictions.eq("f.foldername", folderName));
		return criteria;
	}

}
