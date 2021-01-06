<%@page import="test.cafe.dao.CafeDao"%>
<%@page import="java.util.List"%>
<%@page import="test.cafe.dto.CafeDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<CafeDto> list=CafeDao.getInstance().getList();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/cafe/list.jsp</title>
</head>
<body>
	<div class="container">
	<a href="private/insertform.jsp">새 글 작성</a>
	<h2>카페 글 목록</h2>
		<table>
			<thead>
				<tr>
					<th>글번호</th>
					<th>작성자</th>
					<th>제목</th>
					<th>조회수</th>
					<th>작성일자</th>
				</tr>
			</thead>
			<tbody>
				<%for(CafeDto dto:list){ %>
				<tr>
					<td><%=dto.getNum() %></td>
					<td><%=dto.getWriter() %></td>
					<td><%=dto.getTitle() %></td>
					<td><%=dto.getViewCount() %></td>
					<td><%=dto.getRegdate() %></td>
				</tr>
			<%} %>
			</tbody>
		</table>
	</div>
</body>
</html>