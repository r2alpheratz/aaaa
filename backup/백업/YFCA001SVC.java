package com.korail.yf.ca;

import java.util.List;
import java.util.Map;

/**
 * 구간별, 객실등급별, 기간별 승차인원 예측치 조회를 위한 기간별예측승차인원조회 Service 클래스
 * 
 * @author 김응규
 * @stereotype ServiceImpl
 * @name_ko 기간별예측승차인원조회SVC
 */
@LocalName("기간별예측승차인원조회SVC")
public class YFCA001SVC {

	/**
	 * 1. Description : 기간별 예측승차인원을 조회
	 * 
	 * 2. Input : 검색조건
	 * 
	 * 3. Output : 검색결과
	 * 
	 * 4.Processing : 운행일자, 열차번호, 요일, 열차종별 구역구간을 입력하고 조회
	 * 
	 * @name_ko 예측승차인원조회
	 * @param srchCnd
	 *            검색조건
	 * @return List 검색결과
	 */
	@LocalName("예측승차인원조회")
	public List selectListFcstAbrdPrnb(Map srchCnd) {
		/*-FD-CALL-START-0001-------------------------------
		 * 예측승차인원조회
		 * 1. 내용 : 기간별 예측승차인원 조회
		 * 2. 호출클래스 : YFCA001SVC
		 * 3. 호출메서드 : selectListFcstAbrdPrnb
		 * 4. 리턴값 : List
		 *--------------------------------------------------*/
		// TODO yFCA001QMDAO.selectListFcstAbrdPrnb 호출 수정
		// YFCA001QMDAO yFCA001QMDAO = null;
		// List = yFCA001QMDAO.selectListFcstAbrdPrnb(srchCnd );
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
	 * @name_ko 예측승차인원상세조회
	 * @param dtlQrySrchCnd
	 *            상세조회검색조건
	 * @return List 상세결과
	 */
	@LocalName("예측승차인원상세조회")
	public List selectListFcstAbrdPrnbDtl(Map dtlQrySrchCnd) {
		/*-FD-CALL-START-0001-------------------------------
		 * 예측승차인원상세조회
		 * 1. 내용 : 선택한 열차의 할인등급별 예측승차인원 상세 조회
		 * 2. 호출클래스 : YFCA001SVC
		 * 3. 호출메서드 : selectListFcstAbrdPrnbDtl
		 * 4. 리턴값 : List
		 *--------------------------------------------------*/
		// TODO yFCA001QMDAO.selectListFcstAbrdPrnbDtl 호출 수정
		// YFCA001QMDAO yFCA001QMDAO = null;
		// List = yFCA001QMDAO.selectListFcstAbrdPrnbDtl(dtlQrySrchCnd );
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
	 * @name_ko OD별예측승차인원조회
	 * @param srchCnd
	 *            검색조건
	 * @return List 검색결과
	 */
	@LocalName("OD별예측승차인원조회")
	public List selectListOdFcstAbrdPrnb(Map srchCnd) {
		/*-FD-CALL-START-0001-------------------------------
		 * OD별예측승차인원조회
		 * 1. 내용 : 선택한열차의 OD별 예측승차인원을 조회
		 * 2. 호출클래스 : YFCA001SVC
		 * 3. 호출메서드 : selectListOdFcstAbrdPrnb
		 * 4. 리턴값 : List
		 *--------------------------------------------------*/
		// TODO yFCA001QMDAO.selectListOdFcstAbrdPrnb 호출 수정
		// YFCA001QMDAO yFCA001QMDAO = null;
		// List = yFCA001QMDAO.selectListOdFcstAbrdPrnb(srchCnd );
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
	 * @name_ko OD별예측승차인원상세조회
	 * @param dtlQrySrchCnd
	 *            상세조회검색조건
	 * @return List 상세결과
	 */
	@LocalName("OD별예측승차인원상세조회")
	public List selectListOdFcstAbrdPrnbDtl(Map dtlQrySrchCnd) {
		/*-FD-CALL-START-0001-------------------------------
		 * OD별예측승차인원상세조회
		 * 1. 내용 : OD별예측승차인원의 객실등급별 할인등급별 상세조회
		 * 2. 호출클래스 : YFCA001SVC
		 * 3. 호출메서드 : selectListOdFcstAbrdPrnbDtl
		 * 4. 리턴값 : List
		 *--------------------------------------------------*/
		// TODO yFCA001QMDAO.selectListOdFcstAbrdPrnbDtl 호출 수정
		// YFCA001QMDAO yFCA001QMDAO = null;
		// List = yFCA001QMDAO.selectListOdFcstAbrdPrnbDtl(dtlQrySrchCnd );
		/*-FD-CALL-END-0001---------------------------------*/
		return null;
	}

	/**
	 * 1. Description : OD별예측승차인원상세내역의 예측승차인원을 수정
	 * 
	 * 2. Input : 등록정보
	 * 
	 * 3. Output : 수정결과
	 * 
	 * 4.Processing : OD별예측승차인원상세내역의 예측승차인원을 수정하여 저장한다.
	 * 
	 * @name_ko 예측승차인원수정
	 * @param regInfo
	 *            등록정보
	 * @return Integer 수정결과
	 */
	@LocalName("예측승차인원수정")
	public Integer updateFcstAbrdPrnb(Map regInfo) {
		/*-FD-CALL-START-0001-------------------------------
		 * 수익관리작업ID조회
		 * 1. 내용 : 수익관리작업ID를 조회
		 * 2. 호출클래스 : YFCA001SVC
		 * 3. 호출메서드 : selectYmgtJobId
		 * 4. 리턴값 : String
		 *--------------------------------------------------*/
		// TODO yFCA001QMDAO.selectYmgtJobId 호출 수정
		// YFCA001QMDAO yFCA001QMDAO = null;
		// String = yFCA001QMDAO.selectYmgtJobId();
		/*-FD-CALL-END-0001---------------------------------*/
		/*-FD-CALL-START-0002-------------------------------
		 * 수익관리작업ID저장
		 * 1. 내용 : 수익관리작업ID를 테이블에 저장
		 * 2. 호출클래스 : YFCA001SVC
		 * 3. 호출메서드 : insertYmgtJobId
		 * 4. 리턴값 : Integer
		 *--------------------------------------------------*/
		// TODO yFCA001QMDAO.insertYmgtJobId 호출 수정
		// YFCA001QMDAO yFCA001QMDAO = null;
		// Integer = yFCA001QMDAO.insertYmgtJobId(ymgtJobId );
		/*-FD-CALL-END-0002---------------------------------*/
		/*-FD-CALL-START-0003-------------------------------
		 * 예측승차인원수정입력
		 * 1. 내용 : 예측승차인원 수정내역을 최종탑승예측수요내역 테이블에 등록
		 * 2. 호출클래스 : YFCA001SVC
		 * 3. 호출메서드 : insertFcstAbrdPrnbMdfy
		 * 4. 리턴값 : Integer
		 *--------------------------------------------------*/
		// TODO yFCA001QMDAO.insertFcstAbrdPrnbMdfy 호출 수정
		// YFCA001QMDAO yFCA001QMDAO = null;
		// Integer = yFCA001QMDAO.insertFcstAbrdPrnbMdfy(regInfo );
		/*-FD-CALL-END-0003---------------------------------*/
		/*-FD-CALL-START-0004-------------------------------
		 * 수익관리작업처리수정
		 * 1. 내용 : 예측승차인원수 등록 후 수익관리작업처리상태 수정
		 * 2. 호출클래스 : YFCA001SVC
		 * 3. 호출메서드 : updateYmgtJobPrs
		 * 4. 리턴값 : Integer
		 *--------------------------------------------------*/
		// TODO yFCA001QMDAO.updateYmgtJobPrs 호출 수정
		// YFCA001QMDAO yFCA001QMDAO = null;
		// Integer = yFCA001QMDAO.updateYmgtJobPrs(jobPrsInfo );
		/*-FD-CALL-END-0004---------------------------------*/
		return null;
	}
}
