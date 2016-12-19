<%@ page language="java" session="false"
	contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>
<%
    String psURL = (String) request.getParameter("psURL");
%>
<!DOCTYPE html>
<html>
<head>
<title>openDlg</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="pyramid-theme" value="gray">
<script type="text/javascript" src="../build/scripts/pyramid.js"></script>
<link rel="icon" type="image/x-icon" href="./pyramid/images/favicon.ico"/>
<script type="text/javaScript">
	function initForm() {
	    var sURL = "<%=psURL%>";
	    var manager = new tmt.viewer.Manager();
	    var viewer = manager.createViewer();
	    var resource = {
	         image : "../images/"
	        , doc : "../doc/"
	        , css : "../css/"
	    };
	    manager.setCommonResourcePath(resource);
	    viewer.setSrc(sURL);
	    viewer.setTargetDivId("container");
	    viewer.setControlName("container");
	    manager.addViewer(viewer);
	    manager.useAsync(true);
	    manager.apply(manager.MODE.ADD);
	}
</script>
</head>
<body topmargin='0' leftmargin='0' onLoad="initForm();">
	<div id="container" class="eXstory_divCanvas"></div>
</body>
</html>