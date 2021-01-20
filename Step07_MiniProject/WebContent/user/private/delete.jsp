<%@page import="test.user.dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id=(String)session.getAttribute("id");
	boolean isSuccess=UserDao.getInstance().delete(id);
	session.removeAttribute("id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/user/private/delete.jsp</title>
</head>
<body>
	<%if(isSuccess){ %>
		<script>
			alert("탈퇴 완료");
			location.href="${pageContext.request.contextPath }/index.jsp";
		</script>
	<%}else{ %>
		<script>
			alert("탈퇴 실패");
			location.href="${pageContext.request.contextPath }/private/info.jsp"
		</script>
	<%} %>
</body>
</html>