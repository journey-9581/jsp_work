<%@page import="java.util.List"%>
<%@page import="test.gallery.dao.GalleryDao"%>
<%@page import="test.gallery.dto.GalleryDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	final int PAGE_ROW_COUNT=8;
	final int PAGE_DISPLAY_COUNT=5;
	
	//ajax 요청 파라미터 pageNum 읽어오기 (pageNum은 무조건 넘어옴)
	int pageNum=Integer.parseInt(request.getParameter("pageNum"));
	
	int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
	int endRowNum=pageNum*PAGE_ROW_COUNT;
	
	//pageNum에 해당되는 목록만 불러오기
	GalleryDto dto=new GalleryDto();
	dto.setStartRowNum(startRowNum);
	dto.setEndRowNum(endRowNum);
	List<GalleryDto> list=GalleryDao.getInstance().getList(dto);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/gallery/ajax_page.jsp</title>
</head>
<body>
<%for(GalleryDto tmp:list) { %>
<div class="col-6 col-md-4 col-lg-3">
	<a href="detail.jsp?num=<%=tmp.getNum() %>">
		<div class="card mb-3">
			<div class="img-wrapper page-<%=pageNum%>">
				<img class="card-img-top" src="${pageContext.request.contextPath }<%=tmp.getImagePath()%>"/>
			</div>
			<div class="card-body">
				<p class="card-text"><%=tmp.getCaption() %></p>
				<p class="card-text">by <strong><%=tmp.getWriter() %></strong></p>
				<p><small><%=tmp.getRegdate() %></small></p>
			</div>
		</div>
	</a>
</div>
<%} %>
</body>
</html>