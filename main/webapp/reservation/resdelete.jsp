<%@ page import = "reservation.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약삭제</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
String m_id = (String)session.getAttribute("m_id");
String res_code = request.getParameter("res_code");
String caretaker_code = request.getParameter("caretaker_code");
ReservationDAO dao = new ReservationDAO();

dao.delres(res_code, caretaker_code);

%>


</body>
<script>
alert('예약취소가 완료되었습니다.');
window.location.href='../member/mMain.jsp';
</script>
</html>