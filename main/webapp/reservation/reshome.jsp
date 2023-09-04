<%@ page import = "reservation.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>SC 스위트케어 | 간병 예약</title>
<%@ include file="/header-import.jsp"%>

<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="/suiteCare/assets/js/execDaumPostcode.js"></script>
<script src="${context}/assets/js/progress.js"></script>                                                                                              
<script>

function homecheck() {
	var f = document.homeForm;
	 let roadAddress = document.getElementById("roadAddress").value;
	 let namujiAddress = document.getElementById("namujiAddress").value;
	 if (!roadAddress) {
         alert("주소를 입력해 주세요.");
         $("#roadAddress").focus();
     } else if (!namujiAddress) {
         alert("나머지 주소를 입력해 주세요.");
         $("#namujiAddress").focus();
     } else {
 	return true;}
 }
}

function onAddressSearchCompleted() {
    var roadAddressInput = document.getElementById("roadAddress");
    var jibunAddressInput = document.getElementById("jibunAddress");

    if (roadAddressInput.value === "") {
        if (jibunAddressInput.value !== "") {
            roadAddressInput.value = jibunAddressInput.value;
        } else {
            // 둘 다 값이 없을 경우 빈칸으로 처리
            roadAddressInput.value = "";
        }
    }
}

function reshstop() {
	alert("예약이 중지되었습니다.");
	window.location.href = "${context}/member/main";
}


</script>

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
						<h2>자택 주소 입력</h2>
					</header>

					<div class="form_wrapper">
<form action="/suiteCare/reservation/home" method = "post" name="homeForm"
							onSubmit="return homecheck();">
							<input type="hidden" name="type" value="reshome_addr"/>
			<div class="form_row">
				<label>주소</label>
				<span class="button default" onClick="javascript:execDaumPostcode()">주소검색</span>
				<span></span>
				<input type="hidden" id="zipcode" name="zipcode" pattern="[0-9]{5}" placeholder="우편번호 (숫자 5자리)" title="우편번호 (숫자 5자리)" maxlength="5">
				<input type="hidden" id="jibunAddress" name="jibunAddress" placeholder="지번 주소" title="지번 주소" required>
				<input type="text" id="roadAddress" name="roadAddress" placeholder="도로명 주소" title="도로명 주소" required><br>
				<input type=text id="namujiAddress" name="namujiAddress" placeholder="나머지 주소" title="나머지 주소" required>
			</div>
			<div class="form_button_three">
		 <input type="button" class="button alt" onclick="reshstop();" value="예약 중지">
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
<script>
function execDaumPostcode() {
	  new daum.Postcode({
	    oncomplete: function(data) {
	      // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	      
	      // 우편번호와 주소 정보를 초기화한다.
	      document.getElementById('zipcode').value = "";
	      document.getElementById('roadAddress').value = "";
	      document.getElementById('jibunAddress').value = "";
	      
	      // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
	      // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기한다.
	      var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
	      var extraRoadAddr = ''; // 도로명 조합형 주소 변수

	      // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	      // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	      if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	        extraRoadAddr += data.bname;
	      }
	      // 건물명이 있고, 공동주택일 경우 추가한다.
	      if(data.buildingName !== '' && data.apartment === 'Y'){
	        extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	      }
	      // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	      if(extraRoadAddr !== ''){
	        extraRoadAddr = ' (' + extraRoadAddr + ')';
	      }
	      // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
	      if(fullRoadAddr !== ''){
	        fullRoadAddr += extraRoadAddr;
	      }

	      // 우편번호와 주소 정보를 해당 필드에 넣는다.
	      document.getElementById('zipcode').value = data.zonecode; //5자리 새 우편번호 사용
	      document.getElementById('roadAddress').value = fullRoadAddr;
	      document.getElementById('jibunAddress').value = data.jibunAddress;
	      
	    }
	  }).open();
	}
</script>
</html>