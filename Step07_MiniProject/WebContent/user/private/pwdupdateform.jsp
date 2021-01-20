<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/user/private/pwdupdateform.jsp</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
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
				<li class="breadcrumb-item active">비밀번호 수정</li>
			</ul>
		</nav>
		<form action="${pageContext.request.contextPath }/user/private/pwdupdate.jsp" method="post" id="myForm">
			<div class="form-group">
				<label for="pwd">기존 비밀번호</label>
				<input type="password" name="pwd" id="pwd" class="form-control"/>
			</div>
			<div class="form-group">
				<label for="newPwd">새 비밀번호</label>
				<input type="password" name="newPwd" id="newPwd" class="form-control"/>
			</div>
			<div class="form-group">
				<label for="newPwd2">새 비밀번호 확인</label>
				<input type="password" id="newPwd2" class="form-control"/>
			</div>
			<button type="submit" class="btn btn-success">수정하기</button>
			<button type="reset" class="btn btn-danger">취소</button>
		</form>
	</div>
	<script>
		document.querySelector("#myForm")
		.addEventListener("submit", function(event){
			let pwd1=document.querySelector("#newPwd").value;
			let pwd2=document.querySelector("#newPwd2").value;
			if(pwd1!=pwd2){
				alert("비밀번호를 확인하세요");
				event.preventDefault();
			}
		});
	</script>
</body>
</html>