<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="navbar.jsp" %>
<%@ include file="sideBar.jsp" %>
<%@ include file="Reference.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <script type="text/javascript">
    	
    	$(function(){
    		$("#productManager").prepend("<div class='pointer'><div class='arrow'></div><div class='arrow_border'></div></div>");
    		$("#productManager").addClass("active");
    		$("#productInformation").addClass("active");
    		$("#productInformation").parent().parent().addClass("active");
    	});
    	
    </script>
</head>
<body>

	


</body>
</html>