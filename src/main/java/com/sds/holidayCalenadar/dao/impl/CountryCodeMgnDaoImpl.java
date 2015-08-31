/**
 * 
 */
package com.sds.holidayCalenadar.dao.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sds.holidayCalenadar.common.base.vo.CodeInfoVo;
import com.sds.holidayCalenadar.common.util.CommonUtil;
import com.sds.holidayCalenadar.dao.CountryCodeMgnDao;
import com.sds.lego.core.orm.LegoSqlTemplate;

/**
 * CountryCodeMgnDaoImpl
 *
 * @author 김응규
 * @since  2015/08/26

 */
@Repository("com.sds.holidayCalenadar.dao.CountryCodeMgnDao")
public class CountryCodeMgnDaoImpl implements CountryCodeMgnDao {
	private final static  String sqlStatement="CountryCodeMgn.";

	@Autowired
	private LegoSqlTemplate sqlTemplate;
	
	/**
	 * 국가코드 조회	
	 *
	 * @param null
	 * @return 국가코드List(CodeInfoVoList)
	 *
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<CodeInfoVo> selectCountryCodeList(Map<String, Object> param) {
		param = CommonUtil.dbWildCardChange(param);
		List<CodeInfoVo> countryCodeList = sqlTemplate.selectList(sqlStatement+"selectCountryCodeList", param);
		return countryCodeList;
	}
}
