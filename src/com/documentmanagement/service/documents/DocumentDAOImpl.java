package com.documentmanagement.service.documents;


import org.hibernate.criterion.Restrictions;

import com.documentmanagement.model.documents.DocumentDTO;
import com.documentmanagement.service.GenericHibernateDAOAbs;

public class DocumentDAOImpl extends GenericHibernateDAOAbs<DocumentDTO> implements DocumentDAO{

	public DocumentDAOImpl() {
		super(DocumentDTO.class);
	}

	@Override
	public DocumentDTO getbyId(Integer id) {
		return getByCriteria(getDetachedCriteria(Restrictions.eq("id", id)));
	}

	@Override
	public DocumentDTO getbyName(String name) {
		return getByCriteria(getDetachedCriteria(Restrictions.eq("documentName", name)));
	}
	
}
