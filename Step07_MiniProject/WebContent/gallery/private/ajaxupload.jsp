<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String realPath=application.getRealPath("/upload");

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
	
	//업로드 된 이미지 파일의 저장 경로만 json으로 응답하면 된다
	String saveFileName=mr.getFilesystemName("image");
	String imagePath="/upload/"+saveFileName;
%>
{"imagePath":"<%=imagePath %>"}