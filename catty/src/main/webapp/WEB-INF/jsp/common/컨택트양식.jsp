<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>컨택트 양식</title>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/etc/top.jsp"%>

	<section class="main-content single-page contact">
		<div class="container">
			<div class="row">
				<div class="col-sm-12">
					<div class="post-item">
						<div class="post-header">
							<h3 class="post-title">Contact</h3>
						</div>
						<div class="row">
							<div class="col-md-10 col-md-offset-1 col-sm-offset-0">
								<div class="post-content">
									<div class="row">
										<div class="col-sm-4">
											<div class="contact-box">
												<div class="title-box">
													<div class="icon-box">
														<i class="fa fa-map-marker"></i>
													</div>
													<div class="name-box">
														<h4>Location</h4>
													</div>
												</div>
												<div class="content-box">
													<p>NewYork, USA</p>
													<p>10 Street Name</p>
												</div>
											</div>
										</div>
										<div class="col-sm-4">
											<div class="contact-box">
												<div class="title-box">
													<div class="icon-box">
														<i class="fa fa-envelope"></i>
													</div>
													<div class="name-box">
														<h4>Email</h4>
													</div>
												</div>
												<div class="content-box">
													<p>Leilasmith@Infos.com</p>
													<p>info@example.com</p>
												</div>
											</div>
										</div>
										<div class="col-sm-4">
											<div class="contact-box">
												<div class="title-box">
													<div class="icon-box">
														<i class="fa fa-phone"></i>
													</div>
													<div class="name-box">
														<h4>Phone</h4>
													</div>
												</div>
												<div class="content-box">
													<p>+1 212 442-7584</p>
													<p>+1 212 512-4514</p>
												</div>
											</div>
										</div>
									</div>
									<form class="contact-form" action="mail.php" method="post">
										<div class="row">
											<div class="col-sm-6">
												<div class="form-group">
													<input type="text" class="form-control" placeholder="Name"
														id="name" name="name" required>
												</div>
											</div>
											<div class="col-sm-6">
												<div class="form-group">
													<input type="email" class="form-control"
														placeholder="Your email" id="email" name="email" required>
												</div>
											</div>
											<div class="col-sm-12">
												<div class="form-group">
													<input type="text" class="form-control"
														placeholder="Subject" id="subject" name="subject" required>
												</div>
											</div>
											<div class="col-sm-12">
												<div class="form-group">
													<textarea class="form-control" placeholder="Message"
														id="message" name="message" required></textarea>
												</div>
											</div>
											<!-- Button Send Message -->
											<div class="col-sm-12">
												<button class="contact-btn main-btn" type="submit"
													name="send">Send Message</button>
											</div>
											<!-- Form Message  -->
											<div class="form-message text-center">
												<span></span>
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