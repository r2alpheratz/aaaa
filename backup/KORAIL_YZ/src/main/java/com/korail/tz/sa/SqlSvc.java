package com.korail.tz.sa;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;

import cosmos.comm.dao.CommDAO;
import cosmos.comm.util.SqlUtil;
import cosmos.velocity.VelocityUtil;

public class SqlSvc {
	private CommDAO dao;
	private NamedParameterJdbcTemplate jdbcTemplate;
	public void setNamedParameterJdbcTemplate(NamedParameterJdbcTemplate namedParameterJdbcTemplate){
		this.jdbcTemplate = namedParameterJdbcTemplate;
	}
	public void setJdbcDAO(CommDAO commDAO){
		this.dao = commDAO;
	}
	
	public Map<String, Object> execute(Map<String, ?> param){
		Set<String> fieldNames = new LinkedHashSet<String>();
		String sql = (String)param.get("sql");
		if(VelocityUtil.isDynamic(sql)){
			sql = VelocityUtil.convert(sql, param);
		}
		
		List<Map<String, Object>> list = jdbcTemplate.query(sql, param, new RowMapper<Map<String, Object>>(){
			public Map<String, Object> mapRow(ResultSet resultSet, int paramInt) throws SQLException{
				return SqlUtil.transferToCamelCase(resultSet);
			}
		});
		
		if(!list.isEmpty()){
			Map<String, Object> record = list.get(0);
			for(String key : record.keySet()){
				fieldNames.add(key);
			}
		}
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("fields", fieldNames);
		result.put("list", list);
		
		return result;
	}
	public int save(Map<String, String> param){
		@SuppressWarnings("unchecked")
		Map<String, Object> map = (Map<String, Object>)dao.select("cosmos.comm.tool.select", param);
		if(map.isEmpty()){
			return dao.insert("cosmos.comm.tool.insert", param);
		}else{
			return dao.update("cosmos.comm.tool.update", param);
		}
	}
	public Map<String, ? extends Object> list(Map<String, ?> param){
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("COUNT", dao.count("cosmos.comm.tool.count", param));
		result.put("LIST", dao.list("cosmos.comm.tool.list", param));
		return result;
		
	}
	public Object select(Map<String, ?> param){
		return dao.select("cosmos.comm.tool.select", param);
	}
}
