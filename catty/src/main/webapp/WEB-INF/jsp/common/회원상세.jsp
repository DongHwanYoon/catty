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
								<button class="member-btn" type="button" onclick="location.href='${pageContext.request.contextPath}/member/${no}/form'">수정</button>
							</div>
						</div>
						<div class="col-md-6">
							<div class="member-body-right">
								<input type="text" id="id" name="id" value="${member.id}" placeholder="아이디">
								<input type="text" id="name" name="name" value="${member.name}" placeholder="이름">
								<input type="text" id="authority" name="authority" value="${member.authority}" placeholder="권한">
								<input type="text" id="phoneNo" name="phoneNo" value="${member.phoneNo}" placeholder="전화번호">
								<input type="text" id="index" name="name" placeholder="담당 시설물">
								<button class="member-btn" type="button" onclick="location.href='${pageContext.request.contextPath}/obslog">관찰일지</button>
								<button class="member-btn" type="button" onclick="location.href='${pageContext.request.contextPath}/member/inslog">점검일지</button>
							</div>
						</div>
					</div>
				</div>
			</div>
	</section>

	<%@ include file="/WEB-INF/jsp/etc/footer.jsp"%>
</body>
</html>