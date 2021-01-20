<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/user/signupform.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
<jsp:include page="../include/navbar.jsp"></jsp:include>
	<div class="container">
		<nav>
			<ul class="breadcrumb">
				<li class="breadcrumb-item">
					<a href="${pageContext.request.contextPath }/">홈</a>
				</li>
				<li class="breadcrumb-item active">회원가입</li>
			</ul>
		</nav>
		<form action="${pageContext.request.contextPath }/user/signup.jsp" method="post" id="myForm" novalidate>
			<div class="form-group">
				<label for="id">아이디</label>
				<input type="text" class="form-control" name="id" id="id"/>
				<small class="form-text text-muted">아이디는 소문자로 시작하여 5~10자 이내로 입력해주세요</small>
				<div class="invalid-feedback">사용할 수 없는 아이디 입니다</div>
			</div>
			<div class="form-group">
				<label for="pwd">비밀번호</label>
				<input type="password" class="form-control" name="pwd" id="pwd"/>
				<small class="form-text text-muted">비밀번호는 5~10자 이내로 입력해주세요</small>
				<div class="invalid-feedback">사용할 수 없는 비밀번호 입니다</div>
			</div>
			<div class="form-group">
				<label for="pwd2">비밀번호 확인</label>
				<input type="password" class="form-control" id="pwd2"/>
			</div>
			<div class="form-group">
				<label for="email">이메일</label>
				<input type="email" class="form-control" name="email" id="email"/>
				<small class="form-text text-muted">사용 가능한 이메일을 작성해주세요</small>
				<div class="invalid-feedback">이메일 형식을 확인하세요</div>
			</div>
			<button type="submit" class="btn btn-outline-primary">가입</button>
		</form>
	</div>
	<script>
	let reg_id=/^[a-z].{4,9}$/;
	let reg_pwd=/^.{5,10}$/;
	let reg_email=/@/;
	
	let isIdValid=false;
	let isPwdValid=false;
	let isEmailValid=false;
	let isFormValid=false;
	
	$("#myForm").on("submit", function(){
		isFormValid=isIdValid&&isPwdValid&&isEmailValid;
		if(!isFormValid){
			return false;
		}
	});
	
	$("#pwd, #pwd2").on("input", function(){
		let pwd=$("#pwd").val();
		let pwd2=$("#pwd2").val();
		$("#pwd").removeClass("is-valid is-invalid");
		if(!reg_pwd.test(pwd)){
		 	$("#pwd").addClass("is-invalid");
		 	isPwdValid=false;
		 	return;
		}
		if(pwd==pwd2){
			$("#pwd").addClass("is-valid");
			isPwdValid=true;
		}else{
			$("#pwd").addClass("is-invalid");
			isPwdValid=false;
		}
	});
	
	$("#id").on("input",function(){
		let inputId=$("#id").val();
		$("#id").removeClass("is-valid is-invalid");
		if(!reg_id.test(inputId)){
			$("#id").addClass("is-invalid");
			isIdValid=false;
			return;
		}
		$.ajax({
			url:"checkid.jsp",
			method:"GET",
			data:"inputId="+inputId,
			success:function(responseData){
				if(responseData.isExist){
					$("#id").addClass("is-invalid");
					isIdValid=false;
				}else{
					$("#id").addClass("is-valid");
					isIdValid=true;
				}
			}
		});
	});

	$("#email").on("input", function(){
		let inputEmail=$("#email").val();
		$("#email").removeClass("is-valid is-invalid");
		if(!reg_email.test(inputEmail)){
			isEmailValid=false;
			$("#email").addClass("is-invalid");
		}else{
			isEmailValid=true;
			$("#email").addClass("is-valid");
		}
	});
	</script>
</body>
</html>