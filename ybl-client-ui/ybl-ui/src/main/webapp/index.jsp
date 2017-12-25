<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
</head>
<body  onload="onloadFun();">
</body>
<script>
	function onloadFun() {
		if(!!parent) {
			top.location.href='/loginV4Controller/index.htm';
		} else {
			window.location='/loginV4Controller/index.htm';
		}
	}
</script>
</html>
