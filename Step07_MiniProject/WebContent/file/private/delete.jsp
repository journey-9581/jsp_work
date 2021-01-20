<%@page import="java.io.File"%>
<%@page import="test.file.dao.FileDao"%>
<%@page import="test.file.dto.FileDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num=Integer.parseInt(request.getParameter("num"));
	FileDto dto=FileDao.getInstance().getData(num);
	
	String id=(String)session.getAttribute("id");
	if(!dto.getWriter().equals(id)){
		response.sendError(HttpServletResponse.SC_FORBIDDEN, "본인이 올린 파일만 지울 수 있습니다");
		return;
	}
	
	boolean IsSuccess=FileDao.getInstance().delete(num);
	String path=application.getRealPath("/upload")+File.separator+dto.getSaveFileName();
	File file=new File(path);
	if(file.exists()){
		file.delete();
	}

	String cPath=request.getContextPath();
	response.sendRedirect(cPath+"/file/list.jsp");
%>