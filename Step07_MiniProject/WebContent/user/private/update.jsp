<%@page import="test.user.dao.UserDao"%>
<%@page import="test.user.dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id=(String)session.getAttribute("id");
	String email=request.getParameter("email");
	UserDto dto=new UserDto();
	dto.setId(id);
	dto.setEmail(email);
	
	boolean isSuccess=UserDao.getInstance().update(dto);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/user/private/update.jsp</title>
</head>
<body>
	<script>
		<%if(isSuccess){%>
			alert("수정 했습니다");
			location.href="${pageContext.request.contextPath }/user/private/info.jsp";
		<%}else{%>
			alert("수정 실패");
			location.href="${pageContext.request.contextPath }/user/private/updateform.jsp"
		<%}%>
	</script>
</body>
</html>