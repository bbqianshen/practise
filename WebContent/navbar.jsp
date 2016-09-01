<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	
</head>
<body>
 <!-- navbar -->
    <div class="navbar navbar-inverse">
        <div class="navbar-inner">
            <button type="button" class="btn btn-navbar visible-phone" id="menu-toggler">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            
            <a class="brand" href="index.html"><img src="img/logo.png" /></a>

            <ul class="nav pull-right">    
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle hidden-phone" data-toggle="dropdown">
                    	<strong>欢迎您 , <shiro:principal/></strong>
                        <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="personal-info.html">个人信息</a></li>
                        <li><a href="#">账户设置</a></li>
                        <li><a href="#">修改密码</a></li>
                        <li><a href="logout">退出</a></li>
                    </ul>
                </li>
            </ul>            
        </div>
    </div>
    <!-- end navbar -->
</body>
</html>