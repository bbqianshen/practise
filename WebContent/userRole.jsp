<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <script type="text/javascript">
    	
    	$(function(){
    		
    		//导航侧边栏添加激活标记
    		$("#userManager").prepend("<div class='pointer'><div class='arrow'></div><div class='arrow_border'></div></div>");
    		$("#userManager").addClass("active");
    		//导航侧边栏当前选项字体加粗
    		$("#userRole").addClass("active");
    		$("#userRole").parent().parent().addClass("active");
    		
    		
    		//只选中一个checkbox
    		$('#roleTable').find('input[type=checkbox]').bind('click', function(){
    	        $('#roleTable').find('input[type=checkbox]').not(this).attr("checked", false);
    	    });
    		
    		$("#update").click(function(){
    			var flag = $('#roleTable').find('input[type=checkbox]').is(':checked');
				if(!flag){
					$('#remindCheck').modal('show');
				}else{
					var val = $('#roleTable').find('input[type=checkbox]:checked').parent().find('input:hidden').val();
					var target = "updateRolePermission?roleId=" + val;
					$(this).attr("target",target);
				}
    		});
    		
    		$("#view").click(function(){
    			var flag = $('#roleTable').find('input[type=checkbox]').is(':checked');
    			if(!flag){
					$('#remindCheck').modal('show');
				}else{
					var userId = $('#roleTable').find('input[type=checkbox]:checked').parent().find('input:hidden').val();
					var url = "${pageContext.request.contextPath }/viewUser";
    				var args = {"userId":userId, "date":new Date()};
    				$.post(url,args,function(data){
    					var dataObj=eval("("+data.viewUser+")");//转换为json对象
    					$("#viewUserName").attr("value",dataObj.userName);
    					$("#viewUserChineseName").attr("value",dataObj.chineseName);
    					$("#viewUserSex").attr("value",dataObj.sex == 1 ? '男' : '女');
    					$("#viewUserDepartment").attr("value",dataObj.dept.deptName);
    					$("#viewUserEmail").attr("value",dataObj.email);
    					$("#viewUserPhone").attr("value",dataObj.phone);
    					$("#viewUserAddress").attr("value",dataObj.address);
    					$("#viewUserComments").attr("value",dataObj.comments);
    					
    					$('#viewUser').modal('show');
    				});
				}
    		});
    		
    		//删除按钮动作
    		$("#delete").click(function(){
    			var flag = $('#roleTable').find('input[type=checkbox]').is(':checked');
    			//检查是否勾选了用户，否则将提醒勾选
    			if(!flag){
					$('#remindCheck').modal('show');
				}else{
					//获取当前勾选用户的ID
					var val = $('#roleTable').find('input[type=checkbox]:checked').parent().find('input:hidden').val();
					//添加删除链接
					$('#deleteWarning').find("#confirm").attr("href","delete?userId=" + val);
					//弹出提醒界面
					$('#deleteWarning').modal('show');
				}
    		});
    		
    		$("#userRolePage").find("a").click(function(){
    			var target = $(this).attr("target");
    			if(target != null){
    				$(".pointer").remove();
        			$(".active").removeClass("active");
        			
        			$.get(target,function(data){
        				$("#refreshPage").html(data);	
        			});
    			}
    			
    		});
    		
    	});
    	
    </script>
</head>
<body>

	
<!-- main container -->
    <div class="content" id="userRolePage">
        
        <div class="container-fluid">
            <div id="pad-wrapper">
                
                <!-- orders table -->
                <div class="table-wrapper orders-table">
                    
                    <div class="row-fluid filter-block">
                        
                        <div class="pull-right">
                            <a class="btn-flat btn-mini gray" id="update">配置权限</a>
                            <a class="btn-flat btn-mini danger" id="delete">删除角色</a>
                        </div>
                        
                    </div>

                    <div class="row-fluid">
                        <table class="table table-hover" id="roleTable">
                            <thead>
                                <tr>
                                	<th class="span1">
	                                    <input type="checkbox" />
                                    	<span class="line"></span>
                                    </th>
                                    <th class="span3">
                                    	<span class="line"></span>
                                       	角色名称
                                    </th>
                                    <th class="span3">
                                        <span class="line"></span>
                                       	角色描述
                                    </th>
                                    <th class="span3">
                                        <span class="line"></span>
                                       	角色权限
                                    </th>
                                    <th class="span3">
                                        <span class="line"></span>
                                       	角色状态
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
	                            <c:forEach items="${role }" var="role">
									<!-- row -->
									<tr class="first">
										<td><input type="checkbox" /><input type="hidden" value="${role.roleId }"/></td>
										<td>${role.roleName }</td>
										<td>${role.roleDesc }</td>
										<td>
											<c:forEach items="${role.permissions }" var="permission">
												${permission.permissionName } /
											</c:forEach>
										</td>
										<td>
											<c:choose>
												<c:when test="${role.status == 1 }">
													<span class="label label-success">可用</span>
												</c:when>
												<c:when test="${role.status == 2 }">
													<span class="label">停用</span>
												</c:when>
												<c:otherwise>
													<span class="label label-info">异常</span>
												</c:otherwise>
											</c:choose>
										</td>
									</tr>
								</c:forEach>
                            </tbody>
                        </table>
                        <div class="row ctrls">
                            <div class="pagination pull-left">
                                <ul id="pageNoSeleteor">
                                    
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end orders table -->
            </div>
            
            <div id="deleteWarning" class="modal hide fade in">
				<div class="modal-body">
					<h4 style="color:#F00">警告!</h4>
					<br>
					<p>是否删除用户?</p>		        
				</div>
				<div class="modal-footer">
					<a class="btn btn-success" id="confirm">确定</a>
					<a class="btn" data-dismiss="modal">取消</a>
				</div>
			</div>
			
			<div id="remindCheck" class="modal hide fade in">
				<div class="modal-body">
					<h4>请先选择用户</h4>		        
				</div>
				<div class="modal-footer">
					<a href="#" class="btn btn-success" data-dismiss="modal">确定</a>
				</div>
			</div>
			
			<div class="modal fade" id="viewUser" aria-hidden="true">
		          <div class="modal-header">
		              <h4 class="modal-title">用户信息</h4>
		          </div>
			
		          <div class="modal-body">
		              <form class="form-horizontal">
		                 <label class="control-label pull-left">用户名&nbsp;&nbsp;</label>
		                 <input type="text"  name="username" readonly="readonly" id="viewUserName"/>
		                 <br><br>
		                 <label class="control-label">真实姓名&nbsp;&nbsp;</label>
		                 <input type="text" readonly="readonly" id="viewUserChineseName"/>
		                 <br><br>
		                 <label class="control-label">性别&nbsp;&nbsp;</label>
		                 <input type="text" readonly="readonly" id="viewUserSex"/>
		                 <br><br>
		                 <label class="control-label">部门&nbsp;&nbsp;</label>
		                 <input type="text" readonly="readonly" id="viewUserDepartment"/>
		                 <br><br>
		                 <label class="control-label">邮箱地址&nbsp;&nbsp;</label>
		                 <input type="text" readonly="readonly" id="viewUserEmail"/>
		                 <br><br>
		                 <label class="control-label">电话&nbsp;&nbsp;</label>
		                 <input type="text" readonly="readonly" id="viewUserPhone"/>
		                 <br><br>
		                 <label class="control-label">住址&nbsp;&nbsp;</label>
		                 <input type="text" readonly="readonly" id="viewUserAddress"/>
		                 <br><br>
		                 <label class="control-label">备注&nbsp;&nbsp;</label>
		                 <input type="text" readonly="readonly" id="viewUserComments"/>
		              </form>
		          </div>
		          <div class="modal-footer">
				  		<a class="btn btn-success" data-dismiss="modal">确定</a>
				  </div>
			</div>
			
        </div>
    </div>
    <!-- end main container -->

</body>
</html>