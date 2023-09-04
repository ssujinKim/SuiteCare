<%@ page import="member.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.Time"%>
<%@ page import="java.sql.Date"%>
<%@ page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<title>SC 스위트케어 | 회원정보</title>
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
						<h2>회원 정보 조회</h2>
					</header>

					<form name="memberinfo"  class="table-wrapper">
						<table>
							<thead>
								<tr>
									<td>No.</td> <td>아이디</td> <td>이름</td> <td>성별</td>
									<td>핸드폰번호</td> <td>이메일</td> <td>주소</td> <td>sms 수신동의</td> 
									<td>email 수신동의</td> <td>가입일</td> <td>등록한 피간병인</td>
								</tr>
							</thead>
							<%
							request.setCharacterEncoding("utf-8");

							MemberDAO dao = new MemberDAO();

							List<MemberVO> list = dao.listMembers();
							for (int i = 0; i < list.size(); i++) {
								MemberVO listt = (MemberVO) list.get(i);

								m_id = listt.getM_id();
								String m_name = listt.getM_name();
								String m_gender = listt.getM_gender();
								String m_phone = listt.getM_phone();
								String m_email = listt.getM_email();
								String m_address = listt.getM_address();	
								String m_sms_yn = listt.getM_sms_yn();
								String m_email_yn = listt.getM_email_yn();
								
								Date m_signup_date = listt.getM_signup_date();
								
								String phone = m_phone.substring(0,3) + "-" + m_phone.substring(3,7) + "-" + m_phone.substring(7,11);
							%>
							<tr>
								<td><%=i + 1%></td>
								<td><%=m_id%></td>
								<td><%=m_name%></td>
								<td><%=m_gender%></td>
								<td><%=phone%></td>
								<td><%=m_email%></td>
								<td><%=m_address%></td>
								<td><%=m_sms_yn%></td>
								<td><%=m_email_yn%></td>
								<td><%=m_signup_date%></td>
								<td><a onclick="javascript:openAdTinfo('<%=m_id%>')">더보기</a></td>
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
function openAdTinfo(m_id){
	window.open("${context}/admin/admin_tinfo.jsp?m_id="+m_id, "name(about:blank)", "width=800, height=600");
}
</script>

	<%@include file="/footer.jsp"%>
</body>
</html>