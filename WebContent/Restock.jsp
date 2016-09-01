<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${pageContext.request.contextPath }/scripts/jquery-1.7.2.js"></script>
<script type="text/javascript">

	$(function(){
		
		$(".AddRecord").click(function(){
			
			$(".inputList").after("<tr><td><input type='text' name='productName'/></td><td><input type='text' name='stockNumber' /></td><td><input type='text' name='costPrice' /></td><td><input type='text' name='salePrice' /></td><td><input type='button' value='删除' class='delete'/><td/></tr>");
			$(".delete").click(function(){
				$(this).parent().parent().remove();
			});
			
			
		});
		
		
	});

</script>
</head>
<body>

	<form:form action="stock" method="POST" >
		
		<table border="0" cellpadding="10" cellspacing="0">
		
			<tr>
				<th>商品名</th>
				<th>数量</th>
				<th>进价</th>
				<th>零售价</th>
				<th></th>
			</tr>
			
			<tr class="inputList">
				<td><input type="text" name="productName"/></td>
				<td><input type="text" name="stockNumber"/></td>
				<td><input type="text" name="costPrice"/></td>
				<td><input type="text" name="salePrice"/></td>
			</tr>
			
		</table>
		<br>
		<input type="button" value="添加一条记录" class="AddRecord"/>
		<br><br>
		<input type="submit" value="提交"/>
		
	</form:form>

</body>
</html>