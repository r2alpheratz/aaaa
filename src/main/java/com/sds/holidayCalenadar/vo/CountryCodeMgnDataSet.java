/**
 * 
 */
package com.sds.holidayCalenadar.vo;

import java.util.List;

/**
 * 국가코드조회 DataSet
 * 	
 * @author 김응규
 * @since 2015/08/26
 *
 */

public class CountryCodeMgnDataSet {
	
	private int readindex;
	private int readcount;
	private int rowcount;
	

	private List<CountryCodeMapVo> countryCodeMapVoList;

	/**
	 * @return the rowcount
	 */
	public int getRowcount() {
		return rowcount;
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

	/**
	 * @param rowcount the rowcount to set
	 */
	public void setRowcount(int rowcount) {
		this.rowcount = rowcount;
	}

	/**
	 * @return the countryCodeMapVoList
	 */
	public List<CountryCodeMapVo> getCountryCodeMapVoList() {
		return countryCodeMapVoList;
	}

	/**
	 * @param countryCodeMapVoList the countryCodeMapVoList to set
	 */
	public void setCountryCodeMapVoList(List<CountryCodeMapVo> countryCodeMapVoList) {
		this.countryCodeMapVoList = countryCodeMapVoList;
	}
}
