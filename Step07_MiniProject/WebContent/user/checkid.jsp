<%@page import="test.user.dao.UserDao"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String inputId=request.getParameter("inputId");
	System.out.println("inputId:"+inputId);
	boolean isExist=UserDao.getInstance().isExist(inputId);
%>
{"isExist":<%=isExist%>}