

$(function(){
	//debugger;
	//页面加载初始化年月
    var mydate = new Date();
    $(".f-year").html( mydate.getFullYear() );
    $(".f-month").html( mydate.getMonth()+1 );
  
    //日历上一月
    $(".f-btn-jian ").click(function(){
        var mm = parseInt($(".f-month").html());
        var yy = parseInt($(".f-year").html());
        if( mm == 1){//返回12月
            $(".f-year").html(yy-1);
            $(".f-month").html(12);
            showDate(yy-1,12);
        }else{//上一月
            $(".f-month").html(mm-1);
            showDate(yy,mm-1);
        }
    })
    //日历下一月
    $(".f-btn-jia").click(function(){
        var mm = parseInt($(".f-month").html());
        var yy = parseInt($(".f-year").html());
        if( mm == 12){//返回12月
            $(".f-year").html(yy+1);
            $(".f-month").html(1);
            showDate(yy+1,1);
        }else{//上一月
            $(".f-month").html(mm+1);
            showDate(yy,mm+1);
        }
    })
    //返回本月
    $(".f-btn-fhby").click(function(){
        $(".f-year").html( mydate.getFullYear() );
        $(".f-month").html( mydate.getMonth()+1 );
        showDate(mydate.getFullYear(),mydate.getMonth()+1);
    })
    
    //读取年月写入日历  重点算法!!!!!!!!!!!
    function showDate(yyyy,mm){
        var dd = new Date(parseInt(yyyy),parseInt(mm), 0);   //Wed Mar 31 00:00:00 UTC+0800 2010  
        var daysCount = dd.getDate();      //alert(daysCount);      //本月天数  
        var mystr ="";//写入代码
        var icon = "";//图标代码
        var today = new Date().getDate(); //今天几号  21
        var monthstart = new Date(parseInt(yyyy)+"/"+parseInt(mm)+"/1").getDay()//本月1日周几  
        var lastMonth; //上一月天数
        var nextMounth//下一月天数
        if(  parseInt(mm) ==1 ){
            lastMonth = new Date(parseInt(yyyy)-1,parseInt(12), 0).getDate();
        }else{
            lastMonth = new Date(parseInt(yyyy),parseInt(mm)-1, 0).getDate();
        }
        if( parseInt(mm) ==12 ){
            nextMounth = new Date(parseInt(yyyy)+1,parseInt(1), 0).getDate();
        }else{
            nextMounth = new Date(parseInt(yyyy),parseInt(mm)+1, 0).getDate();
        }
        //计算上月空格数
        for(j=monthstart;j>0;j--){
            mystr += "<div class='f-td f-null f-lastMonth' style='color:#ccc;'>"+(lastMonth-j+1)+"</div>";
        }
        var tempDate = yyyy+"-"+mm;
        var repaymentPlanList = null;
        $.ajax({url : "/factorAccountCenterController/queryMonthRepaymentPlan",
				dataType : "json",
				type : "post",
				//async: true,
				data : {dd:tempDate},
				success : function(data) {
						   if(data.responseType != 'ERROR'){
							   console.info(data.object);
							   repaymentPlanList = data.object;
							   
							   //本月单元格
					             for(i=1;i<=daysCount;i++){
					            	// debugger;
					             	mystr += "<div class='f-td f-number'><span class='f-day'>"+i+"</span>" ;
					             	//定义还款笔数 ,总还款金额
					             	var repaymentNum = 0 , repaymentSum = 0; var content = "";
					             	//变量应还款日期List
					             	 for(var m= 0;m < repaymentPlanList.length ;m++ ){
					             		var repaymentPlan = repaymentPlanList[m];
					             		var repaymentDate = repaymentPlan.repayment_date; //还款日期
					             		if(judegeTime(repaymentDate) != ""){
					             		   if(repaymentDate == dateTime(yyyy,mm,i)){
					             			//这里为一个单元格，添加内容在此
					             			  repaymentNum++;
					             			  repaymentSum = accAdd(repaymentPlan.repayment_principal, repaymentSum) ;
					             			content ="<div class='f-yuan'></div>"
					             				+ "<div class='f-table-msg'>回款笔数:<span class='major'>"
					             				+repaymentNum+"</span>笔,还款本息:<span class='major'>"
					             				+repaymentSum+"</span>元</div>" ; 
					             		   }
					             		}
					             	} 
					             	content += "</div>"
					             	mystr += content;
					             	
					             }
					            
					             //计算下月空格数
					             for(k=0; k<42-(daysCount+monthstart);k++ ){//表格保持等高6行42个单元格
					                 mystr += "<div class='f-td f-null f-nextMounth' style='color:#ccc;'>"+(k+1)+"</div>";
					             }
					              
					             //写入日历
					             $(".f-rili-table .f-tbody").html(mystr);
					             //给今日加class
					             if( mydate.getFullYear() == yyyy){
					                 if( (mydate.getMonth()+1 ) == mm){
					                     var today = mydate.getDate();
					                     var lastNum = $(".f-lastMonth").length;
					                     $(".f-rili-table .f-td").eq(today+lastNum-1).addClass("f-today");
					                 }
					             }
					             //绑定选择方法
					             $(".f-rili-table .f-number").off("click");
					             $(".f-rili-table .f-number").on("click",function(){
					                 $(".f-rili-table .f-number").removeClass("f-on");
					                 $(this).addClass("f-on");
					             });
					             
					             //绑定查看方法
					             $(".f-yuan").off("mouseover");
					             $(".f-yuan").on("mouseover",function(){
					                 $(this).parent().find(".f-table-msg").show();
					             });
					             $(".f-table-msg").off("mouseover");
					             $(".f-table-msg").on("mouseover",function(){
					                 $(this).show();
					             });
					             $(".f-yuan").off("mouseleave");
					             $(".f-yuan").on("mouseleave",function(){
					                 $(this).parent().find(".f-table-msg").hide();
					             });
					             $(".f-table-msg").off("mouseleave");
					             $(".f-table-msg").on("mouseleave",function(){
					                 $(this).hide();
					             });
							}else{
								
							}
						},
						error : function() {
							//alert("数据加载失败");
						}
					});
       
    }
	//图表（饼图-资产分布）start
	var data = $("#totalPrincipal").html().replace(/,/g, "");
	var data1 = $("#totalUnInterest").html().replace(/,/g, "");
	var allMount = $("#allMount").html().replace(/,/g, "");
	showPieDiagram_forMemberCenter(data,data1,"assets_chart_loading",allMount);
	//图表（饼图-资产分布）end
	 showDate(mydate.getFullYear(),mydate.getMonth()+1);
	
});

/**
 * 用户中心资产分布-饼图
 * @param num_1 待收本金
 * @param num_2 待收利息
 * @param containerId 展示的区域id
 * @param totalUserAmt 总资产
 */
function showPieDiagram_forMemberCenter(num_1,num_2,containerId,totalUserAmt){
	 var pieChart = echarts.init(document.getElementById(containerId));
	 var pieOption = {
			   title: {
			        text: '总资产',
			        subtext: totalUserAmt,
			        x: 'center',
			        y: 'center',
			       
			   },	
			   textStyle: {
                  fontSize: '18',
              },
	     tooltip: {
	         trigger: 'item',
	         formatter: "{a} <br/>{b}: {c} ({d}%)"
	     },
	     legend: {
	         orient: 'vertical',
	         x: 'left',
	         data:['','','','']
	     },
	     series: [
	      {
	             name:'资产统计',
	             type:'pie',
	             radius: ['60%', '76%'],
	             avoidLabelOverlap: false,
	             label: {
	                 normal: {
	                     show: false,
	                     position: 'center'
	                 },
	                 emphasis: {
	                     show: false,
	                     textStyle: {
	                         fontSize: '30',
	                         fontWeight: 'bold'
	                     }
	                 }
	             },
	             labelLine: {
	                 normal: {
	                     show: false
	                 }
	             },             
	             data:[
	                 {value:num_1, 
	                	 name:'待收本金',
	                	 itemStyle: {
	                	        normal: {
	                	            color: '#76a8f8'
	                	        }
	                	    }},
	                 {value:num_2, 
	            	    name:'待收利息', 
	              	  itemStyle: {
	                     normal: {
	                         color: '#ff8111'
	                     }
	                 }}
	        
	             ]
	         }
	     ]
	 };

	 pieChart.setOption(pieOption);
	
}
function dateAfter(dateStr, num) {
	 var date1 = new Date(Date.parse(dateStr.replace(/-/g,   "/")));
	 var date2 = new Date(date1);
	 date2.setDate(date1.getDate()+num);
	 var times = date2.getFullYear()+"-"+(date2.getMonth()+1)+"-"+date2.getDate();
	   return times;
}
//判断时间有没有
function judegeTime(datetime){
	if(datetime == undefined || datetime =="" || datetime=="NaN-NaN-NaN"){
	  return "";
  }else{
	return datetime;
   }
  }
//比较时间的大小
function GetDateDiff(startDate, endDate) {
	
	var startTime = new Date(Date.parse(startDate.replace(/-/g,   "/"))).getDate(); 
	var endTime  = new Date(Date.parse(endDate.replace(/-/g,   "/"))).getDate();
       
    var dates = startTime - endTime;     
    return  dates;
}
//当前日期加上1天
function addOneDate(maxDate){
	var curDate = new Date(Date.parse(maxDate.replace(/-/g,   "/"))).getTime();
	var addDate = new Date((curDate/1000+86400)*1000);
	return dateTime(addDate);
}
//日期格式转化
function dateTime(year,month,date) {
  month = month < 10 ? ('0' + month) : month;
  date = date < 10 ? ('0' + date) : date;
  return [year,month,date].join('-');
}
/** 
 * 加法 
 * @param arg1 
 * @param arg2 
 * @returns {Number} 
 */  
function accAdd(arg1, arg2) {  
    var r1, r2, m, c;  
    try { r1 = arg1.toString().split(".")[1].length } catch (e) { r1 = 0 }  
    try { r2 = arg2.toString().split(".")[1].length } catch (e) { r2 = 0 }  
    c = Math.abs(r1 - r2);  
    m = Math.pow(10, Math.max(r1, r2))  
    if (c > 0) {  
        var cm = Math.pow(10, c);  
        if (r1 > r2) {  
            arg1 = Number(arg1.toString().replace(".", ""));  
            arg2 = Number(arg2.toString().replace(".", "")) * cm;  
        }  
        else {  
            arg1 = Number(arg1.toString().replace(".", "")) * cm;  
            arg2 = Number(arg2.toString().replace(".", ""));  
        }  
    }  
    else {  
        arg1 = Number(arg1.toString().replace(".", ""));  
        arg2 = Number(arg2.toString().replace(".", ""));  
    }  
    return (arg1 + arg2) / m  
}