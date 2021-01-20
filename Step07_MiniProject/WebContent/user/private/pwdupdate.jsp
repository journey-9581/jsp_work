<%@page import="test.user.dao.UserDao"%>
<%@page import="test.user.dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id=(String)session.getAttribute("id");

	String pwd=request.getParameter("pwd");
	String newPwd=request.getParameter("newPwd");

	UserDto dto=new UserDto();
	dto.setId(id);
	dto.setPwd(pwd);
	dto.setNewPwd(newPwd);
	boolean isSuccess=UserDao.getInstance().updatePwd(dto);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>user/private/pwdupdate.jsp</title>
</head>
<body>
	<%if(isSuccess){ session.removeAttribute("id");%>
		<script>
			alert("수정 완료");
			location.href="${pageContext.request.contextPath }/user/loginform.jsp";
		</script>
	<%}else{ %>
		<script>
			alert("이전 비밀번호와 일치하지 않습니다")
			location.href="${pageContext.request.contextPath }/user/private/pwdupdateform.jsp"
		</script>
	<%} %>
</body>
</html>