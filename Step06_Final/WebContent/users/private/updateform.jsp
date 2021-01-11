<%@page import="test.users.dto.UsersDto"%>
<%@page import="test.users.dao.UsersDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/private/updateform.jsp</title>
<style>
	/* 프로필 이미지를 작은 원형으로 만든다 */
	#profileImage{
		width: 50px;
		height: 50px;
		border: 1px solid #cecece;
		border-radius: 50%
	}
</style>
</head>
<body>
<%
	//세션 영역에 저장된 아이디를 이용해서
	String id=(String)session.getAttribute("id");
	//DB에 저장된 가입정보를 읽어온다
	UsersDto dto=UsersDao.getInstance().getData(id);
%>
	<div class="container">
		<h1>가입정보 수정 폼</h1>
			<%if(dto.getProfile()==null){ %>
				<svg id="profileImage" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-fill" viewBox="0 0 16 16">
	  				<path d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>
				</svg>
			<%}else{ %>
				<img src="${pageContext.request.contextPath }<%=dto.getProfile() %>" id="profileImage"/>
			<%} %>
		<form action="update.jsp" method="post">
			<div>
				<label for="id">아이디</label>
				<input type="text" id="id" value="<%=dto.getId() %>" disabled/>
			</div>
			<div>
				<label for="email">이메일</label>
				<input type="text" id="email" name="email" value="<%=dto.getEmail() %>"/>
			</div>
			<button type="submit">수정 확인</button>
			<button type="reset">취소</button>
		</form>
		<h2>프로필 이미지 업로드 테스트</h2>
		<form action="profile_upload.jsp" method="post" enctype="multipart/form-data">
			<input type="file" name="image" accept=".jpg, .jpeg, .png, .JPG, .JPEG"/>
			<button type="submit">업로드</button>
		</form>
	</div>
</body>
</html>