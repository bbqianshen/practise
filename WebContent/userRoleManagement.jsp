<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache,no-store, must-revalidate"> 
<META HTTP-EQUIV="pragma" CONTENT="no-cache"> 
<META HTTP-EQUIV="expires" CONTENT="0">
<head>
    <script type="text/javascript">
    	
    	$(function(){
    		
    		//导航侧边栏添加激活标记
    		$("#userManager").prepend("<div class='pointer'><div class='arrow'></div><div class='arrow_border'></div></div>");
    		$("#userManager").addClass("active");
    		//导航侧边栏当前选项字体加粗
    		$("#userRoleManagement").addClass("active");
    		$("#userRoleManagement").parent().parent().addClass("active");
    		
			
    		
    		//加载页码
    		var i = 0;
    		//如果当前页码为第一页则上一页箭头超链接置空
    		if(${page.number  - 1 } < 0){
    			$("#pageNoSeleteor").append("<li><a target='#'>&#8249;</a></li>");
    		}else{
	    		$("#pageNoSeleteor").append("<li><a target='search?path=userRoleManagement&pageNo=${page.number  - 1 }&userName=${condition.userName }'>&#8249;</a></li>");
    		}
    		//循环增加页码节点，并添加页码和查询条件的链接
    		while(i < ${page.totalPages } ){
    			$("#pageNoSeleteor").append("<li><a id='page" + (i + 1) + "' target='search?path=userRoleManagement&pageNo=" + i + "&userName=${condition.userName }'>" + (i + 1) + "</a></li>");
    			i ++;
    		}
    		//如果当前页码为最后一页则下一页箭头超链接置空
    		if(${page.number  +  1 } >= ${page.totalPages }){
    			$("#pageNoSeleteor").append("<li><a target='#'>&#8250;</a></li>");
    		}else{
    			$("#pageNoSeleteor").append("<li><a target='search?path=userRoleManagement&pageNo=${page.number + 1 }&userName=${condition.userName }'>&#8250;</a></li>");
    		}
    		
    		//设置当前页码激活效果
    		$("#page${page.number  +  1 }").addClass("active");
    		
    		//只选中一个checkbox
    		$('#userTable').find('input[type=checkbox]').bind('click', function(){
    	        $('#userTable').find('input[type=checkbox]').not(this).attr("checked", false);
    	    });
    		
    		$("#update").click(function(){
    			var flag = $('#userTable').find('input[type=checkbox]').is(':checked');
				if(!flag){
					$('#remindCheck').modal('show');
				}else{
					var val = $('#userTable').find('input[type=checkbox]:checked').parent().find('input:hidden').val();
					$(this).attr("target","updateUserRole?userId=" + val);
				}
    		});
    		
    		$("#view").click(function(){
    			var flag = $('#userTable').find('input[type=checkbox]').is(':checked');
    			if(!flag){
					$('#remindCheck').modal('show');
				}else{
					var userId = $('#userTable').find('input[type=checkbox]:checked').parent().find('input:hidden').val();
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
    		
    		
    		//回车搜索
    		$('#search').keydown(function(e){
	   			if(e.keyCode==13){
	   				
	   				var userName = $.trim($(this).val());
	   				var url = "${pageContext.request.contextPath }/search?path=userRoleManagement&userName=" + userName;
	   				$(".pointer").remove();
        			$(".active").removeClass("active");
	   				$.get(url,function(data){
        				$("#refreshPage").empty();
        				$("#refreshPage").html(data);	
        			});
	   			}
    		});
    		
    		$("#userRoleManagementPage").find("a").click(function(){
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
    <div class="content" id="userRoleManagementPage">
        
        <div class="container-fluid">
            <div id="pad-wrapper">
                
                <!-- orders table -->
                <div class="table-wrapper orders-table">
                    
                    <div class="row-fluid filter-block">
                        
                        <div class="pull-right">
                        	<a><input type="text" class="search order-search" placeholder="输入内容按回车搜索" id="search" value="${condition.userName }"/></a>
                            <a class="btn-flat btn-mini info" id="view">查看用户角色</a>
                            <a class="btn-flat btn-mini gray" id="update">配置用户角色</a>
                        </div>
                        
                    </div>

                    <div class="row-fluid">
                        <table class="table table-hover" id="userTable">
                            <thead>
                                <tr>
                                	<th class="span1">
	                                    <input type="checkbox" />
                                    	<span class="line"></span>
                                    </th>
                                    <th class="span3">
                                    	<span class="line"></span>
                                       	用户名
                                    </th>
                                    <th class="span3">
                                        <span class="line"></span>
                                       	部门
                                    </th>
                                    <th class="span3">
                                        <span class="line"></span>
                                       	上次登录时间
                                    </th>
                                    <th class="span3">
                                        <span class="line"></span>
                                       	用户状态
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
	                            <c:forEach items="${page.content }" var="user">
									<!-- row -->
									<tr class="first">
										<td><input type="checkbox" /><input type="hidden" value="${user.userId }"/></td>
										<td>${user.userName }</td>
										<td>${user.dept.deptName }</td>
										<td>
											<fmt:formatDate value="${user.lastLogTime }" pattern="yyyy-MM-dd hh:mm:ss"/>
										</td>
										<td>
											<c:choose>
												<c:when test="${user.status == 1 }">
													<span class="label label-success">可用</span>
												</c:when>
												<c:when test="${user.status == 2 }">
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