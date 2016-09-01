<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>

<body>
	<!-- sidebar -->
    <div id="sidebar-nav">
        <ul id="dashboard-menu">
            <li id="personalConsole">
                <a class="dropdown-toggle" href="#">
                    <span>个人工作台</span>
                </a>
                <ul class="submenu">
                    <li><a href="index" id="backlog" class="text-center">待办事项</a></li>
                    <li><a href="inDos" id="inDos" class="text-center">在办事项</a></li>
                    <li><a href="complete" id="complete" class="text-center">办结事项</a></li>
                </ul>
            </li>
            <li id="productManager">
                <a class="dropdown-toggle" href="#">
                    <span>商品管理</span>
                </a>
                <ul class="submenu">
                    <li><a href="productCategory" id="productCategory" class="text-center">商品分类</a></li>
                    <li><a href="productInformation" id="productInformation" class="text-center">商品信息</a></li>
                </ul>
            </li>            
            <li id="stockManager">
                <a href="stockManager">
                    <span>进货管理</span>
                </a>
            </li>
            <li id="inventoryManager">
                <a class="dropdown-toggle" href="#">
                    <span>库存管理</span>
                </a>
                <ul class="submenu">
                    <li><a href="stockInquiry" id="stockInquiry" class="text-center">库存查询</a></li>
                    <li><a href="stockTransfer" id="stockTransfer" class="text-center">库存调拨</a></li>
                </ul>
            </li>
            <li id="saleManager">
                <a class="dropdown-toggle" href="#">
                    <span>销售管理</span>
                </a>
                <ul class="submenu">
                    <li><a href="saleOrder" id="saleOrder" class="text-center">销售订单</a></li>
                    <li><a href="saleReturn" id="saleReturn" class="text-center">销售退货单</a></li>
                </ul>
            </li>
            <li id="reportManager">
                <a href="reportManager" >
                    <span>报表管理</span>
                </a>
            </li>
         	<li id="userManager">
                <a class="dropdown-toggle" href="#">
                    <span>用户管理</span>
                </a>
                <ul class="submenu">
                    <li><a href="search?path=fingerClient" id="fingerClient" class="text-center">用户信息管理</a></li>
                    <li><a href="showRole" id="userRole" class="text-center">用户角色</a></li>
                    <li><a href="search?path=userPermissions" id="userPermissions" class="text-center">用户权限</a></li>
                </ul>
            </li>
        </ul>
    </div>
    <!-- end sidebar -->
</body>
</html>