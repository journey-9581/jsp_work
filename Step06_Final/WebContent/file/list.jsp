<%@page import="test.file.dto.FileDto"%>
<%@page import="java.util.List"%>
<%@page import="test.file.dao.FileDao"%>
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
	
	FileDto dto=new FileDto();
	dto.setStartRowNum(startRowNum);
	dto.setEndRowNum(endRowNum);
	
	List<FileDto> list=FileDao.getInstance().getList(dto);
	
	int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
	int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;
		
	int totalRow=FileDao.getInstance().getCount();
	int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
	if(endPageNum > totalPageCount){
		endPageNum=totalPageCount;
	}
	
	//로그인 된 아이디가 있는지 읽어와본다(로그인을 하지 않으면 null)
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
		<a href="private/upload_form.jsp">업로드 하기</a>
		<table class="table table-striped">
			<thead class="table-secondary">
				<tr>
					<th>번호</th>
					<th>작성자</th>
					<th>제목(설명)</th>
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
						<a class="page-link" href="list.jsp?pageNum=<%=startPageNum-1 %>">Prev</a>
					</li>
				<%}else{ %>
					<li class="page-item disabled">
						<a class="page-link" href="javascript:">Prev</a>
					</li>
				<%} %>
				<%for(int i=startPageNum; i<=endPageNum; i++) {%>
					<%if(i==pageNum){ %>
						<li class="page-item active">
							<a class="page-link" href="list.jsp?pageNum=<%=i %>"><%=i %></a>
						</li>
					<%}else{ %>
						<li class="page-item">
							<a class="page-link" href="list.jsp?pageNum=<%=i %>"><%=i %></a>
						</li>
					<%} %>
				<%} %>
				<%if(endPageNum < totalPageCount){ %>
					<li class="page-item">
						<a class="page-link" href="list.jsp?pageNum=<%=endPageNum+1 %>">Next</a>
					</li>
				<%}else{ %>
					<li class="page-item disabled">
						<a class="page-link" href="javascript:">Next</a>
					</li>
				<%} %>
			</ul>
		</nav>
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