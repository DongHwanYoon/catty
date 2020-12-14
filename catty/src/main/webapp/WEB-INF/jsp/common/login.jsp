<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>

<body>
	<%@ include file="/WEB-INF/jsp/etc/top.jsp"%>

	<section class="main-content">
		<div class="container">
			<div class="col-md-3 .col-md-offset-3"></div>
			<div class="col-md-6 .col-md-offset-3">
				<div class="login-wrap">
					<div class="login-body">
						<h3 class="login-title">로그인</h3>
						<form class="login-form" method="POST"
							action="${pageContext.request.contextPath}/common/login">
							<div class="login-form-fields">
								<div class="row">
									<div class="form-group">
										<input type="text" name="id" value="${loginInfo.id}"
											placeholder="아이디" required>
									</div>
									<div class="form-group">
										<input type="password" name="pwd" placeholder="비밀번호" required>
									</div>
									<div class="form-group">
										<input type="submit" value="로그인">
									</div>
									<div class="form-group">
										<div class="login-bottom">
											<div class="col-md-6" align="left">
												<p class="remember-id">
													<input id="isRemember" name="isRemember" type="checkbox"
														value="false"> <label for="isRemember">아이디
														기억하기</label>
												</p>
											</div>
											<div class="col-md-6" align="right">
												<a href="${pageContext.request.contextPath}/member/join">회원가입</a>
											</div>
										</div>
									</div>
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
	$(function() {
		var responseMessage = "<c:out value = "${message}" />";
		if (responseMessage == "registered") {
			alert("회원가입 성공")
		}

		if (responseMessage == "isDeleted") {
			alert("회원탈퇴 완료")
		}

		if (responseMessage == "unlogged") {
			alert("로그인 실패")
		}
	})
</script>
</html>