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
			<a href="detail2.jsp?num=<%=tmp.getNum() %>">
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
	
	//페이지가 처음 로딩될때 1 page를 보여주기 때문에 초기값을 1로 지정한다
	let currentPage=1; //화면 상에 로딩된 최신 페이지 번호를 저장할 변수
	//현재 페이지가 로딩중인지 여부를 저장할 변수
	let isLoading=false;
	
	//웹브라우저의 창을 스크롤 할때마다 호출되는 함수 등록
	$(window).on("scroll", function(){
		//최하단까지 스크롤 되었는지 조사해본다
		//위로 스크롤 된 길이
		let scrollTop=$(window).scrollTop();
		//웹브라우저 창의 높이
		let windowHeight=$(window).height();
		//문서 전체의 높이
		let documentHeight=$(document).height();
		//바닥까지 스크롤 되었는지 여부를 알아낸다
		let isBottom=scrollTop+windowHeight+10>=documentHeight;
		if(isBottom){
			//만일 현재가 마지막 페이지라면
			if(currentPage==<%=totalPageCount%>||isLoading){
				return; //함수를 여기서 끝낸다
			}
			//현재 로딩 중이라고 표시한다
			isLoading=true;
			//로딩바를 띄우고
			$(".back-drop").show();
			//요청할 페이지 번호를 1 증가 시킨다
			currentPage++;
			//추가로 받아올 페이지를 서버에 ajax 요청을 하고 / $.ajax()로 요청하고 ()안 option들은 object
			$.ajax({
				url: "ajax_page.jsp",
				method: "GET",
				data: "pageNum="+currentPage, //{pageNum:currentPage}도 가능 (즉, object를 넣어도 됨! query문자열이나 object 둘 다 가능, jquery가 알아서 해줌)
				success:function(data){
					//응답된 문자열은 html 형식이다
					//해당 문자열을 #galleryList div에 html로 해석하라고 추가한다
					$("#galleryList").append(data);
					//=document.querySelector("#galleryList").append(data);
					//로딩바를 숨긴다
					$(".back-drop").hide();
					//현재 추가된 img 요소의 부모 div를 선택해서 imgLiquid() 동작하기
					$(".page-"+currentPage).imgLiquid();
					//로딩중이 아니라고 표시한다
					isLoading=false;
				}
			});
		}
	});
</script>
</body>
</html>