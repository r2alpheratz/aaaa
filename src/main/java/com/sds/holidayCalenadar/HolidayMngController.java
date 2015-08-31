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
import org.springframework.web.bind.annotation.ResponseBody;

import com.sds.holidayCalenadar.service.HolidayService;
import com.sds.holidayCalenadar.vo.HolidayInfoVo;
import com.sds.holidayCalenadar.vo.HolidayMgnDataSet;
import com.sds.lego.core.orm.LegoSqlTemplate;
/**
 * Holiday 관리
 *
 * @author 박진영
 *
 */
@Controller
@RequestMapping("/")
public class HolidayMngController {

private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
//	@Autowired
//	private LegoSqlTemplate sqlTemplate;
	
	@Autowired
	private HolidayService holidayService;
	
	// ���̺� ��
	private final static String sqlStatement = "TB_HC_HOLIDAY_INFO";
								
	@RequestMapping(value = "/searchholidayPageList", method = RequestMethod.POST)
	public @ResponseBody HolidayMgnDataSet searchMessageList(
			@RequestBody Map map) {

		//srchMessageValue
//		if(map.containsKey("srchMessageValue") ){
//			String srchMessageValue=(String) map.get("srchMessageValue");
//			srchMessageValue=srchMessageValue.replaceAll("<", "&lt;");
//			srchMessageValue=  srchMessageValue.replaceAll(">", "&gt;");
//			map.put("srchMessageValue", srchMessageValue);
//		}
//		map.put("country", FaroUserSessionHolder.getLanguage());

		Map resMap = holidayService.searchHolidayInfoList(map);
		
		HolidayMgnDataSet result = new HolidayMgnDataSet();
		result.setReadindex((int) resMap.get("readindex"));
		result.setReadcount((int) resMap.get("readcount"));
		result.setHolidayInfoVoList((List<HolidayInfoVo>) resMap
				.get("holidayInfoVoList"));
		result.setRowcount((int) resMap.get("rowcount"));

		return result;
	}
}
