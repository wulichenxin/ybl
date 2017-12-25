function getWebAppPath() {   
    var url = window.location.href;
    var htmlIndex=url.indexOf("html", 0);
    if(htmlIndex>0){
    	url=url.substring(0, htmlIndex);
    }
    return url;
}
var webAppPath=getWebAppPath();

function sendAjax(arrayParam) {
	var urlStr=arrayParam["url"]==null?"":arrayParam["url"];
	var sendData=arrayParam["data"]==null?null:arrayParam["data"];
	var sendType=arrayParam["type"]==null?"POST":arrayParam["type"];
	var msgType=arrayParam["dataType"]==null?"json":arrayParam["dataType"];
	var successFunc=arrayParam["success"]==null?null:arrayParam["success"];
	var failFunc=arrayParam["fail"]==null?function(data){if(data.msg!=null && data.msg!=""){alert(data.msg);}}:arrayParam["fail"];
	var completeFunc=arrayParam["complete"]==null?null:arrayParam["complete"];
	var errorFunc=arrayParam["error"]==null?null:arrayParam["error"];
	var asyncFlag=arrayParam["async"]==null?true:arrayParam["async"];//异步
	var traditionalFlag=arrayParam["traditional"]==null?false:arrayParam["traditional"];//阻止深度序列化,用来提交数组
    $.ajax({
            url: webAppPath+urlStr,
            timeout : 10000,
            type: sendType,
            async: false,
            data: sendData,
            dataType: msgType,
            async: asyncFlag,
            traditional:traditionalFlag,
            success: function(data) {
            	var status=data.status;
                if(status==200){
                	if(successFunc!=null){
                		successFunc(data);
                	}
                }else{
                	if(failFunc!=null){
                		failFunc(data);
                	}
                }
            },
          error: errorFunc,
          //complete: completeFunc
          complete : function(XMLHttpRequest,status){ //请求完成后最终执行参数
        	  if(status=='timeout'){//超时,status还有success,error等值的情况
        		  alert("服务器连接超时，请重试！");
        	  }
          }
     });
}

//点击之后控制其继续操作
function ajax() {
	var bodyWidth = document.documentElement.clientWidth;   
	var bodyHeight =Math.max(document.documentElement.clientHeight,document.body.scrollHeight);       
	$("<div class='wrap'></div>").appendTo("body");
	$(".wrap").width(bodyWidth);$(".wrap").height(bodyHeight); 
}

function  setFormDisable(formId,isDisabled){
	$("form[id='"+formId+"'] :text").attr("disabled",isDisabled);
	$("form[id='"+formId+"'] :password").attr("disabled",isDisabled); 
	$("form[id='"+formId+"'] textarea").attr("disabled",isDisabled);  
	$("form[id='"+formId+"'] select").attr("disabled",isDisabled);  
	$("form[id='"+formId+"'] :radio").attr("disabled",isDisabled);  
	$("form[id='"+formId+"'] :checkbox").attr("disabled",isDisabled); 
}

/**
 * 获取url参数
 * @param name
 * @returns
 */
function getUrlParam(name) {  
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象  
    var r = window.location.search.substr(1).match(reg);  //匹配目标参数  
    if (r != null) return unescape(r[2]); return null; //返回参数值  
}

/**
 * 将josn对象赋值给form
 * @param {dom} 指定的选择器
 * @param {obj} 需要给form赋值的json对象
 * @method serializeJson
 **/
$.fn.setForm = function(jsonValue){
  var obj = this;
  if(jsonValue!=null){
	  $.each(jsonValue,function(name,ival){
	    var $oinput = obj.find("input[name="+name+"]");
	    if($oinput.attr("type")=="checkbox"){
	      if(ival !== null){
	        var checkboxObj = $("[name="+name+"]");
	        var checkArray = ival.split(";");
	        for(var i=0;i<checkboxObj.length;i++){
	          for(var j=0;j<checkArray.length;j++){
	            if(checkboxObj[i].value == checkArray[j]){
	              checkboxObj[i].click();
	            }
	          }
	        }
	      }
	    }
	    else if($oinput.attr("type")=="radio"){
	      $oinput.each(function(){
	        var radioObj = $("[name="+name+"]");
	        for(var i=0;i<radioObj.length;i++){
	          if(radioObj[i].value == ival){
	            radioObj[i].click();
	          }
	        }
	      });
	    }
	    else if($oinput.attr("type")=="textarea"){
	      obj.find("[name="+name+"]").html(ival);
	    }
	    else{
	      obj.find("[name="+name+"]").val(ival);
	    }
	  });
  }
};

//对Date的扩展，将 Date 转化为指定格式的String
//月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符， 
//年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字) 
//例子： 
//(new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423 
//(new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18 
Date.prototype.Format = function (fmt) { //author: meizz 
    var o = {
        "M+": this.getMonth() + 1, //月份 
        "d+": this.getDate(), //日 
        "h+": this.getHours(), //小时 
        "m+": this.getMinutes(), //分 
        "s+": this.getSeconds(), //秒 
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
        "S": this.getMilliseconds() //毫秒 
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
};
function isNull(data){
	if(data != null && data != undefined){
		return data;
	}else{
		return 0;
	}
}
function isNullString(data){
	if(data != null && data != undefined){
		return data;
	}else{
		return "未知";
	}
}

function time(second){
    var s = second!=undefined?parseInt(second):00;// 秒 
	var m = 0;// 分 
	var h = 0;// 小时 
	if(s >= 60) {
		m = parseInt(s / 60);
		s = parseInt(s % 60);
		if(m >= 60) {
			h = parseInt(m / 60);
			m = parseInt(m % 60);
		}
	}
	if (h<10) h ="0"+h;if (m<10) m ="0"+m;if (s<10) s ="0"+s;
	return h > 0 ? (h + ":" + m + ":" + s) : (m > 0 ? (h + ":" + m + ":" + s ) : (h + ":" + m + ":" + s));
}