package com.sds.holidayCalenadar.common.base.vo;

import java.io.Serializable;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;

public class CommonVo implements Serializable{

	private static final long serialVersionUID = -7302306805298756490L;
	
	private String  createUsrId;

	private String  createDt;

	private String  updateUsrId;

	private String  updateDt;
	 
	public String getCreateUsrId() {
		return createUsrId;
	}

	public void setCreateUsrId(String createUsrId) {
		this.createUsrId = createUsrId;
	}

	public String getCreateDt() {
		return createDt;
	}

	public void setCreateDt(String createDt) {
		this.createDt = createDt;
	}

	public String getUpdateUsrId() {
		return updateUsrId;
	}

	public void setUpdateUsrId(String updateUsrId) {
		this.updateUsrId = updateUsrId;
	}

	public String getUpdateDt() {
		return updateDt;
	}

	public void setUpdateDt(String updateDt) {
		this.updateDt = updateDt;
	}
	
	public boolean equals(Object o) {
        return EqualsBuilder.reflectionEquals(this, o);
    }  
 
    public int hashCode() {
        return HashCodeBuilder.reflectionHashCode(this);
    }
}
