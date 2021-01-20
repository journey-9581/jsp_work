<%@page import="test.cafe.dao.CafeDao"%>
<%@page import="test.cafe.dto.CafeDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num=Integer.parseInt(request.getParameter("num"));
	String title=request.getParameter("title");
	String content=request.getParameter("content");
	
	CafeDto dto=new CafeDto();
	dto.setNum(num);
	dto.setTitle(title);
	dto.setContent(content);
	
	boolean isSuccess=CafeDao.getInstance().update(dto);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/cafe/private/update.jsp</title>
</head>
<body>
	<%if(isSuccess){ %>
		<script>
			alert("수정 성공");
			location.href="${pageContext.request.contextPath }/cafe/detail.jsp?num=<%=num%>";
		</script>
	<%}else{ %>
		<script>
			alert("수정 실패");
			location.href="${pageContext.request.contextPath }/cafe/updateform.jsp?num=<%=num%>";
		</script>
	<%} %>
</body>
</html>