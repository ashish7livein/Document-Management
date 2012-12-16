package com.documentmanagement.action.addDcoument.service;

import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

public class FolderProjectionHandlerImpl implements FolderProjectionHandler {
	private String userName;
	@Override
	public DetachedCriteria getProjection(DetachedCriteria criteria) {
		// TODO Auto-generated method stub
		criteria.createAlias("user", "user", CriteriaSpecification.LEFT_JOIN);
		criteria.add(Restrictions.eq("user.username", userName));
		return criteria;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}

}
