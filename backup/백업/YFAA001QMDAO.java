package com.korail.yf.aa;

import java.awt.List;
import java.util.Map;

/**
 * 역그룹 설정 정보 조회를 위한 역그룹정보조회 DAO 클래스
 * 
 * @author 김응규
 * @stereotype Dao
 * @name_ko 역그룹정보조회
 * @daoType
 */
@LocalName("역그룹정보조회")
public class YFAA001QMDAO {

	/**
	 * 1. Description : 역그룹 설정 정보를 보여준다.
	 * 
	 * 2. Input : 검색조건
	 * 
	 * 3. Output : 조회결과
	 * 
	 * 4.Processing :역그룹설정정보를 조회하여 화면에 출력한다.
	 * 
	 * @dmlType
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
		 * 2. SQL 유형 : SELECT
		 * 3. SQL 설명 :  검색조건(역그룹명, 열차종별 등)에 대해서 결과목록(역그룹명, 소속역명, 대표역 여부, 취급 대표 열차종 등)을 조회
		 * 4. 대상테이블 : 역그룹차수기본(TB_YYFB001), 역그룹핑내역(TB_YYFD002), 예발역코드(TB_YYDK001), 역코드이력(TB_YYDK102)
		 *--------------------------------------------------*/
		// TODO target.method 호출 수정
		/*-FD-CALL-END-0001---------------------------------*/
		return null;
	}
}
