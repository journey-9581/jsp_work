<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--  
	jsp 페이지 안에서의 주석 입니다. 
	여기 작성한 내용은 jsp 페이지가 해석하지 않습니다.
	클라이언트 웹브라우저에 출력되지 않습니다.
--%>
<%--
	특정 jsp 페이지에 포함 시킬 내용을 jsp 페이지에 작성할수 있습니다.
 --%>
 
 <%
 	// "thisPage" 라는 파라미터 명으로 전달된 문자열 읽어오기 
 	String thisPage=request.getParameter("thisPage");
 	//NullPointerException 방지 (500번 버스 안타기)
 	if(thisPage==null){
 		thisPage="";
 	}
 %>
 <nav class="navbar navbar-dark bg-secondary navbar-expand-sm fixed-top">
	<div class="container">
	  	<a class="navbar-brand" href="${pageContext.request.contextPath }/">
	  		<img style="width:30px;height:30px" src="${pageContext.request.contextPath }/images/laptop-coding.png"/> DailyCoding
	  	</a>
		<button class="navbar-toggler" data-toggle="collapse" data-target="#topNav">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="topNav">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item <%=thisPage.equals("list") ? "active" : "" %>">
					<a class="nav-link" href="${pageContext.request.contextPath }/cafe/list.jsp">글 목록</a>
				</li>
				<li class="nav-item <%=thisPage.equals("filelist") ? "active" : "" %>">
					<a class="nav-link" href="${pageContext.request.contextPath }/file/list.jsp">자료실</a>
				</li>
				<li class="nav-item <%=thisPage.equals("gallerylist") ? "active" : "" %>">
					<a class="nav-link" href="${pageContext.request.contextPath }/gallery/list.jsp">갤러리</a>
				</li>
			</ul>
			<%
				//로그인 된 아이디가 있는지 읽어와본다
				String id=(String)session.getAttribute("id");
			%>
			<%if(id==null){ %>
				<a class="btn btn-success btn-sm" href="${pageContext.request.contextPath }/users/loginform.jsp">로그인</a>
				<a class="btn btn-danger btn-sm ml-1" href="${pageContext.request.contextPath }/users/signup_form.jsp">회원가입</a>
			<%}else{ %>
				<span class="navbar-text">
					<a href="${pageContext.request.contextPath }/users/private/info.jsp"><%=id %></a> 님 접속중
					<a class="btn btn-success btn-sm" href="${pageContext.request.contextPath }/users/logout.jsp">로그아웃</a>
				</span>
			<%} %>	
		</div>
	</div>
</nav>
