
<%@ page language="java" pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta http-equiv="X-UA-Compatible" content="IE=10">
<link href="/fw/resources/css/css.css" rel="stylesheet" type="text/css" />
<link href="/fw/resources/css/page.css" rel="stylesheet" type="text/css" />
<link href="/fw/resources/plugins/messagebox/messagebox.css" rel="stylesheet" type="text/css" />
<script src="/fw/resources/js/jquery-1.8.0.min.js" type="text/javascript" ></script>
<script src="/fw/resources/js/dialog.js" type="text/javascript" ></script>
<script src="/fw/resources/js/fw-common-combox.js" type="text/javascript" ></script>
<script src="/fw/resources/js/jquery-extends.js" type="text/javascript" ></script>

<script src="/fw/resources/plugins/messagebox/messagebox.js" type="text/javascript" ></script>

<%
	Object path = request.getServletContext().getAttribute("serverUrl");// request.getContextPath();
	path = null == path ? "" : path.toString();
	request.setAttribute("path", path);
%>
