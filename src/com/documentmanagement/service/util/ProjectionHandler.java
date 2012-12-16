package com.documentmanagement.service.util;

import org.hibernate.criterion.DetachedCriteria;

public interface ProjectionHandler {
	public DetachedCriteria getProjection(DetachedCriteria criteria);
}
