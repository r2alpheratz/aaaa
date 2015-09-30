package com.korail.yf.aa;

import java.awt.List;
import java.util.Map;

/**
 * 역그룹 설정 정보 조회를 위한 역그룹정보조회 Service 클래스
 * 
 * @author 김응규
 * @stereotype ServiceImpl
 * @name_ko 역그룹정보조회SVC
 */
@LocalName("역그룹정보조회SVC")
public class YFAA001SVC {

	/**
	 * 1. Description : 역그룹 설정 정보를 보여준다.
	 * 
	 * 2. Input : 검색조건
	 * 
	 * 3. Output : 조회결과
	 * 
	 * 4.Processing :역그룹설정정보를 조회하여 화면에 출력한다.
	 * 
	 * @name_ko 역그룹조회
	 * @param srchCnd
	 *            검색조건
	 * @return List 조회결과
	 */
	@LocalName("역그룹조회")
	public List selectListStgpInfo(Map srchCnd) {
		/*-FD-CALL-START-0001-------------------------------
		 * 역그룹정보조회
		 * 1. 내용 : 역그룹정보를 조회
		 * 2. 호출클래스 : YFAA001SVC
		 * 3. 호출메서드 : selectListStgpInfo
		 * 4. 리턴값 : List
		 *--------------------------------------------------*/
		// TODO yFAA001QMDAO.selectListStgpInfo 호출 수정
		// YFAA001QMDAO yFAA001QMDAO = null;
		// List = yFAA001QMDAO.selectListStgpInfo(srchCnd );
		/*-FD-CALL-END-0001---------------------------------*/
		return null;
	}
}
