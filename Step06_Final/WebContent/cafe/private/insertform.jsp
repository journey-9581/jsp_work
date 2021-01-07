<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/cafe/private/insertform.jsp</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
</head>
<body>
<jsp:include page="../../include/navbar.jsp">
	<jsp:param value="list" name="thisPage"/>
</jsp:include>
	<div class="container">
		<nav>
		<ul class="breadcrumb">
			<li class="breadcrumb-item">
				<a href="${pageContext.request.contextPath }/">홈</a>
			</li>
			<li class="breadcrumb-item">
				<a href="${pageContext.request.contextPath }/cafe/list.jsp">글 목록</a>
			</li>
			<li class="breadcrumb-item active">새 글 쓰기</li>
		</ul>
		</nav>
		<form action="insert.jsp">
			<div class="form-group">
				<label for="title">제목</label>
				<input type="text" class="form-control" name="title" id="title"/>				
			</div>
			<div class="form-group">
				<label for="content">내용</label>
				<textarea name="content" class="form-control" id="content"></textarea>
			</div>
			<button type="submit" class="btn btn-secondary">저장</button>
		</form>
	</div>
</body>
</html>