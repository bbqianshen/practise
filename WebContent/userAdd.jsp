<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
	<title>Detail Admin - New User Form</title>

    <!-- libraries -->
    <link href="css/lib/bootstrap-wysihtml5.css" type="text/css" rel="stylesheet" />
    <link href="css/lib/uniform.default.css" type="text/css" rel="stylesheet" />
    <link href="css/lib/select2.css" type="text/css" rel="stylesheet" />
    <link href="css/lib/bootstrap.datepicker.css" type="text/css" rel="stylesheet" />
    
    <!-- this page specific styles -->
    <link rel="stylesheet" href="css/compiled/form-wizard.css" type="text/css" media="screen" />

</head>
    <script type="text/javascript">
    	
    	$(function(){
    		
    		$("#userManager").prepend("<div class='pointer'><div class='arrow'></div><div class='arrow_border'></div></div>");
    		$("#userManager").addClass("active");
    		$("#fingerClient").addClass("active");
    		$("#fingerClient").parent().parent().addClass("active");
    		
    		var userNameFlag = true;
    		var realNameFlag = true;
    		var departmentFlag = true;
    		var sexFlag = true;
    		
    		$("#userName").blur(function(){
    			var userName = $.trim($(this).val());
    			if( userName == ""){
    				$(this).parent().append("<span class='alert-msg'>用户名不能为空!</span>");
    				$(this).parent().addClass("error");
    				userNameFlag = false;
    			}else{
    				userNameFlag = true;
    				var url = "${pageContext.request.contextPath }/userValidate";
    				var args = {"userName":userName, "date":new Date()};
    				$.post(url,args,function(data){
    					if(data){
    						$("#userName").parent().append("<span class='alert-msg'>用户名已存在!</span>");
    						$("#userName").parent().addClass("error");
    						$("#submit").attr("disabled",true);
    					}else{
    						$("#userName").parent().append("<span class='alert-msg'>用户名可用!</span>");
    						$("#userName").parent().addClass("success");
    						$("#submit").attr("disabled",false);
    					}
    				});
    			}
    		});
    		
    		$("#userName").focus(function(){
    			$(this).parent().find("span").remove();
    			$(this).parent().removeClass("error");
    			$(this).parent().removeClass("success");
    		}); 
    		
    		$("#realName").blur(function(){
    			if($.trim($(this).val()) == ""){
    				$(this).parent().append("<span class='alert-msg'>真实姓名不能为空!</span>");
    				$(this).parent().addClass("error");
    				realNameFlag = false;
    			}
    			else{
    				realNameFlag = true;
    			}
    		});
    		
    		$("#realName").focus(function(){
    			$(this).parent().find("span").remove();
    			$(this).parent().removeClass("error");
    		}); 
    		
    		$("#department").change(function(){
    			if($("#department").val() != ""){
    				departmentFlag = true;
    				$(this).parent().parent().find("span").remove();
    				$(this).parent().parent().removeClass("error");
    			}
    		});
    		
    		$("#sex").change(function(){
    			if($("#sex").val() != ""){
    				sexFlag = true;
    				$(this).parent().parent().find("span").remove();
    				$(this).parent().parent().removeClass("error");
    			}
    		});
    		
    		$("#userForm").submit(function(){
    			if(${user.userId == null }){
	    			if($.trim($("#userName").val()) == ""){
	    				$("#userName").parent().find("span").remove();
	    				$("#userName").parent().append("<span class='alert-msg'>用户名不能为空!</span>");
	    				$("#userName").parent().addClass("error");
	    				userNameFlag = false;
	    			}
    			}
    			
				if($.trim($("#realName").val()) == ""){
					$("#realName").parent().find("span").remove();
					$("#realName").parent().append("<span class='alert-msg'>真实姓名不能为空!</span>");
    				$("#realName").parent().addClass("error");
    				departmentFlag = false;
    			}
    			
    			if($("#department").val() == ""){
    				$("#department").parent().parent().find("span").remove();
    				$("#department").parent().parent().append("<span class='alert-msg'>请选择部门!</span>");
    				$("#department").parent().parent().addClass("error");
    				departmentFlag = false;
    			}
    			
    			if($("#sex").val() == ""){
    				$("#sex").parent().parent().find("span").remove();
    				$("#sex").parent().parent().append("<span class='alert-msg'>请选择性别!</span>");
    				$("#sex").parent().parent().addClass("error");
    				sexFlag = false;
    			}
    			
    			return userNameFlag && realNameFlag && departmentFlag && sexFlag;
    		});
    		
    	});
    	
    </script>
<body>

	<!-- main container -->
    <div class="content">
        
        <div class="container-fluid">
            <div id="pad-wrapper" class="new-user">
                <div class="row-fluid header">
                    <h3>新增用户</h3>
                </div>
                
                <div class="row-fluid form-wrapper">
                    <!-- left column -->
                    <div class="span12 ">
                        <div class="container">
                            <form:form action="userSave" id="userForm" method="post" class="form-horizontal" modelAttribute="user">

								<c:if test="${user.userId == null }">
								 	<div class="span12 field-box">
	                                    <label><font color="red">*</font>用户名:</label>
	                                    <form:input class="span8" type="text" id="userName" path="userName"/>
                                	</div>
							 	</c:if>
							 	<c:if test="${user.userId != null }">
							 		<form:hidden path="userId"/>
							 		<input type="hidden" name="_method" value="PUT"/>
							 	</c:if>
                                
                                <div class="span12 field-box">
                                    <label><font color="red">*</font>真实姓名:</label>
                                   	<form:input class="span8" type="text" id="realName" path="chineseName"/>
                                </div>
                                <div class="span12 field-box">
	                                <label><font color="red">*</font>性别:</label>
	                                <div class="ui-select span3">
                                        <form:select id="sex" path="sex">
                                            <option value="">请选择</option>
                                            <option value="1">男</option>
                                            <option value="2">女</option>
                                        </form:select>
                                    </div>
	                            </div>
                                <div class="span12 field-box">
                                    <label><font color="red">*</font>部门:</label>
                                    <div class="ui-select span3">
                                        <form:select path="dept.deptId" items="${department }" 
 				itemLabel="dept.deptName" itemValue="dept.deptId"></form:select>
                                    </div>
                                </div>
                                <div class="span12 field-box">
                                    <label>邮箱地址:</label>
                                    <form:input class="span8" type="text" path="email"/>
                                </div>
                                <div class="span12 field-box">
                                    <label>电话:</label>
                                    <form:input class="span8" type="text" path="phone"/>
                                </div>
                                <div class="span12 field-box">
                                    <label>住址:</label>
                                    <form:input class="span8" type="text" path="address"/>
                                </div>
                                <div class="span12 field-box textarea">
                                    <label>备注:</label>
                                    <form:textarea class="span8" path="comments"></form:textarea>
                                    <span class="charactersleft">字长限制在100字以内</span>
                                </div>
                                <div class="span6 actions">
                                    <input type="submit" class="btn-glow primary" value="保存用户" id="submit"/>
                                </div>
                            </form:form>
                            
                            
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <!-- end main container -->

</body>
</html>