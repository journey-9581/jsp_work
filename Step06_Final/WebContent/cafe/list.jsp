<%@page import="java.net.URLEncoder"%>
<%@page import="test.cafe.dao.CafeDao"%>
<%@page import="java.util.List"%>
<%@page import="test.cafe.dto.CafeDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	final int PAGE_ROW_COUNT=5;
	final int PAGE_DISPLAY_COUNT=5;
	
	int pageNum=1;
	String strPageNum=request.getParameter("pageNum");
	if(strPageNum != null){
		pageNum=Integer.parseInt(strPageNum);
	}

	int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
	int endRowNum=pageNum*PAGE_ROW_COUNT;
	
	String keyword=request.getParameter("keyword");
	String condition=request.getParameter("condition");
	if(keyword==null){
		keyword="";
		condition="";
	}
	
	String encodedK=URLEncoder.encode(keyword);
	
	CafeDto dto=new CafeDto();
	dto.setStartRowNum(startRowNum);
	dto.setEndRowNum(endRowNum);
	
	List<CafeDto> list=null;
	int totalRow=0;
	if(!keyword.equals("")){
		if(condition.equals("title_content")){
			dto.setTitle(keyword);
			dto.setContent(keyword);
			list=CafeDao.getInstance().getListTC(dto);
			totalRow=CafeDao.getInstance().getCountTC(dto);
		}else if(condition.equals("title")){
			dto.setTitle(keyword);
			list=CafeDao.getInstance().getListT(dto);
			totalRow=CafeDao.getInstance().getCountT(dto);
		}else if(condition.equals("writer")){
			dto.setWriter(keyword);
			list=CafeDao.getInstance().getListW(dto);
			totalRow=CafeDao.getInstance().getCountW(dto);
		}
	}else{
		list=CafeDao.getInstance().getList(dto);
		totalRow=CafeDao.getInstance().getCount();
	}
	
	int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
	int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;

	int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
	if(endPageNum > totalPageCount){
		endPageNum=totalPageCount;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/cafe/list.jsp</title>
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
				<li class="breadcrumb-item active">글 목록</li>
			</ul>
		</nav>
		<a href="private/insertform.jsp">새 글 쓰기</a>
			<table class="table table-striped">
				<thead class="table-secondary">
					<tr>
						<th>글번호</th>
						<th>작성자</th>
						<th>제목</th>
						<th>조회수</th>
						<th>작성일자</th>
					</tr>
				</thead>
				<tbody>
					<%for(CafeDto tmp:list){ %>
					<tr>
						<td><%=tmp.getNum() %></td>
						<td><%=tmp.getWriter() %></td>
						<td><a href="detail.jsp?num=<%=tmp.getNum()%>"><%=tmp.getTitle() %></a></td>
						<td><%=tmp.getViewCount() %></td>
						<td><%=tmp.getRegdate() %></td>
					</tr>
				<%} %>
				</tbody>
			</table>
			<nav>
			<ul class="pagination justify-content-center">
				<%if(startPageNum != 1){ %>
					<li class="page-item">
						<a class="page-link" href="list.jsp?pageNum=<%=startPageNum-1 %>&condition=<%=condition%>&keyword=<%=encodedK%>">Prev</a>
					</li>
				<%}else{ %>
					<li class="page-item disabled">
						<a class="page-link" href="javascript:">Prev</a>
					</li>
				<%} %>
				<%for(int i=startPageNum; i<=endPageNum; i++) {%>
					<%if(i==pageNum){ %>
						<li class="page-item active">
							<a class="page-link" href="list.jsp?pageNum=<%=i %>&condition=<%=condition%>&keyword=<%=encodedK%>"><%=i %></a>
						</li>
					<%}else{ %>
						<li class="page-item">
							<a class="page-link" href="list.jsp?pageNum=<%=i %>&condition=<%=condition%>&keyword=<%=encodedK%>"><%=i %></a>
						</li>
					<%} %>
				<%} %>
				<%if(endPageNum < totalPageCount){ %>
					<li class="page-item">
						<a class="page-link" href="list.jsp?pageNum=<%=endPageNum+1 %>&condition=<%=condition%>&keyword=<%=encodedK%>">Next</a>
					</li>
				<%}else{ %>
					<li class="page-item disabled">
						<a class="page-link" href="javascript:">Next</a>
					</li>
				<%} %>
			</ul>
		</nav>
		<form action="list.jsp" method="get">
			<label for="condition">검색 조건</label>
			<select name="condition" id="condition">
				<option value="title_content" <%=condition.equals("title_content")?"selected":"" %>>제목+내용</option>
				<option value="title" <%=condition.equals("title")?"selected":"" %>>제목</option>
				<option value="writer" <%=condition.equals("writer")?"selected":"" %>>작성자</option>
			</select>
			<input type="text" name="keyword" placeholder="검색어" value="<%=keyword %>"/>
			<button type="submit">검색</button>
		</form>
		<%if(!keyword.equals("")){%>
			<div class="alert alert-success">
				<strong><%=totalRow %></strong> 개의 자료가 검색되었습니다
			</div>
		<%} %>
	</div>
</body>
</html>