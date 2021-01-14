<%@page import="test.gallery.dto.GalleryDto"%>
<%@page import="test.gallery.dao.GalleryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num=Integer.parseInt(request.getParameter("num"));
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
		<img src="${pageContext.request.contextPath }<%=dto.getImagePath() %>" class="card-img-top"/>
		<div class="card-body">
			<h5 class="card-title"><strong><%=dto.getCaption() %></strong></h5>
			<p class="card-text">by <strong><%=dto.getWriter() %></strong></p>
			<p><small class="card-text"><%=dto.getRegdate() %></small></p>
			<%String id=(String)session.getAttribute("id"); %>
			<a href="list2.jsp" class="btn btn-outline-secondary">목록</a>
			<%if(dto.getWriter().equals(id)){ %>
				<a href="${pageContext.request.contextPath }/gallery/private/updateform.jsp?num=<%=dto.getNum()%>" class="btn btn-outline-warning">수정</a>
				<a href="javascript:deleteConfirm()" class="btn btn-outline-danger">삭제</a>
			<%} %>
			<p></p>
			<div>
				<%if(dto.getPrevNum()!=0) { %>
					<a href="detail2.jsp?num=<%=dto.getPrevNum()%>" class="btn btn-outline-primary">이전</a>
				<%} %>
				<%if(dto.getNextNum()!=0) { %>
					<a href="detail2.jsp?num=<%=dto.getNextNum()%>" class="btn btn-outline-primary">다음</a>
				<%} %>
			</div>
		</div>
	</div>
</div>
</body>
<script>
	function deleteConfirm(){
		let isDelete=confirm("글을 삭제하시겠습니까?");
		if(isDelete){
			location.href="${pageContext.request.contextPath }/gallery/private/delete.jsp?num=<%=dto.getNum()%>";
		}
	}
</script>
</html>