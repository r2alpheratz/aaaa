package com.sds.holidayCalenadar.common.util;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

public class CommonUtil {

	public static void setAuiDataSetInfo(Object dataSet, Map<String, Object> map) throws Exception{
		dataSet.getClass().getMethod("setReadcount", int.class).invoke((int)map.get("readcount"));
		dataSet.getClass().getMethod("setReadindex", int.class).invoke((int)map.get("readindex"));
		dataSet.getClass().getMethod("setRowcount", int.class).invoke((int)map.get("rowcount"));
	}

	public static Map dbWildCardChange(Map map){

		Map out = new HashMap();
		if(map==null|| map.isEmpty()){
			return map;
		}

		Set<String> keyset = map.keySet();

		for (String key : keyset) {
			Object value = map.get(key);
			if(key.contains("srch") && !key.contains("Cd") && value != null && value.getClass() == String.class){
					value = dbWildCardChange(value.toString());

			}
			out.put(key, value);
		}

		return out;

	}

	public static String dbWildCardChange(String str){

		if(str.contains("_")) str = str.replaceAll("_", "\\\\_");
		if(str.contains("%")) str = str.replaceAll("%", "\\\\%");

		return str;
	}
}
