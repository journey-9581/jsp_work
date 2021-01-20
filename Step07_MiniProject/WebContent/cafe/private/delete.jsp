<%@page import="test.cafe.dao.CafeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num=Integer.parseInt(request.getParameter("num"));
	boolean isSuccess=CafeDao.getInstance().delete(num);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/cafe/private/delete.jsp</title>
</head>
<body>
	<%if(isSuccess){ %>
		<script>
			alert("삭제 완료");
			location.href="${pageContext.request.contextPath }/cafe/list.jsp";
		</script>
	<%}else{ %>
		<script>
			alert("삭제 실패");
			location.href="${pageContext.request.contextPath }/cafe/detail.jsp?num=<%=num%>";
		</script>
	<%} %>
</body>
</html>