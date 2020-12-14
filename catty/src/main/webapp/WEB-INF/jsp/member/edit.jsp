<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정보 수정</title>
</head>

<body>
	<%@ include file="/WEB-INF/jsp/etc/top.jsp"%>

	<section class="main-content">
		<div class="container">


			<div class="row">
				<div class="col-md-3"></div>
				<div class="col-md-6">
					<div class="member-wrap">
							<h3 class="member-title">프로필</h3>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-3"></div>
				<div class="col-md-6">
					<div class="member-wrap">
						<div class="col-md-1"></div>
						<div class="col-md-3">
							<div class="member-body-left">
								<p>아이디</p>
								<p>이름</p>
								<p>권한</p>
								<p>전화번호</p>
								<p>담당 시설물</p>
								<input class="member-btn" type="submit" value="수정">
							</div>
						</div>
						<div class="col-md-6">
							<div class="member-body-right">
								<input type="text" id="id" name="id" value="${member.member.id}" placeholder="아이디" readonly>
								<input type="text" id="name" name="name" value="${member.member.name}" placeholder="이름" readonly>
								<input type="text" id="authority" name="authority" placeholder="권한" readonly>
								<input type="text" id="phoneNo" name="phoneNo" value="${member.member.phoneNo}" placeholder="전화번호" oninput="this.value = this.value.replace(/[^0-9.]/g, '')
																			.replace(/(\..*)\./g, '$1');">
								<div class="check_font" id="phone_check"></div>
								<input type="text" id="index" name="name" placeholder="담당 시설물" readonly>
							</div>
						</div>
					</div>
				</div>
			</div>
	</section>

	<%@ include file="/WEB-INF/jsp/etc/footer.jsp"%>
</body>

<script>
	var authority;
	
	if ('${member.member.authority}' == 'A') {
		authority = '관리자';
	} else {
		authority = '회원';
	}
	
	$(document).ready(function() {
	    $('#authority').val(authority);
	});
	
	// 휴대폰 번호 정규식
	var phoneJ = /^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$/;
	
	// 휴대전화 검증
	$('#phoneNo').blur(function(){
		if(phoneJ.test($(this).val())){
			console.log(phoneJ.test($(this).val()));
			$("#phone_check").text('');
		} else {
			$('#phone_check').val('휴대폰 번호를 확인해주세요');
			$('#phone_check').css('color', 'red');
		}
	});
</script>
</html>