package com.documentmanagement.model.documents;

public class TestJava {
	public static void main(String args[]){
		
		for (ContentTypeEnum string : ContentTypeEnum.values()) {
			System.out.println(string.getId());
			System.out.println(ContentTypeEnum.valueOf(string.getId()));
		}
		System.out.println("067e6162-3b6f-4ae2-a171-2470b63dff00".length());
	
	}
}
