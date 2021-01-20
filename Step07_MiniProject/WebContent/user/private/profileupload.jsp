<%@page import="test.user.dao.UserDao"%>
<%@page import="test.user.dto.UserDto"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String realPath=application.getRealPath("/upload");
	
	File f=new File(realPath);
	if(!f.exists()){
		f.mkdir();
	}

	int sizeLimit=1024*1024*5;
	MultipartRequest mr=new MultipartRequest(request,
			realPath,
			sizeLimit,
			"utf-8",
			new DefaultFileRenamePolicy());
	String orgFileName=mr.getOriginalFileName("image");
	String saveFileName=mr.getFilesystemName("image");
	
	String id=(String)session.getAttribute("id");
	String profile="/upload/"+saveFileName;
	UserDto dto=new UserDto();
	dto.setId(id);
	dto.setProfile(profile);
	UserDao.getInstance().updateProfile(dto);
	String cPath=request.getContextPath();
	response.sendRedirect(cPath+"/user/private/updateform.jsp");
%>