<%@page import="test.gallery.dao.GalleryDao"%>
<%@page import="test.gallery.dto.GalleryDto"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//업로드 된 이미지 정보를 DB에 저장하고
	String realPath=application.getRealPath("/upload");
	
	File f=new File(realPath);
	if(!f.exists()){ //만일 폴더가 존재하지 않으면
		f.mkdir(); //upload 폴더 만들기
	}
	
	int sizeLimit=1024*1024*10;
	
	MultipartRequest mr=new MultipartRequest(request,
			realPath,
			sizeLimit,
			"utf-8",
			new DefaultFileRenamePolicy());
	
	String caption=mr.getParameter("caption");
	//원본 파일명 (다운로드 시킬 때 필요)
	String orgFileName=mr.getOriginalFileName("image");
	//upload 폴더에 저장된 파일명 (DB에 저장할 때 필요)
	String saveFileName=mr.getFilesystemName("image");
	
	String writer=(String)session.getAttribute("id");
	
	GalleryDto dto=new GalleryDto();
	dto.setWriter(writer);
	dto.setCaption(caption);
	dto.setImagePath("/upload/"+saveFileName);
	
	GalleryDao.getInstance().insert(dto);
	
	// /gallery/list.jsp 페이지로 리다이렉트 이동해서 업로드 된 이미지 목록을 보여주는 프로그래밍을 해보세요
	String cPath=request.getContextPath();
	response.sendRedirect(cPath+"/gallery/list.jsp");
%>