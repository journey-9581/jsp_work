<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 <%
 	String thisPage=request.getParameter("thisPage");
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
				String id=(String)session.getAttribute("id");
			%>
			<%if(id==null){ %>
				<a class="btn btn-success btn-sm" href="${pageContext.request.contextPath }/user/loginform.jsp">로그인</a>
				<a class="btn btn-danger btn-sm ml-1" href="${pageContext.request.contextPath }/user/signupform.jsp">회원가입</a>
			<%}else{ %>
				<span class="navbar-text">
					<a href="${pageContext.request.contextPath }/user/private/info.jsp"><%=id %></a> 님 접속중
					<a class="btn btn-success btn-sm" href="${pageContext.request.contextPath }/user/logout.jsp">로그아웃</a>
				</span>
			<%} %>	
		</div>
	</div>
</nav>
