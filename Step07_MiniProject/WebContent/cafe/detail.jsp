<%@page import="test.cafe.dao.CafeDao"%>
<%@page import="test.cafe.dto.CafeDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num=Integer.parseInt(request.getParameter("num"));
	CafeDto dto=CafeDao.getInstance().getData(num);
	CafeDao.getInstance().addViewCount(num);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/cafe/detail.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="list" name="thisPage"/>
</jsp:include>
	<div class="container">
		<nav>
			<ul class="breadcrumb">
				<li class="breadcrumb-item">
					<a href="${pageContext.request.contextPath }/">홈</a>
				</li>
				<li class="breadcrumb-item">
					<a href="${pageContext.request.contextPath }/cafe/list.jsp">글 목록</a>
				</li>
				<li class="breadcrumb-item active"><%=dto.getTitle() %></li>
			</ul>
		</nav>
		<table class="table table-bordered">
			<tr>
				<th>글 번호</th>
				<td><%=dto.getNum() %></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><%=dto.getWriter() %></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><%=dto.getTitle() %></td>
			</tr>
			<tr>
				<th>조회수</th>
				<td><%=dto.getViewCount() %></td>
			</tr>
			<tr>
				<th>등록일자</th>
				<td><%=dto.getRegdate() %></td>
			</tr>
			<tr>
				<td colspan="2">
					<div id="contents"><%=dto.getContent() %></div>
				</td>
			</tr>
		</table>
		<%
			String id=(String)session.getAttribute("id");
		%>
		<dl>
			<dd><a href="${pageContext.request.contextPath }/cafe/list.jsp">목록보기</a></dd>
			<%if(dto.getWriter().equals(id)){ %>
				<dd><a href="${pageContext.request.contextPath }/cafe/private/updateform.jsp?num=<%=dto.getNum()%>">수정</a></dd>
				<dd><a href="javascript:deleteConfirm()">삭제</a></dd>
			<%} %>
		</dl>
	</div>
	<script>
		function deleteConfirm(){
			let isDelete=confirm("글을 삭제하시겠습니까?");
			if(isDelete){
				location.href="${pageContext.request.contextPath }/cafe/private/delete.jsp?num=<%=dto.getNum()%>";
			}
		}
	</script>	
</body>
</html>