<%@ page import="caregiver.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.Time"%>
<%@ page import="java.sql.Date"%>
<%@ page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<title>SC 스위트케어 | 간병인정보</title>
<%@ include file="/header-import.jsp"%>

<style>
.fc-col-header {
    margin: 0;
    padding: 0;
}
.fc-daygrid-day-number, .fc-col-header-cell-cushion {
text-decoration:none;
 cursor: default;
}
.fc-daygrid-day:hover{
font-weight: bold;
background-color: #DFD7BF50;
}
.fc-scroller{
overflow:hidden !important;
}
.fc .fc-button-primary{
background-color: transparent;
border: none;
outline: none;
}
.fc .fc-button-primary:hover{
background-color: #cccccc50;
}
.fc .fc-daygrid-day.fc-day-today{
background-color: #A4907Caa;
font-weight: bold;
}
.fc .fc-button-primary:not(:disabled):active, .fc .fc-button-primary:not(:disabled).fc-button-active{
background-color: #DFD7BFaa;
font-weight: bold;
}
.fc .fc-toolbar.fc-header-toolbar{
margin-left: 7.2rem;
}
.fc .fc-toolbar-title {
    font-size: 1.75em;
    margin: 0;
    display: inline;
    position: relative;
    top: 0.4rem;
}
</style>

</head>

<script>

</script>

<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales-all.js"></script>

<body>

	<!-- Two -->
	<section id="two" class="wrapper style2">
		<div class="inner">
			<div class="box">
				<div class="content">
					<header class="align-center">
						<p>상세정보</p>
						<h2></h2>
					</header>

					<form name="giverinfo">
							<%
							request.setCharacterEncoding("utf-8");
							g_id = request.getParameter("g_id");
							
							CaregiverDAO dao = new CaregiverDAO();

							List<CaregiverVO> list = dao.giverList(g_id);
							for (int i = 0; i < list.size(); i++) {
								CaregiverVO listt = (CaregiverVO) list.get(i);

								String address = listt.getG_address();
								String sms_yn = listt.getG_sms_yn();
								String email_yn = listt.getG_email_yn();
								String profile = listt.getG_profile();
								String service1 = listt.getG_service1();
								String service2 = listt.getG_service2();
								String service3 = listt.getG_service3();
								String qualification = listt.getG_qualification();
								String location1 = listt.getG_location1();
								String location2 = listt.getG_location2();
								String location3 = listt.getG_location3();
								String hourwage1 = listt.getG_hourwage1();
								String hourwage2 = listt.getG_hourwage2();
								String hourwage3 = listt.getG_hourwage3();
								Date signup_date = listt.getG_signup_date();
							%>
							
						<div class="form_wrapper">
							<div class="form_row">
								<label for="address">주소</label> 
								<input type="text" value="<%=address%>"  readonly>
							</div>

							<div class="form_row">
								<label for="sms_yn">sms 수신여부</label> <input type="text"
									value="<%=sms_yn%>" readonly>
							</div>

							<div class="form_row">
								<label for="email_yn">email 수신여부</label> <input type="text"
									value="<%=email_yn%>" readonly>
							</div>

							<div class="form_row">
								<label for="qualification">취득 자격증</label> <input type="text"
									value="<%=qualification%>" readonly>
							</div>
							
							<div class="form_row">
								<label for="service">대표 서비스</label> <input type="text"
									value="<%=service1%>, <%=service2%>, <%=service3%>" readonly>
							</div>
							
							<div class="form_row">
								<label for="location">활동 지역</label> <input type="text"
									value="<%=location1%>, <%=location2%>, <%=location3%>" readonly>
							</div>
							
							<div class="form_row">
								<label for="hourwage">희망 시급</label> <input type="text"
									value="<%=hourwage1%>, <%=hourwage2%>, <%=hourwage3%>" readonly>
							</div>
							
							<div class="form_row">
								<label for="signup_date">가입일</label> <input type="text"
									value="<%=signup_date%>" readonly>
							</div>
						</div>
						<%
						}
						%>
					</form>
				</div>
			</div>
		</div>
	</section>

</body>

</html>