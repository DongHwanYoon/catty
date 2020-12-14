 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <head>
    	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="FusionBlog - Personal Blog Theme">
        <meta name="keywords" content="Html, Css, jQuery, JavaScript, FusionBlog, blog, personal blog, template, news theme">
        
        <!-- Title -->
        <title>Catty</title>
        <!-- Favicon -->
        <link rel="icon" href="https://via.placeholder.com/80x80">
        <!-- Google Fonts -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@400;500;700;900&display=swap">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@700&display=swap">
                
        <!-- Font Awesome Css -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font-awesome.min.css">
        <!-- Bootstrap Css -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
        <!-- Slick Css -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/slick.min.css">
        <!-- Main Style Css -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
        <!-- Cat Style Css -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/cat.css">
        <!-- ObservationLog Style Css -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/observationLog.css">
        
        <!-- Login Style Css -->
		<link rel="stylesheet"
			href="${pageContext.request.contextPath}/css/login.css">
		<!-- Join Style Css -->
		<link rel="stylesheet"
			href="${pageContext.request.contextPath}/css/memberlist.css">
		<!-- Join Style Css -->
		<link rel="stylesheet"
			href="${pageContext.request.contextPath}/css/member.css">
		<!-- Join Style Css -->
		<link rel="stylesheet"
			href="${pageContext.request.contextPath}/css/loginbar.css">
        <link rel="stylesheet"
			href="${pageContext.request.contextPath}/css/inspectionLog.css">
		<link rel="stylesheet"
		href="${pageContext.request.contextPath}/css/facility.css">
        
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
				<a href="${pageContext.request.contextPath}/cat">
					<h2>Catty</h2>
				</a>
				<p class="site-description">고양이 관리 서비스</p>
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
									<li class="menu-item dropdown"><a
										href="${pageContext.request.contextPath}/cat">고양이</a>
										<ul role="menu" class=" dropdown-menu">
											<li class="menu-item"><a
												href="${pageContext.request.contextPath}/cat">고양이 목록</a></li>
											<li class="menu-item" id="obs-menu" hidden="hidden"><a
												href="${pageContext.request.contextPath}/obslog">관찰일지</a></li>
										</ul>
									</li>
									<li class="menu-item dropdown" id="facility-menu"></li>
									<li class="menu-item" id="member-list"></li>
								</ul>
							</div>
						</nav>
					</div>
					<div class="col-md-3 col-sm-4 col-xs-9 text-md-center">
						<div class="search-toggle">
							<c:choose>
								<c:when test="${sessionScope.id == null}">
									<li class="menu-item dropdown"><a
										href="${pageContext.request.contextPath}/common/login">로그인</a>
										<ul role="menu" class=" dropdown-menu">
											<li class="menu-item"><a
												href="${pageContext.request.contextPath}/member/join">회원가입</a></li>
										</ul>
									</li>
								</c:when>
								<c:otherwise>
									<li class="menu-item dropdown"><a
										href="${pageContext.request.contextPath}/cat"
										data-toggle="dropdown" class="dropdown-toggle"
										aria-haspopup="true">${id} 님</a>
										<ul role="menu" class=" dropdown-menu">
											<li class="menu-item"><a
												href="${pageContext.request.contextPath}/member/${no}">회원
													정보</a></li>
											<li class="menu-item"><a
												href="${pageContext.request.contextPath}/common/logout">로그아웃</a></li>
										</ul>
									</li>
								</c:otherwise>
							</c:choose>
						</div>
						<ul class="social-icons-menu list-unstyled">
							<li><a href="https://www.facebook.com/nyangnyang2020"
								target="_blank"><i class="fa fa-facebook"></i></a></li>
							<li><a href="https://www.instagram.com/nyangnyang_guard"
								target="_blank"><i class="fa fa-instagram"></i></a></li>
							<li><a
								href="https://www.youtube.com/channel/UCwK3hT2ah8OA9Hzjmiq4TmQ"
								target="_blank"><i class="fa fa-youtube"></i></a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</header>