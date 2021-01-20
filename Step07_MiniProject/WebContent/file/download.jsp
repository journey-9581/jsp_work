<%@page import="java.io.File"%>
<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="test.file.dao.FileDao"%>
<%@page import="test.file.dto.FileDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num=Integer.parseInt(request.getParameter("num"));

	FileDto dto=FileDao.getInstance().getData(num);
	
	String orgFileName=dto.getOrgFileName();
	String saveFileName=dto.getSaveFileName();
	String path=request.getServletContext().getRealPath("/upload")+File.separator+saveFileName;
	FileInputStream fis=new FileInputStream(path);
	String encodedName=null;
	System.out.println(request.getHeader("User-Agent"));
	if(request.getHeader("User-Agent").contains("Firefox")){
		encodedName=new String
			(orgFileName.getBytes("utf-8"),"ISO-8859-1");
	}else{
		encodedName=URLEncoder.encode(orgFileName, "utf-8");
		encodedName=encodedName.replaceAll("\\+"," ");
	}
	
	response.setHeader("Content-Disposition","attachment;filename="+encodedName);
	response.setHeader("Content-Transfer-Encoding", "binary");
	
	response.setContentLengthLong(dto.getFileSize());
	
	BufferedOutputStream bos=new BufferedOutputStream(response.getOutputStream());
	byte[] buffer=new byte[1024*1024];
	int readedByte=0;
	while(true){
		readedByte = fis.read(buffer);
		if(readedByte == -1)break;
		bos.write(buffer, 0, readedByte);
		bos.flush();
	}
	
	fis.close();
%>