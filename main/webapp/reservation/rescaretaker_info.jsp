<%@ page import = "reservation.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>
<title>SC 스위트케어 | 간병 예약</title>
<%@ include file="/header-import.jsp"%>

<script>

function reservation() {
	//console.log('확인');
	var f = document.detailtinfoForm;
	var consciousness = document.detailtinfoForm.consciousness.value;
	var meal = document.detailtinfoForm.care_meal_yn.value;
	var toilet = document.detailtinfoForm.care_toilet.value;
	var paralysis = document.detailtinfoForm.state_paralysis.value;
	var mobility = document.detailtinfoForm.state_mobility.value;
	var bedsore = document.detailtinfoForm.bedsore_yn.value;
	var suction = document.detailtinfoForm.suction_yn.value;
	var outpatient = document.detailtinfoForm.outpatient_yn.value;
	var night = document.detailtinfoForm.care_night_yn.value;
	
	if(!consciousness || !meal || !toilet || !paralysis || !mobility || !bedsore || !suction || !outpatient || !night) {
		alert("모든 항목을 입력해주세요");
		return false;
	} else {
		f.action = "res_insert.jsp";
		f.submit();
		return true;
	}
	}

function recheck() {
	var f = document.tinfoform;
	f.action = "rescaretaker.jsp";
	f.submit();
}

function update() {
	var f = document.tinfoform;
	f.action = "../member/mypage.jsp";
	f.submit();
}

function callres() {
	var f = document.detailtinfoForm;
	f.action = "rescaretaker_call.jsp";
	f.submit();
}

function opChange() {
	var outop=document.detailtinfoForm.outpatient_option;
	var outyn=document.detailtinfoForm.outpatient_yn;
	
	if(outop.options[outop.selectedIndex].value=='9') {
		outyn.disabled=false;
		outyn.value="";
		outyn.focus();
	}	else {
		outyn.disabled=false;
		outyn.value=outop.options[outop.selectedIndex].value;
	}
}

</script>
</head>
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
<%
request.setCharacterEncoding("utf-8");
String m_id = (String)session.getAttribute("m_id");
ReservationDAO dao = new ReservationDAO();
String tname = request.getParameter("tname");

List<CaretakerinfoVO> list = dao.listtinfo(m_id, tname);
for(int i=0; i<list.size(); i++) {
	CaretakerinfoVO listvo = (CaretakerinfoVO) list.get(i);
	
	String t_name = listvo.getT_name();
	String t_code = listvo.getT_code();
	int t_age = listvo.getT_age();
	int t_height = listvo.getT_height();
	int t_weight = listvo.getT_weight();
	String t_gender = listvo.getT_gender();
	String diagnosis = listvo.getDiagnosis();
	
	session.setAttribute("t_name", t_name);
	session.setAttribute("caretaker_code", t_code);
%>


	<!-- Two -->
	<section id="two" class="wrapper style2">
		<div class="inner">
			<div class="box">
				<div class="content">
					<header class="align-center">
						<p>maecenas sapien feugiat ex purus</p>
						<h2><%=tname %>님의 기본 정보</h2>
					</header>

					<div class="form_wrapper">
<form name="tinfoform">
<table border=1>
<tr><td> 피간병인 코드 </td><td><%=t_code %></td></tr>
<tr><td> 피간병인 이름 </td><td><%=t_name %></td></tr>
<tr><td> 나이 </td><td><%=t_age %>세</td></tr>
<tr><td> 키 </td><td><%=t_height %>cm</td></tr>
<tr><td> 몸무게 </td><td><%=t_weight %>kg</td></tr>
<tr><td> 성별 </td><td><%=t_gender %></td></tr>
<tr><td> 진단명 </td><td><%=diagnosis %></td></tr>
</table>
<button type="button" onclick="recheck();">다시선택</button>
<button type="button" onclick="update();">기본정보수정</button>
</form>

<h3> <%=tname %>님의 상세정보를 입력해주세요</h3>
<form name="detailtinfoForm" method="post">
<table border=1>
<tr> <td>Q1. 의식상태는 어떠신가요? </td></tr>
<tr><td><input type="radio" id="con_y" name="consciousness" value="의식 있음">
		<label for="con_y">의식 있음</label>
	<input type="radio" id="difficult_com" name="consciousness" value="의식은 있으나 의사소통 어려움">
		<label for="difficult_com">의식은 있으나 의사소통 어려움</label>
	<input type="radio" id="con_n" name="consciousness" value="의식 없음">
		<label for="con_n">의식 없음</label></td></tr>
<tr> <td>Q2. 식사를 어떻게 하고 계산가요?</td> </tr>
<tr><td><input type="radio" id="meal_self" name="care_meal_yn" value="스스로 식사 가능">
		<label for="meal_self">스스로 식사 가능</label>
	<input type="radio" id="meal_assistance" name="care_meal_yn" value="식사 보조 필요함">
		<label for="meal_assistance">식사 보조 필요함</label>
	<input type="radio" id="Feeding" name="care_meal_yn" value="경관영양(피딩)">
		<label for="Feeding">경관영양(피딩)</label>
	<input type="radio" id="injection" name="care_meal_yn" value="주사를 통한 정맥영양">
		<label for="injection">주사를 통한 정맥영양</label></td></tr>
<tr> <td>Q3. 대소변 해결은 어떻게 하시나요? </td></tr>
<tr> <td><input type="radio" id="toilet_self" name="care_toilet" value="스스로 화장실 이용">
		<label for="toilet_self">스스로 화장실 이용</label>
	<input type="radio" id="toilet_assistance" name="care_toilet" value="동행하여 화장실 이용">
		<label for="toilet_assistance">동행하여 화장실 이용</label>
	<input type="radio" id="diapers" name="care_toilet" value="기저귀">
		<label for="diapers">기저귀</label>
	<input type="radio" id="foley_catheter" name="care_toilet" value="소변줄">
		<label for="foley_catheter">소변줄</label>
	<input type="radio" id="stoma" name="care_toilet" value="장루/요루">
		<label for="stoma">장루/요루</label></td></tr>
<tr> <td>Q4. 마비가 있는 상태신가요?</td></tr>
<tr> <td><input type="radio" id="general" name="state_paralysis" value="전신마비">
		<label for="general">전신마비</label>
	<input type="radio" id="hemiplegia" name="state_paralysis" value="편마비">
		<label for="hemiplegia">편마비</label>
	<input type="radio" id="ps_n" name="state_paralysis" value="없음">
		<label for="ps_n">없음</label></td></tr>
<tr> <td> Q5. 거동 및 운동 상태는 어떠신가요? </td></tr>
<tr> <td><input type="radio" id="mobility_self" name="state_mobility" value="스스로 걸을 수 있음">
		<label for="mobility_self">스스로 걸을 수 있음</label>
	<input type="radio" id="cw_assistance" name="state_mobility" value="지팡이 혹은 휠체어 보조 필요">
		<label for="cw_assistance">지팡이 혹은 휠체어 보조 필요</label>
	<input type="radio" id="only_bed" name="state_mobility" value="침대에서만 움직임이 가능">
		<label for="only_bed">침대에서만 움직임이 가능</label>
	<input type="radio" id="mobility_n" name="state_mobility" value="움직일 수 없음">
		<label for="mobility_n">움직일 수 없음</label></td></tr>
<tr> <td> Q6. 욕창이 있으신가요?</td></tr>
<tr> <td><input type="radio" id="b_yes" name="bedsore_yn" value="있음">
		<label for="b_yes">있음</label>
	<input type="radio" id="b_no" name="bedsore_yn" value="없음">
		<label for="b_no">없음</label></td></tr>
<tr> <td> Q7. 석션이 필요하신가요? </td></tr>
<tr> <td><input type="radio" id="s_yes" name="suction_yn" value="예">
		<label for="s_yes">예</label>
	<input type="radio" id="s_no" name="suction_yn" value="아니오">
		<label for="s_no">아니오</label></td></tr>
<tr> <td> Q8. 주기적인 외부치료가 있으신가요? </td></tr>
<tr> <td><input type="text" name="outpatient_yn" id="outpatient_yn" disabled>
		<select id="outpatient_option" name="outpatient_option" onchange="opChange()">
			<option value="">==선택==</option>
			<option value="없음">없음</option>
			<option value="9">직접 입력(예:투석, 재활 등)</option>
		</select></td></tr>
<tr> <td> Q9. 환자분에게 야간 돌봄이 필요하신가요? </td></tr>
<tr> <td><input type="radio" id="caren_yes" name="care_night_yn" value="예">
		<label for="caren_yes">예</label>
	<input type="radio" id="caren_no" name="care_night_yn" value="아니오">
		<label for="caren_no">아니오</label></td></tr>
<tr> <td> Q10. 간병할 때 유의사항을 입력해 주세요 </td></tr>
<tr> <td>
<div id="notice_cnt">(0 / 100)</div>
<textarea id="notice" name="notice" cols="100" rows="3"></textarea>
    
    </td></tr>
</table>
<button type="button" onclick="callres();">불러오기</button>
<button type="button" onclick="reservation();">예약하기</button>
</form>

<%
}
%>

					</div>
				</div>
			</div>
		</div>
	</section>
	
	<%@ include file="/footer.jsp"%>

</body>
<script>
 
    $(document).ready(function() {
        $('#notice').on('keyup', function() {
            $('#notice_cnt').html("("+$(this).val().length+" / 100)");
 
            if($(this).val().length > 100) {
                $(this).val($(this).val().substring(0, 100));
                $('#notice_cnt').html("(100 / 100)");
            }
        });
    });
        
    </script>
</html>