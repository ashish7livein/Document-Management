package com.documentmanagement.service;

import com.documentmanagement.service.util.ProjectionHandler;


public interface GenericHibernateDAO<T> {
	public void setProjectionHandler(ProjectionHandler projectionHandler);
}
