<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- ========== Start Scroll To Top ========== -->
		
		     <a href="#" class="scroll-top">
                 <span><i class="fa fa-arrow-up"></i></span>
             </a>
		
		     <!-- ========== End Scroll To Top ========== -->
		
		     <!-- ========== Start Footer ========== -->
		
			 <div class="footer text-center">
				 <div class="footer-info">
					 <div class="container">
						 <p class="copyright">
							 copyright &copy; 2020 FusionBlog, All Right Reserved
						 </p>
						 <div class="textwidget custom-html-widget">
							 <ul class="social-icons-menu list-unstyled">
								<li><a href="https://www.facebook.com/nyangnyang2020" target="_blank"><i class="fa fa-facebook"></i></a></li>
                                <li><a href="https://www.instagram.com/nyangnyang_guard/" target="_blank"><i class="fa fa-instagram"></i></a></li>
                                <li><a href="https://www.youtube.com/channel/UCwK3hT2ah8OA9Hzjmiq4TmQ" target="_blank"><i class="fa fa-youtube"></i></a></li>
							  </ul>
						 </div>
					 </div>
				 </div>
			 </div>

			 <!-- ========== End Footer ========== -->

			 <!-- ========== Js ========== -->

			 <!-- jQuery -->
			 <script src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
			 <!-- Bootstrap Js -->
			 <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
			 <!-- Slick Js -->
			 <script defer src="${pageContext.request.contextPath}/js/slick.min.js"></script>
			 <!-- Main Js -->
			 <script src="${pageContext.request.contextPath}/js/main.js"></script>
			 
			 <script>
				var session = "${sessionScope.id}";
				
				if (session) {
					$("#obs-menu").show();
					var script = "";
					
					script += "<a href='${pageContext.request.contextPath}/facility'>시설물</a>";
					script += "<ul role='menu' class='dropdown-menu'>";
					script += "		<li class='menu-item'>";
					script += "			<a href='${pageContext.request.contextPath}/facility'>시설물 목록</a>";
					script += "		</li>";
					script += "		<li class='menu-item'>";
					script += "			<a href='${pageContext.request.contextPath}/inslog'>점검일지</a>";
					script += "		</li>";
					script += "		</ul>";
					
					$("#facility-menu").html(script);
					
					var isAdmin = "${sessionScope.isAdmin}";
					if (isAdmin) {
						$("#member-list").html("<a href='${pageContext.request.contextPath}/member'>회원 관리</a>");
					}
				} else {
					$("#obs-menu").hide();
				}
			</script>