<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

    
    <link rel="stylesheet" href="css/compiled/form-showcase.css" type="text/css" media="screen" />
    <script type="text/javascript">
    	
    	$(function(){
    		
    		//导航侧边栏添加激活标记
    		$("#userManager").prepend("<div class='pointer'><div class='arrow'></div><div class='arrow_border'></div></div>");
    		$("#userManager").addClass("active");
    		//导航侧边栏当前选项字体加粗
    		$("#userRoleManagement").addClass("active");
    		$("#userRoleManagement").parent().parent().addClass("active");
    		
    		//返回用户角色分配页面
    		$("#returnButton").attr("target","search?path=userRoleManagement");
    		
    		//只选中一个checkbox
    		$('#assignRoleTable').find('input[type=checkbox]').bind('click', function(){
    			$(this).parent().parent().find('input[type=checkbox]').not(this).attr("checked", false);
    	    });
    		
    		$("#assignRolePage").find("a").click(function(){
    			var target = $(this).attr("target");
    			if(target != null){
    				$(".pointer").remove();
        			$(".active").removeClass("active");
        			
        			$.get(target,function(data){
        				$("#refreshPage").html(data);	
        			});
    			}
    			
    		});
    		
    		$("#saveButton").click(function(){
	    		$.ajax({
	                cache: true,
	                type: "POST",
	                url:"saveRole?userId=${user.userId }",
	                data:$('#assignRoleForm').serialize(),// 你的formid
	                async: false,
	                success: function(data) {
	                	$("#refreshPage").html(data);
	                }
	            });
    		});
    		
    		
    	});
    	
    </script>
</head>
<body>
	
    <div class="content">
        
        <div class="container-fluid" id="assignRolePage">
            <div id="pad-wrapper">
                
               <form:form id="assignRoleForm">
	                <div class="table-wrapper orders-table">
						<div class="row-fluid head">
	                        <div class="span12">
	                            <h4>用户角色分配</h4>
	                        </div>
	                    </div>
	                    
	                    <div class="row-fluid filter-block">
	                        <div class="pull-right">
	                        	<a class="btn-flat btn-mini primary" id="saveButton" >保存设置</a>
	                            <a class="btn-flat btn-mini gray" id="returnButton" >返回</a>
	                        </div>
	                    </div>
	                    
	                    <div class="row-fluid">
	                        <table class="table table-hover" id="assignRoleTable">
	                            <thead>
	                                <tr>
	                                    <th class="span2">
	                                    	<span class="line"></span>
	                                       	角色名称
	                                    </th>
	                                    <th class="span2">
	                                    	<span class="line"></span>
	                                       	角色描述
	                                    </th>
	                                    <th class="span3">
	                                        <span class="line"></span>
	                                       	角色权限
	                                    </th>
	                                    <th class="span1">
	                                        <span class="line"></span>
	                                       	授权
	                                    </th>
	                                    <th class="span1">
	                                        <span class="line"></span>
	                                       	禁用
	                                    </th>
	                                </tr>
	                            </thead>
	                            <tbody>
		                            <c:forEach items="${role }" var="roles">
										<!-- row -->
										<tr class="first">
											<td>${roles.roleName }</td>
											<td>${roles.roleDesc }</td>
											<td>
												<c:forEach items="${roles.permissions }" var="permission">
													${permission.permissionName } /
												</c:forEach>
											</td>
											
											<c:set var="hasRole" value="0"/>
											<c:forEach items="${setRole }" var="setRoles">
													<c:if test="${setRoles.roleId == roles.roleId }">
														<c:set var="hasRole" value="1"/>
													</c:if>
											</c:forEach>
											<c:if test="${hasRole == 1 }">
												<td>
													<input type="checkbox" name="setRoles" value="${roles.roleId }" checked="checked"/>
												</td>
												<td>
													<input type="checkbox" />
												</td>
											</c:if>
											<c:if test="${hasRole != 1 }">
												<td>
													<input type="checkbox" name="setRoles" value="${roles.roleId }"/>
												</td>
												<td>
													<input type="checkbox" checked="checked"/>
												</td>
											</c:if>
											
											
										</tr>
									</c:forEach>
	                            </tbody>
	                        </table>
	                    </div>
	                </div>
                </form:form>
            </div>
			
        </div>
    </div>
    
</body>
</html>