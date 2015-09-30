package com.korail.yz.co;
import java.util.ArrayList;
import java.util.List;


@SuppressWarnings("serial")
class BizLogicException extends Exception
{
	public BizLogicException( String msg)
	{
		super(msg);
	}
}

/**
 * @author "Changki.woo"
 * @date 2014. 5. 14. 오후 5:13:39
 * Class description : 
 */

public class YZCOMM {
	
	
	static String encodingTable [] = {
	    "0","1","2","3","4","5","6","7","8","9",
	    "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P",
	    "Q","R","S","T","U","V","W","X","Y","Z","a","b","c","d","e","f",
	    "g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v",
	    "w","x","y","z","+","/"};
	
	public List<Integer> fnYzcommStr64ToInt(String str)
	{
		List<Integer> strToDecVal = new ArrayList<Integer>();
		
		//1. 유효성검증. 5의 배수가 아니면 종료
		if(str.length() % 5 != 0)
		{
			return null;
		}
		
		List<String> splitStr = new ArrayList<String>();
		
		//2. 전처리. 5개씩 뜯어내서 MAP에 담음
		for(int i = 0; i < str.length(); i += 5)
		{
			String subStr = str.substring(i, i+5);//5개까지 뜯기
			splitStr.add( subStr );
		}
		
		//3. 64 -> 10으로 변환
		for(int i=0; i < splitStr.size(); i++)
		{
			String subStr = splitStr.get(i);	  // 그룹value를 하나씩 꺼냄
			String sign   = subStr.substring(0,1);// 부호 뜯기
			String sDecVal  = subStr.substring(1);  // 부호 뜯은 나머지들
			
			int signVal = 1; //부호 담는변수
			int retVal = 0 ; //최종 리턴변수
			
			if("+".equals(sign))
			{
				signVal *= 1; //양수일때
			}
			
			else if("-".equals(sign))
			{
				signVal *= -1; //음수일때
			}
			
			
/*			for(int j = 0 ; j < val64.length() ; j++)
			{
				int decValue = fnGetDeciFromArrTbl(encodingTable, String.valueOf(val64.charAt(j)) ); // 값을 변환한다.
				if(decValue == -1)
				{
					return null;
				}
				retVal += signVal * decValue; //변환한 값을 부호와 곱한다.
			}*/
			
			int decValue = Integer.valueOf(sDecVal);
			retVal = signVal * decValue;
			
			//4. 한 그룹의 String이 변환이 끝나면 list에 넣어서 return
			strToDecVal.add( retVal ) ;
		}
		
		return strToDecVal;
	}
	
	public int fnGetDeciFromArrTbl(String[] tbl, String e)
	{
		for(int i=0; i< tbl.length;i++)
		{
			String tEle = tbl[i];		
			if(tEle.equals(e))
			{
				return i + 1;
			}
		}
		return -1;
	}	
}