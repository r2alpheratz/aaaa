package com.sds.holidayCalenadar.dao;

import java.util.List;
import java.util.Map;

import com.sds.holidayCalenadar.common.base.vo.CodeInfoVo;

/**
 * 국가코드관리 Dao
 *
 * @author 김응규
 * @since  2015/08/26
 *
 */
public interface CountryCodeMgnDao {
	/**
	 * 국가코드 리스트 조회
	 *
	 */
	  List<CodeInfoVo> selectCountryCodeList(Map<String, Object> param);

}
