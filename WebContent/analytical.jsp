<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<c:if test="${page == null || page.numberOfElements == 0 }">
		没有任何销售记录
	</c:if>
	
	<c:if test="${page != null && page.numberOfElements > 0 }">
	
		<table border="1" cellpadding="10" cellspacing="0">
		
			<tr>
				<th>商品名称</th>
				<th>销售数量</th>
				<th>成本价</th>
				<th>零售价</th>
				<th>零售小计</th>
				<th>销售时间</th>
			</tr>
			
			<c:forEach items="${page.content }" var="saleRecord">
				<tr>
					<td>${saleRecord.productName }</td>
					<td>${saleRecord.soldNumber }</td>
					<td>${saleRecord.costPrice }</td>
					<td>${saleRecord.soldPrice }</td>
					<td>${saleRecord.countPrice }</td>
					<td>
						<fmt:formatDate value="${saleRecord.buyTime }" pattern="yyyy-MM-dd hh:mm:ss"/>
					</td>
				</tr>
			</c:forEach>
			
			<tr>
				<td>
					共${page.totalElements }条记录
					共${page.totalPages }页
					当前${page.number + 1  } 页
					<c:if test="${page.number > 0  }">
						<a href="?pageNo=${page.number  }">上一页</a>
					</c:if>
					<c:if test="${page.number != page.totalPages -1  }">
						<a href="?pageNo=${page.number + 1 + 1  }">下一页</a>
					</c:if>
					总盈利:${totalProfit }
				</td>
			</tr>
		
		</table>
	
	</c:if>

</body>
</html>