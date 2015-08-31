<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script>
	var CONTEXTPATH = "${pageContext.request.contextPath}";
	var MAIN_PAGE = "Index";
</script>
<link rel="stylesheet" type="text/css"
	href="/calendar/lib/css/aui/aui-widgets-1.9.0.opus.min.css" />
<link rel="stylesheet" type="text/css"
	href="/calendar/comm/css/component.css" />
<link rel="stylesheet" type="text/css" href="/calendar/comm/css/btn.css" />
<link rel="stylesheet" type="text/css"
	href="/calendar/comm/css/layout.css" />
<link rel="stylesheet" type="text/css" href="/calendar/comm/css/tab.css" />
<link rel="stylesheet" type="text/css"
	href="/calendar/comm/css/common.css" />
<link rel="stylesheet" type="text/css"
	href="/calendar/comm/opusstyle/css/opus_style.css" />
<script type="text/javascript"
	src="/calendar/lib/js/jquery/jquery-2.1.1.min.js"></script>
<script type="text/javascript"
	src="/calendar/lib/js/jquery/jquery.mCustomScrollbar.js"></script>
<script type="text/javascript"
	src="/calendar/lib/js/jquery/jquery.cookie.js"></script>
<script type="text/javascript"
	src="/calendar/lib/js/aui/aui-core-1.5.0.min.js"></script>
<script type="text/javascript"
	src="/calendar/lib/js/aui/aui-widgets-1.9.0.min.js"></script>
<script type="text/javascript"
	src="/calendar/lib/js/aui/globalization/globalize.js"></script>
<script type="text/javascript"
	src="/calendar/lib/js/aui/globalization/globalize.culture.ko-KR.js"></script>
<script type="text/javascript" src="/calendar/comm/js/commonPopup.js"></script>
<script type="text/javascript" src="/calendar/comm/js/legoJScommon.js"></script>
<script type="text/javascript" src="/calendar/comm/js/commonMessage.js"></script>
</head>
<script type="text/javascript">
	/** ******* Carendar관련 ******* */
	var calendar_data = [
	// holiday
	{
		name : '크리스마스',
		year : 2013,
		month : 12,
		day : 25,
		isHoliday : true,
		isEvent : false
	}, {
		name : '신정',
		year : 2014,
		month : 1,
		day : 1,
		isHoliday : true,
		isEvent : false
	}, {
		name : '',
		year : 2014,
		month : 1,
		day : 30,
		isHoliday : true,
		isEvent : false
	}, {
		name : '설날',
		year : 2014,
		month : 1,
		day : 31,
		isHoliday : true,
		isEvent : false
	}, {
		name : '',
		year : 2014,
		month : 2,
		day : 1,
		isHoliday : true,
		isEvent : false
	}, {
		name : '3.1절',
		year : 2014,
		month : 3,
		day : 1,
		isHoliday : true,
		isEvent : false
	}, {
		name : '어린이날',
		year : 2014,
		month : 5,
		day : 5,
		isHoliday : true,
		isEvent : false
	}, {
		name : '석가탄신일',
		year : 2014,
		month : 5,
		day : 6,
		isHoliday : true,
		isEvent : false
	}, {
		name : '현충일',
		year : 2014,
		month : 6,
		day : 6,
		isHoliday : true,
		isEvent : false
	}, {
		name : '광복절',
		year : 2014,
		month : 8,
		day : 15,
		isHoliday : true,
		isEvent : false
	}, {
		name : '',
		year : 2014,
		month : 9,
		day : 7,
		isHoliday : true,
		isEvent : false
	}, {
		name : '추석',
		year : 2014,
		month : 9,
		day : 8,
		isHoliday : true,
		isEvent : false
	}, {
		name : '',
		year : 2014,
		month : 9,
		day : 9,
		isHoliday : true,
		isEvent : false
	}, {
		name : '개천절',
		year : 2014,
		month : 10,
		day : 3,
		isHoliday : true,
		isEvent : false
	}, {
		name : '한글날',
		year : 2014,
		month : 10,
		day : 9,
		isHoliday : true,
		isEvent : false
	}, {
		name : '크리스마스',
		year : 2014,
		month : 12,
		day : 25,
		isHoliday : true,
		isEvent : false
	},
	// event
	{
		name : 'EventA',
		year : 2014,
		month : 3,
		day : 12,
		isHoliday : false,
		isEvent : true
	}, {
		name : 'EventB',
		year : 2014,
		month : 3,
		day : 13,
		isHoliday : false,
		isEvent : true
	}, {
		name : 'EventC',
		year : 2014,
		month : 3,
		day : 14,
		isHoliday : false,
		isEvent : true
	} ];

	var currentMonth; //현재달
	var currentYear; //현재년도
	var selectYear; //선택한 년도
	var selectQuarter; //선택한 분기
	var calendarSection; //달력 그려지는 DIV
	var calendarWidth = "700";
	var calendarHeight = "500";
	//600*400, 700*500, 800*600
	$(document).ready(
			function() {

				var objSet = document.getElementById("box");

				objSet.style.height = calendarHeight + "px";
				objSet.style.width = calendarWidth + "px";

				currentMonth = new Date().getMonth(); //현재달
				currentYear = new Date().getFullYear(); //현재년도
				selectYear = $("#yearpicker"); //선택한 년도
				selectQuarter = $("#quarter"); //선택한 분기
				calendarSection = $("#drowCalendar"); //달력 그려지는 DIV

				//년도selectBox
				for (i = currentYear + 10; i > 1900; i--) {
					if (i == currentYear) {
						selectYear.append($('<option selected/>').val(i)
								.html(i));
					} else {
						selectYear.append($('<option />').val(i).html(i));
					}

				}

				//처음 로딩시 달력하나 세팅
				fn_drawOneMonthCalendar();

			});

	//selectBox 년도 세팅
	function fn_setSelectYear(year) {
		selectYear.val(year);
	}

	//달 plus 계산 
	function addCalCalenadar(year, month) {
		if (month == 12) {
			year = year + 1;
			month = 1;
		} else {
			month = month + 1;
		}
		return new Date(year, month);
	}

	//달 - 계산 
	// 리턴값 : new Date()
	function minusCalCalenadar(year, month) {
		if (month == 1) {
			year = year - 1;
			month = 12;
		} else {
			month = month - 1;
		}
		return new Date(year, month, 0);
	}

	// 분기 +,- 계산
	// 리턴값 : string (분기)
	function fn_addMinusQuarter(quarter) {
		if (quarter == "last") {
			quarter = "first";
		} else {
			quarter = "last";
		}
		return quarter;
	}

	// 분기에 따른 년도 + 계산
	// 리턴값 : string (년도)
	function fn_addYear(quarter) {
		var year;
		var standardYear = selectYear.val();
		if (quarter == "last") {
			year = (parseInt(standardYear) + 1).toString();
		} else {
			year = standardYear
		}
		return year;
	}

	// 분기에 따른 년도 년도- 계산
	// 리턴값 : new Date()
	function fn_minusYear(quarter) {
		var year;
		var standardYear = selectYear.val();
		if (quarter == "last") {
			year = standardYear;
		} else {
			year = (parseInt(standardYear) - 1).toString();
		}
		return year;
	}

	//pre,next 버튼 클릭시 
	// 결과 : 1개월 ) 달력 날짜 지정 ex) $("#jqxcalendar1").jqxCalendar('setDate', ??);
	//      6개월 ) 검색조건인 year,quater 변경하고 6개 달력다시그려줌 (fn_reDrawSixMonCalendar)
	function fn_clickArrow(obj) {
		var month = $("#jqxcalendar1").jqxCalendar('getDate').getMonth();
		var year = $("#jqxcalendar1").jqxCalendar('getDate').getFullYear();

		if ($("#period").val() == '1') { // 달력 하나 보여줄때
			//달력 날짜 지정
			if (obj == 'right') {
				$("#jqxcalendar1").jqxCalendar('setDate',
						addCalCalenadar(year, month));
			} else {
				$("#jqxcalendar1").jqxCalendar('setDate',
						minusCalCalenadar(year, month));
			}
		} else {
			//year 변경
			if (obj == 'right') {
				selectYear.val(fn_addYear(selectQuarter.val()));
			} else {
				selectYear.val(fn_minusYear(selectQuarter.val()));
			}

			// quater변경
			selectQuarter.val(fn_addMinusQuarter(selectQuarter.val()));

			//6개월달력 다시그림
			fn_reDrawSixMonCalendar(selectQuarter.val());
		}
	}

	//검색조건 year onchange 시
	// 결과 : 1개월 ) 달력 날짜 지정 ex) $("#jqxcalendar1").jqxCalendar('setDate', ??);
	//      6개월 ) 6개 달력다시그려줌 (fn_reDrawSixMonCalendar)
	function fn_clickSelectBox(obj) {

		if ($("#period").val() == '6') {
			fn_reDrawSixMonCalendar();
		} else {
			var year = parseInt($(obj).val());
			$("#jqxcalendar1").jqxCalendar('setDate', new Date(year, 1, 0));
		}
	}

	//검색조건 기간(한달/육개월) onchange 시
	// 결과 : 한달/육개월 달력 모두 현재일자 기준으로 변경
	//     1개월 ) 1개월 달력다시그려줌 (fn_drawOneMonthCalendar)
	//     6개월 ) 6개월 달력다시그려줌 (fn_drawSixMonthCalendar);   
	function fn_clickPeroid(obj) {
		var period = $(obj).val();
		//현재년도 세팅
		selectYear.val(currentYear);

		if (period == "1") { //한달인경우

			selectQuarter.attr("style", "display:none");

			calendarSection.children().remove();
			calendarSection
					.append("<div id='jqxcalendar1' style='float:left'></div>");
			fn_drawOneMonthCalendar();
		} else { //6개월인 경우

			selectQuarter.attr("style", "display:inherit; margin-bottom:10px;");

			calendarSection.children().remove();
			for (var i = 1; i < 7; i++) {
				var text = "<div id='jqxcalendar"+i+"' style='float:left'></div>";
				calendarSection.append(text);
			}

			fn_drawSixMonthCalendar(fn_chkQuarter());
		}
	}

	//1개월 달력다시그려줌 (jqxCalendar)
	//달력 View 변경시 새로 년도 세팅 (fn_calendarValChg)
	function fn_drawOneMonthCalendar() {
		$("#jqxcalendar1").jqxCalendar({
			width : calendarWidth + "px",
			height : calendarHeight + "px",
			specialDatesRawData : calendar_data,
			// selectionMode: 'none',
			// enableWeekend: true,
			enableFastNavigation : false
		});
		// $("#jqxcalendar1").jqxCalendar('setDate', new  Date(2010, 1, 0));

		$("#leftNavigationArrowViewjqxcalendar1").attr("style", "display:none");
		$("#rightNavigationArrowViewjqxcalendar1")
				.attr("style", "display:none");

		fn_calendarValChg();
	}

	//달력 View 변경시 새로 년도 세팅
	function fn_calendarValChg() {
		$('#jqxcalendar1').bind('valuechanged', function(event) {
			var date = event.args.date;
			$("#log").text(date.toDateString());
			//fn_callCalendarPopup(date);
			fn_setSelectYear(date.getFullYear());
		});
	}

	//현재달 기준으로 상하반기 체크
	function fn_chkQuarter() {
		var first = [ 1, 2, 3, 4, 5, 6 ];
		var period;
		if ($.inArray(currentMonth, first) != -1) { //상반기
			period = "first";
		} else { //하반기
			period = "last";
		}

		return period;
	}
	//6개월 달력다시그려줌 (jqxCalendar)  
	function fn_drawSixMonthCalendar(quarter) {
		var i = 0;
		while (true) {
			i++;
			$("#jqxcalendar" + i).jqxCalendar({
				width : (parseInt(calendarWidth) - 6) / 3 + 'px',
				height : (parseInt(calendarHeight) - 4) / 2 + 'px',//205px
				specialDatesRawData : calendar_data,
				selectionMode : 'none',
				// enableWeekend: true,
				enableFastNavigation : false,
				enableViews : false
			//disabled: true
			});
			if (quarter == "first") {
				$("#jqxcalendar" + i).jqxCalendar('setDate',
						new Date(selectYear.val(), i, 0));
			} else {
				$("#jqxcalendar" + i).jqxCalendar('setDate',
						new Date(selectYear.val(), i + 5, 0));
			}

			$("#leftNavigationArrowViewjqxcalendar" + i).attr("style",
					"display:none");
			$("#rightNavigationArrowViewjqxcalendar" + i).attr("style",
					"display:none");

			if (i == 6) {
				break;
			}
		}
	}
	//검색 조건 quarter onchange시 
	//결과 : 6개월 달력다시그려줌 (fn_reDrawSixMonCalendar)
	function fn_selectQuarter() {
		fn_reDrawSixMonCalendar();
	}

	function fn_reDrawSixMonCalendar(quarter) {
		calendarSection.children().remove();
		for (var i = 1; i < 7; i++) {
			var text = "<div id='jqxcalendar"+i+"' style='float:left'></div>";
			calendarSection.append(text);
		}
		if (quarter == null && quarter == undefined) { //biannual아님?
			fn_drawSixMonthCalendar($("#quarter").val());
		} else {
			fn_drawSixMonthCalendar(quarter);
		}
	}

	function fn_callCalendarPopup(data) {
		var title = "Holiday Update";
		// 		if (userEnv.editMode == "EDIT") {
		// 			title = "UI_TEXT_LABEL_EDIT_USER".i18n();
		// 		}

		var pop;
		if (LEGO_POPUP.hasPopup('updateholidayPopup')) {
			pop = LEGO_POPUP.getPopup('updateholidayPopup');
		} else {
			pop = LEGO_POPUP.createPopup({
				name : 'updateholidayPopup',
				url : CONTEXTPATH + '/test',
				title : title,
				width : '500',
				height : '400',
				async : false,
				popupArgs : {
					popType : "ADD",
					data : data,
				// 					async: false,
				// 					pageNum : $('#pager').jqxPager('getSelectedPage'),
				// 					srchUserId : $('#srchUserId').val(),
				// 					srchUserNm : $('#srchUserNm').val(),
				// 					srchStatusCd : $('#srchStatusCd').val(),

				},
				closeCallback : function closeCallback() {
					LEGO_POPUP.destroyPopup('updateholidayPopup');
					//userEnv.editMode = "ADD";
					console.log('closeCallback');
					//					$('#pager').jqxPager('movePage', 1);
				},
				destroyCallback : function destroyCallback() {

					//userEnv.editMode = "ADD";
					console.log('destroyCallback');
				}
			});
		}
		pop.show();

	}
</script>
<body>
	<div id="wrap" style="padding-top:8%">
		<!--  팝업 모달처리를 위해  -->
		<div id='content'>

			<div id='box'
				style="border-style: solid; border-width: 1px; border-color: #c7c7c7; margin: 0 auto; ">
				<div class="calendar_header">
					<div class="search_area fix aui-searchbox-searcharea">
						<span> <select id="period" onchange="fn_clickPeroid(this)">
								<option value="1">One Month</option>
								<option value="6">Six Months</option>
						</select>
						</span> <span>
						<div id="countryCombo"  role="combobox"></div>
						<!-- <select>
								<option>Republic of Korea</option>
								<option>China</option>
						</select> -->
						</span>


					</div>
				</div>
				<div class="calendar_menu">
					<div class="btn_box">
						<span class="btn_prev" onclick="fn_clickArrow('left')" ></span>					
						<span id="yearpickerDiv" class="yearpicker"> 
							<select id="yearpicker" style="margin-bottom: 10px;onchange="fn_clickSelectBox(this)"></select>
						</span>
						
						<span class="biannualpicker" >
							<select id="quarter" style="display: none; margin-bottom: 10px; onchange="fn_selectQuarter()">
								<option value="last">Last</option>
								<option value="first">First</option>
						</select>
						</span> 
						
						<span class="btn_next" onclick="fn_clickArrow('right')" ></span>
						
						<span style="float:right; margin-right: 5px;"><a><span id="searchDiv" class="btn_sh" style="border-radius: 10px; padding: 0px 7px; font-size: 14px;"
						onclick="fn_callCalendarPopup()"> + </span> </a>
						</span>
					</div>
				</div>
			

				<div id="drowCalendar">
					<div id='jqxcalendar1' style="float: left"></div>
					<div id='jqxcalendar2' style="float: left"></div>
					<div id='jqxcalendar3'></div>
					<div id='jqxcalendar4' style="float: left"></div>
					<div id='jqxcalendar5' style="float: left"></div>
					<div id='jqxcalendar6' style="float: left"></div>
				</div>
			</div>


			<div id='log'></div>
		</div>
	</div>
</body>
<script	src="<c:url value="/holidayCalendar/calendar.js" />"></script>
</html>
