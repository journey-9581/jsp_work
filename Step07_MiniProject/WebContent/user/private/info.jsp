<%@page import="test.user.dto.UserDto"%>
<%@page import="test.user.dao.UserDao"%>
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
<title>/user/private/info.jsp</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
<style>
	#profileImage{
		width: 50px;
		height: 50px;
		border: 1px solid #cecece;
		border-radius: 50%
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
				<li class="breadcrumb-item active">프로필</li>
			</ul>
		</nav>
			<table class="table table-striped">
			<colgroup>
				<col width="150"/>
				<col />
			</colgroup>
			<tr>
				<th>아이디</th>
				<td><%=dto.getId()%></td>
			</tr>
			<tr>
				<th>프로필 이미지</th>
				<td>
					<%if(dto.getProfile()==null){ %>
						<svg id="profileImage" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-fill" viewBox="0 0 16 16">
	  						<path d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>
						</svg>
					<%}else{ %>
						<img src="${pageContext.request.contextPath }<%=dto.getProfile() %>" id="profileImage"/>
					<%} %>
				</td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><a href="pwdupdateform.jsp">수정</a></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><%=dto.getEmail() %></td>
			</tr>
			<tr>
				<th>가입일자</th>
				<td><%=dto.getRegdate() %></td>
			</tr>
		</table>
		<a href="updateform.jsp" class="btn btn-outline-secondary">수정</a>
		<a href="javascript:deleteConfirm()" class="btn btn-outline-secondary">탈퇴</a>
	</div>
	<script>
		function deleteConfirm(){
			let isDelete=confirm("<%=id%> 회원님 탈퇴 하시겠습니까?");
			if(isDelete){
				location.href="delete.jsp";
			}
		}
	</script>
</body>
</html>