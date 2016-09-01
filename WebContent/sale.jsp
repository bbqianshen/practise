<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${pageContext.request.contextPath }/scripts/jquery-1.7.2.js"></script>
<script type="text/javascript">

	$(function(){
		
		
		var i = 1;
		
		$(".choose").change(function(){
			//一旦选择发生改变，清空所有的文本内容
			$(this).parent().parent().find("input").attr("value","");
			//当前productId
			var val = $(this).val();
			//当前showNumer文本框节点
			var $node = $(this).parent().parent().find("input#stockNumber");
			//当前salePrice文本框节点
			var $node2 = $(this).parent().parent().find("input#salePrice");
			//请求URL
			var url = "${pageContext.request.contextPath }/ajaxGetStockNumber";
			var args = {"productId":val, "date":new Date()};
			//如果选择值为默认值，则不发送ajax
			if(val == "") return;
			$.post(url,args,function(data){
				//设置查询到的stockNumber值
				$node.attr("value",data.stockNumber);
				//设置查询到的salePrice值
				$node2.attr("value",data.salePrice);
			});
		});
		
		$(".AddRecord").click(function(){
			//克隆choose节点所在的当前行所有节点，并重新设置class属性
			var $node = $(".choose").parent().parent().parent().find("tr:last").clone(true).attr("class","record" + i);
			//将克隆的节点的所有value值清空
			$node.children().find("input").attr("value","");
			//如果是第一次添加则直接添加在当前节点后面
			if( i == 1){
				$node.insertAfter(".record");
			}else{
				//如果不是第一次，则依次往后添加
				$node.insertAfter(".record" + (i - 1));
			}
			i++;
		});
		
		
		$(".itemnumber").change(function(){
			//设置总计金额
			var totalMoney = Number("0");
			//当前itemnumber数
			var number = $.trim($(this).val());
			//如果超出当前商品库存数量，提示错误
			if(Number(number) > Number($(this).parent().parent().find("input[name='stockNumber']").val())){
				$(this).parent().parent().find("div").html("超出库存数量!");
				//清空当前数量
				$(this).attr("value","");
				return;
			}
			
			//正整数正则表达式
			var reg = /^[0-9]*[1-9][0-9]*$/;
			//验证当前输入的数字是否正整数
			if(!reg.test(number)){
				$(this).parent().parent().find("div").html("请输入正确的购买数量!");
				//清空当前数量
				$(this).attr("value","");
				//清空当前小计金额
				$(this).parent().parent().find("input[name='countPrice']").attr("value","");
				return;
			}
			
			//如果通过验证，则取消提醒信息
			$(this).parent().parent().find("div").html("");
			
			//获取当前行的salePrice的值
			var salePrice = $(this).parent().parent().find("input[name='salePrice']").val();
			//设置当前行的countPrice金额
			$(this).parent().parent().find("input[name='countPrice']").attr("value",number * salePrice);
			//累加totalMoney
			$("input[name='countPrice']").each(function (i){
				totalMoney = Number(totalMoney) + Number($(this).val());
			});
			//设置totalMoney
			$(".totalMoney").html(totalMoney);
		});
		
		$("form").submit(function(){
			var flag = true;
			//再次检查每个商品条目
			$("select[name='product.id']").each(function (i){
				var info = "";
				//如果还未选择商品，则提示
				if($(this).val() == ""){
					info = "请选择商品!";
					flag = false;
				}
				//如果当前还未填写数量，则提示
				if($(this).parent().parent().find(".itemnumber").val() == ""){
					info = info + "请输入购买数量!";
					flag = false;
				}
				//将错误信息提示给用户
				$(this).parent().parent().find("div").html(info);
			});
			return flag;
		});
		
		
		
	});

</script>
</head>
<body>

	<form:form action="sale" method="POST" >
	
		<table border="0" cellpadding="10" cellspacing="0" >
		
			<tr>
				<th>商品名称</th>
				<th>购买数量</th>
				<th>零售价</th>
				<th>剩余库存</th>
				<th>小计金额</th>
				<th></th>
			</tr>
			
			<tr class="record">
				<td>
					<select name="product.id" class="choose">
						<option value="">请选择</option>
						<c:forEach items="${products }" var="pro">
							<option value="${pro.id }">${pro.productName }</option>
						</c:forEach>
					</select>
				</td>
				<td><input type="text" name="itemNumber" class="itemnumber"/></td>
				<td><input type="text" name="salePrice" id="salePrice" readonly="readonly"/></td>
				<td><input type="text" name="stockNumber" id="stockNumber" readonly="readonly"/></td>
				<td><input type="text" name="countPrice" readonly="readonly"/></td>
				<td><div style="color:#FF0000;"></div></td>
			</tr>
		
		</table>
		
		<br>
		合计金额:<div class="totalMoney"></div>
		
		<br>
		
		<input type="button" value="添加一条记录" class="AddRecord"/>
		
		<br>
		
		<input type="submit" value="结账" class="submit"/>
		
	
	</form:form>
	

</body>
</html>