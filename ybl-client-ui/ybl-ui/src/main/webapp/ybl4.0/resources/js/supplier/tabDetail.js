$(function(){
	
	/**
	 * 各阶段详情页面中的返回按钮事件
	 */
	$("#btn-return").click(function(){
		var pageFlag=$('#pageFlag', parent.document).val();
		if(pageFlag == '6') {
			window.parent.location.href="/supplierAccountCenterController/receivingacount.htm"; //待收款页面
		}
		if(pageFlag == '8') {
			window.parent.location.href="/supplierAccountCenterController/supplierreceiving.htm"; //待还款页面
		}
		if(pageFlag == '2') {
			window.parent.location.href="/supplierAccountCenterController/supplieroverdue.htm"; //逾期
		}
		if(pageFlag == '1') {
			window.parent.location.href="/supplierAccountCenterController/supplierloanfail.htm"; //逾期
		}
		if(pageFlag == '3') {
			window.parent.location.href="/supplierAccountCenterController/supplierpayoff.htm"; //放款失败
		}
		if(pageFlag == '4') {
			window.parent.location.href="/supplierAccountCenterController/supplierrepayments.htm"; //已还款项目明细
		}
		
	});
	
});
