<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<jsp:include page="/WEB-INF/jsp/etc/top.jsp" />
	
	<section class="main-content post-single" >
		<div class="container">
			<div class="row" >
				<div class="col-md-12 col-sm-12" >
					<div class="cat-detail-form">
						<div class="row">
							<h3 class="log-title">관찰일지 조회</h3>
							<div class="detail">
								<div class="row" >
									<div class="col-sm-3" >
										<div class="cat-image">
											<img id="image_preview" src="${pageContext.request.contextPath}/photo/cat/${ row.cat.no }" alt="고양이 사진"/>
										</div>
									</div>
									<div class="col-sm-9" >
										<div class="col-md-12 col-sm-12" >
											<div class="col-sm-6">
												<div class="cat-desc">이름 : ${ row.cat.name }</div>
												<div class="cat-desc">성별 : 
													<c:choose>
														<c:when test="${ row.cat.gender eq 'M' }" ><i class='fa fa-mars' ></i></c:when>
														<c:otherwise><i class='fa fa-venus' ></i></c:otherwise>
													</c:choose>
												</div>
												<div class="cat-desc">종 : ${ row.cat.spices }</div>
											</div>
											<div class="col-sm-6">
												<c:choose>
													<c:when test="${ row.cat.birthDate != null }">
														<div class="cat-desc">출생 연월 : ${ row.cat.birthDate }</div>
													</c:when>
													<c:otherwise>
														<div class="cat-desc">출생 연월 : 알수 없음</div>
													</c:otherwise>
												</c:choose>
												<div class="cat-desc">중성화 여부 : ${ row.cat.tnrStatus }</div>
												<div class="cat-desc">특징 : ${ row.cat.feature }</div>
											</div>
										</div>
									</div>
								</div>
								
								<div class="col-sm-12">
								
								<div class="row">
										<div class="btn-container">
											<div class="row" align="right">
												<div class="col-sm-8"></div>
												<button class="common-btn" id="button_cat" type="button" >고양이 조회</button>
											</div>
											
											<div class="row" align="right">
												<form action="${pageContext.request.contextPath}/obslog/${ row.obsLog.no }" method="POST" >
													<button class="common-btn" id="button_edit" type="button" onClick="location.href='${pageContext.request.contextPath}/obslog/${ row.obsLog.no }/form'" hidden="hidden">수정</button>
													<input type="hidden" name="_method" value="DELETE" />
													<button class="common-btn" id="button_delete" type="submit" hidden="hidden">삭제</button>
													<button class="common-btn" id="button_obs" type="button" >목록</button>
												</form>
											</div>
										</div>
								</div>
								
								</div>
								
							</div>
						</div>
						
						<div class="row" >
							<div class="obs-detail-form">
								<div class="row">
									<div class="about-widget">
										<div class="log-desc">회원 아이디 : ${ row.member.id }(${ row.member.name })</div>
										<div class="log-desc">작성일자 : ${ row.obsLog.registrateDate }</div>
										<div class="log-desc">수정일자 : ${ row.obsLog.modifiedDate }</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-6 col-sm-6">
										<div class="obsLog-photo">
											<img src="${pageContext.request.contextPath}/photo/obslog/${row.obsLog.no}" onerror="this.style.display='none'" />
										</div>
									</div>
									<div class="col-md-6 col-sm-6">
										<div class="note">
											<div class="desc">${ row.obsLog.note }</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			
		</div>
	</section>
	
	<jsp:include page="/WEB-INF/jsp/etc/footer.jsp" />
</body>
<script>
$(document).ready(function() {
	var sessionNo = ${sessionScope.no};
	var writerNo = ${ row.member.no };
	var isAdmin = "${sessionScope.isAdmin}";
	
	if (isAdmin || (sessionNo == writerNo)) {
		$("#button_edit").show();
		$("#button_delete").show();
	} else {
		$("#button_edit").hide();
		$("#button_delete").hide();
	}
	
	$("#button_cat").click(function() {
		$(location).attr("href", "${pageContext.request.contextPath}/cat/${row.cat.no}");
	});
	
	$("#button_obs").click(function() {
		$(location).attr("href", "${pageContext.request.contextPath}/obslog");
	});
	});
</script>
</html>