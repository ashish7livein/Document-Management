package com.documentmanagement.service.users;

import java.util.Collection;
import java.util.List;

import com.documentmanagement.model.users.UserDTO;
import com.documentmanagement.service.GenericHibernateDAO;

public interface UserDAO extends GenericHibernateDAO<UserDTO> {

	public List<UserDTO> findAll();
	
	public UserDTO getByUserNameAndPassWord(String username, String password);
	public UserDTO getByUserName(String username);

}
