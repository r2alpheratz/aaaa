/**
 * 
 */
package com.sds.holidayCalenadar.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sds.holidayCalenadar.common.base.vo.CodeInfoVo;
import com.sds.holidayCalenadar.dao.CountryCodeMgnDao;
import com.sds.holidayCalenadar.service.CountryCodeMgnService;

/**
 * 국가코드관리 ServiceImpl
 *
 * @author 김응규
 * @since  2015/08/26
 *
 */
@Service("com.sds.holidayCalenadar.service.CountryCodeMgnService")
public class CountryCodeMgnServiceImpl implements CountryCodeMgnService {
	
	@Autowired
	private CountryCodeMgnDao countryCodeDao;
	
	/**
	 * 국가코드조회
	 *
	 * @return 국가코드List(countryCodeList)
	 *
	 */
	@Override
	public List<CodeInfoVo> searchCountryCodeList(Map<String, Object> param) {
		return countryCodeDao.selectCountryCodeList(param);
	}
}
