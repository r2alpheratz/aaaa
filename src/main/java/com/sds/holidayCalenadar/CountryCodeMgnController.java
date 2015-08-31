/**
 * 
 */
package com.sds.holidayCalenadar;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.sds.holidayCalenadar.common.base.vo.CodeInfoVo;
import com.sds.holidayCalenadar.service.CountryCodeMgnService;

/**
 * 국가코드관리 Controller
 * 	
 * @author 김응규
 * @since 2015/08/26
 *
 */

@Controller
@RequestMapping("/")
public class CountryCodeMgnController {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired(required = false)
	private CountryCodeMgnService countryCodeService;
	
	
	/**
	 * Method Description
	 *
	 * @param user
	 *            parameter description
	 * @return Map return type description
	 * @throws Exception
	 *             exception name
	 */
	@RequestMapping
	public ModelAndView view(@RequestParam Map<String, Object> param) {
		ModelAndView mav= new ModelAndView();


		mav.setViewName("/holidayCalenadar");
		return mav;
	}
	
	
	/*@RequestMapping(value ="/searchSigninCodeList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> searchSigninCodeList(@RequestBody Map<String, Object> map) {

		String rocale = FaroUserSessionHolder.getLanguage();

		List<UserInfoVo> deptList = userMgnService.searchDeptList(map);
		List<CodeInfoVo> grdList = userMgnService.searchGrdList(map, rocale);

		map.put("searchDeptList", deptList);
		map.put("searchGrdList", grdList);

		return map;
	}*/
	/**
	 * 국가코드조회
	 *
	 * @param
	 * @return 국가코드리스트
	 *
	*/
	@RequestMapping(value = "/searchCountryCodeList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> searchCountryCodeList(@RequestBody Map<String, Object> map) {

		List<CodeInfoVo> countryCodeList = countryCodeService.searchCountryCodeList(map);
		
		map.put("searchCountryCodeList", countryCodeList);
		
		// 결과
		/*CountryCodeMgnDataSet out = new CountryCodeMgnDataSet();
		out.setCountryCodeMapVoList((List<CountryCodeMapVo>) resMap.get("countryCodeMapVoList"));
		out.setRowcount((int)resMap.get("rowcount"));
		
		List<CountryCodeMapVo> testList = out.getCountryCodeMapVoList();
		*/
		for (int i = 0; i < countryCodeList.size(); i++) {
			logger.debug("국가코드 :::"+countryCodeList.get(i).getCodeSq()+"/"+countryCodeList.get(i).getCodeEngNm()+"/"+countryCodeList.get(i).getCodeNm());
		}
		return map;
	}
}
