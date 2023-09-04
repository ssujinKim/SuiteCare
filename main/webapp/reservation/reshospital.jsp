<%@ page import = "reservation.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SC 스위트케어 | 간병 예약</title>
<%@ include file="/header-import.jsp"%>
<script src="${context}/assets/js/progress.js"></script>                                                                                              
<script>


function hospcheck() {
	var f = document.hospForm;
	var hospname = document.hospForm.hospname.value;
	var hospaddr = document.hospForm.hospaddr.value;
	var hospdetail_addr = document.hospForm.hospdetail_addr.value;
	
	if(hospname=="") {
		alert("병원명을 입력해 주세요");
		return false;
	} else if(hospaddr=="") {
		alert("주소를 입력해 주세요.");
		return false;
	} else if(hospdetail_addr=="") {
		alert("나머지 주소를 입력해 주세요.");
		return false;
	} else {
	return true;
	}
	
}


function searchhosp() {
	var popupUrl = "../hospital/search";
    var popupOptions = 'width=800,height=600,scrollbars=yes,resizable=yes';

    var mapPopup = window.open(popupUrl, 'mapPopup', popupOptions);
   
}
function setHospitalInfo(hospname, hospaddr) {
    document.getElementById('hospname').value = hospname;
    document.getElementById('hospaddr').value = hospaddr;
}


function reshostop() {
	alert("예약이 중지되었습니다.");
	window.location.href = "${context}/member/main";
}
</script>

</head>

<body>
	<%@ include file="/header.jsp"%>

<% 
request.setCharacterEncoding("utf-8");
String caretaker_code = (String)session.getAttribute("caretaker_code");
String res_code = (String)session.getAttribute("res_code");
String r_code = (String)session.getAttribute("r_code");
%>
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
	
	<div id="res-progress">
	<ul>
	<li>피간병인 선택</li>
	<li>피간병인 정보 입력</li>
	<li class="active">간병장소 선택</li>
	<li>예약 일시 지정</li>
	<li>빠른매칭 서비스</li>
	</ul>
	</div>
	
		<div class="inner">
			<div class="box">
				<div class="content">
					<header class="align-center">
						<p>maecenas sapien feugiat ex purus</p>
						<h2>병원 주소 입력</h2>
					</header>

					<div class="form_wrapper">
<form action="/suiteCare/reservation/hospital" method = "post" name="hospForm"
							onSubmit="return hospcheck();">
							<input type="hidden" name="type" value="reshosp_addr"/>
			<div class="form_row">
				<label>병원명</label>
				<div class="form_row_sub">
					<input type="text" name="hospname" id="hospname" placeholder="병원명">
					<input type="button" onclick="searchhosp()" value="병원 찾기">
				</div>
			</div>

			<div class="form_row">
			    <label>병원 주소</label><span></span>
				<label class="addr-label">도로명 주소</label><input type="text" id="hospaddr" name="hospaddr" placeholder="도로명 주소" title="도로명 주소" >
				<label class="addr-label">상세호수</label><input type="text" id="hospdetail_addr" name="hospdetail_addr" placeholder="상세호수" title="나머지 주소" >
			</div>
			 <input type="hidden" name="type" id="type" value=""/>
			<div class="form_button_three">
		  <input type="button" class="button alt" onclick="reshostop();" value="예약 중지">
		 <div>

		 <span class="button alt" onclick="location.href='${context}/reservation/location'">뒤로가기</span>
		 <input type="submit" class="button special" value="확인">
		 </div>
			</div>
			
</form>
					</div>

				</div>
			</div>
		</div>
	</section>

	<%@ include file="/footer.jsp"%>


</body>
</html>