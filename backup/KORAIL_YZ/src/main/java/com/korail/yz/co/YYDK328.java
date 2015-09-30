/**
 * project : KORAIL_YZ
 * package : com.korail.yz.co
 * date : 2014. 5. 15.오전 9:33:27
 */
package com.korail.yz.co;

/**
 * @author "Changki.woo"
 * @date 2014. 5. 15. 오전 9:33:27
 * Class description : 
 */
public class YYDK328 {
	
	String runDt;
	String runDtTxt;
	String trnNo;
	String restSeatMgId;
	String bkclCd;
	String bkcls;
	String runDvCd;
	int bkclOrdr;
	int segGpNo;
	String dealDt;
	String psrmClCd;
	String psrmCl;
	String seatAttCd;
	String shtmExcsRsvAllwFlg;
	int firstAlcNum;     /*예매일별 최초할당수*/
	int gpFstAlcSeatNum; /*그룹/bc별 최초할당수*/
	int gpFstAlcSeatNumBak;
	int gpMrkSeatNum;
	int gpActMrkSeatNum;
	long bizRvnAmt;
	
	//그룹별 할당수(계산)
	int gpAlcNum;
	//부킹클래스할당수(계산)
	int bkclAlcNum;
	//그룹판매허용수(계산)
	int gpMrkAllwNum;
	//부킹클래스판매허용수
	int bkclMrkAllwNum;
	//미할당수	
	int notyAlcNum;
	//(최종)할당잔여석
	int restSeatNum;
	//기본좌석수
	int bsSeatNum;
	int notySaleSeatNum;
	
	
	/**
	 * Comment   : 
	 * @return the firstAlcNum
	 */
	public int getFirstAlcNum() {
		return firstAlcNum;
	}
	/**
	 * @param firstAlcNum the firstAlcNum to set
	 */
	public void setFirstAlcNum(int firstAlcNum) {
		this.firstAlcNum = firstAlcNum;
	}
	/**
	 * Comment   : 
	 * @return the bizRvnAmt
	 */
	public long getBizRvnAmt() {
		return bizRvnAmt;
	}
	/**
	 * @param bizRvnAmt the bizRvnAmt to set
	 */
	public void setBizRvnAmt(long bizRvnAmt) {
		this.bizRvnAmt = bizRvnAmt;
	}
	/**
	 * Comment   : 
	 * @return the runDtTxt
	 */
	public String getRunDtTxt() {
		return runDtTxt;
	}
	/**
	 * @param runDtTxt the runDtTxt to set
	 */
	public void setRunDtTxt(Object runDtTxt) {
		this.runDtTxt = objToString(runDtTxt);
	}
	/**
	 * Comment   : 
	 * @return the psrmCl
	 */
	public String getPsrmCl() {
		return psrmCl;
	}
	/**
	 * @param psrmCl the psrmCl to set
	 */
	public void setPsrmCl(Object psrmCl) {
		this.psrmCl = objToString(psrmCl);
	}
	/**
	 * Comment   : 
	 * @return the bkcls
	 */
	public String getBkcls() {
		return bkcls;
	}
	/**
	 * @param bkcls the bkcls to set
	 */
	public void setBkcls(Object bkcls) {
		this.bkcls = objToString(bkcls);
	}
	/**
	 * Comment   : 
	 * @return the shtmExcsRsvAllwFlg
	 */
	public String getShtmExcsRsvAllwFlg() {
		return shtmExcsRsvAllwFlg;
	}
	/**
	 * @param shtmExcsRsvAllwFlg the shtmExcsRsvAllwFlg to set
	 */
	public void setShtmExcsRsvAllwFlg(Object shtmExcsRsvAllwFlg) {
		this.shtmExcsRsvAllwFlg = objToString(shtmExcsRsvAllwFlg);
	}
	/**
	 * Comment   : 
	 * @return the runDvCd
	 */
	public String getRunDvCd() {
		return runDvCd;
	}
	/**
	 * @param runDvCd the runDvCd to set
	 */
	public void setRunDvCd(Object runDvCd) {
		this.runDvCd = objToString(runDvCd);
	}
	/**
	 * Comment   : 
	 * @return the bkclOrdr
	 */
	public int getBkclOrdr() {
		return bkclOrdr;
	}
	/**
	 * @param bkclOrdr the bkclOrdr to set
	 */
	public void setBkclOrdr(int bkclOrdr) {
		this.bkclOrdr = bkclOrdr;
	}
	/**
	 * Comment   : 
	 * @return the psrmClCd
	 */
	public String getPsrmClCd() {
		return psrmClCd;
	}
	/**
	 * @param psrmClCd the psrmClCd to set
	 */
	public void setPsrmClCd(Object psrmClCd) {
		this.psrmClCd = objToString(psrmClCd);
	}
	/**
	 * Comment   : 
	 * @return the seatAttCd
	 */
	public String getSeatAttCd() {
		return seatAttCd;
	}
	/**
	 * @param seatAttCd the seatAttCd to set
	 */
	public void setSeatAttCd(Object seatAttCd) {
		this.seatAttCd = objToString(seatAttCd);
	}
	/**
	 * Comment   : 
	 * @return the bsSeatNum
	 */
	public int getBsSeatNum() {
		return bsSeatNum;
	}
	/**
	 * @param bsSeatNum the bsSeatNum to set
	 */
	public void setBsSeatNum(int bsSeatNum) {
		this.bsSeatNum = bsSeatNum;
	}
	/**
	 * Comment   : 
	 * @return the notySaleSeatNum
	 */
	public int getNotySaleSeatNum() {
		return notySaleSeatNum;
	}
	/**
	 * @param notySaleSeatNum the notySaleSeatNum to set
	 */
	public void setNotySaleSeatNum(int notySaleSeatNum) {
		this.notySaleSeatNum = notySaleSeatNum;
	}
	/**
	 * Comment   : 
	 * @return the runDt
	 */
	
	public String getRunDt() {
		return runDt;
	}
	/**
	 * @param runDt the runDt to set
	 */
	public void setRunDt(Object runDt) {
		this.runDt = objToString(runDt);
	}
	/**
	 * Comment   : 
	 * @return the trnNo
	 */
	public String getTrnNo() {
		return trnNo;
	}
	/**
	 * @param trnNo the trnNo to set
	 */
	public void setTrnNo(Object trnNo) {
		this.trnNo = objToString(trnNo);
	}
	/**
	 * Comment   : 
	 * @return the restSeatMgId
	 */
	public String getRestSeatMgId() {
		return restSeatMgId;
	}
	/**
	 * @param restSeatMgId the restSeatMgId to set
	 */
	public void setRestSeatMgId(Object restSeatMgId) {
		this.restSeatMgId = objToString(restSeatMgId);
	}
	/**
	 * Comment   : 
	 * @return the bkclCd
	 */
	public String getBkclCd() {
		return bkclCd;
	}
	/**
	 * Comment   : 
	 * @return the gpFstAlcSeatNumBak
	 */
	public int getGpFstAlcSeatNumBak() {
		return gpFstAlcSeatNumBak;
	}
	/**
	 * @param gpFstAlcSeatNumBak the gpFstAlcSeatNumBak to set
	 */
	public void setGpFstAlcSeatNumBak(int gpFstAlcSeatNumBak) {
		this.gpFstAlcSeatNumBak = gpFstAlcSeatNumBak;
	}
	/**
	 * @param bkclCd the bkclCd to set
	 */
	public void setBkclCd(Object bkclCd) {
		this.bkclCd = objToString(bkclCd);
	}
	/**
	 * Comment   : 
	 * @return the segGpNo
	 */
	public int getSegGpNo() {
		return segGpNo;
	}
	/**
	 * @param segGpNo the segGpNo to set
	 */
	public void setSegGpNo(int segGpNo) {
		this.segGpNo = segGpNo;
	}
	/**
	 * Comment   : 
	 * @return the dealDt
	 */
	public String getDealDt() {
		return dealDt;
	}
	/**
	 * @param dealDt the dealDt to set
	 */
	public void setDealDt(Object dealDt) {
		this.dealDt = objToString(dealDt);
	}
	/**
	 * Comment   : 
	 * @return the gpFstAlcSeatNum
	 */
	public int getGpFstAlcSeatNum() {
		return gpFstAlcSeatNum;
	}
	/**
	 * @param gpFstAlcSeatNum the gpFstAlcSeatNum to set
	 */
	public void setGpFstAlcSeatNum(int gpFstAlcSeatNum) {
		this.gpFstAlcSeatNum = gpFstAlcSeatNum;
	}
	/**
	 * Comment   : 
	 * @return the gpMrkSeatNum
	 */
	public int getGpMrkSeatNum() {
		return gpMrkSeatNum;
	}
	/**
	 * @param gpMrkSeatNum the gpMrkSeatNum to set
	 */
	public void setGpMrkSeatNum(int gpMrkSeatNum) {
		this.gpMrkSeatNum = gpMrkSeatNum;
	}
	/**
	 * Comment   : 
	 * @return the gpActMrkSeatNum
	 */
	public int getGpActMrkSeatNum() {
		return gpActMrkSeatNum;
	}
	/**
	 * @param gpActMrkSeatNum the gpActMrkSeatNum to set
	 */
	public void setGpActMrkSeatNum(int gpActMrkSeatNum) {
		this.gpActMrkSeatNum = gpActMrkSeatNum;
	}
	/**
	 * Comment   : 
	 * @return the gpAlcNum
	 */
	public int getGpAlcNum() {
		return gpAlcNum;
	}
	/**
	 * @param gpAlcNum the gpAlcNum to set
	 */
	public void setGpAlcNum(int gpAlcNum) {
		this.gpAlcNum = gpAlcNum;
	}
	/**
	 * Comment   : 
	 * @return the bkclAlcNum
	 */
	public int getBkclAlcNum() {
		return bkclAlcNum;
	}
	/**
	 * @param bkclAlcNum the bkclAlcNum to set
	 */
	public void setBkclAlcNum(int bkclAlcNum) {
		this.bkclAlcNum = bkclAlcNum;
	}
	/**
	 * Comment   : 
	 * @return the gpMrkAllwNum
	 */
	public int getGpMrkAllwNum() {
		return gpMrkAllwNum;
	}
	/**
	 * @param gpMrkAllwNum the gpMrkAllwNum to set
	 */
	public void setGpMrkAllwNum(int gpMrkAllwNum) {
		this.gpMrkAllwNum = gpMrkAllwNum;
	}
	/**
	 * Comment   : 
	 * @return the bkclMrkAllwNum
	 */
	public int getBkclMrkAllwNum() {
		return bkclMrkAllwNum;
	}
	/**
	 * @param bkclMrkAllwNum the bkclMrkAllwNum to set
	 */
	public void setBkclMrkAllwNum(int bkclMrkAllwNum) {
		this.bkclMrkAllwNum = bkclMrkAllwNum;
	}
	/**
	 * Comment   : 
	 * @return the notyAlcNum
	 */
	public int getNotyAlcNum() {
		return notyAlcNum;
	}
	/**
	 * @param notyAlcNum the notyAlcNum to set
	 */
	public void setNotyAlcNum(int notyAlcNum) {
		this.notyAlcNum = notyAlcNum;
	}
	/**
	 * Comment   : 
	 * @return the restSeatNum
	 */
	public int getRestSeatNum() {
		return restSeatNum;
	}
	/**
	 * @param restSeatNum the restSeatNum to set
	 */
	public void setRestSeatNum(int restSeatNum) {
		this.restSeatNum = restSeatNum;
	}
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "YYDK328 [runDt=" + runDt + ", runDtTxt=" + runDtTxt
				+ ", trnNo=" + trnNo + ", restSeatMgId=" + restSeatMgId
				+ ", bkclCd=" + bkclCd + ", bkcls=" + bkcls + ", runDvCd="
				+ runDvCd + ", bkclOrdr=" + bkclOrdr + ", segGpNo=" + segGpNo
				+ ", dealDt=" + dealDt + ", psrmClCd=" + psrmClCd + ", psrmCl="
				+ psrmCl + ", seatAttCd=" + seatAttCd + ", shtmExcsRsvAllwFlg="
				+ shtmExcsRsvAllwFlg + ", gpFstAlcSeatNum=" + gpFstAlcSeatNum
				+ ", gpFstAlcSeatNumBak=" + gpFstAlcSeatNumBak
				+ ", gpMrkSeatNum=" + gpMrkSeatNum + ", gpActMrkSeatNum="
				+ gpActMrkSeatNum + ", bizRvnAmt=" + bizRvnAmt + ", gpAlcNum="
				+ gpAlcNum + ", bkclAlcNum=" + bkclAlcNum + ", gpMrkAllwNum="
				+ gpMrkAllwNum + ", bkclMrkAllwNum=" + bkclMrkAllwNum
				+ ", notyAlcNum=" + notyAlcNum + ", restSeatNum=" + restSeatNum
				+ ", bsSeatNum=" + bsSeatNum + ", notySaleSeatNum="
				+ notySaleSeatNum + "]";
	}
	
	public String getMKeyFullSeg(){
		return this.getRunDt()+"|#|"+"|#|"+this.getTrnNo()+"|#|"+this.getSegGpNo()+"|#|"+this.getBizRvnAmt()+"|#|"+this.getPsrmClCd();
	}
	
	
	public String objToString( Object obj )
	{
		if( obj == null ){
			return "";
		}
		return obj.toString();
	}
}
