<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false"
%>
<%@ taglib prefix = "fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
	<title>SC 스위트케어 | 일반 본문</title>
		<%@ include file="/header-import.jsp"%>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<link rel="stylesheet" href="../assets/css/main.css" />
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script src="/suiteCare/assets/js/execDaumPostcode.js"></script>
	<script>
		function signUpValidation() {
		  const id = $("#id").val().trim();
		  const name = $("#name").val().trim();
		  const pw = $("#pw").val();
	
		  // 중복 확인 검사
		  if (!$("#id").prop("disabled")) {
		    alert("아이디 중복확인이 필요합니다.");
		    $("#duplicateID").focus();
		    return false;
		  }
	
		  // 이름 검사
		  if (name.length < 2) {
		    alert("올바른 이름을 입력하십시오.");
		    $("#name").focus();
		    return false;
		  }
	
		  // 비밀번호 유효성 검사
		  if (pw.length < 4) {
		    alert("비밀번호는 4자리 이상이어야 합니다.");
		    $(".pw_check_notice").show();
		    $("#pw").focus();
		    return false;
		  }
	
		  // 비밀번호 확인 검사
		  if (!PWValidation()) {
		    alert("비밀번호 확인이 일치하지 않습니다.");
		    $(".pw_check_notice").show();
		    $("#pw").focus();
		    return false;
		  }
	
		  // 성별 검사
		  if ($("#gender").val() == "") {
		    alert("성별을 선택하십시오.");
		    $("#gender").focus();
		    return false;
		  }
		  
		  if($("#service_etc").prop("checked")) {
	   			var etc = "(기타)" + $("#ser_etc").val();
	   			$("#ser_etc").val(etc);
		  }
		  
		  document.getElementById("joinForm").submit();
		}
	
	function PWValidation(){
		//비밀번호 확인 검사
		let pw = $("#pw").val();
		let pwcheck = $("#pw_check").val();
		
		if (pw != pwcheck) {		
			$(".pw_check_notice").show();
			return false;
		} else {
			$(".pw_check_notice").hide();
			return true;
		}
	}
	
	function setID() {
		//ID 입력값을 정리하기 위함
		let id = $("#id").val();
		let g_id = $("#g_id").val();
		g_id = id.trim().toLowerCase();
		console.log(g_id);
	}
	
	function isDuplicateID() {
		//중복확인 함수
		let _id = $("#id").val();
		let g_id = "";
		let regExp = /^[a-z0-9_.]{4,}$/;
		
		if (!regExp.test(_id)){
		    alert("ID는 4자 이상의 영문, 숫자로 이루어진 문자여야 합니다.");
		    setTimeout(function () { $("#id").focus(); }, 100);
		} else {
			 $.ajax({
			        type: "get",
			        async: false,
			        url: "/suiteCare/join",
			        dataType: "json",
			        data: {id: _id, type: "isDuplicateID"},
			        success: function(data, textStatus) {
			        	console.log(data.isDuplicateID);
			            if (data.isDuplicateID == 0) {
			                alert("사용할 수 있는 ID입니다.");
			                g_id = _id.trim().toLowerCase();
			                $("#g_id").val(g_id);
			                $("#id").prop("disabled", true);
			                console.log(g_id);
			            } else if (data.isDuplicateID == 1) {
			                alert("사용할 수 없는 ID입니다.");
			        	    setTimeout(function () { $("#id").focus(); }, 100);
			            } else {
			            	console.log("count: -1 (error)");
			                alert("오류가 발생했습니다.");
			            }
			        },
			        error: function(data, textStatus) {
			        	console.log("data: "+ data +" / textStatus: "+textStatus);
			            alert("오류가 발생했습니다.");
			        },
			        complete: function(data, textStatus) {
			        }
			    });
		}
	}
	
	function setAddress() {
		//주소를 한 input으로 합치는 함수
	    let zipcode = document.getElementById("zipcode").value;
	    let jibunAddress = document.getElementById("jibunAddress").value;
	    let roadAddress = document.getElementById("roadAddress").value;
	    let namujiAddress = document.getElementById("namujiAddress").value;
	    
	    if (!roadAddress){
	    	document.joinForm.g_address.value = "(우)" + zipcode + "/" + jibunAddress + "/ /" + namujiAddress;
	    } else {
	    	document.joinForm.g_address.value = "(우)" + zipcode + "/ /" + roadAddress + "/" + namujiAddress;    	
	    }
	    
	    console.log(document.joinForm.g_address.value);
	}
	
	</script>
	
</head>

<body>
	<%@ include file="../header.jsp" %>
	<% String file_repo = "/suiteCare/src/main/webapp/assets/profile/"; %>

<!-- One -->
   <section id="One" class="wrapper style3">
      <div class="inner">
         <header class="align-center">
            <p>Eleifend vitae urna</p>
            <h2>Suite Care</h2>
         </header>
      </div>
   </section>

<!-- Two -->
   <section id="two" class="wrapper style2">
		<div class="inner">
			<div class="box">
				<div class="content">
					<header class="align-center">
						<h2>회원가입</h2>
					</header>
					<br><br>
					
				   <!-- form 시작 -->
					<form name="joinForm"  id="joinForm" method=post action=join enctype="multipart/form-data">
						<div class="form_wrapper">
							<div class="form_row">
								<input type="file" name="g_profile">
							</div>   
							
							<div class="form_row">
								<label for="id">아이디</label> <div class="form_row_sub">
								<input type="text" id="id" placeholder="아이디 (영문, 숫자 4~20자)" title="아이디 (영문, 숫자 4~20자)" maxlength="20" required>
								<input type="hidden" id="g_id" name="g_id">
								<span class="button default" onclick="javascript:isDuplicateID()">중복확인</span></div>
							</div>
										   
							<div class="form_row">
								<label for="pw">비밀번호</label> <input type="password" id="pw" name="g_pw" placeholder="비밀번호 (4자 이상)" title="비밀번호 (4자 이상)" oninput="javascript:PWValidation();" required>
							</div>
							<div class="form_row">
								<label for="pw">비밀번호 확인</label>
								<input type="password" id="pw_check" placeholder="비밀번호 확인 (비밀번호와 동일한 값)" title="바밀번호 확인 (비밀번호와 동일한 값)" oninput="javascript:PWValidation()" required>
								<span class="pw_check_notice"></span><span class="pw_check_notice" style="color: red; display: none;"><i class="fa-solid fa-circle-exclamation"></i> 비밀번호 확인이 일치하지 않습니다.</span>
							</div>
						
							<div class="form_row">
								<label for="name">이름</label>
								<input type="text" name="g_name" id="name" placeholder="이름">
							</div>
						
							<div class="form_row">
								<label for="gender">성별</label>
								<input type="radio" id="man" name="g_gender" value="M">
								<label for="man">남자</label>
								<input type="radio" id="woman" name="g_gender" value="W">
								<label for="woman">여자</label> <br><br>
							</div>
						         
							<div class="form_row">
								<label for="birth">생년월일</label>
								<input type="text" name="g_birth" placeholder="생년월일">
							</div>
							<div class="form_row">
								<label for="phone"> 휴대폰 </label>
								<input type="text" name="g_phone" placeholder="휴대폰" id="phone">
							</div>
							
							<div class="form_row">
								<label for="sms_yn">SMS 수신 여부</label>
								<div onclick="javascript:setSMSYN()">
                                   	<input type="checkbox" name="g_sms_yn" id="sms_switch" value = "Y">
                                   	<label for="sms_switch" id= "sms_switch_text"style="margin:0.3rem 0 0 0;"> SMS 소식을 수신합니다.</label>
								</div>
							</div>
							
							<div class="form_row">
								<label for="email"> 이메일 </label>
								<input type="text" name="g_email" placeholder="이메일" id="email">
								
							</div>
							<div class="form_row">
							<label for="email_yn">이메일 수신 여부</label>
								<div onclick="javascript:setEmailYN()">
								<input type="checkbox" name="g_email_yn" id="email_switch" value="Y">
								<label for="email_switch" id="email_switch_text" style="margin:0.3rem 0 0 0;"> 메일로 소식을 수신합니다.</label>
								</div>
							</div>
							
							<div class="form_row">
							    <label>주소</label>
								<span class="button default" onClick="javascript:execDaumPostcode()">주소검색</span>
								<label class="addr-label">우편번호</label><input type="text" id="zipcode" pattern="[0-9]{5}" placeholder="우편번호 (숫자 5자리)" title="우편번호 (숫자 5자리)" maxlength="5" onInput="javascript:setAddress()" required>
								<label class="addr-label">지번 주소</label><input type="text" id="jibunAddress" placeholder="지번 주소" title="지번 주소" onInput="javascript:setAddress()" required>
								<label class="addr-label">도로명 주소</label><input type="text" id="roadAddress" placeholder="도로명 주소" title="도로명 주소" onInput="javascript:setAddress()" required>
								<label class="addr-label">나머지 주소</label><input type="text" id="namujiAddress" placeholder="나머지 주소" title="나머지 주소" onInput="javascript:setAddress()" required>
								<input type="hidden" id="address" name="g_address" value="">
							</div>
							
							<div class="form_row">
								<label for="service">서비스</label>
								<div>
                                    <input type="checkbox" name="service" id="service" value = "욕창">
                                    <label for="service" style="margin:0.3rem 0 0 0;">욕창</label>
								</div>
								<div>
                                    <input type="checkbox" name="service" id="service2" value = "뇌병변">
                                    <label for="service2" style="margin:0.3rem 0 0 0;">뇌병변</label>
								</div>
								<div>
                                    <input type="checkbox" name="service" id="service3" value = "외상환자">
                                    <label for="service3" style="margin:0.3rem 0 0 0;">외상환자</label>
								</div>
								<div>
                                    <input type="checkbox" id="service_etc" class="act" value = "etc">
                                    <label for="service_etc" style="margin:0.3rem 0 0 0;">기타</label>
                                    <input type="text" name="service" id="ser_etc" disabled />
								</div>
							</div>
						        
							<div class="form_row" id="qualDiv">
								<div class="col">
									<label for="qual" class="qualification">자격증 </label>
								</div>
								<div>
									<div>
										<input type="text" placeholder="자격증" name="qual" class="qtext">
										<span id="delete">삭제</span>
									</div>
									<input type="button" value="추가" id="add">
								</div>
							</div>
						
							<div class="form_row">
								<label for="location">선호지역</label>
								<select name="g_location"  id="sel">
									<c:set var="g_loc" value="${info.g_location}"/>
									<option value = "1">선택</option>
									<c:forEach var="loc" items="${location }">
										<option value="${loc.sido_code }">${loc.sido }</option>
									</c:forEach>
								</select>
							</div> 
						</div>
					
						<div style="text-align: center;" class="form_btn">
							<input type="hidden" name="command" value="signup">
							<button type="submit" class="button special" id="join" onclick="signUpValidation();">회원가입</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>

	<%@ include file="../footer.jsp"%>
</body>
</html>

<script>
   $(document).on('click', '#add' , function() {
      $("#add").before("<div><input type='text' name='qual' class='qtext'><span id='delete'>삭제</span></div>");

      var qualCnt = 0;
      $("#qualDiv > .qtext").each(function(){
         qualCnt++;
        });
   
      $(".qualification").attr("rowspan", qualCnt);
   });

   $(document).on('click', '#delete' , function() {
	   $(this).parent().remove();
	   $(this).prev().remove();
	   $(this).next().remove();
	   $(this).remove();
   });
   
	$(function(){
		$("#service_etc").change(function(){
			if($("#service_etc").prop("checked")){
				$("#ser_etc").attr("disabled", false);
			}else{
				$("#ser_etc").attr("disabled", true);
			}
		});
	});
</script>