<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib uri="/WEB-INF/customTag" prefix="ct" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Cache-Control" content="no-cache,no-store, must-revalidate"> 
<meta http-equiv="pragma" content="no-cache"> 
<meta http-equiv="expires" content="0">
<!-- bootstrap -->
    <link href="css/bootstrap/bootstrap.css" rel="stylesheet" />
    <link href="css/bootstrap/bootstrap-responsive.css" rel="stylesheet" />
    <link href="css/bootstrap/bootstrap-overrides.css" type="text/css" rel="stylesheet" />
    
    <!-- libraries -->
    <link href="css/lib/jquery-ui-1.10.2.custom.css" rel="stylesheet" type="text/css" />
    <link href="css/lib/font-awesome.css" type="text/css" rel="stylesheet" />
 	<link rel="stylesheet" href="css/compiled/tables.css" type="text/css" media="screen" /> 
    <link rel="stylesheet" href="css/compiled/new-user.css" type="text/css" media="screen" />

    <!-- global styles -->
    <link rel="stylesheet" type="text/css" href="css/layout.css" />
    <link rel="stylesheet" type="text/css" href="css/elements.css" />
    <link rel="stylesheet" type="text/css" href="css/icons.css" />

    <!-- this page specific styles -->
    <link rel="stylesheet" href="css/compiled/index.css" type="text/css" media="screen" />

    <!-- open sans font -->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css' />

    <!-- lato font -->
    <link href='http://fonts.googleapis.com/css?family=Lato:300,400,700,900,300italic,400italic,700italic,900italic' rel='stylesheet' type='text/css' />

    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
	<meta name="viewport" content="width=device-width, initial-scale=1.0;" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
	<!-- scripts -->
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.min.js"></script>
    <script src="js/jquery-ui-1.10.2.custom.min.js"></script>
    <!-- knob -->
    <script src="js/jquery.knob.js"></script>
    <!-- flot charts -->
    <script src="js/jquery.flot.js"></script>
    <script src="js/jquery.flot.stack.js"></script>
    <script src="js/jquery.flot.resize.js"></script>
    <script src="js/theme.js"></script>
    <script type="text/javascript">
    
    	$(function(){
    		
    		$.get("indexBackUp.jsp",function(data){
    			$("#refreshPage").html(data);//初始化加载界面
    		});
    		
    		
    		$("#sidebar-nav").find("a").click(function(){
    			var target = $(this).attr("target");
    			if(target != null){
    				$(".pointer").remove();
        			$(".active").removeClass("active");
        			
        			$.get(target,function(data){
        				$("#refreshPage").html("");
        				$("#refreshPage").html(data);	
        			});
    			}
    			
    		});
    		
    		
    	});
    
    </script>
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
	<!-- sidebar -->
    <div id="sidebar-nav">
        <ul id="dashboard-menu">
            <li id="personalConsole">
                <a class="dropdown-toggle" href="#">
                    <span>个人工作台</span>
                </a>
                <ul class="submenu" id="path">
                    <li><a target="indexBackUp.jsp" id="backlog" class="text-center">待办事项</a></li>
                    <li><a target="inDos" id="inDos" class="text-center">在办事项</a></li>
                    <li><a target="complete" id="complete" class="text-center">办结事项</a></li>
                </ul>
            </li>
            
            <ct:hasAnyPermission name="商品分类,商品信息">
	            <li id="productManager">
	                <a class="dropdown-toggle" href="#">
	                    <span>商品管理</span>
	                </a>
	                <ul class="submenu">
	                	<shiro:hasPermission name="商品分类"></shiro:hasPermission>
	                    <li><a target="productCategory.jsp" id="productCategory" class="text-center">商品分类</a></li>
	                    <shiro:hasPermission name="商品信息"></shiro:hasPermission>
	                    <li><a target="productInformation" id="productInformation" class="text-center">商品信息</a></li>
	                </ul>
	            </li>
            </ct:hasAnyPermission>
            
            <shiro:hasPermission name="进货管理">
	            <li id="stockManager">
	                <a class="dropdown-toggle" href="#">
	                    <span>进货管理</span>
	                </a>
	                <ul class="submenu">
	                    <li><a target="stockManager" id="stockManager" class="text-center">进货管理</a></li>
	                </ul>
	            </li>
            </shiro:hasPermission>
            
            <ct:hasAnyPermission name="库存查询,库存调拨">
	            <li id="inventoryManager">
	                <a class="dropdown-toggle" href="#">
	                    <span>库存管理</span>
	                </a>
	                <ul class="submenu">
	                	<shiro:hasPermission name="库存查询">
		                    <li><a target="stockInquiry" id="stockInquiry" class="text-center">库存查询</a></li>
	                	</shiro:hasPermission>
	                	<shiro:hasPermission name="库存调拨">
		                    <li><a target="stockTransfer" id="stockTransfer" class="text-center">库存调拨</a></li>
	                	</shiro:hasPermission>
	                </ul>
	            </li>
            </ct:hasAnyPermission>
            
            <ct:hasAnyPermission name="销售订单,销售退货单">
	            <li id="saleManager">
	                <a class="dropdown-toggle" href="#">
	                    <span>销售管理</span>
	                </a>
	                <ul class="submenu">
	                	<shiro:hasPermission name="销售订单">
		                    <li><a target="saleOrder" id="saleOrder" class="text-center">销售订单</a></li>
	                	</shiro:hasPermission>
	                    <shiro:hasPermission name="销售退货单">
		                    <li><a target="saleReturn" id="saleReturn" class="text-center">销售退货单</a></li>
	                    </shiro:hasPermission>
	                </ul>
	            </li>
            </ct:hasAnyPermission>
            
            <shiro:hasPermission name="报表管理">
	            <li id="reportManager">
	                <a class="dropdown-toggle" href="#" >
	                    <span>报表管理</span>
	                </a>
	                <ul class="submenu">
	                    <li><a target="reportManager" id="reportManager" class="text-center">报表管理</a></li>
	                </ul>
	            </li>
            </shiro:hasPermission>
            
            <ct:hasAnyPermission name="用户信息管理,用户角色分配,用户权限分配,角色权限配置">
	         	<li id="userManager">
	                <a class="dropdown-toggle" href="#">
	                    <span>用户管理</span>
	                </a>
	                <ul class="submenu">
	                	<shiro:hasPermission name="用户信息管理">
		                    <li><a target="search?path=fingerClient" id="fingerClient" class="text-center">用户信息管理</a></li>
	                	</shiro:hasPermission>
	                	<shiro:hasPermission name="用户角色分配">
		                    <li><a target="search?path=userRoleManagement" id="userRoleManagement" class="text-center">用户角色分配</a></li>
	                	</shiro:hasPermission>
	                	<shiro:hasPermission name="用户权限分配">
		                    <li><a target="search?path=userPermissions" id="userPermissions" class="text-center">用户权限分配</a></li>
	                	</shiro:hasPermission>
	                	<shiro:hasPermission name="角色权限配置">
		                    <li><a target="showRole" id="userRole" class="text-center">角色权限配置</a></li>
	                	</shiro:hasPermission>
	                </ul>
	            </li>
            </ct:hasAnyPermission>
            
        </ul>
    </div>
    <!-- end sidebar -->
    
    <div id="refreshPage"></div>
</body>
</html>