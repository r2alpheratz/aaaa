package com.sds.holidayCalenadar;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.sds.lego.core.orm.LegoSqlTemplate;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/faro")
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
//	@Autowired
//	private LegoSqlTemplate sqlTemplate;
//	
//	// ���̺� ��
//	private final static String sqlStatement = "Holiday.";
//	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	
	@RequestMapping
	public String getIndexPage(HttpServletRequest request) {
//		logger.info("Welcome home! The client locale is {}.", locale);
		
//		Date date = new Date();
//		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
//		
//		String formattedDate = dateFormat.format(date);
		
//		model.addAttribute("serverTime", formattedDate );
		
		return "calendar";
	}
	
	
//	@RequestMapping(value = "/test", method = RequestMethod.GET)
//	public String test(Locale locale, Model model) {
//		logger.info("Welcome home! The client locale is {}.", locale);
//		Holiday a = new Holiday();
//		
//		Map workGroupSqMap= new HashMap();
////			workGroupSqMap.put("language", param.get("language"));
//
//		sqlTemplate.selectList(sqlStatement + "selectholiday");
//		
//		return "calendarPopup";
//	}
	//데이터 불러올때
//	@RequestMapping(value ="/test", method =  {RequestMethod.GET, RequestMethod.POST})
//	public @ResponseBody Map searchRoleUserList(@RequestBody Map map) {
//
//		//return roleMgnService.searchRoleUserList(map);
//		Map resMap =null;
////		RoleMgnDataSet result = new RoleMgnDataSet();
////		result.setReadindex((int) resMap.get("readindex"));
////		result.setReadcount((int) resMap.get("readcount"));
////		result.setRoleUserList((List<UserInfoVo>) resMap.get("roleUserList"));
////		result.setRowcount((int) resMap.get("rowcount"));
//
//		return resMap;
//	}
	
	//에이작스 성공시 팝업호출
	@RequestMapping("/test") // 어드민이 사용자 수정시 사용
	public ModelAndView viewUserEditPopup(@RequestParam Map param) {

		ModelAndView mav= new ModelAndView();

		mav.setViewName( "/calendarPopup");
		return mav;
	}
	
	@RequestMapping("/viewRoleUserPopup")
	public ModelAndView viewRoleUserPopup(@RequestParam Map param) {

		ModelAndView mav= new ModelAndView();

		/*mav.setViewName( "/faro/admin/rolemgn/roleUserPopup");*/
		return mav;
	}
	
}
