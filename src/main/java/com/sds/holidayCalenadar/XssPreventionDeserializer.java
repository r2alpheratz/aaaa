package com.sds.holidayCalenadar;

import java.io.IOException;
import java.util.regex.Pattern;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.deser.std.StdDeserializer;
public class XssPreventionDeserializer extends StdDeserializer<String> {

    /**
	 *
	 */
	private static final long serialVersionUID = 1L;

	public XssPreventionDeserializer() {
        super(String.class);
    }

    @Override
    public String deserialize(JsonParser json, DeserializationContext context)
            throws IOException, JsonProcessingException {

         return 	convertXsshtml(json.getText());

    }


    private String  convertXsshtml(String value) {
    	  if (value != null) {

              Pattern scriptPattern = Pattern.compile("<script>(.*?)</script>", Pattern.CASE_INSENSITIVE);
              value = scriptPattern.matcher(value).replaceAll("");

              // Avoid anything in a src='...' type of expression
              scriptPattern = Pattern.compile("src[\r\n]*=[\r\n]*\\\'(.*?)\\\'", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL);
              value = scriptPattern.matcher(value).replaceAll("");

              scriptPattern = Pattern.compile("src[\r\n]*=[\r\n]*\\\"(.*?)\\\"", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL);
              value = scriptPattern.matcher(value).replaceAll("");

              // Remove any lonesome </script> tag
              scriptPattern = Pattern.compile("</script>", Pattern.CASE_INSENSITIVE);
              value = scriptPattern.matcher(value).replaceAll("");

              // Remove any lonesome <script ...> tag
              scriptPattern = Pattern.compile("<script(.*?)>", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL);
              value = scriptPattern.matcher(value).replaceAll("");

              // Avoid eval(...) expressions
              scriptPattern = Pattern.compile("eval\\((.*?)\\)", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL);
              value = scriptPattern.matcher(value).replaceAll("");

              // Avoid expression(...) expressions
              scriptPattern = Pattern.compile("expression\\((.*?)\\)", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL);
              value = scriptPattern.matcher(value).replaceAll("");

              // Avoid javascript:... expressions
              scriptPattern = Pattern.compile("javascript:", Pattern.CASE_INSENSITIVE);
              value = scriptPattern.matcher(value).replaceAll("");

              // Avoid vbscript:... expressions
              scriptPattern = Pattern.compile("vbscript:", Pattern.CASE_INSENSITIVE);
              value = scriptPattern.matcher(value).replaceAll("");

              // Avoid onload= expressions
              scriptPattern = Pattern.compile("onload(.*?)=", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL);
              value = scriptPattern.matcher(value).replaceAll("");

              value = value.replaceAll("", "");
              value=   value.replaceAll("<", "&lt;");
              value=  value.replaceAll(">", "&gt;");
          }
          return value;
    }


}
