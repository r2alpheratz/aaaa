package com.korail.tz.sa;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.MessageSource;
import org.springframework.web.servlet.view.AbstractView;

import xdataset.XDataSet;

public class XframeView  extends AbstractView {
	
	@Resource(name = "messageSource")
	MessageSource messageSource;
	
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		XDataSet xDataSet = new XDataSet(request, response);
				
		try {
			Map<?, ?> tmpResult = (Map<?, ?>)model.get("result");
			xDataSet.setMessage((String) tmpResult.get("xframeCommonMessageCode"),"");
			List<String> outDsNames = (List<String>)model.get("outDsNames");			
			
			if (null != tmpResult) {
				for(String outDsName : outDsNames) {
					XframeControllerUtils.setListToXDataSet(xDataSet, outDsName, (List)tmpResult.get(outDsName));
				}							
			} else {				
				String throwMessage =  messageSource.getMessage("xframe.000.error", new String[] {}, ISA0001SVC.ERROR_MESSAGE_LOCALE);			   
				xDataSet.setErrorMessage(ISA0001SVC.XDATASET_ERROR_MESSAGE_KEY, throwMessage);
				//throw new Exception(throwMessage);
			}
		} catch(RuntimeException re){										
									 
			if(ISA0001SVC.XDATASET_MESSAGE_LEVEL_WARN.equals((String) model.get(ISA0001SVC.XDATASET_MESSAGE_LEVEL))){
				xDataSet.setErrorMessage((String) model.get(ISA0001SVC.XDATASET_WARN_MESSAGE_KEY),  "");	
				System.out.println( this.getClass().getName() + "message =====>>> " + (String) model.get(ISA0001SVC.XDATASET_WARN_MESSAGE_KEY) );
			}else{
				xDataSet.setErrorMessage(ISA0001SVC.XDATASET_ERROR_MESSAGE_KEY,  (String) model.get(ISA0001SVC.XDATASET_ERROR_MESSAGE_KEY));
				System.out.println( this.getClass().getName() + "message =====>>> " + (String) model.get(ISA0001SVC.XDATASET_ERROR_MESSAGE_KEY) );
			}
								
			
		}catch (Exception e) {
			xDataSet.setErrorMessage(ISA0001SVC.XDATASET_ERROR_MESSAGE_KEY,  (String) model.get(ISA0001SVC.XDATASET_ERROR_MESSAGE_KEY));
			
		} finally{									
			xDataSet.returnData();
		}
		
	}


}
