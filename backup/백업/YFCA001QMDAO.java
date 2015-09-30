package com.korail.yf.ca;

import java.util.List;
import java.util.Map;

/**
 * 구간별, 객실등급별, 기간별 승차인원 예측치 조회를 위한 기간별예측승차인원조회 DAO 클래스
 * 
 * @author 김응규
 * @stereotype Dao
 * @name_ko 기간별예측승차인원조회
 * @daoType
 */
@LocalName("기간별예측승차인원조회")
public class YFCA001QMDAO {

	/**
	 * 1. Description : 기간별 예측승차인원을 조회
	 * 
	 * 2. Input : 검색조건
	 * 
	 * 3. Output : 검색결과
	 * 
	 * 4.Processing : 운행일자, 열차번호, 요일, 열차종별 구역구간을 입력하고 조회
	 * 
	 * @dmlType
	 * @name_ko 예측승차인원조회
	 * @param srchCnd
	 *            검색조건
	 * @return List 검색결과
	 */
	@LocalName("예측승차인원조회")
	public List selectListFcstAbrdPrnb(Map srchCnd) {
		/*-FD-CALL-START-0001-------------------------------
		 * 예측승차인원조회
		 * 1. 내용 : 기간별 예측승차인원을 조회
		 * 2. SQL 유형 : SELECT
		 * 3. SQL 설명 :  검색조건(운행일자, 열차번호, 요일, 열차종별, 구역구간 등)에 대해서 결과목록(운행일자, 열차번호, 객실등급, 출발역그룹, 도착역그룹, OD인원 등)을 조회
		 * 4. 대상테이블 : 최종탑승예측수요내역(TB_YYFD410), 열차구간내역(TB_YYDD505), 열차운행내역(TB_YYDK302),
		 * 카렌다내역(TB_YYDK002), 열차기본(TB_YYDK301), 수익관리대상열차내역(TB_YYFD011), 수익관리작업결과내역(TB_YYFD010),
		 * 역그룹차수기본(TB_YYSB001)
		 *--------------------------------------------------*/
		// TODO target.method 호출 수정
		/*-FD-CALL-END-0001---------------------------------*/
		return null;
	}

	/**
	 * 1. Description : 선택한 열차의 할인등급별 승차인원 상세내역 조회
	 * 
	 * 2. Input : 상세조회검색조건
	 * 
	 * 3. Output : 상세결과
	 * 
	 * 4.Processing : 기간별 예측승차인원 조회 목록에서 선택한 열차의 할인등급별 승차인원 상세내역 조회를 처리한다.
	 * 
	 * @dmlType
	 * @name_ko 예측승차인원상세조회
	 * @param dtlQrySrchCnd
	 *            상세조회검색조건
	 * @return List 상세결과
	 */
	@LocalName("예측승차인원상세조회")
	public List selectListFcstAbrdPrnbDtl(Map dtlQrySrchCnd) {
		/*-FD-CALL-START-0001-------------------------------
		 * 예측승차인원상세조회
		 * 1. 내용 : 선택한 열차에대한 할인등급별 승차인원 상세조회
		 * 2. SQL 유형 : SELECT
		 * 3. SQL 설명 :  선택한 열차의 조건(운행일자, 열차번호, 객실등급, 출발/도착역그룹 등)에 대해서 결과목록(할인등급, 승차인원)을 조회
		 * 4. 대상테이블 : 최종탑승예측수요내역(TB_YYFD410)
		 *--------------------------------------------------*/
		// TODO target.method 호출 수정
		/*-FD-CALL-END-0001---------------------------------*/
		return null;
	}

	/**
	 * 1. Description : 선택한 열차의 OD별 예측승차인원 조회
	 * 
	 * 2. Input : 검색조건
	 * 
	 * 3. Output : 검색결과
	 * 
	 * 4.Processing : 기간별예측승차인원조회 목록에서 선택한 열차의 OD별 예측승차인원을 조회한다.
	 * 
	 * @dmlType
	 * @name_ko OD별예측승차인원조회
	 * @param srchCnd
	 *            검색조건
	 * @return List 검색결과
	 */
	@LocalName("OD별예측승차인원조회")
	public List selectListOdFcstAbrdPrnb(Map srchCnd) {
		/*-FD-CALL-START-0001-------------------------------
		 * OD별예측승차인원조회
		 * 1. 내용 : 선택열차의 OD별 예측 승차인원을 조회
		 * 2. SQL 유형 : SELECT
		 * 3. SQL 설명 :  검색조건(운행일자, 열차번호)에 대해서 출발/도착역별 예측승차인원을 조회
		 * 4. 대상테이블 : 최종탑승예측수요내역(TB_YYFD410), 열차구간내역(TB_YYDD505), 수익관리대상열차내역(TB_YYFD011),
		 * 열차운행내역(TB_YYDK302)
		 *--------------------------------------------------*/
		// TODO target.method 호출 수정
		/*-FD-CALL-END-0001---------------------------------*/
		return null;
	}

	/**
	 * 1. Description : 선택한 승차인원이 객실등급, 할인등급별로 분포한 내역을 조회
	 * 
	 * 2. Input : 상세조회검색조건
	 * 
	 * 3. Output : 상세결과
	 * 
	 * 4.Processing : OD별예측승차인원 목록에서 선택한 승차인원의 객실등급별 할인등급별 상세 인원을 조회한다.
	 * 
	 * @dmlType
	 * @name_ko OD별예측승차인원상세조회
	 * @param dtlQrySrchCnd
	 *            상세조회검색조건
	 * @return List 상세결과
	 */
	@LocalName("OD별예측승차인원상세조회")
	public List selectListOdFcstAbrdPrnbDtl(Map dtlQrySrchCnd) {
		/*-FD-CALL-START-0001-------------------------------
		 * OD별예측승차인원상세조회
		 * 1. 내용 : 선택한 OD별 예측 승차인원의 상세조회
		 * 2. SQL 유형 : SELECT
		 * 3. SQL 설명 :  선택한 검색조건(출발/도착역)에 대해서 결과목록(출발역, 도착역, 객실등급, 할인등급, 승차인원)을 조회
		 * 4. 대상테이블 : 최종탑승예측수요내역(TB_YYFD410), 열차구간내역(TB_YYDD505), 수익관리대상열차내역(TB_YYFD011)
		 *--------------------------------------------------*/
		// TODO target.method 호출 수정
		/*-FD-CALL-END-0001---------------------------------*/
		return null;
	}

	
	/**
	 * 1. Description : 수익관리작업처리를 위한 수익관리작업ID조회
	 * 
	 * 2. Input : void
	 * 
	 * 3. Output : 수익관리작업ID
	 * 
	 * 4.Processing : 예측승차인원 조정 후 저장시 수익관리작업ID가 채번된다.
	 * 
	 * @dmlType
	 * @name_ko 수익관리작업ID조회
	 * @param parameter
	 *            Description
	 * @return String 수익관리작업ID
	 */
	@LocalName("수익관리작업ID조회")
	public String selectYmgtJobId(Void parameter) {
		/*-FD-CALL-START-0001-------------------------------
		 * 수익관리작업ID조회
		 * 1. 내용 : 수익관리작업ID를 채번(max)
		 * 2. SQL 유형 : SELECT
		 * 3. SQL 설명 :  수익관리작업ID의 max값을 조회
		 * 4. 대상테이블 : 수익관리작업결과기본(TB_YYST009)
		 *--------------------------------------------------*/
		// TODO target.method 호출 수정
		/*-FD-CALL-END-0001---------------------------------*/
		return null;
	}

	/**
	 * 1. Description : 신규 채번한 수익관리작업ID를 수익관리작업 관련 테이블에 저장
	 * 
	 * 2. Input : 수익관리작업ID
	 * 
	 * 3. Output : 저장결과
	 * 
	 * 4.Processing : 수익관리작업ID 채번 후 수익관리작업결과기본(TB_YYST009),
	 * 수익관리작업결과내역(TB_YYSS010), 수익관리대상열차내역(TB_YYSD011) 테이블에 insert
	 * 
	 * @dmlType
	 * @name_ko 수익관리작업ID저장
	 * @param ymgtJobId
	 *            수익관리작업ID
	 * @return Integer 저장결과
	 */
	@LocalName("수익관리작업ID저장")
	public Integer insertYmgtJobId(String ymgtJobId) {
		/*-FD-CALL-START-0001-------------------------------
		 * 수익관리작업ID저장
		 * 1. 내용 : 수익관리작업ID를 관련테이블에 저장
		 * 2. SQL 유형 : INSERT
		 * 3. SQL 설명 : 신규채번한 수익관리작업ID를 관련 테이블에 insert
		 * 4. 대상테이블 : 수익관리작업결과기본(TB_YYST009), 수익관리작업결과내역(TB_YYSS010), 수익관리대상열차내역(TB_YYSD011)
		 *--------------------------------------------------*/
		// TODO target.method 호출 수정
		/*-FD-CALL-END-0001---------------------------------*/
		return null;
	}

	/**
	 * 1. Description : 최종탑승예측수요내역 테이블에 수정한 예측승차인원정보를 등록
	 * 
	 * 2. Input : 등록정보
	 * 
	 * 3. Output : 등록결과
	 * 
	 * 4.Processing : 수익관리작업ID 저장 후 입력처리한다.
	 * 
	 * @dmlType
	 * @name_ko 예측승차인원수정입력
	 * @param regInfo
	 *            등록정보
	 * @return Integer 등록결과
	 */
	@LocalName("예측승차인원수정입력")
	public Integer insertFcstAbrdPrnbMdfy(Map regInfo) {
		/*-FD-CALL-START-0001-------------------------------
		 * 예측승차인원수정입력
		 * 1. 내용 : 예측승차인원 수정입력
		 * 2. SQL 유형 : INSERT
		 * 3. SQL 설명 : 수정입력한 예측승차인원을 테이블에 저장
		 * 4. 대상테이블 : 최종탑승예측수요내역(TB_YYFD410)
		 *--------------------------------------------------*/
		// TODO target.method 호출 수정
		/*-FD-CALL-END-0001---------------------------------*/
		return null;
	}

	/**
	 * 1. Description : 예측승차인원을 수정하고 수익관리 작업처리 상태를 수정
	 * 
	 * 2. Input : 작업처리정보
	 * 
	 * 3. Output : 수정결과
	 * 
	 * 4.Processing : 예측승차인원의 수정 완료 후 수익관리 작업처리 상태를 수정처리한다.
	 * 
	 * @dmlType
	 * @name_ko 수익관리작업처리수정
	 * @param jobPrsInfo
	 *            작업처리정보
	 * @return Integer 수정결과
	 */
	@LocalName("수익관리작업처리수정")
	public Integer updateYmgtJobPrs(Map jobPrsInfo) {
		/*-FD-CALL-START-0001-------------------------------
		 * 수익관리작업처리수정
		 * 1. 내용 : 수익관리작업처리수정
		 * 2. SQL 유형 : UPDATE
		 * 3. SQL 설명 :  수익관리작업결과를 UPDATE
		 * 4. 대상테이블 : 수익관리작업결과내역(TB_YYSS010)
		 *--------------------------------------------------*/
		// TODO target.method 호출 수정
		/*-FD-CALL-END-0001---------------------------------*/
		return null;
	}
}
