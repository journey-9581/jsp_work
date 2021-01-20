<%@page import="test.user.dao.UserDao"%>
<%@page import="test.user.dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id=(String)session.getAttribute("id");
	UserDto dto=UserDao.getInstance().getData(id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/user/private/updateform.jsp</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
<style>
	#profileImage {
		width: 50px;
		height: 50px;
		border: 1px solid #cecece;
		border-radius: 50%
	}
	#profileForm {
		display: none;
	}
</style>
</head>
<body>
<jsp:include page="../../include/navbar.jsp"></jsp:include>
	<div class="container">
		<nav>
			<ul class="breadcrumb">
				<li class="breadcrumb-item">
					<a href="${pageContext.request.contextPath }/">홈</a>
				</li>
				<li class="breadcrumb-item">
					<a href="${pageContext.request.contextPath }/user/private/info.jsp">프로필</a>
				</li>
				<li class="breadcrumb-item active">프로필 수정</li>
			</ul>
		</nav>
		<a id="profilelink" href="javascript:">
			<%if(dto.getProfile()==null){ %>
				<svg id="profileImage" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-fill" viewBox="0 0 16 16">
	  				<path d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>
				</svg>
			<%}else{ %>
				<img src="${pageContext.request.contextPath }<%=dto.getProfile() %>" id="profileImage"/>
			<%} %>
			프로필 이미지 수정
		</a>
		<br/>
		<br/>
		<form action="${pageContext.request.contextPath }/user/private/update.jsp" method="post" id="myForm">
			<div class="form-group">
				<label for="id">아이디</label>
				<input type="text" id="id" value="<%=dto.getId() %>" class="form-control" disabled/>
			</div>
			<div class="form-group">
				<label for="email">이메일</label>
				<input type="text" id="email" name="email" class="form-control" value="<%=dto.getEmail() %>"/>
			</div>
			<button type="submit" class="btn btn-success">저장</button>
			<button type="reset" class="btn btn-danger">취소</button>
		</form>
		<form action="${pageContext.request.contextPath }/user/private/profileupload.jsp" method="post" enctype="multipart/form-data" id="profileForm">
			<label for="image">프로필 이미지 선택</label>
			<input type="file" name="image" id="image" accept=".jpg, .jpeg, .png, .JPG, .JPEG"/>
			<button type="submit">업로드</button>
		</form>
	</div>
	<script>
		$("#profilelink").on("click", function(){
			$("#image").click();
		});
		$("#image").on("change", function(){
			$("#profileForm").submit();
		});
	</script>
</body>
</html>