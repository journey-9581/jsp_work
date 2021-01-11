<%@page import="java.io.File"%>
<%@page import="test.file.dao.FileDao"%>
<%@page import="test.file.dto.FileDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//1. GET 방식 전달되는 삭제할 파일 번호를 읽어온다
	int num=Integer.parseInt(request.getParameter("num"));
	//2. DB에서 해당 파일을 정보를 읽어온다
	FileDto dto=FileDao.getInstance().getData(num);
	
	//만일 로그인 된 아이디와 글 작성자가 다르면 에러를 응답한다
	String id=(String)session.getAttribute("id"); //로그인 된 아이디
	if(!dto.getWriter().equals(id)){
		response.sendError(HttpServletResponse.SC_FORBIDDEN, "본인이 올린 파일만 지울 수 있습니다");
		return; //메소드 종료
	}
	
	//3. DB에서 파일 정보를 삭제한다
	boolean IsSuccess=FileDao.getInstance().delete(num);
	//4. 파일시스템(upload 폴더)에 저장된 파일을 삭제한다
	/*
		Linux는 파일 경로 구분자가 /(슬래시) 이고
		Window는 파일 경로 구분자가 \(역슬래시) 이다
		File.separtor는 운영체제에 맞게끔 알맞는 파일 구분자를 얻어낼 수 있다
	*/
	String path=application.getRealPath("/upload")+File.separator+dto.getSaveFileName();
	//삭제할 파일을 access 할 수 있는 File 객체 생성
	File file=new File(path);
	if(file.exists()){
		file.delete();
	}
	//5. 응답한다(리다이렉트 응답)
	String cPath=request.getContextPath();
	response.sendRedirect(cPath+"/file/list.jsp");
%>