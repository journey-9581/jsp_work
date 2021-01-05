<%@page import="test.users.dao.UsersDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//1. session scope에서 로그인 된 아이디 불러오기
	String id=(String)session.getAttribute("id");
	//2. 로그인 된 아이디를 이용하여 DB에서 삭제하기
	boolean isSuccess=UsersDao.getInstance().delete(id);
	//3. 로그 아웃 처리를 하고 응답한다
	session.removeAttribute("id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/private/delete.jsp</title>
</head>
<body>
	<%if(isSuccess){ %>
		<p> 
			<strong><%=id %></strong> 회원님의 탈퇴처리가 완료되었습니다
			<a href="${pageContext.request.contextPath }/">확인</a>
		</p>
	<%}else{ %>
		<p>회원 정보 삭제 실패 <a href="info.jsp">확인</a></p>
	<%} %>
</body>
</html>