package com.documentmanagement.action.util;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class DMActionSupport<View> extends ActionSupport implements ModelDriven<View> {

	protected View view;;
	
	@Override
	public View getModel() {
		// TODO Auto-generated method stub
		return view;
	}
	public void setView(View view){
		this.view = view;
	}
	
}
