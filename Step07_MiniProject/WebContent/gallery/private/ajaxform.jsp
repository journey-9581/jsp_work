<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/gallery/private/ajaxform.jsp</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
</head>
<body>
<jsp:include page="../../include/navbar.jsp">
	<jsp:param value="gallerylist" name="thisPage"/>
</jsp:include>
	<div class="container">
		<nav>
			<ul class="breadcrumb">
				<li class="breadcrumb-item">
					<a href="${pageContext.request.contextPath }/">홈</a>
				</li>
				<li class="breadcrumb-item">
					<a href="${pageContext.request.contextPath }/gallery/list.jsp">갤러리 목록</a>
				</li>
				<li class="breadcrumb-item active">사진 업로드</li>
			</ul>
		</nav>
		<form action="insert.jsp" method="post" id="insertForm">
			<input type="hidden" name="imagePath" id="imagePath"/>
			<div class="form-group">
				<label for="caption">설명</label>
				<input type="text" name="caption" id="caption" class="form-control"/>
			</div>
		</form>
		<form action="ajaxupload.jsp" method="post" id="ajaxForm" enctype="multipart/form-data">
			<div>
				<label for="image">이미지</label>
				<input type="file" name="image" id="image" accept=".jpg, .jpge, .png, .JPG, .JPGE"/>
			</div>
		</form>
		<button id="submitBtn" class="btn btn-outline-secondary">등록</button>
		<div class="img-wrapper">
			<img />
		</div>
	</div>
	<script src="${pageContext.request.contextPath }/js/jquery.form.min.js"></script>
	<script>
		$("#ajaxForm").ajaxForm(function(data){
			let src="${pageContext.request.contextPath }"+data.imagePath;
			$(".img-wrapper img").attr("src", src); 
			$("#imagePath").val(data.imagePath);
		});
		
		$("#image").on("change", function(){
			$("#ajaxForm").submit();
		});
		
		$("#submitBtn").on("click", function(){
			$("#insertForm").submit();
		});
	</script>
</body>
</html>