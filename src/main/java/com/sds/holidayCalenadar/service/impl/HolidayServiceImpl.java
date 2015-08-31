package com.sds.holidayCalenadar.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sds.holidayCalenadar.dao.HolidayDao;
import com.sds.holidayCalenadar.service.HolidayService;
import com.sds.holidayCalenadar.vo.HolidayInfoVo;
@Service("com.sds.holidayCalenadar.service.HolidayService")
public class HolidayServiceImpl implements HolidayService {

	@Autowired
	private HolidayDao holidayDao;
	
	@Override
	public Map<String, Object> searchHolidayInfoList(Map<String, Object> param) {
		Map<String, Object> out = new HashMap<String, Object>();
		int readindex = (int) param.get("readindex");
		int readcount = (int) param.get("readcount") + readindex;
		param.put("readcount", readcount);

		out.put("readindex", readindex);
		out.put("readcount", readcount);

		String country = (String) param.get("country");
//		if (country != null && defaultLang.equalsIgnoreCase(country)) {
//			param.remove("country"); // 한국어가 들어올 경우
//		}

		List<HolidayInfoVo> holidayVoList = holidayDao
				.selectHolidayInfoList(param);
		int rowcount = holidayDao.selectHolidayListCount(param);
		out.put("holidayInfoVoList", holidayVoList);
		out.put("rowcount", rowcount);

		return out;
	}

}
