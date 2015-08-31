package com.sds.holidayCalenadar.vo;

import com.sds.holidayCalenadar.common.base.vo.CommonVo;


public class HolidayInfoVo extends CommonVo {
	private String messageKey;

	private String countryCd;

	private String holidayStDt;

	private String holidayEndDt;

	private String holidayYn;
	
	private String holidayDescription;
	
	private String useYn;
	
	private String holidayNm;
	
	public String getHolidaySq() {
		return holidaySq;
	}

	public void setHolidaySq(String holidaySq) {
		this.holidaySq = holidaySq;
	}

	private String holidaySq;

	public String getHolidayNm() {
		return holidayNm;
	}

	public void setHolidayNm(String holidayNm) {
		this.holidayNm = holidayNm;
	}

	public String getMessageKey() {
		return messageKey;
	}

	public void setMessageKey(String messageKey) {
		this.messageKey = messageKey;
	}

	public String getCountryCd() {
		return countryCd;
	}

	public void setCountryCd(String countryCd) {
		this.countryCd = countryCd;
	}

	public String getHolidayStDt() {
		return holidayStDt;
	}

	public void setHolidayStDt(String holidayStDt) {
		this.holidayStDt = holidayStDt;
	}

	public String getHolidayEndDt() {
		return holidayEndDt;
	}

	public void setHolidayEndDt(String holidayEndDt) {
		this.holidayEndDt = holidayEndDt;
	}

	public String getHolidayYn() {
		return holidayYn;
	}

	public void setHolidayYn(String holidayYn) {
		this.holidayYn = holidayYn;
	}

	public String getHolidayDescription() {
		return holidayDescription;
	}

	public void setHolidayDescription(String holidayDescription) {
		this.holidayDescription = holidayDescription;
	}

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	
}
