<%@page import="java.util.List"%>
<%@page import="test.gallery.dao.GalleryDao"%>
<%@page import="test.gallery.dto.GalleryDto"%>
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
	
	GalleryDto dto=new GalleryDto();
	dto.setStartRowNum(startRowNum);
	dto.setEndRowNum(endRowNum);
	
	List<GalleryDto> list=GalleryDao.getInstance().getList(dto);
	
	int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
	int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;
	
	int totalRow=GalleryDao.getInstance().getCount();
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
<script src="${pageContext.request.contextPath }/js/imgLiquid.js">

</script>
<style>
	.img-wrapper{
		height: 250px;
		transition: transform 0.15s ease-out;
	}
	
	.img-wrapper:hover{
		transform: scale(1.3);
	}
	
	.card .card-text{
		display: block;
		white-space: nowrap;
		text-overflow: ellipsis;
		overflow: hidden;
	}
	
	.back-drop{
		display: none;
		position: fixed;
		top: 0;
		right: 0;
		bottom: 0;
		left: 0;
		background-color: #cecece;
		padding-top: 300px;
		z-index: 10000;
		opacity: 0.5;
		text-align: center;
	}
	
	.back-drop img{
		width: 50px;
		animation: rotateAnimation 2s ease-out infinite;
	}
	
	@keyframes rotateAnimation{
		0%{
			transform: rotate(0deg);
		}
		100%{
			transform: rotate(360deg);
		}
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
		<a href="${pageContext.request.contextPath }/gallery/private/ajaxform.jsp">사진 업로드 하러 가기</a>
		<div class="row" id="galleryList">
			<%for(GalleryDto tmp:list) { %>
			<div class="col-6 col-md-4 col-lg-3">
				<a href="${pageContext.request.contextPath }/gallery/detail.jsp?num=<%=tmp.getNum() %>">
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
		<div class="back-drop">
			<img src="${pageContext.request.contextPath }/svg/spinner-solid.svg"/>
		</div>
	</div>
	<script>
		$("img-wrapper").imgLiquid();
		
		let currentPage=1;
		let isLoading=false;
		
		$(window).on("scroll", function(){
			let scrollTop=$(window).scrollTop();
			let windowHeight=$(window).height();
			let documentHeight=$(document).height();
			let isBottom=scrollTop+windowHeight+10>=documentHeight;
			if(isBottom){
				if(currentPage==<%=totalPageCount%>||isLoading){
					return;
				}
				isLoading=true;
				$(".back-drop").show();
				currentPage++;
				$.ajax({
					url: "ajaxpage.jsp",
					method: "GET",
					data: "pageNum="+currentPage,
					success:function(data){
						$("#galleryList").append(data);
						$(".back-drop").hide();
						$(".page-"+currentPage).imgLiquid();
						isLoading=false;
					}
				});
			}
		});
	</script>
</body>
</html>