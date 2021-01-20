<%@page import="java.util.List"%>
<%@page import="test.file.dao.FileDao"%>
<%@page import="test.file.dto.FileDto"%>
<%@page import="java.net.URLEncoder"%>
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
	
	FileDto dto=new FileDto();
	dto.setStartRowNum(startRowNum);
	dto.setEndRowNum(endRowNum);
	
	List<FileDto> list=null;
	int totalRow=0;
	if(!keyword.equals("")){
		if(condition.equals("title_filename")){
			dto.setTitle(keyword);
			dto.setOrgFileName(keyword);
			list=FileDao.getInstance().getListTF(dto);
			totalRow=FileDao.getInstance().getCountTF(dto);
		}else if(condition.equals("title")){
			dto.setTitle(keyword);
			list=FileDao.getInstance().getListT(dto);
			totalRow=FileDao.getInstance().getCountT(dto);
		}else if(condition.equals("writer")){
			dto.setWriter(keyword);
			list=FileDao.getInstance().getListW(dto);
			totalRow=FileDao.getInstance().getCountW(dto);
		}
	}else{
		list=FileDao.getInstance().getList(dto);
		totalRow=FileDao.getInstance().getCount();
	}
	
	int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
	int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;
		
	int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
	if(endPageNum > totalPageCount){
		endPageNum=totalPageCount;
	}
	
	String id=(String)session.getAttribute("id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/file/list.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="filelist" name="thisPage"/>
</jsp:include>
	<div class="container">
		<nav>
			<ul class="breadcrumb">
				<li class="breadcrumb-item">
					<a href="${pageContext.request.contextPath }/">홈</a>
				</li>
				<li class="breadcrumb-item active">파일 목록</li>
			</ul>
		</nav>
		<a href="${pageContext.request.contextPath }/file/private/uploadform.jsp">업로드 하기</a>
		<table class="table table-striped">
			<thead class="table-secondary">
				<tr>
					<th>번호</th>
					<th>작성자</th>
					<th>제목</th>
					<th>파일명</th>
					<th>크기</th>
					<th>등록일</th>
					<th>삭제</th>
				</tr>
			</thead>
			<tbody>
			<%for(FileDto tmp:list){%>
				<tr>
					<td><%=tmp.getNum() %></td>
					<td><%=tmp.getWriter() %></td>
					<td><%=tmp.getTitle() %></td>
					<td><a href="download.jsp?num=<%=tmp.getNum()%>"><%=tmp.getOrgFileName() %></a></td>
					<td><%=tmp.getFileSize() %></td>
					<td><%=tmp.getRegdate() %></td>
					<td>
					<%if(tmp.getWriter().equals(id)){ %>
						<a href="javascript:deleteConfirm(<%=tmp.getNum()%>)">삭제</a>
					<%} %>
					</td>
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
				<option value="title_filename" <%=condition.equals("title_filename")?"selected":"" %>>제목+파일명</option>
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
	<script>
		function deleteConfirm(num){
			let isDelete=confirm(num+"번 파일을 삭제하시겠습니까?");
			if(isDelete){
				location.href="private/delete.jsp?num="+num;
			}
		}
	</script>
</body>
</html>