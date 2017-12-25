<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta http-equiv="X-UA-Compatible" content="IE=10">
<meta name="Keywords" content="云保理2.0">
<meta name="Description" content="云保理2.0">
<meta name="Copyright" content="云保理2.0" />
<link href="${app.staticResourceUrl}/ybl/resources/images/favicon.ico" rel="shortcut icon">
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl/resources/css/xcConfirm.css"/>
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl/resources/v2/css/css_v2.css"/>
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl/resources/v2/css/vip_page_v2.css"/>
<link href="/ybl/resources/plugins/messagebox/messagebox.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl/resources/css/fancybox.css"/>
<script language='javascript' src='${app.staticResourceUrl}/ybl/resources/js/jquery-1.8.0.min.js'></script>
<script language='javascript' src='${app.staticResourceUrl}/ybl/resources/js/i18n/jquery.i18n.properties.min.js'></script>
<script language='javascript' src='${app.staticResourceUrl}/ybl/resources/js/i18n/i18n.js'></script>
<script language='javascript' src='${app.staticResourceUrl}/ybl/resources/js/common.js'></script>
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


