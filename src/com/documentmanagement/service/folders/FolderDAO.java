package com.documentmanagement.service.folders;

import java.util.List;

import com.documentmanagement.model.folders.FolderDTO;
import com.documentmanagement.service.GenericHibernateDAO;

public interface FolderDAO  extends GenericHibernateDAO<FolderDTO>{

	public FolderDTO save(FolderDTO folder);
	public List<FolderDTO> findAll();
	public FolderDTO getById(Integer id);
	public FolderDTO getByName(String name);
	
}
