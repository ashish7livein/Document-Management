package com.documentmanagement.action.addDcoument.service;

import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

public class DocumentProjectionHandlerImpl implements DocumentProjectionHandler{

	private String folderName;
	@Override
	public DetachedCriteria getProjection(DetachedCriteria criteria) {
		// TODO Auto-generated method stub
		criteria.createAlias("folder", "f", CriteriaSpecification.LEFT_JOIN);
		criteria.add(Restrictions.eq("f.foldername", folderName));
		return criteria;
	}
	public void setFolderName(String folderName) {
		this.folderName = folderName;
	}

}
