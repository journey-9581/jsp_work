
<%@page import="test.user.dao.UserDao"%>
<%@page import="test.user.dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//폼 전송 되는 가입할 회원의 정보를 읽어온다
	String id=request.getParameter("id");
	String pwd=request.getParameter("pwd");
	String email=request.getParameter("email");
	
	//UsersDto 객체에 회원 정보를 담고
	UserDto dto=new UserDto();
	dto.setId(id);
	dto.setPwd(pwd);
	dto.setEmail(email);
	
	//UsersDao 객체를 이용해서 DB에 저장한다
	boolean isSuccess=UserDao.getInstance().insert(dto);
	
	//결과를 응답하기
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/signup.jsp</title>
</head>
<body>
	<div class="container">
		<%if(isSuccess){ %>
			<script>
			alert("가입 완료");
			location.href="${pageContext.request.contextPath }/user/loginform.jsp";
			</script>
		<%}else{ %>
			<script>
			alert("가입 실패");
			location.href="${pageContext.request.contextPath }/user/signupform.jsp";
			</script>
		<%} %>
	</div>
</body>
</html>