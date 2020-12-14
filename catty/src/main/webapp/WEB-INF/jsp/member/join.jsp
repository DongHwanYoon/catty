<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>

<body>
	<%@ include file="/WEB-INF/jsp/etc/top.jsp"%>

	<section class="main-content">
		<div class="container">
			<div class="col-md-3 .col-md-offset-3"></div>
			<div class="col-md-6 .col-md-offset-3">
				<div class="login-wrap">
					<div class="login-body">
						<h3 class="login-title">회원가입</h3>
						<form class="login-form" method="POST"
							action="${pageContext.request.contextPath}/member/join">
							<div class="login-form-fields">
								<div class="row">
									<div class="form-group">
										<input type="text" id="id" name="id" placeholder="아이디" maxlength="30" required>
										<div class="check_font" id="id_check"></div>
									</div>
									<div class="form-group">
										<input type="password" id="pwd" name="pwd" placeholder="비밀번호" maxlength="30" required>
										<div class="check_font" id="pwd_check"></div>
									</div>
									<div class="form-group">
										<input type="password" id="pwd2" name="pwd2" placeholder="비밀번호 재입력" maxlength="30" required>
										<div class="check_font" id="pwd2_check"></div>
									</div>
									<div class="form-group">
										<input type="text" id="name" name="name" placeholder="이름" maxlength="30" required> 
										<div class="check_font" id="name_check"></div>
									</div>
									<div class="form-group">
										<input type="text"
											name="phoneNo" id="phoneNo" placeholder="전화번호" maxlength="13" required
											oninput="this.value = this.value.replace(/[^0-9.]/g, '')
																			.replace(/(\..*)\./g, '$1');">
											<div class="check_font" id="phone_check"></div>
									</div>
									<input type="hidden" id="authority" name="authority" value="M">
									<input type="submit" value="가입">
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>

	<%@ include file="/WEB-INF/jsp/etc/footer.jsp"%>
</body>

<script>
	$(document).on("keyup", ".phoneN0", function() { $(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") ); });


	//공백체크 정규식
	var empJ = /\s/g;
	//아이디 정규식
	var idJ = /^[a-z0-9]{4,12}$/;
	// 비밀번호 정규식
	var pwJ = /^[A-Za-z0-9]{4,12}$/; 
	// 이름 정규식
	var nameJ = /^[가-힣]{2,6}$/;
	// 휴대폰 번호 정규식
	var phoneJ = /^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$/;
	
	// 아이디 유효성 검사(1 = 중복 / 0 != 중복)
	$("#id").blur(function() {
		// id = "id_reg" / name = "userId"
		var id = $('#id').val();
		$.ajax({
			url : '${pageContext.request.contextPath}/common/idCheck?id='+ id,
			type : 'GET',
			success : function(data) {
				console.log("true = 중복o / false = 중복x : "+ data);							
				
				if (data == true) {
						// 1 : 아이디가 중복되는 문구
						$("#id_check").text("이미 사용 중인 아이디입니다");
						$("#id_check").css("color", "red");
						$("#reg_submit").attr("disabled", true);
					} else {
						
						if(idJ.test(id)){
							// 0 : 아이디 길이 / 문자열 검사
							$("#id_check").text("");
							$("#reg_submit").attr("disabled", false);
				
						} else if(id == ""){
							$('#id_check').text('아이디를 입력해주세요');
							$('#id_check').css('color', 'red');
							$("#reg_submit").attr("disabled", true);				
							
						} else {
							$('#id_check').text("아이디는 소문자와 숫자 4~12자리만 가능합니다");
							$('#id_check').css('color', 'red');
							$("#reg_submit").attr("disabled", true);
						}
					}
				}, error : function() {
						console.log("실패");
				}
			});
		});
	
	// 이름 검증
	$("#name").blur(function() {
		if (nameJ.test($(this).val())) {
				console.log(nameJ.test($(this).val()));
				$("#name_check").text('');
		} else {
			$('#name_check').text('이름을 확인해주세요');
			$('#name_check').css('color', 'red');
		}
	});
	
	// 비밀번호 검증
	$("#pwd").blur(function() {
		if (pwJ.test($(this).val())) {
				console.log(pwJ.test($(this).val()));
				$("#pwd_check").text('');
		} else {
			$('#pwd_check').text('비밀번호를 확인해주세요');
			$('#pwd_check').css('color', 'red');
		}
	});
	
	// 비밀번호 일치 여부 검증
	$("#pwd2").blur(function() {
		if ($('#pwd').val() != $(this).val()) {
			$('#pwd2_check').text('비밀번호가 일치하지 않습니다');
			$('#pwd2_check').css('color', 'red');
		} else {
			$("#pwd2_check").text('');
		}
	});
	
	// 휴대전화 검증
	$('#phoneNo').blur(function(){
		if(phoneJ.test($(this).val())){
			console.log(phoneJ.test($(this).val()));
			$("#phone_check").text('');
		} else {
			$('#phone_check').text('휴대폰 번호를 확인해주세요');
			$('#phone_check').css('color', 'red');
		}
	});
	
	//알림창
	$(function(){
        var responseMessage = "<c:out value="${message}" />";
        if(responseMessage == "notRegistered"){
        	alert("회원가입 실패")
        }
    }) 
	
 // 자동 하이픈 삽입
	$(function(){
		var phoneNo = document.getElemebtById('phoneNo');
        if(responseMessage == "notRegistered"){
        	alert("회원가입 실패")
        }
    }) 
</script>
</html>