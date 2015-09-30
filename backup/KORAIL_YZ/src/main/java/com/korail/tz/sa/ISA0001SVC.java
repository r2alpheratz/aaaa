package com.korail.tz.sa;

import java.util.Locale;

public interface ISA0001SVC {

	public static final String LOGGER_NAME_COM_KORAIL = "com.korail"; 
	public static final int    PG_PR_CNT = 100;
	
	
	public static final Locale ERROR_MESSAGE_LOCALE = Locale.KOREA;
	public static final Locale WARN_MESSAGE_LOCALE = Locale.KOREA;
	public static final String XDATASET_MESSAGE_LEVEL = "MESSAGE_LEVEL";
	public static final String XDATASET_MESSAGE_LEVEL_ERROR = "ERROR";
	public static final String XDATASET_MESSAGE_LEVEL_WARN = "WARN";
	
	public static final String XDATASET_ERROR_MESSAGE_KEY = "ERROR_MESSAGE"; //xframe exception 처리 key
	public static final String XDATASET_WARN_MESSAGE_KEY = "WARN_MESSAGE"; //xframe 예외처리(업무예외) key
	
	public static final String XDATASET_HEADER_USER_ID = "USER_ID";

}
