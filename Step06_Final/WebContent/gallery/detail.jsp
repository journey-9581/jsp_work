<%@page import="test.gallery.dto.GalleryDto"%>
<%@page import="test.gallery.dao.GalleryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//1. GET 방식 파라미터로 전달되는 자세히 보여줄 글 번호를 읽어온다
	int num=Integer.parseInt(request.getParameter("num"));
	//2. 글 번호를 이용해서 DB에서 글 정보를 읽어온다
	GalleryDto dto=GalleryDao.getInstance().getData(num);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/gallery/detail.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
<jsp:include page="../include/navbar.jsp">
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
			<li class="breadcrumb-item active"><%=dto.getCaption() %></li>
		</ul>
	</nav>
	<div class="card">
		<img src="${pageContext.request.contextPath }<%=dto.getImagePath()%>" class="card-img-top"/>
		<div class="card-body">
			<h5 class="card-title"><strong><%=dto.getCaption() %></strong></h5>
			<p class="card-text">by <%=dto.getWriter() %></p>
			<p class="card-text"><%=dto.getRegdate() %></p>
			<%
			//session scope에서 로그인 된 아이디를 읽어와본다 (null 일수도 있음)
			String id=(String)session.getAttribute("id");
			%>
			<a href="list.jsp" class="btn btn-outline-success">갤러리 목록</a>
			<%if(dto.getWriter().equals(id)){ %>
				<a href="${pageContext.request.contextPath }/gallery/private/updateform.jsp?num=<%=dto.getNum()%>" class="btn btn-outline-warning">수정</a>
				<a href="javascript:deleteConfirm()" class="btn btn-outline-danger">삭제</a>
			<%} %>
		</div>
	</div>
</div>
<script>
	function deleteConfirm(){
		let isDelete=confirm("글을 삭제하시겠습니까?");
		if(isDelete){
			location.href="${pageContext.request.contextPath }/gallery/private/delete.jsp?num=<%=dto.getNum()%>";
		}
	}
</script>
</body>
</html>