<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/signup_form.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="signup" name="thisPage"/>
</jsp:include>
	<div class="container">
		<nav>
			<ul class="breadcrumb">
				<li class="breadcrumb-item">
					<a href="${pageContext.request.contextPath }/">홈</a>
				</li>
				<li class="breadcrumb-item active">회원가입</li>
			</ul>
		</nav>
		<form action="signup.jsp" method="post">
			<div class="form-group">
				<label for="id">아이디</label>
				<input type="text" class="form-control" name="id" id="id"/>
				<small class="form-text text-muted">아이디는 6자 이상 영문과 숫자로 만들어주세요</small>
			</div>
			<div class="form-group">
				<label for="pwd">비밀번호</label>
				<input type="password" class="form-control" name="pwd" id="pwd"/>
				<small class="form-text text-muted">비밀번호는 10자 이상 영문과 숫자로 만들어주세요</small>
			</div>
			<div class="form-group">
				<label for="email">이메일</label>
				<input type="email" class="form-control" name="email" id="email"/>
				<small class="form-text text-muted">사용 가능한 이메일을 작성해주세요</small>
			</div>
			<button type="submit" class="btn btn-secondary">가입</button>
		</form>
	</div>
</body>
</html>