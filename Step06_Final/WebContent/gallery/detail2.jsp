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
<div class="container">
	<div>
		<img src="${pageContext.request.contextPath }<%=dto.getImagePath() %>"/>
		<div>
			<p><%=dto.getCaption() %></p>
			<p>by <strong><%=dto.getWriter() %></strong></p>
			<p><small><%=dto.getRegdate() %></small></p>
		</div>
	</div>
	<%if(dto.getPrevNum()!=0) { %>
		<a href="detail2.jsp?num=<%=dto.getPrevNum()%>">이전</a>
	<%} %>
	<%if(dto.getNextNum()!=0) { %>
		<a href="detail2.jsp?num=<%=dto.getNextNum()%>">다음</a>
	<%} %>
</div>
</body>
</html>