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
    		$("#userManager").prepend("<div class='pointer'><div class='arrow'></div><div class='arrow_border'></div></div>");
    		$("#userManager").addClass("active");
    		
    		
    		if(${backPath == "showRole"}){
    			$("#returnButton").attr("target","showRole");
    			$("#userRole").addClass("active");
        		$("#userRole").parent().parent().addClass("active");
    		}
    		if(${backPath == "search?path=userPermissions"}){
    			$("#returnButton").attr("target","search?path=userPermissions");
    			$("#userPermissions").addClass("active");
    	   		$("#userPermissions").parent().parent().addClass("active");
    		}
    		
    		
    		//只选中一个checkbox
    		$('#permissionTable').find('input[type=checkbox]').bind('click', function(){
    			$(this).parent().parent().find('input[type=checkbox]').not(this).attr("checked", false);
    	    });
    		
    		$("#permissionPage").find("a").click(function(){
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
	                url:"savePermission?userId=${user.userId }&roleId=${role.roleId }",
	                data:$('#permissionForm').serialize(),// 你的formid
	                async: false,
	                error: function(request) {
	                    alert("Connection error");
	                },
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
        
        <div class="container-fluid" id="permissionPage">
            <div id="pad-wrapper">
                
               <form:form id="permissionForm">
	                <div class="table-wrapper orders-table">
						<div class="row-fluid head">
	                        <div class="span12">
	                            <h4>${title }</h4>
	                        </div>
	                    </div>
	                    
	                    <div class="row-fluid filter-block">
	                        <div class="pull-right">
	                        	<a class="btn-flat btn-mini primary" id="saveButton" >保存设置</a>
	                            <a class="btn-flat btn-mini gray" id="returnButton" >返回</a>
	                        </div>
	                    </div>
	                    
	                    <div class="row-fluid">
	                        <table class="table table-hover" id="permissionTable">
	                            <thead>
	                                <tr>
	                                    <th class="span2">
	                                    	<span class="line"></span>
	                                       	功能模块
	                                    </th>
	                                    <th class="span3">
	                                    	<span class="line"></span>
	                                       	描述
	                                    </th>
	                                    <th class="span1">
	                                        <span class="line"></span>
	                                       	可见
	                                    </th>
	                                    <th class="span1">
	                                        <span class="line"></span>
	                                       	隐藏
	                                    </th>
	                                    <th class="span2">
	                                        <span class="line"></span>
	                                       	设置失效日期
	                                    </th>
	                                </tr>
	                            </thead>
	                            <tbody>
		                            <c:forEach items="${permission }" var="permissions">
										<!-- row -->
										<tr class="first">
											<td>${permissions.permissionName }</td>
											<td>${permissions.permissionDesc }</td>
											<c:set var="hasPermission" value="0"/>
											<c:forEach items="${setPermission }" var="setPermissions">
													<c:if test="${setPermissions.id == permissions.id }">
														<c:set var="hasPermission" value="1"/>
													</c:if>
											</c:forEach>
											<c:if test="${hasPermission == 1 }">
												<td>
													<input type="checkbox" name="setPermissions" value="${permissions.id }" checked="checked"/>
												</td>
												<td>
													<input type="checkbox" />
												</td>
											</c:if>
											<c:if test="${hasPermission != 1 }">
												<td>
													<input type="checkbox" name="setPermissions" value="${permissions.id }"/>
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