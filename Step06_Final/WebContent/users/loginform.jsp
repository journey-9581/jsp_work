<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/loginform.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
<%
	//GET 방식 파라미터 url이라는 이름으로 전달되는 값이 있는지 읽어와보기
	String url=request.getParameter("url");
	if(url==null){
		//로그인 후에 index.jsp 페이지로 가도록 절대 경로를 구성한다
		String cPath=request.getContextPath();
		url=cPath+"/index.jsp";
	}
%>
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="login" name="thisPage"/>
</jsp:include>
	<div class="container">
		<nav>
			<ul class="breadcrumb">
				<li class="breadcrumb-item">
					<a href="${pageContext.request.contextPath }/">홈</a>
				</li>
				<li class="breadcrumb-item active">로그인</li>
			</ul>
		</nav>
		<form action="login.jsp" method="post">
			<%-- 원래 가려던 목적지 정보를 url이라는 파라미터 명으로 전송될 수 있도록 한다 --%>
			<input type="hidden" name="url" value="<%=url %>"/>
			<div class="form-group">
				<label for="id">아이디</label>
				<input type="text" class="form-control" name="id" id="id"/>
				<small class="form-text text-muted">아이디를 입력해주세요</small>
			</div>
			<div class="form-group">
				<label for="pwd">비밀번호</label>
				<input type="password" class="form-control" name="pwd" id="pwd"/>
				<small class="form-text text-muted">비밀번호를 입력해주세요</small>
			</div>
			<button type="submit" class="btn btn-secondary">로그인</button>
		</form>
	</div>
</body>
</html>