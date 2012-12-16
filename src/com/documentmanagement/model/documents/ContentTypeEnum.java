package com.documentmanagement.model.documents;

public enum ContentTypeEnum {
	PDF("application/pdf","fullDocument"),//
	TEXT("text/plain","fullDocument"),//
	DOC("application/msword","fullDocument"),//
	EXCEL("application/excel","fullDocument"),//
	HTML("text/html","fullDocument"),//
	XML("application/xml","fullDocument"),//
	
	MPG("video/mpeg","videoDocument"),//
	AVI("video/x-msvideo","videoDocument"),//
	OGV("video/ogv","videoDocument"),//
	
	WAV("audio/x-wav","videoDocument"),//
	MP3("audio/mp3","audioDocument"),//
	
	
	TIF("image/tiff","imageDocument"),//
	PNG("image/png","imageDocument"),//
	JPG("image/jpeg","imageDocument"),//
	GIF("image/gif","imageDocument"),//
	BMP("image/bmp","imageDocument"),//
	;
	String mimeType;
	String resultString;
	private ContentTypeEnum(String mimeType, String resultString){
		this.mimeType =mimeType;
		this.resultString = resultString;
	}
	public String getId() {
		return name();
	}
	public String getMimeType(){
		return mimeType;
	}
	public String getResultString() {
		return resultString;
	}
	
}
