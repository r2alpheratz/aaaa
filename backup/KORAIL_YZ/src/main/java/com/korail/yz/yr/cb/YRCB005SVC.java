/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yb.co
 * date : 2014. 3. 11.오후 3:32:36
 */
package com.korail.yz.yr.cb;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;

import com.korail.tz.sa.ISA0001SVC;
import com.korail.tz.sa.XframeControllerUtils;

import cosmos.comm.dao.CommDAO;


/**
 * @author "Changki.woo"
 * @date 2014. 8. 6. 오전 10:22:23
 * Class description : 이벤트 열차 전체 목록 조회
 */
@Service("com.korail.yz.yr.cb.YRCB005SVC")
public class YRCB005SVC {

	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 8. 5. 오전 11:00:34
	 * Method description : 이벤트 열차 전체 목록 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListEvntTrmAcvm(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet  = null;
		List<Map<String, Object>> resultListStd = null;
		List<Map<String, Object>> resultListComp3 = null;
		List<Map<String, Object>> resultListComp2 = null;
		List<Map<String, Object>> resultListComp = null;
		
		String svcUrl = "com.korail.yz.yr.cb.YRCB005QMDAO.selectListEvntTrmAcvmQry";
		
		String dsCondStdNm = "dsCond";
		String dsListStdNm = "dsList";
		
		String dsCondNm = "dsCondComp";
		String dsListNm = "dsListComp";
		
		String dsCond2Nm = "dsCondComp2";
		String dsList2Nm = "dsListComp2";
		
		String dsCond3Nm = "dsCondComp3";
		String dsList3Nm = "dsListComp3";		
		
		if( param.containsKey(dsCondStdNm) )
		{
			getParamSet  = XframeControllerUtils.getParamDataSet(param, dsCondStdNm);
			resultListStd = (List<Map<String, Object>>) dao.list(svcUrl, getParamSet);
			result.put(dsListStdNm, resultListStd);
			
			for(int i=0;i<resultListStd.size();i++)
			{
				Object[] keySet = resultListStd.get(i).keySet().toArray();
				Map<String, Object> mRow = resultListStd.get(i);
				
				for(int j=0; j<keySet.length;j++)
				{
					String strKeySet = keySet[j].toString();
					if("LABEL".equals( strKeySet ))
					{
						continue;
					}
					if(mRow.containsKey(strKeySet) && mRow.get(strKeySet) == null)
					{
						XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
						continue;
					}
					
				}
			}		
			
		}
		
		if( param.containsKey(dsCond3Nm) )
		{
			getParamSet  = XframeControllerUtils.getParamDataSet(param, dsCond3Nm);
			resultListComp3 = (List<Map<String, Object>>) dao.list(svcUrl, getParamSet);
			result.put(dsList3Nm, resultListComp3);
			
			for(int i=0;i<resultListComp3.size();i++)
			{
				Object[] keySet = resultListComp3.get(i).keySet().toArray();
				Map<String, Object> mRow = resultListComp3.get(i);
				
				for(int j=0; j<keySet.length;j++)
				{
					String strKeySet = keySet[j].toString();
					if("LABEL".equals( strKeySet ))
					{
						continue;
					}
					if(mRow.containsKey(strKeySet) && mRow.get(strKeySet) == null)
					{
						XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
						continue;
					}
					
				}
			}
		}
		
		if( param.containsKey(dsCond2Nm) )
		{
			getParamSet  = XframeControllerUtils.getParamDataSet(param, dsCond2Nm);
			resultListComp2 = (List<Map<String, Object>>) dao.list(svcUrl, getParamSet);
			result.put(dsList2Nm, resultListComp2);
			
			for(int i=0;i<resultListComp2.size();i++)
			{
				Object[] keySet = resultListComp2.get(i).keySet().toArray();
				Map<String, Object> mRow = resultListComp2.get(i);
				
				for(int j=0; j<keySet.length;j++)
				{
					String strKeySet = keySet[j].toString();
					if("LABEL".equals( strKeySet ))
					{
						continue;
					}
					if(mRow.containsKey(strKeySet) && mRow.get(strKeySet) == null)
					{
						XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
						continue;
					}
					
				}
			}
		}
		
		if( param.containsKey(dsCondNm) )
		{
			getParamSet  = XframeControllerUtils.getParamDataSet(param, dsCondNm);
			resultListComp = (List<Map<String, Object>>) dao.list(svcUrl, getParamSet);
			result.put(dsListNm, resultListComp);
			
			for(int i=0;i<resultListComp.size();i++)
			{
				Object[] keySet = resultListComp.get(i).keySet().toArray();
				Map<String, Object> mRow = resultListComp.get(i);
				
				for(int j=0; j<keySet.length;j++)
				{
					String strKeySet = keySet[j].toString();
					if("LABEL".equals( strKeySet ))
					{
						continue;
					}
					if(mRow.containsKey(strKeySet) && mRow.get(strKeySet) == null)
					{
						XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
						continue;
					}
					
				}
			}
		}
		if(!result.containsKey("xframeCommonMessageCode"))
		{
			XframeControllerUtils.setMessage("IZZ000009", result);			
		}
		return result;
	}
}