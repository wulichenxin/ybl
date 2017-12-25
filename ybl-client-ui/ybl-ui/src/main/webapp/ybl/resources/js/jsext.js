var ext = {
	/**
	 * 格式化金额100000->100,000
	 * @param s	总金额 number
	 * @param n	保留小数
	 * @returns {String}  ###,###.##
	 */
	formatMoney:function(s,n){
		if(n!=0){
			n = n > 0 && n <= 20 ? n : 2;
		}
		s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toFixed(n) + "";
		var l = s.split(".")[0].split("").reverse(), r = s.split(".")[1];
		t = "";
		for (i = 0; i < l.length; i++) {
			t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length ? "," : "");
		}
		if(n==0){
			return t.split("").reverse().join("");
		}else{
			return t.split("").reverse().join("") + "." + r;
		}
	},
	/**
	 * ext.format('yyyy-MM-dd h:m:s')
	 */
	formatDate:function(time,format){
		var date = {
		           "M+": time.getMonth() + 1,
		           "d+": time.getDate(),
		           "h+": time.getHours(),
		           "m+": time.getMinutes(),
		           "s+": time.getSeconds(),
		           "q+": Math.floor((time.getMonth() + 3) / 3),
		           "S+": time.getMilliseconds()
		    };
		    if (/(y+)/i.test(format)) {
		           format = format.replace(RegExp.$1, (time.getFullYear() + '').substr(4 - RegExp.$1.length));
		    }
		    for (var k in date) {
		           if (new RegExp("(" + k + ")").test(format)) {
		                  format = format.replace(RegExp.$1, RegExp.$1.length == 1
		                         ? date[k] : ("00" + date[k]).substr(("" + date[k]).length));
		           }
		    }
		    return format;
	},
	//校验
	formValidation:function(formId){
		return ($("#"+formId)||$("."+formId)).validationEngine({
			validationEventTriggers : "blur", // 触发的事件
			inlineValidation : true,// 是否即时验证，false为提交表单时验证,默认true
			success : false,// 为true时即使有不符合的也提交表单,false表示只有全部通过验证了才能提交表单,默认false
			promptPosition : "bottomLeft",// 提示所在的位置，topLeft, topRight,bottomLeft,bottomRight
			maxErrorsPerField:1,//一次只提示一条提醒信息
			autoHidePrompt:true,
			autoHideDelay:2000,
			scroll:false
		})
	}
}
