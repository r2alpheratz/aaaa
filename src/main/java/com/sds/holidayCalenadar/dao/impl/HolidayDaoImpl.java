package com.sds.holidayCalenadar.dao.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sds.holidayCalenadar.common.util.CommonUtil;
import com.sds.holidayCalenadar.dao.HolidayDao;
import com.sds.holidayCalenadar.vo.HolidayInfoVo;
import com.sds.lego.core.orm.LegoSqlTemplate;

@Repository("com.sds.holidayCalenadar.dao.HolidayDao")
public class HolidayDaoImpl implements HolidayDao {
	
	@Autowired
	private LegoSqlTemplate sqlTemplate;
	
	private final static  String sqlStatement="TB_HC_HOLIDAY_INFO.";
	
	@Override
	public List<HolidayInfoVo> selectHolidayInfoList(Map<String, Object> param) {
		param = CommonUtil.dbWildCardChange(param);
		return sqlTemplate.selectList(sqlStatement+"selectMessageInfoList", param);
	}

	@Override
	public int selectHolidayListCount(Map<String, Object> param) {
		param = CommonUtil.dbWildCardChange(param);
		return sqlTemplate.selectOne(sqlStatement+"selectMessageListCount", param);
	}

}
