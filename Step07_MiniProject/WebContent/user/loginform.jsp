<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String savedId="";
	String savedPwd="";
	Cookie[] cooks=request.getCookies();
	if(cooks!=null){
		for(Cookie tmp: cooks){
			String key=tmp.getName();
			if(key.equals("savedId")){
				savedId=tmp.getValue();
			}
			if(key.equals("savedPwd")){
				savedPwd=tmp.getValue();
			}
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<style>
		html,
		body {
		  height: 100%;
		}
		
		body {
		  display: -ms-flexbox;
		  display: flex;
		  -ms-flex-align: center;
		  align-items: center;
		  padding-top: 40px;
		  padding-bottom: 40px;
		  background-color: #f5f5f5;
		}
		
		.form-signin {
		  width: 100%;
		  max-width: 330px;
		  padding: 15px;
		  margin: auto;
		}
		
		.form-signin .checkbox {
		  font-weight: 400;
		}
		
		.form-signin .form-control {
		  position: relative;
		  box-sizing: border-box;
		  height: auto;
		  padding: 10px;
		  font-size: 16px;
		}
		
		.form-signin .form-control:focus {
		  z-index: 2;
		}
		
		.form-signin input[type="email"] {
		  margin-bottom: -1px;
		  border-bottom-right-radius: 0;
		  border-bottom-left-radius: 0;
		}
		
		.form-signin input[type="password"] {
		  margin-bottom: 10px;
		  border-top-left-radius: 0;
		  border-top-right-radius: 0;
		}

        .bd-placeholder-img {
          font-size: 1.125rem;
          text-anchor: middle;
          -webkit-user-select: none;
          -moz-user-select: none;
          -ms-user-select: none;
          user-select: none;
        }

        @media (min-width: 768px) {
          .bd-placeholder-img-lg {
            font-size: 3.5rem;
          }
        }
</style>
<meta charset="UTF-8">
<title>/user/loginform.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
<%
	String url=request.getParameter("url");
	if(url==null){
		String cPath=request.getContextPath();
		url=cPath+"/index.jsp";
	}
%>
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="login" name="thisPage"/>
</jsp:include>
	<div class="container">
		<form class="form-signin" action="login.jsp" method="post">
			<input type="hidden" name="url" value="<%=url %>"/>
  			<h1 class="h3 mb-3 font-weight-normal">Please sign in</h1>
  			<label for="id" class="sr-only">Email address</label>
  			<input type="text" id="id" name="id" class="form-control" placeholder="아이디 입력" value="<%=savedId %>" required autofocus>
  			<label for="pwd" class="sr-only">Password</label>
  			<input type="password" id="pwd" name="pwd" class="form-control" placeholder="비밀번호 입력" value="<%=savedPwd %>" required>
 			<div class="checkbox mb-3">
    			<label>
      				<input type="checkbox" name="isSave" value="yes"> 로그인 정보 저장
    			</label>
  			</div>
  		<button class="btn btn-lg btn-primary btn-block" type="submit">로그인</button>
  		<p class="mt-5 mb-3 text-muted">&copy; 2017-2020</p>
	</div>
</body>
</html>