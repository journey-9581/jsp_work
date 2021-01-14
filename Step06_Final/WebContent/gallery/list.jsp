<%@page import="test.gallery.dao.GalleryDao"%>
<%@page import="java.util.List"%>
<%@page import="test.gallery.dto.GalleryDto"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	final int PAGE_ROW_COUNT=8;
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
	
	GalleryDto dto=new GalleryDto();
	dto.setStartRowNum(startRowNum);
	dto.setEndRowNum(endRowNum);
	
	List<GalleryDto> list=null;
	int totalRow=0;
	if(!keyword.equals("")){
		if(condition.equals("caption")){
			dto.setCaption(keyword);
			list=GalleryDao.getInstance().getListC(dto);
			totalRow=GalleryDao.getInstance().getCountC(dto);
		}else if(condition.equals("writer")){
			dto.setWriter(keyword);
			list=GalleryDao.getInstance().getListW(dto);
			totalRow=GalleryDao.getInstance().getCountW(dto);
		}
	}else{
		list=GalleryDao.getInstance().getList(dto);
		totalRow=GalleryDao.getInstance().getCount();
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
<title>/gallery/list.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<!-- 
	jquery 플러그인 imgLiquid.js 로딩하기 
	- 반드시 jquery.js가 먼저 로딩이 되어 있어야지만 동작한다
	- 사용법은 이미지의 부모 div 크기를 결정하고 이미지를 선택해서 .imgLiquid() 동작을 하면 된다
-->
<script src="${pageContext.request.contextPath }/js/imgLiquid.js">
	
</script>
<style>
	/* card 이미지 부모 요소의 높이 지정 */
	.img-wrapper{
		height: 250px;
		/* transform을 적용할 때 0.15s 동안 순차적으로 적용하기 */
		transition: transform 0.15s ease-out;
	}
	
	/* .img-wrapper에 마우스가 hover 되었을 때 적용할 css */
	.img-wrapper:hover{
		/* 원본 크기의 1.3배로 확대 시키기 */
		transform: scale(1.3);
	}
	
	.card .card-text{
		/* 한 줄만 text가 나오고 한 줄 넘는 길이에 대해서는 ... 처리하는 css */	
		display: block;
		white-space: nowrap;
		text-overflow: ellipsis;
		overflow: hidden;
	}
</style>
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
			<li class="breadcrumb-item active">갤러리 목록</li>
		</ul>
	</nav>
	<a href="private/upload_form.jsp">사진 업로드 하기</a><br/>
	<a href="private/ajax_form.jsp">사진 업로드 하러 가기2</a>
	<div class="row">
		<%for(GalleryDto tmp:list) { %>
		<!-- 
			[칼럼의 폭을 반응형으로]
			device 폭 768px 미만에서 칼럼의 폭 => 6/12 (50%)
			device 폭 768px ~ 992px 에서 칼럼의 폭 => 4/12 (33.333..%)
			device 폭 992px 이상에서 칼럭의 폭 => 3/12 (25%)
		 -->
		<div class="col-6 col-md-4 col-lg-3">
			<a href="detail.jsp?num=<%=tmp.getNum() %>">
				<div class="card mb-3">
					<div class="img-wrapper">
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
	</div>
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
				<option value="caption" <%=condition.equals("caption")?"selected":"" %>>내용</option>
				<option value="writer" <%=condition.equals("writer")?"selected":"" %>>작성자</option>
			</select>
			<input type="text" name="keyword" placeholder="검색어" value="<%=keyword %>"/>
			<button type="submit">검색</button>
		</form>
	<%-- 만일 검색 키워드가 존재한다면 몇개의 글이 검색 되었는지 알려준다 --%>
	<%if(!keyword.equals("")){%>
		<div class="alert alert-success">
			<strong><%=totalRow %></strong> 개의 자료가 검색되었습니다
		</div>
	<%} %>
</div>
<script>
	//card 이미지의 부모 요소를 선택해서 imgLiquid 동작(jquery plugin 동작) 하기
	$("img-wrapper").imgLiquid();
</script>
</body>
</html>