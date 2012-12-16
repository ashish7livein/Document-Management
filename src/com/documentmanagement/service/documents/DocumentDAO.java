package com.documentmanagement.service.documents;

import java.util.List;

import com.documentmanagement.model.documents.DocumentDTO;
import com.documentmanagement.service.GenericHibernateDAO;

public interface DocumentDAO extends GenericHibernateDAO<DocumentDTO>{

	public List<DocumentDTO> findAll();
	public DocumentDTO save(DocumentDTO document);
	public DocumentDTO getbyId(Integer id);
	public DocumentDTO getbyName(String name);
}
