package com.documentmanagement.action.login;

import java.util.Collection;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import com.documentmanagement.model.users.UserDTO;
import com.documentmanagement.service.users.UserDAO;
import com.opensymphony.xwork2.ActionSupport;


public class ScreenAction extends ActionSupport{
	private static final long serialVersionUID = 1L;
	public String execute(){
		return SUCCESS;
	}
	
	
	
}
