package com.sds.holidayCalenadar.common.base.vo;

import com.sds.holidayCalenadar.common.base.vo.CommonVo;

/**
 * 코드 관리
 * @author 이구현(gray.lee)
 * @modify 김응규(Tim.Kim)
 *
 */

public class CodeInfoVo extends CommonVo{


	//public static final String PARENT_CODE_NAME = "LOG_000002";

	private String id;
	private String codeSq;
	private String codeNm;
	private String codeEngNm;
	
	private String parentCodeSq;
	private String codeDescription;

	private int codeLevelNo;
	private int codeOrderNo;

	private String language;


	private String useYn;
	
	private String initYn;

	// 최상위 코드 이름( 현재는 테스트 상에 CODE )
	private String superPrntName;


	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getCodeSq() {
		return codeSq;
	}

	public void setCodeSq(String codeSq) {
		this.codeSq = codeSq;
	}

	public String getCodeNm() {
		return codeNm;
	}

	public void setCodeNm(String codeNm) {
		this.codeNm = codeNm;
	}

	public String getCodeEngNm() {
		return codeEngNm;
	}

	public void setCodeEngNm(String codeEngNm) {
		this.codeEngNm = codeEngNm;
	}
	
	public String getParentCodeSq() {
		return parentCodeSq;
	}

	public void setParentCodeSq(String parentCodeSq) {
		this.parentCodeSq = parentCodeSq;
	}

	public int getCodeLevelNo() {
		return codeLevelNo;
	}

	public void setCodeLevelNo(int codeLevelNo) {
		this.codeLevelNo = codeLevelNo;
	}

	public int getCodeOrderNo() {
		return codeOrderNo;
	}

	public void setLanguage(String language) {
		this.language = language;
	}
	public void setCodeOrderNo(int codeOrderNo) {
		this.codeOrderNo = codeOrderNo;
	}




	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	
	public String getInitYn() {
		return initYn;
	}

	public void setInitYn(String initYn) {
		this.initYn = initYn;
	}

	public String getCodeDescription() {
		return codeDescription;
	}

	public void setCodeDescription(String codeDescription) {
		this.codeDescription = codeDescription;
	}



	public String getSuperPrntName() {
		return superPrntName;
	}

	public void setSuperPrntName(String superPrntName) {
		this.superPrntName = superPrntName;
	}


	public String getLanguage() {
		return language;
	}

}
