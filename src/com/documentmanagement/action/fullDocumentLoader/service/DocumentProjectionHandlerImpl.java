package com.documentmanagement.action.fullDocumentLoader.service;

import org.hibernate.FetchMode;
import org.hibernate.criterion.DetachedCriteria;

public class DocumentProjectionHandlerImpl implements DocumentProjectionHandler{

	@Override
	public DetachedCriteria getProjection(DetachedCriteria criteria) {
		criteria.setFetchMode("folder", FetchMode.JOIN);
		return criteria;
	}

}
