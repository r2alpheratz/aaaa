/*
 * Copyright © 2014 Lego Team ..
 * 본 코드는 Lego 팀에서 개발한 공통모듈로 Samsung SDS  내에서 자유롭게 수정 및 확산이  가능하며 기여 또한 가능합니다.
 *  homepage : http://70.121.244.190/gitnsam
 *
 */
var BDA_GRID_UTIL = {
	/***************************************************************************
	 * [BDA_GRID_UTIL] Count Object설정.(TreeGrid는 선택Count는 설정하지 않는다)
	 **************************************************************************/
	setTreeGridTotalCount : function(treeGridDataSetObj, totalCntObjectId,
			pagingCntObjectId) {
		var rowCount = treeGridDataSetObj.getRowCount();
		this.setGridCount("TOTAL",  totalCntObjectId, treeGridDataSetObj.getRowCount());
		this.setGridCount("PAGING", pagingCntObjectId, treeGridDataSetObj);

//		$("#" + pagingCntObjectId).text(rowCount);
//		$("#" + totalCntObjectId).text(rowCount);
	},
	/*******************************************************************************
	 * [BDA_GRID_UTIL] grid 현재 선택된 rowIndex 리턴
	 *******************************************************************************/
	getCurrentGridRowIndex : function(gridObj)
	{
		var currentRowIndex = gridObj.jqxGrid('getselectedrowindex');
		return currentRowIndex;
	},
	/*******************************************************************************
	 * [BDA_GRID_UTIL] rowIndex의 rowData 리턴
	 *******************************************************************************/
	getGridRowData : function(gridObj, rowIndex)
	{
		return gridObj.jqxGrid('getrowdata', rowIndex);
	},
	/*******************************************************************************
	 * [BDA_GRID_UTIL] check된 rowIndexes 리턴
	 *******************************************************************************/
	getSelectedRowIndexes : function(gridObj){
		return gridObj.jqxGrid('getselectedrowindexes');
	},
	/*******************************************************************************
	 * [BDA_GRID_UTIL] auto resize Column
	 *******************************************************************************/
	autoresizeColumn : function(gridObj)
	{
		return gridObj.jqxGrid('autoresizecolumns');
	},
	clearGridData : function(gridObj)
	{
		return gridObj.jqxGrid('clear');
	},
	/*******************************************************************************
	 * [BDA_GRID_UTIL] Count Object설정.
	 *******************************************************************************/
	setGridCount : function(typeCd, cntObjId, paramObj1)
	{
		var rowCnt = 0;

		if(typeCd == "TOTAL") //TOTAL_CNT
		{
			rowCnt = paramObj1;// paramObj1 = TOTAL_CNT
		}
		else if(typeCd == "PAGING") // PAGING_CNT
		{
			if(  BDA_JAVA_UTIL.isNotNullObject(paramObj1) ) // paramObj1 = GRID_DATASET_OBJECT
			{
				rowCnt = paramObj1.getRowCount();
			}
		}
		else if(typeCd == "SELECTED") // SELECTED_CNT
		{
			if(  BDA_JAVA_UTIL.isNotNullObject(paramObj1) ) // paramObj1 = GRID_OBJECT
			{
				var selectedRows = paramObj1.jqxGrid('getselectedrowindexes');
				if( BDA_JAVA_UTIL.isNotNullObject(selectedRows) )
				{
					rowCnt = selectedRows.length;
				}
			}
		}

		$("#" + cntObjId).text(rowCnt);
	}
};

var BDA_JAVA_UTIL = {
		/*******************************************************************************
		 * [BDA_JAVA_UTIL] Object null체크
		 *******************************************************************************/
		isNotNullObject : function(obj)
		{
			var isNull = false;

			if(obj != undefined && obj != null)
			{
				isNull = true;
			}

			return isNull;
		}

	};


