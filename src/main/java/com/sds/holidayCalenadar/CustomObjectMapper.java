package com.sds.holidayCalenadar;


import com.fasterxml.jackson.core.Version;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.module.SimpleModule;

public class CustomObjectMapper extends ObjectMapper {

	/**
	 *XSS  방지
	 */
	private static final long serialVersionUID = 1L;


	 public CustomObjectMapper() {

		  SimpleModule module = new SimpleModule("HTML XSS Serializer", new Version(1, 0, 0, "FINAL"));
	      module.addDeserializer(String.class, new XssPreventionDeserializer());

	        super.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
	      this.registerModule(module);
	    }







}
