<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>페이지를 찾을 수 없습니다</title>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/etc/top.jsp"%>

	<section class="main-content">
            <div class="container">
		        <main id="main" class="site-main" role="main">
			        <section class="error-404 not-found">
				        <header class="page-header">
					        <h1 class="page-title">404</h1>
				        </header>
				        <div class="page-content">
                            <p>앗! 요청하신 페이지를 찾을 수 없습니다 ㅠㅠ</p>
                            <span class="back"><a href="index.html">뒤로 돌아가기</a></span>
				        </div>
			        </section>
                </main>
            </div>
	    </section>

	<%@ include file="/WEB-INF/jsp/etc/footer.jsp"%>
</body>
</html>