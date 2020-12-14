<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 상세</title>
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
								<button class="member-btn" type="button" onclick="location.href='${pageContext.request.contextPath}/member/${no}/form'">정보 수정</button>
							</div>
						</div>
						<div class="col-md-7">
							<div class="member-body-right">
								<input type="text" id="id" name="id" value="${member.member.id}" placeholder="아이디" readonly>
								<input type="text" id="name" name="name" value="${member.member.name}" placeholder="이름" readonly>
								<input type="text" id="authority" name="authority" placeholder="권한" readonly>
								<input type="text" id="phoneNo" name="phoneNo" value="${member.member.phoneNo}" placeholder="전화번호" readonly>
								<input type="text" id="facilityNames" name="name" placeholder="담당 시설물" readonly>
								
								<form action="${pageContext.request.contextPath}/member/${member.member.no}" method="POST" >
										<button class="member-btn" type="button" onclick="location.href='${pageContext.request.contextPath}/obslog'">관찰일지</button>
										<button class="member-btn" type="button" onclick="location.href='${pageContext.request.contextPath}/inslog'">점검일지</button>
										<input type="hidden" name="_method" value="DELETE" />
										<c:choose>
											<c:when test="${sessionScope.isAdmin eq true && member.member.authority eq 'M'}">
												<button class="member-btn" id="button_delete" type="submit" >회원삭제</button>
											</c:when>
											<c:when test="${member.member.id eq sessionScope.id && member.member.authority eq 'M'}">
												<button class="member-btn" id="button_delete" type="submit" >회원탈퇴</button>
											</c:when>
										</c:choose>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
	</section>
	
	<%@ include file="/WEB-INF/jsp/etc/footer.jsp"%>
</body>

<script>
	var authority = '';
	var facilityNames = "<c:out value = "${member.facilityNames}" />";
	var names = '';

	$(function(){
	    if ('${member.member.authority}' == 'A') {
	    	authority = '관리자';
	    } else {
	    	authority = '회원';
	    }
	}) 
	
	$(function(){
		if (facilityNames.length > 0) {
			console.log(facilityNames);
			for (var i = 0; i < facilityNames.length; i++) {
				var name = facilityNames[i];
	   			names = names + name;
	   			console.log(names);
	   		}
		} else {
			names = '담당 시설물 없음';
		}
	}) 
	
	$(document).ready(function() {
	    $('#authority').val(authority);
	    $('#facilityNames').val(names);
	});
	
</script>
</html>