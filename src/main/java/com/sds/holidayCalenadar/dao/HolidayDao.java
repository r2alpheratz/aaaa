package com.sds.holidayCalenadar.dao;

import java.util.List;
import java.util.Map;

import com.sds.holidayCalenadar.vo.HolidayInfoVo;

public interface HolidayDao {

	List<HolidayInfoVo> selectHolidayInfoList(Map<String, Object> param);

	int selectHolidayListCount(Map<String, Object> param);

}
