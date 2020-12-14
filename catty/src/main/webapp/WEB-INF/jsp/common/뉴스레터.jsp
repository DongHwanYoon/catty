<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관찰일지 등록</title>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/etc/top.jsp"%>

	<section class="main-content">
            <div class="container">
                <div class="archive-box">
                    <span>Browsing Tag</span>
                    <h1>travel</h1>
                </div>
                <div class="row">
                <div class="col-md-3 .col-md-offset-3"></div>
                    <div class="col-md-6 .col-md-offset-3">
                        <div class="sidebar">
                            <div class="widget about-widget">
                                <h3 class="widget-title">About Me</h3>
                                <div class="author-image">
									<img class="img-responsive" src="https://via.placeholder.com/251x251" alt="" height="107" width="107">
                                </div>
                                <div class="author-info">
                                    <h3 class="author-name">Hi I'm <span>Leila Smith</span></h3>
                                    <p class="author-desc">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maxi mus orci ac condiorci mentum efficitur suspendi potentio fuscestas ut eleifend.</p>
                                </div>
                            </div>
                            <div class="widget categories-widget">
                                <h3 class="widget-title">Categories</h3>
                                <div class="category-item">
                                    <a href="category.html">Culture</a>
                                    <span class="count">(4)</span>
                                </div>
								<div class="category-item">
                                    <a href="category.html">Fashion</a>
                                      <a href="category.html">2222</a>
                                    <span class="count">(4)</span>
                                </div>
								<div class="category-item">
                                    <a href="category.html">Food</a>
                                    <span class="count">(4)</span>
                                </div>
								<div class="category-item">
                                    <a href="category.html">Lifestyle</a>
                                    <span class="count">(6)</span>
                                </div>
								<div class="category-item">
                                    <a href="category.html">Stories</a>
                                    <span class="count">(4)</span>
                                </div>
								<div class="category-item">
                                    <a href="category.html">Travel</a>
                                    <span class="count">(6)</span>
                                </div>
                            </div>
							<div class="widget newsletter">
							   <div class="widget widget_mc4wp_form_widget">
								   <h3 class="widget-title">Subscribe</h3>
								   <form class="mc4wp-form mc4wp-form-101" method="post" action="#">
									   <div class="mc4wp-form-fields">
										   <label>Fill your email below to subscribe to my newsletter</label>
										   <input type="email" name="EMAIL" placeholder="Your email address" required="">
										   <input type="submit" value="Subscribe">
									   </div>
								   </form>
								</div>
							</div>
							<div class="widget tags-widget">
								<h3 class="widget-title">Tags</h3>
								<ul class="tags-list list-unstyled">
									<li><a href="tag.html">Culture</a></li>
									<li><a href="tag.html">Explortion</a></li>
									<li><a href="tag.html">Fashion</a></li>
									<li><a href="tag.html">Food</a></li>
									<li><a href="tag.html">Lifestyle</a></li>
									<li><a href="tag.html">Mode</a></li>
									<li><a href="tag.html">Self-confidence</a></li>
									<li><a href="tag.html">Stories</a></li>
									<li><a href="tag.html">Travel</a></li>
									<li><a href="tag.html">Trends</a></li>
									<li><a href="tag.html">Trip</a></li>
								</ul>
							</div>
							<div class="widget follow-widget">
								<h3 class="widget-title">Follow Us</h3>
								<ul class="social-icons-menu list-unstyled">
									<li><a href="#" target="_blank"><i class="fa fa-facebook"></i></a></li>
								   <li><a href="#" target="_blank"><i class="fa fa-twitter"></i></a></li>
								   <li><a href="#" target="_blank"><i class="fa fa-instagram"></i></a></li>
								   <li><a href="#" target="_blank"><i class="fa fa-pinterest"></i></a></li>
								   <li><a href="#" target="_blank"><i class="fa fa-youtube"></i></a></li>
								 </ul>
							</div>
						</div>
                    </div>
                </div>
            </div>
         </section>

	<%@ include file="/WEB-INF/jsp/etc/footer.jsp"%>
</body>
</html>