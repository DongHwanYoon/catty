<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="utf-8">
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<meta name="author" content="SemiColonWeb" />

	<!-- Stylesheets
	============================================= -->
	<link href="https://fonts.googleapis.com/css?family=Lato:300,400,400i,700|Poppins:300,400,500,600,700|PT+Serif:400i&display=swap" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" href="css/bootstrap.css" type="text/css" />
	<link rel="stylesheet" href="style.css" type="text/css" />
	<link rel="stylesheet" href="css/dark.css" type="text/css" />
	<link rel="stylesheet" href="css/font-icons.css" type="text/css" />
	<link rel="stylesheet" href="css/animate.css" type="text/css" />
	<link rel="stylesheet" href="css/magnific-popup.css" type="text/css" />

	<link rel="stylesheet" href="css/custom.css" type="text/css" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />

	<!-- Document Title
	============================================= -->
	<title>Started - Forms | Canvas</title>

	<style>

		#get-started-form .dark .form-control:not(.not-dark),
		#get-started-form .dark .form-control:not(.not-dark):active,
		#get-started-form .dark .form-control:not(.not-dark):focus {
			background-color: transparent;
			border: 0;
			border-bottom: 2px solid rgba(255,255,255,0.6);
			padding: 0 4px;
			text-shadow: none;
			color: #FFF;
		}

		#get-started-form .dark .form-control:not(.not-dark):active,
		#get-started-form .dark .form-control:not(.not-dark):focus {
			border-color: var(--danger) !important;
		}

		#get-started-form-processing .tab-action-btn-prev {
			opacity: 0;
			pointer-events: none;
		}

		#get-started-form .alert-success {
		    color: #FFF;
		    background-color: transparent !important;
		    border: none !important;
		    font-size: 20px;
		    text-align: center;
		    line-height: 1.8;
		}
		.tab-pane.active {
			-webkit-animation: scale-center 0.4s cubic-bezier(0.390, 0.575, 0.565, 1.000) both;
	        animation: scale-center 0.4s cubic-bezier(0.390, 0.575, 0.565, 1.000) both;
		}
		@-webkit-keyframes scale-center {
		  0% {
		  	opacity: 0;
		    -webkit-transform: scale(0.9);
		            transform: scale(0.9);
		  }
		  100% {
		  	opacity: 1;
		    -webkit-transform: scale(1);
		            transform: scale(1);
		  }
		}
		@keyframes scale-center {
		  0% {
		  	opacity: 0;
		    -webkit-transform: scale(0.9);
		            transform: scale(0.9);
		  }
		  100% {
		  	opacity: 1;
		    -webkit-transform: scale(1);
		            transform: scale(1);
		  }
		}
	</style>
</head>

<body class="stretched">

	<!-- Document Wrapper
	============================================= -->
	<div id="wrapper" class="clearfix">

		<!-- Slider
		============================================= -->
		<section id="slider" class="slider-element min-vh-100 "
			style="background: linear-gradient(to top, rgba(38, 38, 38, 0.922), rgba(38, 38, 38, 0.922)), url('/images/main-5.jpg') no-repeat center center/cover;">
			<div class="slider-inner" style="overflow-y: auto;">

				<div class="row justify-content-center align-items-center h-100">

					<div class="col-lg-4 col-sm-7 col-10 mt-sm-5">

						<div class="list-group d-none" id="tab-hidden" role="tablist">
							<a class="active" data-toggle="list" href="#get-started-form-select-dates">1.</a> 
							<a data-toggle="list" href="#get-started-form-select-details">2.</a>
							<a data-toggle="list" href="#get-started-form-result">3.</a>
						</div>
						<div class="tab-content" id="nav-tabContent">

							<div class="tab-pane show active" id="get-started-form-select-dates" role="tabpanel" aria-labelledby="get-started-form-select-dates">
								<div class="row align-items-center">
									<div class="col-12">
										<div class="mb-4 center dark">
											<h1 class="font-weight-semibold display-4 mb-4">환영합니다</h1>
											<p class="font-weight-normal text-white-50">로그인 후 서비스 이용가능합니다.</p>
										</div>
										<form id="login" action="/login" method="post">
											<div class="row align-items-center forms-section">
												<div class="col-12 form-group mb-5 dark">
													<label>이메일:</label> 
													<input type="email" name="email" id="loginEmail" class="form-control form-control-lg required" placeholder="user@company.com" required>
												</div>
												<div class="col-12 form-group mb-5 dark">
													<label>비밀번호:</label> 
													<input type="password" name="password" class="form-control form-control-lg required" placeholder="password" required>
												</div>
												<div class="col-12 d-flex">
													<button type="button" class="button button-rounded tab-action-btn-next bg-danger mt-1  py-0 button-large">
														회원가입
													</button>
													<input type="submit" form="login" name="get-started-form-submit" class="button button-rounded bg-danger  col button-large" value="로그인">
												</div>
											</div>
										</form>
									</div>
								</div>
							</div>


							<div class="tab-pane dark" id="get-started-form-select-details" role="tabpanel" aria-labelledby="get-started-form-select-details">
								<div class="center mb-4">
									<h1 class="font-weight-semibold display-4 mb-4">회원가입</h1>
									<p class="font-weight-normal text-white-50">이메일로 회원가입 가능합니다. 회원 정보를 입력하세요.</p>
								</div>
								<form id="login" action="/member" method="post">
									<div class="row align-items-center forms-section">
										<c:set var="code" value="<%=UUID.randomUUID().toString().toUpperCase().substring(0, 6)%>" />
										<input type="hidden" id="code" name="code" value="${code}" />
										<div class="col-12 form-group mb-4">
											<label>이메일:</label>
											<input type="email" name="email" id="email" class="form-control form-control-lg required" placeholder="user@company.com" onchange="checkEmail()" required>
											<input type="button" class="button button-rounded bg-danger" id="send" value="전송" style="float: right;" />
										</div>
										<div class="col-12 form-group">
											<label>인증코드:</label> 
											<input type="text" name="authCode" id="authCode" class="form-control form-control-lg required" value="">
											<input class="button button-rounded bg-danger" type="button" id="auth" value="인증" style="float: right;" />
										</div>
										<div class="col-12 form-group mb-4">
											<label>비밀번호:</label>
											<input type="password" name="password" id="password" class="form-control form-control-lg required" value="" maxlength="20" required>
										</div>
										<div class="col-12 form-group mb-4">
											<label>이름:</label>
											<input type="text" name="name" id="name" class="form-control form-control-lg required" value="" maxlength="40" required>
										</div>
										<div class="col-12 form-group mb-4">
											<label>닉네임:</label>
											<input type="text" name="nickname" id="nickname" class="form-control form-control-lg required" value="" required>
										</div>
										<div class="col-12 form-group mb-4">
											<label for="" style="font-size: 15px;">은행:</label>
											 <select id="bank" name="bank" class="select-1 form-control" style="width: 100%;" required>
												<option value="" disabled selected>은행 선택</option>
												<option value="KB국민은행">KB국민은행</option>
												<option value="기업은행">기업은행</option>
												<option value="농협">농협</option>
												<option value="새마을금고">새마을금고</option>
												<option value="수협">수협</option>
												<option value="신한은행">신한은행</option>
												<option value="신협">신협</option>
												<option value="외환은행">외환은행</option>
												<option value="우리은행">우리은행</option>
												<option value="카카오뱅크">카카오뱅크</option>
												<option value="하나은행">하나은행</option>
											</select>
										</div>
										<div class="col-12 form-group mb-4">
											<label>계좌번호:</label> <input type="number" name="account" id="account" class="form-control form-control-lg required" maxlength="14" required>
										</div>
										<div class="col-12 d-flex">
											<button type="button" class="button button-border button-rounded border-light button-white button-light col tab-action-btn-prev button-large">
												<i class="icon-arrow-left"></i>뒤로가기
											</button>
											<button type="submit" name="get-started-form-submit" class="button button-rounded bg-danger tab-action-btn-next-submit col button-large" disabled>
												가입 <i class="icon-arrow-right"></i>
											</button>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>


	</div><!-- #wrapper end -->

	<!-- Go To Top
	============================================= -->
	<div id="gotoTop" class="icon-angle-up"></div>

	<!-- External JavaScripts
	============================================= -->
	<script src="js/jquery.js"></script>
	<script src="js/plugins.min.js"></script>

	<!-- Footer Scripts
	============================================= -->
	<script src="js/functions.js"></script>

	<script>
		jQuery(document).ready( function(){
			$('.tab-action-btn-next').click(function() {
				$('#tab-hidden > .active').next('a').trigger('click');
			});

			$('.tab-action-btn-prev').click(function() {
				$('#tab-hidden > .active').prev('a').trigger('click');
			});

			$('.tab-action-btn-first').click(function(e) {
				$('#tab-hidden > a:first-child').tab('show');
				e.preventDefault();
			});

			jQuery('#get-started-form').on( 'formSubmitSuccess formSubmitError', function(){
				$('#tab-hidden > a:last-child').tab('show');
			});
		});
		
		document.getElementById('send').addEventListener('click', send_code);
		function send_code() {
			var xhr = new XMLHttpRequest();
			var formData = new FormData();
			formData.append('email', document.getElementById("email").value);
			formData.append('code', document.getElementById("code").value);
			xhr.onload = function() {
				alert("해당 이메일로 인증코드가 발송되었습니다!");
				
			}
			xhr.open("POST", "http://localhost:8080/email");
			xhr.send(formData);
		};
		
		document.getElementById('auth').addEventListener('click', auth_code);
		function auth_code(){
			if(document.getElementById("authCode").value
					== document.getElementById("code").value){
				alert("인증에 성공했습니다.");
				
				$('button[type="submit"]').removeAttr('disabled');
				
			}  else {
				alert("인증코드가 잘못되었습니다.");
			}
		}
		
		function checkEmail() {    
			var email = document.getElementById("email").value;
		    var regex=/([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
		   if (regex.test(email)) {
			   
		   } else {
			   document.getElementById("email").value ='';
			   alert("이메일 형식에 맞게 입력해주세요")
		   }
		}			
		
	</script>

</body>
</html>