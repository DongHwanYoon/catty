<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="/WEB-INF/jsp/etc/top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=ptdxeli5jv&callback=drawAccessMap"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
	<title>Insert title here</title>
</head>
<body>
	<section class="main-content post-single">
		<div class="container" >
			<div class="col-md-12">
				<div class="post-item">
					<div class="facility">
						<div class="register">
							<div class="row">
								<div class="col-md-12">
									<form action="/facility" method="post" id="addForm">
										<div class="row">
											<div class="col-md-12">
												<h3 class="title">
													시설물 정보
												</h3>
											</div>
										</div>
									
										<div class="row">
											<div class="col-md-12">
												<div class="detail">
														<p><label>이름 : </label><input id="input-name" type="text" name="name" readonly="readonly" value="${facility.name}" title="특수문자는 입력이 불가능합니다." pattern="[가-힣a-zA-Z0-9]{1,100}"/></p>
														<p><label>고유번호 : </label><input type="text" id="uid" name="uid" value="${facility.uid}" readonly="readonly"></p>
														<p><label>종류 :</label>
															<c:choose>
																<c:when test="${facility.type eq 'F'}">
																	<input type="text" id="type" readonly="readonly"  name="type" value="급식소" readonly="readonly"></p>
																</c:when>
																<c:when test="${facility.type eq 'H'}">
																	<input type="text" id="type" readonly="readonly"  name="type" value="집" readonly="readonly"></p>
																</c:when>
																<c:when test="${facility.type eq 'R'}">
																	<input type="text" id="type" readonly="readonly"  name="type" value="쉼터" readonly="readonly"></p>
																</c:when>
															</c:choose>
														<p><label>위도 : </label><input type="text" value="${facility.latitude}" name="latitude" id="latitude" readonly="readonly"/></p>
														<p><label>경도 : </label><input type="text" value="${facility.longitude}" name="longitude" id="longitude" readonly="readonly"/></p>
												</div>
											</div>
										</div>
										
										<div class="row">
											<div class="col-md-12">
												<div class="map">
													<label class="map-title">시설물의 위치</label><br>
													<div id="resource" style="margin-top: 30px;margin-bottom: 60px"></div><br>
												</div>
											</div>
										</div>
										
										<div class="row">
											<div class="col-md-12">
												<div class="optional">
													<c:if test="${memberList[0] ne null}">
														<p class="select-member-desc">담당자 목록</p>
														
														<table class='table table-hover'>
																<tr>
																	<th style='background-color: #DEDEDE'>번호</th>
																	<th style='background-color: #DEDEDE'>아이디</th>
																	<th style='background-color: #DEDEDE'>이름</th>
																	<th style='background-color: #DEDEDE; text-align: center'>권한</th>
																</tr>
																
																	<c:forEach var="member" varStatus="no" items="${memberList}">
																		<tr>
																			<td>${no.count} 번</td>
																			<td><a href="${pageContext.request.contextPath}/member/${member.no}">${member.id}</a></td>
																			<td>${member.name}</td>
																			
																			<c:choose>
																				<c:when test="${member.authority eq 'M'}">
																					<td style="text-align: center">회원</td>
																				</c:when>
																				<c:when test="${member.authority eq 'A'}">
																					<td style="text-align: center">관리자</td>
																				</c:when>
																			</c:choose>
																			
																		</tr>	
																	</c:forEach>
															</table>
													</c:if><br><br>
													
													<c:if test="${facility.type eq 'F'}">
														<c:if test="${feedBarrelList[0] ne null}">
															<p class="select-member-desc">사료통 목록</p>
															<table class='table table-hover'>
																<tr>
																	<th style='background-color: #DEDEDE'>번호</th>
																	<th style='background-color: #DEDEDE'>규격</th>
																	<th style='background-color: #DEDEDE'>잔여량</th>
																	<th style='background-color: #DEDEDE; text-align: center'>보충 필요 여부</th>
																	<th style='background-color: #DEDEDE; text-align: center'>상태</th>
																</tr>
																	<c:forEach var="feedBarrel" items="${feedBarrelList}">
																		<tr>
																			<td>${feedBarrel.no} 번</td>
																			<td>${feedBarrel.standard}g</td>
																			<c:choose>
																				<c:when test="${feedBarrel.supplementStatus eq 'X'}">
																					<td style="color: #00B915">${feedBarrel.capacity}g</td>
																				</c:when>
																				<c:when test="${feedBarrel.supplementStatus eq 'O'}">
																					<td style="color: red">${feedBarrel.capacity}g</td>
																				</c:when>
																			</c:choose>	
																			<c:choose>
																				<c:when test="${feedBarrel.supplementStatus eq 'X'}">
																					<td style="text-align: center;color: #00B915">충분</td>
																				</c:when>
																				<c:when test="${feedBarrel.supplementStatus eq 'O'}">
																					<td style="text-align: center;color: red">부족</td>
																				</c:when>
																			</c:choose>	
																			
																			<c:choose>
																				<c:when test="${feedBarrel.status eq 'X'}">
																					<td style="text-align: center;color: #00B915">정상</td>
																				</c:when>
																				<c:when test="${feedBarrel.status eq 'O'}">
																					<td style="text-align: center;color: red">고장</td>
																				</c:when>
																			</c:choose>	
																		</tr>
																	</c:forEach>
																
															</table>
														</c:if>
														
														<c:if test="${waterBarrelList[0] ne null}">
															<p class="select-member-desc" style="margin-top: 60px;">물통 목록</p>
															<table class='table table-hover'>
																<tr>
																	<th style='background-color: #DEDEDE'>번호</th>
																	<th style='background-color: #DEDEDE'>규격</th>
																	<th style='background-color: #DEDEDE'>잔여량</th>
																	<th style='background-color: #DEDEDE; text-align: center'>보충 필요 여부</th>
																	<th style='background-color: #DEDEDE; text-align: center'>상태</th>
																</tr>
																	<c:forEach var="waterBarrel" items="${waterBarrelList}">
																		<tr>
																			<td>${waterBarrel.no} 번</td>
																			<td>${waterBarrel.standard}ml</td>
																			<c:choose>
																				<c:when test="${waterBarrel.supplementStatus eq 'X'}">
																					<td style="color: #00B915">${waterBarrel.capacity}ml</td>
																				</c:when>
																				<c:when test="${waterBarrel.supplementStatus eq 'O'}">
																					<td style="color: red">${waterBarrel.capacity}ml</td>
																				</c:when>
																			</c:choose>	
																			<c:choose>
																				<c:when test="${waterBarrel.supplementStatus eq 'X'}">
																					<td style="text-align: center;color: #00B915">충분</td>
																				</c:when>
																				<c:when test="${waterBarrel.supplementStatus eq 'O'}">
																					<td style="text-align: center;color: red">부족</td>
																				</c:when>
																			</c:choose>	
																			
																			<c:choose>
																				<c:when test="${waterBarrel.status eq 'X'}">
																					<td style="text-align: center;color: #00B915">정상</td>
																				</c:when>
																				<c:when test="${waterBarrel.status eq 'O'}">
																					<td style="text-align: center;color: red">고장</td>
																				</c:when>
																			</c:choose>	
																		</tr>	
																	</c:forEach>
															</table>
														</c:if>
													</c:if>
													<div id="managementFacility"></div>
												</div>
											</div>
										</div>
										</form>
										<div class="row">
											<div class="col-md-12">
												<div class="detail-buttons">
													<form action="${pageContext.request.contextPath}/facility/${facility.no}" method="post">
														<input type="hidden" name="_method" value="delete" />
														<input type="submit" value="삭제">
													</form>
													
													<form action="${pageContext.request.contextPath}/facility/${facility.no}/form"  method="get">
														<input type="submit" value="수정">	
													</form>
													<input class="regist-ins-log" type="button" value="점검일지 등록" onclick="moveRegistInsLog()">
													<input class="move-list" type="button" value="시설물 목록으로" onclick="moveList()">
												</div>
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
</body>

<script>

function moveList() {
	location.href = "/facility";
}

function moveRegistInsLog() {
	location.href = "/inslog/form?facilityNo=${facility.no}";
}

$(document).ready(function() {
	drawAccessMap();
});
	function drawAccessMap() {
		$.ajax({
	        url: "${pageContext.request.contextPath}/facility/${facility.no}",
	        type: "get",
	        data: { },
	        headers: { "Content-Type" : "application/json" },
	        success: function() {
	        	var script = "";
	        	
				if ("${facility.uid}" != null) {
					script += "<div id='map' style='width:75%;height:450px;margin:auto;box-shadow: 0px 0px 15px 3px'></div>";					
		           $("#resource").html(script);
		           
		           var position = new naver.maps.LatLng(${facility.latitude}, ${facility.longitude});

			       	var mapOptions = {
			       		//지도 좌표
			           	center: position,
			           	zoom: 17
			       	};
			       	
			       	var contentString = [
			       	    '<div class="iw_inner">',
			       	  	'<h3>${facility.name}</h3>',
			       	    '</div>'
			       	].join('');
			       	
			       	var map = new naver.maps.Map(document.getElementById('map'), mapOptions);
			       	
			       	var marker = new naver.maps.Marker({
			       	    position: position,
			       	    map: map
			       	});
			       	
			       	var infowindow = new naver.maps.InfoWindow({
			       	    content: contentString
			       	});
			       	infowindow.open(map, marker);
			       	
			       	naver.maps.Event.addListener(marker, "click", function(e) {
			       		passive: true
			    	    if (infowindow.getMap()) {
			    	        infowindow.close();
			    	    } else {
			    	        infowindow.open(map, marker);
			    	    }
			    	});
				} else {
					script += "<h3>시설물의 정보가 존재하지 않습니다!</h3>";
					
					$("#resource").html(script);
				}
	        }
	    })
	};
</script>
</html>
<%@ include file="/WEB-INF/jsp/etc/footer.jsp" %>