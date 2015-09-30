
1. cosmos.asset.xdataset packages는  Refactoring 대상ؼ 
   com.korail package로 변경하는 것을 고려
   
2. /korail_bz/src/main/resources/config/springmvc/thirdparty-view.xml

   <bean id="xframeView" class="cosmos.asset.xdataset.web.XframeView" />
   View Class의 패키지, 클래스에 대한 Refactoring 발생 시 해당 부분도 수정필요
   
3. /korail_bz/src/main/resources/config/spring/applicationContext-cosmos-core.xml

    <bean id="cosmosController" class="cosmos.asset.xdataset.web.CmmXframeController">
		<property name="commSVC" ref="commSVC" />
		<property name="exceptionHandler" ref="cosmosExceptionHandler" />
    </bean>
    
	<bean id="commSVC" class="cosmos.asset.xdataset.svc.XframeCommSVC">
		<property name="commDAO" ref="commDAO" />
	</bean>
	
4. 	/korail_bz/src/main/resources/config/spring/applicationContext-transaction.xml

   transaction 설정을 위한 aop pointcut expression에 대한 확인 필요
   
	<aop:config proxy-target-class="true">
		<aop:pointcut id="beanOp"
			expression=" execution(* cosmos..*SVC.*(..)) || execution(* com.korail..*SVC.*(..))" />
		<aop:advisor advice-ref="txAdvice" pointcut-ref="beanOp" />
	</aop:config>
	
5. viewer_db.js의 
   var myParam3  
    = document.createElement('<PARAM NAME="SCREENSOURCE" VALUE="LOCAL">'); 을
   var myParam3  
    = document.createElement('<PARAM NAME="SCREENSOURCE" VALUE="WEB">'); 로 변경고려
   
   var myParam4  
   	= document.createElement('<PARAM NAME="SCREENURL" VALUE="D:\\cosmos_client\\workspace\\korail_bz\\was">'); 를   
   var myParam4  
   	= document.createElement('<PARAM NAME="SCREENURL" VALUE="http://127.0.0.1:8090');  로 변경고려 (xdataset.xml에 변경한 URL)
   	
   	
6. 
   <xlinktranmap id="TR_SELECT_EMP" url="http://127.0.0.1:8090/korail_bz/bz/te/tt.do" 부분의 korail_bz가 webapp context ?
  <screen version="2.0" scriptcode="java" title="직원정보처리" directory="/실습/"  
     => <screen version="2.0" scriptcode="java" title="직원정보처리" directory="/XDATASET/" 
   	
   	
   	
   