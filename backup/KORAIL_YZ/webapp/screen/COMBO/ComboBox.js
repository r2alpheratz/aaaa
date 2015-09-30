// 코드 데이터 설정 버튼 이벤트 처리
function btnSetCode_on_mouseup(objInst)
{
	// 기본 콤보 박스에 있는 내용을 모두 삭제
	cboScript.removeall();

	// 코드 및 코드 설명(Comment)에 대한 어레이 변수 선언
	var arrCode = ["01", "02", "03"];
	var arrComment = ["대한민국", "중국", "미국"];

	// 코드 데이터에 대한 Delimeter 변수 설언
	var strDelimeter = ":";
			
	var i;

	// JavaScript 언어에서 어레이 변수에 대한 길이는 length 속성을 읽어서 구할 수 있다.
	// 어레이 갯수 만큼 Loop를 돌면서 콤보 박스에 코드 데이터 추가
	for(i = 0; i < arrCode.length; i++) {
		// 코드 데이터 형식 : "코드" + "코드 Delimeter" + "코드 설명(Comment")
		cboScript.addstring(arrCode[i] + strDelimeter + arrComment[i]);
	}
}