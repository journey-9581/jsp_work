<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/file/private/uploadform.jsp</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
</head>
<body>
<jsp:include page="../../include/navbar.jsp">
	<jsp:param value="filelist" name="thisPage"/>
</jsp:include>
	<div class="container">
		<nav>
			<ul class="breadcrumb">
				<li class="breadcrumb-item">
					<a href="${pageContext.request.contextPath }/">홈</a>
				</li>
				<li class="breadcrumb-item">
					<a href="${pageContext.request.contextPath }/file/list.jsp">파일 목록</a>
				</li>
				<li class="breadcrumb-item active">파일 업로드</li>
			</ul>
		</nav>
		<form action="${pageContext.request.contextPath }/file/private/upload.jsp" method="post" enctype="multipart/form-data">
			<div class="form-group">
				<label for="title">제목</label>
				<input type="text" name="title" id="title" class="form-control"/>
			</div>
			<div class="form-group">
				<label for="myFile">첨부파일</label>
				<input type="file" name="myFile" id="myFile" accept=".jpg, .jpge, .png, .JPG, .JPGE"/>
			</div>
			<button type="submit" class="btn btn-outline-secondary">업로드</button>
		</form>
	</div>
</body>
</html>