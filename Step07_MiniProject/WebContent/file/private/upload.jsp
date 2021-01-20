<%@page import="test.file.dao.FileDao"%>
<%@page import="test.file.dto.FileDto"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String realPath=application.getRealPath("/upload");
	System.out.println("realPath:"+realPath);
	
	File f=new File(realPath);
	if(!f.exists()){
		f.mkdir();
	}
	
	int sizeLimit=1024*1024*50;
	
	MultipartRequest mr=new MultipartRequest(request,
			realPath,
			sizeLimit,
			"utf-8",
			new DefaultFileRenamePolicy());
	//폼 전송된 내용 추출하기
	String title=mr.getParameter("title");
	String orgFileName=mr.getOriginalFileName("myFile");
	String saveFileName=mr.getFilesystemName("myFile");
	long fileSize=mr.getFile("myFile").length();

	String writer=(String)session.getAttribute("id");
	
	FileDto dto=new FileDto();
	dto.setWriter(writer);
	dto.setTitle(title);
	dto.setOrgFileName(orgFileName);
	dto.setSaveFileName(saveFileName);
	dto.setFileSize(fileSize);
	
	boolean isSuccess=FileDao.getInstance().insert(dto);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%if(isSuccess){ %>
		<script>
			alert("<%=orgFileName%> 업로드 완료");
			location.href="${pageContext.request.contextPath }/file/list.jsp";
		</script>
	<%}else{ %>
		<script>
			alert("<%=orgFileName%> 업로드 완료");
			location.href="${pageContext.request.contextPath }/file/private/uploadform.jsp";
		</script>
	<%} %>
</body>
</html>