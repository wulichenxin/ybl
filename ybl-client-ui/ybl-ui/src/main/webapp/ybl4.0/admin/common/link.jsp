<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta http-equiv="X-UA-Compatible" content="IE=10">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl4.0/resources/css/page.css"/>

<!-- ybl-v4 -->
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl4.0/resources/css/index.css" />
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl4.0/resources/jquery.datetimepicker/jquery.datetimepicker.css" />
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl4.0/resources/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl4.0/resources/css/font-awesome.css" />
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl4.0/resources/css/htmleaf-demo.css">
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl4.0/resources/css/bootsnav.css">
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/css/validationEngine.jquery.css" />
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl/resources/css/xcConfirm.css"/>
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl4.0/resources/messagebox/dialog.css">
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl4.0/resources/messagebox/messagebox.css">
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl4.0/resources/messagebox/page.css">

<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/js/jquery-1.11.1.js"></script>
<link href="/ybl/resources/images/favicon.ico" rel="shortcut icon" mce_href="/ybl/resources/images/favicon.ico" type="image/x-icon">
<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/js/index.js" ></script>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/jquery.datetimepicker/jquery.datetimepicker.min.js"></script>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/js/bootsnav.js"></script>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/messagebox/dialog.js"></script>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/messagebox/messagebox.js"></script>

<script language='javascript' src='${app.staticResourceUrl}/ybl/resources/js/i18n/jquery.i18n.properties.min.js'></script>
<script language='javascript' src='${app.staticResourceUrl}/ybl/resources/js/i18n/i18n.js'></script>

<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/v2/js/yuangong_v2.js"></script>
<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/js/jsext.js"></script>
<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/plugins/jquery.form.3.51/jquery.form.js"></script>
<script language='javascript' src='${app.staticResourceUrl}/ybl/resources/js/jquery.hDialog.min.js'></script>
<script language='javascript' src='${app.staticResourceUrl}/ybl/resources/js/jquery-extends.js'></script>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/v2/js/jquery.dragndrop_v2.js"></script>

<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/v2/js/jquery.msgbox_v2.js"></script>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/xcConfirm.js"></script>
<script src="/ybl/resources/plugins/messagebox/messagebox.js" type="text/javascript" ></script>
<script language='javascript' src='${app.staticResourceUrl}/ybl/resources/js/jquery.fancybox-1.3.1.pack.js'></script>


<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine-zh_CN.js"></script>
<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine.js"></script>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/jquery.dragndrop.js"></script>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/jquery.msgbox.js"></script>

<!-- jquery校验 -->
<link rel="stylesheet" href="/ybl4.0/resources/css/custom_validate.css"/>
<script type="text/javascript" src="/ybl4.0/resources/js/common/jquery.validate.min.js"></script>
<script type="text/javascript" src="/ybl4.0/resources/js/common/messages_zh.js"></script>
<!-- 自定义校验规则 -->
<script type="text/javascript" src="/ybl4.0/resources/js/common/validate.expand.js"></script>
<script>
function jumpPost(url,args) {
	var form = $("<form method='post'></form>");
    form.attr({"action":url});
    for (arg in args) {
        var input = $("<input type='hidden'>");
        input.attr({"name":arg});
        input.val(args[arg]);
        form.append(input);
    }
    $(document.body).append(form);
    form.submit();
}
</script>
<script>
$(function() {
	window.alert = function(msg) {
		window.wxc.xcConfirm(msg, window.wxc.xcConfirm.typeEnum.info);
	}
	
	window.alert = function(msg, _callback) {
		if(_callback) {
			window.wxc.xcConfirm(msg, window.wxc.xcConfirm.typeEnum.info, {
				onOk : function(v) {
					_callback();
				}
			});
		} else {
			window.wxc.xcConfirm(msg, window.wxc.xcConfirm.typeEnum.info);
		}
	}
	
	window.confirm = function(msg, _callback) {
		if(_callback) {
			window.wxc.xcConfirm(msg, window.wxc.xcConfirm.typeEnum.confirm, {
				onOk : function(v) {
					_callback();
				}
			});
		} else {
			window.wxc.xcConfirm(msg, window.wxc.xcConfirm.typeEnum.confirm);
		}
	}
	
});
</script>