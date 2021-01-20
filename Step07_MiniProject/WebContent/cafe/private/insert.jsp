<%@page import="test.cafe.dao.CafeDao"%>
<%@page import="test.cafe.dto.CafeDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String writer=(String)session.getAttribute("id");
	
	String title=request.getParameter("title");
	String content=request.getParameter("content");
	
	CafeDto dto=new CafeDto();
	dto.setWriter(writer);
	dto.setTitle(title);
	dto.setContent(content);
	boolean isSuccess=CafeDao.getInstance().insert(dto);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/cafe/private/insertform.jsp</title>
</head>
<body>
	<%if(isSuccess){ %>
		<script>
			alert("글 작성 성공");
			location.href="${pageContext.request.contextPath }/cafe/list.jsp";
		</script>
	<%}else{ %>
		<script>
			alert("글 작성 실패");
			location.href="${pageContext.request.contextPath }/cafe/private/insertform.jsp";
		</script>
	<%} %>
</body>
</html>