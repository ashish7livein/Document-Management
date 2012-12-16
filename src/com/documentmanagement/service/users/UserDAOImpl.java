package com.documentmanagement.service.users;


import java.util.Arrays;

import org.hibernate.FetchMode;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import com.documentmanagement.model.users.UserDTO;
import com.documentmanagement.service.GenericHibernateDAOAbs;

public class UserDAOImpl extends GenericHibernateDAOAbs<UserDTO> implements UserDAO{

	public UserDAOImpl() {
		super(UserDTO.class);
	}

	@Override
	public UserDTO getByUserNameAndPassWord(String username, String password) {
		DetachedCriteria criteria = getDetachedCriteria();
		criteria.add(Restrictions.eq("username", username));
		criteria.add(Restrictions.eq("password", password));
		criteria.setFetchMode("folders", FetchMode.JOIN);
		return getByCriteria(criteria);
	}

	@Override
	public UserDTO getByUserName(String username) {
		DetachedCriteria criteria = getDetachedCriteria();
		criteria.add(Restrictions.eq("username", username));
		criteria.setFetchMode("folders", FetchMode.JOIN);
		return getByCriteria(criteria);
	}

		
}
