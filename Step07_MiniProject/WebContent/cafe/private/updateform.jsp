<%@page import="test.cafe.dto.CafeDto"%>
<%@page import="test.cafe.dao.CafeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num=Integer.parseInt(request.getParameter("num"));
	CafeDto dto=CafeDao.getInstance().getData(num);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/cafe/private/updateform.jsp</title>
<style>
	#content {
		width: 99.7%;
		height: 400px;
	}
</style>
<jsp:include page="../../include/resource.jsp"></jsp:include>
</head>
<body>
<jsp:include page="../../include/navbar.jsp">
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
				<li class="breadcrumb-item">
					<a href="${pageContext.request.contextPath }/cafe/detail.jsp?num=<%=num%>"><%=dto.getTitle() %></a>
				</li>
				<li class="breadcrumb-item active">글 수정 하기</li>
			</ul>
		</nav>
		<form action="update.jsp" method="post">
			<input type="hidden" name="num" value="<%=dto.getNum()%>"/>
			<div class="form-group">
				<label>작성자</label>
				<input type="text" class="form-control" value="<%=dto.getWriter()%>" disabled/>
			</div>
			<div class="form-group">
				<label for="title">제목</label>
				<input type="text" class="form-control" name="title" id="title" value="<%=dto.getTitle()%>"/>
			</div>
			<div class="form-group">
				<label for="content">내용</label>
				<textarea name="content" class="form-control" id="content"><%=dto.getContent() %></textarea>
			</div>
			<button type="submit" class="btn btn-secondary" onclick="submitContents(this);">수정</button>
			<button type="reset" class="btn btn-secondary"">취소</button>
		</form>
	</div>
	<script src="${pageContext.request.contextPath }/SmartEditor/js/HuskyEZCreator.js"></script>
	<script>
		var oEditors = [];
		
		//추가 글꼴 목록
		//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];
		
		nhn.husky.EZCreator.createInIFrame({
			oAppRef: oEditors,
			elPlaceHolder: "content",
			sSkinURI: "${pageContext.request.contextPath}/SmartEditor/SmartEditor2Skin.html",	
			htParams : {
				bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
				//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
				fOnBeforeUnload : function(){
					//alert("완료!");
				}
			}, //boolean
			fOnAppLoad : function(){
				//예제 코드
				//oEditors.getById["ir1"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
			},
			fCreator: "createSEditor2"
		});
		
		function pasteHTML() {
			var sHTML = "<span style='color:#FF0000;'>이미지도 같은 방식으로 삽입합니다.<\/span>";
			oEditors.getById["content"].exec("PASTE_HTML", [sHTML]);
		}
		
		function showHTML() {
			var sHTML = oEditors.getById["content"].getIR();
			alert(sHTML);
		}
		
		//폼 전송 버튼을 눌렀을때 호출되는 함수
		//<button type="submit" onclick="submitContent(this);"></button>
		function submitContents(elClickedObj) {
			oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
			
			// 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("content").value를 이용해서 처리하면 됩니다.
			
			try {
				elClickedObj.form.submit();
			} catch(e) {}
		}
		
		function setDefaultFont() {
			var sDefaultFont = '궁서';
			var nFontSize = 24;
			oEditors.getById["content"].setDefaultFont(sDefaultFont, nFontSize);
		}
	</script>
</body>
</html>