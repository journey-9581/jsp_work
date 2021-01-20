<%@page import="test.user.dao.UserDao"%>
<%@page import="test.user.dto.UserDto"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String url=request.getParameter("url");
	String encodedUrl=URLEncoder.encode(url);

	String id=request.getParameter("id");
	String pwd=request.getParameter("pwd");
	UserDto dto=new UserDto();
	dto.setId(id);
	dto.setPwd(pwd);
	boolean isValid=UserDao.getInstance().isValid(dto);

	String isSave=request.getParameter("isSave");
	
	if(isSave == null){
		Cookie idCook=new Cookie("savedId", id);
		idCook.setMaxAge(0);
		response.addCookie(idCook);
		
		Cookie pwdCook=new Cookie("savedPwd", pwd);
		pwdCook.setMaxAge(0);
		response.addCookie(pwdCook);
	}else{
		Cookie idCook=new Cookie("savedId", id);
		idCook.setMaxAge(60*60);
		response.addCookie(idCook);
		
		Cookie pwdCook=new Cookie("savedPwd", pwd);
		pwdCook.setMaxAge(60*60);
		response.addCookie(pwdCook);
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/user/login.jsp</title>
</head>
<body>
	<div class="container">
		<%if(isValid){ 
			session.setAttribute("id", id);%>
			<script>
				alert("<%=id %>님 로그인 완료");
				location.href="<%=url%>";
			</script>
		<%}else{ %>
			<script>
				alert("아이디 혹은 비밀번호가 틀려요");
				location.href="${pageContext.request.contextPath }/user/loginform.jsp?url=<%=encodedUrl%>";
			</script>
		<%} %>
	</div>
</body>
</html>