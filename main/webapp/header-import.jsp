<%@ taglib prefix = "fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false"
%>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.List" %>

<%
String context = request.getContextPath();
request.setCharacterEncoding("utf-8");
%>
<c:set var="context" value="${pageContext.request.contextPath}" />

<!--          meta 선언          -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">

<!--          script 선언          -->
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://kit.fontawesome.com/d75ead5752.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.min.js" integrity="sha384-Rx+T1VzGupg4BHQYs2gCW9It+akI2MM/mndMCy36UVfodzcJcF0GGLxZIzObiEfa" crossorigin="anonymous"></script>

<!--          link 선언          -->
<link rel="stylesheet" href="${context}/assets/css/main.css" />
<link rel="stylesheet" href="${context}/assets/css/sc.css" />
<link rel="stylesheet" href="${context}/assets/css/bootstrap.tab.css" />

<!--          로그인 체크          -->
<% String m_id = (String)session.getAttribute("m_id");
String g_id = (String)session.getAttribute("g_id");
String adcode = (String)session.getAttribute("adcode");

String[] uriArr = request.getServletPath().split("/");
String uri = uriArr[uriArr.length-1];

String[] pageArray = {"index", "Signup", "Login", "Find", "ad"};
boolean logincheck = true;
for (String exWord: pageArray){
	if (uri.contains(exWord)){
		System.out.println(uri+"에 "+exWord+" 이(가) 포함되어 로그인 체크 예외처리함");
		logincheck = false;
		break;
	}	
}

if (logincheck){
	if(m_id == null && g_id == null){
		System.out.println("로그인 세션 없음");
		out.print("<script>alert('로그인이 필요합니다.'); location.href='"+request.getContextPath()+"/index.jsp';</script>");
	}
}
%>