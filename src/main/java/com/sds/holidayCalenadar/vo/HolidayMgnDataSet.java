package com.sds.holidayCalenadar.vo;

/*
 * Copyright © 2014 SDS Lego Team ..
 * 본 코드는 Lego 팀에서 개발한 공통모듈로 Samsung SDS 내에서 자유롭게 수정 및 확산이 가능하며 기여 또한 가능합니다.
 *  homepage : http://70.121.244.190/gitnsam
 *  email : gitnsam@samsung.com
 */

import java.io.Serializable;
import java.util.List;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class HolidayMgnDataSet extends HolidayInfoVo implements Serializable {

	private static final long serialVersionUID = 1L;

	private int searchGroupId = 0;

	private List<HolidayInfoVo> insertHolidayInfoVo;

	private List<HolidayInfoVo> updateHolidayInfoVo;

	private List<HolidayInfoVo> deleteHolidayInfo;

	private List<HolidayInfoVo> holidayInfoVoList;

	private int readindex;
	private int readcount;
	private int rowcount;

	/**
	 * @return the searchGroupId
	 */
	public int getSearchGroupId() {
		return searchGroupId;
	}

	/**
	 * @param searchGroupId
	 *            the searchGroupId to set
	 */
	public void setSearchGroupId(int searchGroupId) {
		this.searchGroupId = searchGroupId;
	}

	/**
	 * @return the insertHolidayInfoVo
	 */
	public List<HolidayInfoVo> getInsertHolidayInfoVo() {
		return insertHolidayInfoVo;
	}

	/**
	 * @param insertHolidayInfoVo
	 *            the insertHolidayInfoVo to set
	 */
	public void setInsertHolidayInfoVo(List<HolidayInfoVo> insertHolidayInfoVo) {
		this.insertHolidayInfoVo = insertHolidayInfoVo;
	}

	/**
	 * @return the updateHolidayInfoVo
	 */
	public List<HolidayInfoVo> getUpdateHolidayInfoVo() {
		return updateHolidayInfoVo;
	}

	/**
	 * @param updateHolidayInfoVo
	 *            the updateHolidayInfoVo to set
	 */
	public void setUpdateHolidayInfoVo(List<HolidayInfoVo> updateHolidayInfoVo) {
		this.updateHolidayInfoVo = updateHolidayInfoVo;
	}

	/**
	 * @return the deleteHolidayInfoVo
	 */
	public List<HolidayInfoVo> getDeleteHolidayInfo() {
		return deleteHolidayInfo;
	}

	/**
	 * @param deleteHolidayInfoVo
	 *            the deleteHolidayInfoVo to set
	 */
	public void setDeleteHolidayInfo(List<HolidayInfoVo> deleteHolidayInfo) {
		this.deleteHolidayInfo = deleteHolidayInfo;
	}

	public List<HolidayInfoVo> getHolidayInfoVoList() {
		return holidayInfoVoList;
	}

	public void setHolidayInfoVoList(List<HolidayInfoVo> HolidayInfoVoList) {
		this.holidayInfoVoList = HolidayInfoVoList;
	}

	public int getReadindex() {
		return readindex;
	}

	public void setReadindex(int readindex) {
		this.readindex = readindex;
	}

	public int getReadcount() {
		return readcount;
	}

	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}

	public int getRowcount() {
		return rowcount;
	}

	public void setRowcount(int rowcount) {
		this.rowcount = rowcount;
	}

}
