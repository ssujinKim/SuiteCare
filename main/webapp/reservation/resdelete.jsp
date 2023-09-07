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

int delresinfo = dao.delresinfo(res_code, caretaker_code);

if(delresinfo>0) {
	int delresbook = dao.delresbook(res_code); 
	
	if(delresbook>=0) {
		int match = dao.deltmatch(res_code);
		
		if(match>=0) {
			int delquick = dao.delquick(res_code);
			
			if(delquick>=0) {
		int delres = dao.delres(res_code, caretaker_code);
		
		if(delres>0) {
			
			%>
			<script>
			alert('예약취소가 완료되었습니다.');
			window.location.href='<%=request.getContextPath()%>/member/main';
			</script>
			
			<%
		} else {
			%>
			<script>
			alert('예약취소 오류');
			window.location.href='<%=request.getContextPath()%>/member/main';
			</script>
			<%
		} } else {
			%>
			<script>
			alert('예약취소 오류');
			window.location.href='<%=request.getContextPath()%>/member/main';
			</script>
			<%
	} } else {
			%>
			<script>
			alert('예약취소 오류');
			window.location.href='<%=request.getContextPath()%>/member/main';
			</script>
			<%
	} } else {
		%>
		<script>
		alert('예약취소 오류');
		window.location.href='<%=request.getContextPath()%>/member/main';
		</script>
		<%
}} else {
	%>
	<script>
	alert('예약취소 오류');
	window.location.href='<%=request.getContextPath()%>/member/main';
	</script>
	<%
	
}

%>


</body>
</html>