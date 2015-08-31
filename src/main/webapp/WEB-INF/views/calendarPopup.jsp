<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script type="text/javascript">

jQuery(document).ready(function() {
    jQuery('.tabs .tab-links a').on('click', function(e)  {
        var currentAttrValue = jQuery(this).attr('href');
 
        // Show/Hide Tabs
        jQuery('.tabs ' + currentAttrValue).show().siblings().hide();
 
        // Change/remove current tab to active
        jQuery(this).parent('li').addClass('active').siblings().removeClass('active');
 
        e.preventDefault();
    });
});

</script>

<div class="tabs">
    <ul class="tab-links">
        <li class="active"><a href="#tab1">general</a></li>
        <li><a href="#tab2">period</a></li>
    </ul>
 
    <div class="tab-content">
        <div id="tab1" class="tab active">
            <div class="detail_basic" style="margin-top: 5%;;margin-bottom: 65px;">
				<form name="menuForm" id="menuForm">
					<table class="table-border">
						<colgroup>
							<col width="25%">
							<col width="">
						</colgroup>
						<thead style="display: none"></thead>
						<tfoot></tfoot>
			
						<tbody>
							<tr>
								<th><span class="essential fL"><span>date</span></th>
								<td>
									<input type="text" name="holidayStDt" id="holidayStDt"
									vtype="required,correctKoEngNullNumCheck"
									vname="ddddddddd"
									id="menuNm" maxlength="15" style="width: 80px"
									onkeypress="gf_checkTypes(this, 'NOTSPC', event);"
									onKeyDown="limitText(this.form.menuNm,this.form.countdownName,15);"
									onKeyUp="limitText(this.form.menuNm,this.form.countdownName,15);">
									-
									<input type="text" name="holidayEndDt" id="holidayEndDt"
									vtype="required,correctKoEngNullNumCheck"
									vname="ddddddddd"
									id="menuNm" maxlength="15" style="width: 80px"
									onkeypress="gf_checkTypes(this, 'NOTSPC', event);"
									onKeyDown="limitText(this.form.menuNm,this.form.countdownName,15);"
									onKeyUp="limitText(this.form.menuNm,this.form.countdownName,15);">
								
								</td>
							</tr>
							<tr>
								<th><span id="menuSpan" class="essential fL">name</span></th>
								<td>	
								  <input type="text" name="holidayNm" id="holidayNm"
									vtype="required,correctKoEngNullNumCheck"
									vname="ddddddddd"
									id="menuNm" maxlength="15" style="width: 150px"
									onkeypress="gf_checkTypes(this, 'NOTSPC', event);"
									onKeyDown="limitText(this.form.menuNm,this.form.countdownName,15);"
									onKeyUp="limitText(this.form.menuNm,this.form.countdownName,15);">
									<input readonly
									class="jqx-widget jqx-radiobutton jqx-fill-state-disabled"
									id="countdownName" size="2" style="text-align: right" /> 
								</td>
							</tr>
							<tr>
								<th><span class="essential fL">description</span></th>
								<td>
									<textarea name="holidayDescription" id="holidayDescription" style="width: 300px"
											     onKeyDown="limitText(this.form.codeDescription,this.form.countdownDesc,100);"
												 onKeyUp="limitText(this.form.codeDescription,this.form.countdownDesc,100);">
											</textarea><!-- onkeypress="gf_checkTypes(this, 'NOTSPC', event);" -->
								</td>
									
							</tr>
							<tr>
								<th><span class="essential fL">calendar style</span></th>
								<td>
								  <input type="radio" name="menuOrderNo" id="menuOrderNo"
									onkeypress="gf_checkTypes(this, 'NUM', event);" maxlength="2"
									onkeyup="gf_delHangul(this)" vtype="required,onlyNumCheck"
									vname="ss"
									style="width: 45px">solar(양력)
									<input type="radio" name="menuOrderNo" id="menuOrderNo"
									onkeypress="gf_checkTypes(this, 'NUM', event);" maxlength="2"
									onkeyup="gf_delHangul(this)" vtype="required,onlyNumCheck"
									vname="sss"
									style="width: 45px"> luna(음력)
								</td>
							</tr>
							<tr>
								<th><span id="menuUrlSpan" class="noessential fL">frequncy</span></th>
								<td>
									<input type="radio" name="menuOrderNo" id="menuOrderNo"
									onkeypress="gf_checkTypes(this, 'NUM', event);" maxlength="2"
									onkeyup="gf_delHangul(this)" vtype="required,onlyNumCheck"
									vname="sss" style="width: 45px">every year
									<br/><br/>
									<input type="radio" name="menuOrderNo" id="menuOrderNo"
									onkeypress="gf_checkTypes(this, 'NUM', event);" maxlength="2"
									onkeyup="gf_delHangul(this)" vtype="required,onlyNumCheck"
									vname="sss" style="width: 45px">
									
									<input type="text" name="menuNm" id="menuNm"
									vtype="required,correctKoEngNullNumCheck"
									vname="ddddddddd"
									id="menuNm" maxlength="15" style="width: 150px"
									onkeypress="gf_checkTypes(this, 'NOTSPC', event);"
									onKeyDown="limitText(this.form.menuNm,this.form.countdownName,15);"
									onKeyUp="limitText(this.form.menuNm,this.form.countdownName,15);">
									time(s)
			
								</td>
							</tr>	
							<input type="hidden" name="useYn" id="useYn" />
							<input type="hidden" name="parentMenuSq" id="parentMenuSq" />
	
						</tbody>
					</table>
				</form>
			</div>
        </div>
 
        <div id="tab2" class="tab">
            <div id="searchBox" class="search_box mt10 aui-searchbox">
				<div class="search_area fix aui-searchbox-searcharea">
					pre next
				</div>
			</div>
			<div class="mt50" style="margin-top:10px">
				<div class="gridtable fix mt10">
					<div class="table_total">
					 total <span id="total1_divGrid" class="total_color3">0</span>
					</div>
					<div class="icoleftbox">
						<span id="btn_rowAdd" class="add_col_icon mr10"></span> <span
							id="btn_rowDel" class="del_sel_ico"></span>
					</div>
				</div>
				<div id="holidayGrid" role="grid" align="left"
					class="jqx-grid jqx-reset jqx-rc-all jqx-widget jqx-widget-content jqx-disableselect"></div>
				<div class="pager-wrapper">
			        	<div id="pager"/>
			        </div>
				<br />
			</div>
        </div>
    </div>
     <p class="btnarea" style="bottom: 0px;margin-left: 85%;;margin-top: -20px;">
			<a><span id="searchDiv" class="btn_sh" onclick="fn_callCalendarPopup()"> Save </span> </a>
	</p>
</div>
<script src="<c:url value="/holidayCalendar/calendarPopup.js" />"></script>