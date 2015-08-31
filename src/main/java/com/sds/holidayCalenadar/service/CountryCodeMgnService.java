/**
 * 
 */
package com.sds.holidayCalenadar.service;

import java.util.List;
import java.util.Map;

import com.sds.holidayCalenadar.common.base.vo.CodeInfoVo;

/**
 * 국가코드관리 Service
 *
 * @author 김응규
 * @since  2015/08/26
 *
 */
public interface CountryCodeMgnService {
	/**
	 * 국가코드 리스트 조회
	 *
	 */
	 List<CodeInfoVo> searchCountryCodeList(Map<String, Object> map);

}
