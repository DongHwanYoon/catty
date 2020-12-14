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

	<section class="main-content post-single">
		<div class="container">
			<div class="row">
				<div class="col-sm-12">
					<div class="row">
						<div class="col-xs-12">
							<div class="obs-log">
								<h3 class="obs-log-title">관찰일지 작성</h3>
								<div class="cat">
									<div class="cat-info">
										<div class="cat-detail">
											<img alt="" src="https://via.placeholder.com/251x251"
												class="avatar" height="100" width="100"> <cite
												class="fn">고양이 이름</cite> <span class="says">says:</span>
										</div>
										<div class="comment-meta commentmetadata">
											<p>등록일자</p> <a
												class="comment-edit-link" href="#">(Edit)</a>
										</div>
										<p>고양이의 상세 정보를 보여주는 곳</p>
										<div class="access-record-btn">
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

	<%@ include file="/WEB-INF/jsp/etc/footer.jsp"%>
</body>
</html>