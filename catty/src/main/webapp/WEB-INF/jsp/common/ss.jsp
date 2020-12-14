<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>

<body>
	<%@ include file="/WEB-INF/jsp/etc/top.jsp"%>


	<section class="main-content single-page contact">
		<div class="container">
			<div class="row">
				<div class="col-sm-12">
					<div class="post-item">
						<div class="post-header">
							<h3 class="post-title">로 그 인</h3>
						</div>
						<div class="row">
							<div class="col-md-6 col-md-offset-3">
								<div class="post-content">
									<form class="login-form"
										action="${pageContext.request.contextPath}/common/login"
										method="POST">
										<div class="row">
											<div class="login-top">
												<div class="col-sm-12">
													<div class="form-group">
														<input type="text" class="form-control" placeholder="아이디"
															id="id" name="id" required>
													</div>
												</div>
												<div class="col-sm-12">
													<div class="form-group">
														<input type="password" class="form-control"
															placeholder="비밀번호" id="pwd" name="pwd" required>
													</div>
												</div>
											</div>
											<div class="col-sm-12">
												<button class="login-btn" type="submit" name="send">로
													그 인</button>
											</div>
											<!-- Form Message  -->
											<div class="form-message text-center">
												<span></span>
											</div>

											<div class="row">
											<div class="login-bottom">
												<div class="col-sm-6">
													<p class="remember-id">
														<input id="remember-id"
															name="remember-id" type="checkbox"
															value="yes"> <label for="remember-id">아이디
															저장</label>
													</p>
												</div>
												<div class="col-sm-6">
													<a class="join"
														href="${pageContext.request.contextPath}/member/join">회원가입</a>
												</div>
											</div>
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<%@ include file="/WEB-INF/jsp/etc/footer.jsp"%>
</body>
</html>