<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="caregiver.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.Time"%>
<%@ page import="java.sql.Date"%>
<%@ page import="java.util.*"%>    


<!DOCTYPE html>
<html>
<head>
<title>SC 스위트케어 | 간병인 회원 정보</title>
<%@ include file="/header-import.jsp"%>

</head>

<body>

<%@ include file="/header.jsp"%>

	<!-- One -->
	<section id="One" class="wrapper style3">
		<div class="inner">
			<header class="align-center">
				<p>Premium Caregiver Matching Platform</p>
				<h2>SuiteCare</h2>
			</header>
		</div>
	</section>

	<!-- Two -->
	<section id="two" class="wrapper style2">
		<div class="inner">
			<div class="box">
				<div class="content">
					<header class="align-center">
						<p>SC 스위트케어</p>
						<h2>간병인 회원 정보 조회</h2>
					</header>
					
					<form name="giverinfo" class="table-wrapper">
					<table>
					<thead>
							<tr>
									<td>No.</td> <td>아이디</td> <td>이름</td> <td>성별</td> <td>생년월일</td>
									<td>핸드폰번호</td> <td>이메일</td> <td>주소</td> <td>sms 수신동의</td> 
									<td>email 수신동의</td> <td>가입일</td> <td>비고</td>
								</tr>
							</thead>
							<%
							request.setCharacterEncoding("utf-8");

							CaregiverDAO dao = new CaregiverDAO();

							List<CaregiverVO> list = dao.giver_admin_info();
							for (int i = 0; i < list.size(); i++) {
								CaregiverVO listt = (CaregiverVO) list.get(i);
								
								g_id = listt.getG_id();
								String g_name = listt.getG_name();
								String g_gender = listt.getG_gender();
								String g_birth = listt.getG_birth();
								String g_phone = listt.getG_phone();
								String g_email = listt.getG_email();
								String g_address = listt.getG_address();	
								String g_sms_yn = listt.getG_sms_yn();
								String g_email_yn = listt.getG_email_yn();							

								Date signup_date = listt.getG_signup_date();
								
								String phone = g_phone.substring(0,3) + "-" + g_phone.substring(3,7) + "-" + g_phone.substring(7,11);
							%>
							<tr>
								<td><%=i + 1%></td>
								<td><%=g_id%></td>
								<td><%=g_name%></td>
								<td><%=g_gender%></td>
								<td><%=g_birth%></td>
								<td><%=g_phone%></td>
								<td><%=g_email%></td>
								<td><%=g_address%></td>
								<td><%=g_sms_yn%></td>
								<td><%=g_email_yn%></td>
								<td><%=signup_date%></td>
								<td><a onclick="javascript:openAdGinfo('<%=g_id%>')">더보기</a></td>
							</tr>
							<%
							}
							%>
						
						</table>
					
					</form>
				</div>
			</div>
		</div>
	</section>

<script>
function openAdGinfo(g_id){
	window.open("${context}/admin/admin_ginfo.jsp?g_id="+g_id, "name(about:blank)", "width=800, height=600");
}
</script>
	<%@include file="/footer.jsp"%>

</body>
</html>