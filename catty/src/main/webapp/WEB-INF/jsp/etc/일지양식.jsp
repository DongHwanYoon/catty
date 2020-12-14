<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="FusionBlog - Personal Blog Theme">
<meta name="keywords"
	content="Html, Css, jQuery, JavaScript, FusionBlog, blog, personal blog, template, news theme">

<!-- Title -->
<title>FusionBlog - Personal Blog Theme</title>
<!-- Favicon -->
<link rel="icon" href="https://via.placeholder.com/80x80">
<!-- Google Fonts -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@400;500;700;900&display=swap">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@700&display=swap">

<!-- Font Awesome Css -->
<link rel="stylesheet" href="css/font-awesome.min.css">
<!-- Bootstrap Css -->
<link rel="stylesheet" href="css/bootstrap.min.css">
<!-- Slick Css -->
<link rel="stylesheet" href="css/slick.min.css">
<!-- Main Style Css -->
<link rel="stylesheet" href="css/main.css">

<!--[if lt IE 9]>
        <script src="js/html5shiv.min.js"></script>
        <script src="js/respond.min.js"></script>
        <![endif]-->

</head>
<body>

	<!-- ========== Start Loading ========== -->

	<div class="loading">
		<div class="loading-content">
			<div class="inner-item"></div>
			<div class="inner-item"></div>
			<div class="inner-item"></div>
			<div class="inner-item"></div>
			<div class="inner-item"></div>
		</div>
	</div>

	<!-- ========== End Loading ========== -->

	<!-- ========== Start Header ========== -->

	<header>
		<div class="site-brand text-center">
			<div class="container">
				<a href="index.html">
					<h2>FusionBlog</h2>
				</a>
				<p class="site-description">A Captivating Personal Blog Theme</p>
			</div>
		</div>
		<div class="header-inner">
			<div class="container">
				<div class="row">
					<div class="col-md-9 col-sm-8 col-xs-3 pos-s">
						<button class="menu-toggle">
							<span class="bar"></span> <span class="bar"></span> <span
								class="bar"></span>
						</button>
						<nav class="navbar navbar-default">
							<div class="collapse navbar-collapse">
								<ul class="nav navbar-nav">
									<li class="menu-item active"><a href="index.html">Home</a>
									</li>
									<li class="menu-item"><a href="category.html">Lifestyle</a>
									</li>
									<li class="menu-item"><a href="category.html">Travel</a></li>
									<li class="menu-item"><a href="category.html">Fashion</a>
									</li>
									<li class="menu-item dropdown"><a href="#"
										data-toggle="dropdown" class="dropdown-toggle"
										aria-haspopup="true">Pages <span class="caret"></span></a>
										<ul role="menu" class=" dropdown-menu">
											<li class="menu-item"><a href="archive.html">Archive</a></li>
											<li class="menu-item"><a href="author.html">Author</a></li>
											<li class="menu-item"><a href="category.html">Category</a></li>
											<li class="menu-item"><a href="tag.html">Tag</a></li>
											<li class="menu-item"><a href="404.html">404</a></li>
										</ul></li>
									<li class="menu-item"><a href="about.html">About</a></li>
									<li class="menu-item"><a href="contact.html">Contact</a></li>
								</ul>
							</div>
						</nav>
					</div>
					<div class="col-md-3 col-sm-4 col-xs-9 text-md-center">
						<div class="search-toggle">
							<i class="fa fa-search"></i>
						</div>
						<ul class="social-icons-menu list-unstyled">
							<li><a href="#" target="_blank"><i
									class="fa fa-facebook"></i></a></li>
							<li><a href="#" target="_blank"><i class="fa fa-twitter"></i></a></li>
							<li><a href="#" target="_blank"><i
									class="fa fa-instagram"></i></a></li>
							<li><a href="#" target="_blank"><i
									class="fa fa-pinterest"></i></a></li>
							<li><a href="#" target="_blank"><i class="fa fa-youtube"></i></a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<div class="search-area">
			<span class="close-search"> <i class="fa fa-close"></i>
			</span>
			<div class="display-table">
				<div class="display-table-cell">
					<form role="search" method="get" class="search-form" action="#">
						<input type="search" class="search-field" placeholder="Search..."
							name="s" required="required" />
						<button type="submit" class="search-submit">
							<i class="fa fa-search"></i>
						</button>
					</form>
				</div>
			</div>
		</div>
	</header>

	<!-- ========== End Header ========== -->

	<!-- ========== Start Single Post ========== -->

	<section class="main-content post-single">
		<div class="container">
			<div class="row">
				<div class="col-sm-12">
					<div class="row">
						<div class="col-xs-12">
							<div class="obs-log">
								<!-- comments -->
								<h3 class="obs-log-title">관찰일지 작성</h3>
								<!-- comments-count -->
								<div class="cat">
									<!-- list-unstyled comments-list -->
									<div class="cat-info">
										<!-- comment-body -->
										<div class="cat-detail">
											<!-- comment-author  -->
											<img alt="" src="https://via.placeholder.com/251x251"
												class="avatar" height="64" width="64"> <cite
												class="fn">고양이 이름</cite> <span class="says">says:</span>
										</div>
										<div class="comment-meta commentmetadata">
											<!-- comment-meta commentmetadata -->
											<a href="#">October 21, 2020 at 11:45 am</a> <a
												class="comment-edit-link" href="#">(Edit)</a>
											<!-- comment-edit-link -->
										</div>
										<p>고양이의 상세 정보를 보여주는 곳</p>
										<div class="reply">
											<!-- reply -->
											<a class="access-record-link" href="#">접근 기록 조회</a>
										</div>
									</div>
									<div id="respond" class="comment-respond">
										<h3 class="comment-reply-title">Leave a Reply</h3>
										<form action="#" method="post" class="comment-form">
											<label class="label">Comment</label>
											<textarea id="comment" name="comment"
												placeholder="관찰내용을 작성하세요" required="required"></textarea>
											<p class="comment-form-cookies-consent">
												<input id="comment-cookies-consent"
													name="comment-cookies-consent" type="checkbox" value="yes"
													checked="checked"> <label
													for="comment-cookies-consent">아이디 저장</label>
											</p>
											<p class="form-submit">
												<input name="submit" type="submit" id="submit"
													class="submit" value="작성">
											</p>
										</form>
									</div>
								</div>
							</div>
						</div>
						<div class="clearfix"></div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- ========== Start Scroll To Top ========== -->

	<a href="#" class="scroll-top"> <span><i
			class="fa fa-arrow-up"></i></span>
	</a>

	<!-- ========== End Scroll To Top ========== -->

	<!-- ========== Start Footer ========== -->

	<div class="footer text-center">
		<div class="footer-info">
			<div class="container">
				<p class="copyright">copyright &copy; 2020 FusionBlog, All Right
					Reserved</p>
				<div class="textwidget custom-html-widget">
					<ul class="social-icons-menu list-unstyled">
						<li><a href="#" target="_blank"><i class="fa fa-facebook"></i></a></li>
						<li><a href="#" target="_blank"><i class="fa fa-twitter"></i></a></li>
						<li><a href="#" target="_blank"><i
								class="fa fa-instagram"></i></a></li>
						<li><a href="#" target="_blank"><i
								class="fa fa-pinterest"></i></a></li>
						<li><a href="#" target="_blank"><i class="fa fa-youtube"></i></a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>

	<!-- ========== End Footer ========== -->

	<!-- ========== Js ========== -->

	<!-- jQuery -->
	<script src="js/jquery-3.2.1.min.js"></script>
	<!-- Bootstrap Js -->
	<script src="js/bootstrap.min.js"></script>
	<!-- Slick Js -->
	<script src="js/slick.min.js"></script>
	<!-- Main Js -->
	<script src="js/main.js"></script>
</body>
</body>
</html>