<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title><spring:message code="sys.v2.client.log.manage" /></title>
<!-- 日志管理 -->
<%@include file="/ybl/v2/admin/common/link.jsp"%>
<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/v2/js/systemSetting/logManage.js"></script>
<style type="text/css">
	div {
	    white-space: pre;
	    font-size: 14px;
	    font-family: Courier, monospace;
	}
</style>
</head>
<body>
	<div id="result"></div>
</body>
<script type="text/javascript">
$(function(){
	var str = '${context}';
	var json = eval('(' + str + ')'); 
	$('#result').text(formatJson(json));
});

var formatJson = function(json, options) {
    var reg = null,
      formatted = '',
      pad = 0,
      PADDING = '    '; // one can also use '\t' or a different number of spaces

    // optional settings
    options = options || {};
    // remove newline where '{' or '[' follows ':'
    options.newlineAfterColonIfBeforeBraceOrBracket = (options.newlineAfterColonIfBeforeBraceOrBracket === true) ? true : false;
    // use a space after a colon
    options.spaceAfterColon = (options.spaceAfterColon === false) ? false : true;
    
    // begin formatting...

    // make sure we start with the JSON as a string
    if (typeof json !== 'string') {
      json = JSON.stringify(json);
    }
    // parse and stringify in order to remove extra whitespace
    json = JSON.parse(json);
    json = JSON.stringify(json);

    // add newline before and after curly braces
    reg = /([\{\}])/g;
    json = json.replace(reg, '\r\n$1\r\n');

    // add newline before and after square brackets
    reg = /([\[\]])/g;
    json = json.replace(reg, '\r\n$1\r\n');
    
    // add newline after comma
    reg = /(\,)/g;
    json = json.replace(reg, '$1\r\n');
    
    // remove multiple newlines
    reg = /(\r\n\r\n)/g;
    json = json.replace(reg, '\r\n');
    
    // remove newlines before commas
    reg = /\r\n\,/g;
    json = json.replace(reg, ',');

    // optional formatting...
    if (!options.newlineAfterColonIfBeforeBraceOrBracket) {     
      reg = /\:\r\n\{/g;
      json = json.replace(reg, ':{');
      reg = /\:\r\n\[/g;
      json = json.replace(reg, ':[');
    }
    if (options.spaceAfterColon) {      
      reg = /\:/g;
      json = json.replace(reg, ': ');
    }

    $.each(json.split('\r\n'), function(index, node) {
      var i = 0,
        indent = 0,
        padding = '';
      
      if (node.match(/\{$/) || node.match(/\[$/)) {
        indent = 1;
      } else if (node.match(/\}/) || node.match(/\]/)) {
        if (pad !== 0) {
          pad -= 1;
        }
      } else {
        indent = 0;
      }
    
      for (i = 0; i < pad; i++) {
        padding += PADDING;
      }
    
      formatted += padding + node + '\r\n';
      pad += indent;
    });
    
    return formatted;
};
</script>
</html>