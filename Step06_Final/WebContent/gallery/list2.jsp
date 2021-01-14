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
	
	/* img가 가운데 정렬 되도록 */
	.back-drop{
		/* 일단 숨겨 놓는다 */
		display: none;
		/* 화면 전체를 투명도가 있는 회색으로 덮기 위한 css */
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
		/* rotateAnimation이라는 키프레임을 2초 동안 무한 반복하기*/
		animation: rotateAnimation 2s ease-out infinite;
	}
	
	/* 회전하는 rotateAnimation이라는 이름의 키프레임 정의하기 */
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
	<a href="private/upload_form.jsp">사진 업로드 하기</a><br/>
	<a href="private/ajax_form.jsp">사진 업로드 하러 가기2</a>
	<div class="row" id="galleryList">
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
	<div class="back-drop">
		<img src="${pageContext.request.contextPath }/svg/spinner-solid.svg"/>
	</div>
</div>
<script>
	//card 이미지의 부모 요소를 선택해서 imgLiquid 동작(jquery plugin 동작) 하기
	$("img-wrapper").imgLiquid();

	//웹브라우저의 창을 스크롤 할때마다 호출되는 함수 등록
	$(window).on("scroll", function(){
		console.log("scroll");
		//최하단까지 스크롤 되었는지 조사해본다
		let scrollTop=$(window).scrollTop();
		let windowHeight=$(window).height();
		let documentHeight=$(document).height();
		
		let isBottom=scrollTop+windowHeight+10>=documentHeight;
		if(isBottom){
			console.log("바닥");
			//로딩바를 띄우고
			$(".back-drop").show();
			//추가로 받아올 페이지를 서버에 ajax 요청을 하고 / $.ajax()로 요청하고 ()안 option들은 object
			$.ajax({
				url: "ajax_page.jsp",
				method: "GET",
				data: "pageNum=2",
				success:function(data){
					//응답된 문자열은 html 형식이다
					//해당 문자열을 #galleryList div에 html로 해석하라고 추가한다
					$("#galleryList").append(data);
					//로딩바를 숨긴다
					$(".back-drop").hide();
				}
			});
		}
	});
</script>
</body>
</html>