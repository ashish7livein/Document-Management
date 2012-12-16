package com.documentmanagement.service.folders;

import org.hibernate.criterion.Restrictions;

import com.documentmanagement.model.folders.FolderDTO;
import com.documentmanagement.service.GenericHibernateDAOAbs;

public class FolderDAOImpl extends GenericHibernateDAOAbs<FolderDTO> implements FolderDAO{

	public FolderDAOImpl() {
		super(FolderDTO.class);
	}

	@Override
	public FolderDTO getById(Integer id) {
		return getByCriteria(getDetachedCriteria(Restrictions.eq("id", id)));
	}

	@Override
	public FolderDTO getByName(String name) {
		return getByCriteria(getDetachedCriteria(Restrictions.eq("foldername", name)));
	}
	
	

}
