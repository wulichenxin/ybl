<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta http-equiv="X-UA-Compatible" content="IE=10">
<meta name="Keywords" content="äºä¿ç">
<meta name="Description" content="äºä¿ç">
<meta name="Copyright" content="äºä¿ç" />
<link href="${app.staticResourceUrl}/ybl/resources/images/favicon.ico" rel="shortcut icon">
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl/resources/css/page.css"/>
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl/resources/css/css.css"/>
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl/resources/css/vip_page.css"/>
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl/resources/css/comcon.css"/>
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl/resources/css/xcConfirm.css"/>
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl/resources/css/fancybox.css"/>
<script language='javascript' src='${app.staticResourceUrl}/ybl/resources/js/jquery-1.8.0.min.js'></script>
<script language='javascript' src='${app.staticResourceUrl}/ybl/resources/js/i18n/jquery.i18n.properties.min.js'></script>
<script language='javascript' src='${app.staticResourceUrl}/ybl/resources/js/i18n/i18n.js'></script>
<script language='javascript' src='${app.staticResourceUrl}/ybl/resources/js/common.js'></script>
<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/js/yuangong.js"></script>
<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/js/jsext.js"></script>
<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/plugins/jquery.form.3.51/jquery.form.js"></script>
<script language='javascript' src='${app.staticResourceUrl}/ybl/resources/js/jquery.hDialog.min.js'></script>
<script language='javascript' src='${app.staticResourceUrl}/ybl/resources/js/jquery-extends.js'></script>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/jquery.dragndrop.js"></script>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/jquery.msgbox.js"></script>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/msgboxClose.js"></script>

<!-- æç¤ºæ¡ -->
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/xcConfirm.js"></script>
<script language='javascript' src='${app.staticResourceUrl}/ybl/resources/js/jquery.fancybox-1.3.1.pack.js'></script>


<script>
$(function() {
	
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
	
	/*param为传递给_callback的参数*/
	window.alert = function(msg, _callback,param) {
		if(_callback) {
			window.wxc.xcConfirm(msg, window.wxc.xcConfirm.typeEnum.info, {
				onOk : function(v) {
					_callback(param);
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



