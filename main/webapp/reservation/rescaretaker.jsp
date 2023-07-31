<%@ page import="reservation.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>SC 스위트케어 | 간병 예약</title>
<%@ include file="/header-import.jsp"%>
<script>
function checkForm() {
	var selectname=document.getElementById("tname").value;
	if(selectname=="") {
		alert("피간병인 이름을 선택해주세요.");
		return false;
	}
	return true;	
}

function inserttinfo() {
	window.location.href = "../careTaker/takerInfo.jsp";
}
</script>
</head>

<body>
	<%
	request.setCharacterEncoding("utf-8");
	%>
	<%
	String m_id = (String) session.getAttribute("m_id");
	ReservationDAO dao = new ReservationDAO();

	int ok = dao.tinfocheck(m_id);

	CaretakerinfoVO vo = new CaretakerinfoVO();

	if (ok == 0) {
		System.out.println("정보없음");
	%>
	<script>
	alert("등록된 회원정보가 없습니다.");
	location.href='<%=request.getContextPath()%>
		/caretaker/takerinfo.jsp';
	</script>

	<%
	} else if (ok == 1) {
	System.out.println("정보있음");
	%>

<body>
	<%@ include file="/header.jsp"%>

	<!-- One -->
	<section id="One" class="wrapper style3">
		<div class="inner">
			<header class="align-center">
				<p>Eleifend vitae urna</p>
				<h2>SC SuiteCare</h2>
			</header>
		</div>
	</section>

	<!-- Two -->
	<section id="two" class="wrapper style2">
		<div class="inner">
			<div class="box">
				<div class="content">
					<header class="align-center">
						<p>maecenas sapien feugiat ex purus</p>
						<h2>피간병인 정보 선택</h2>
					</header>
					<div class="form_wrapper">
						<form action="./rescaretaker_info.jsp" name="cnameform"
							onSubmit="return checkForm();">
							<div class="form_row">
								<label>피간병인 이름</label> <select name="tname" id="tname">
									<option value="">==선택==</option>
									<%
									List<CaretakerinfoVO> list = dao.listtname(m_id);
									for (int i = 0; i < list.size(); i++) {
										CaretakerinfoVO listvo = (CaretakerinfoVO) list.get(i);

										String t_name = listvo.getT_name();
									%>
									<option value=<%=t_name%>><%=t_name%></option>

									<%
									}
									}
									%>
								</select>

							</div>
							<div class="form_button">
								<span class="button" onclick="inserttinfo();">다른 피간병인 정보
									등록하기</span> <input type="submit" class="button special" value="선택">
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>
</body>
</html>