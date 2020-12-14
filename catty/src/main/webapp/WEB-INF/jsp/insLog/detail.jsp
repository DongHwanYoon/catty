<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="post-item">
						<div class="ins-log">
						
							<div class="row">
								<div class="facility">
									<div class="facility-detail">
										<h3 class="facility-detail-title">시설물 정보</h3>
										<div class="col-md-8" >
											<div class="map" id="resource"></div>
											<div class="facility-info">
												<p id="facility-name" style="font-size: 24px;font-weight: 600" >${facility.name}</p>
												<p id="facility-type">${facility.type}</p>
												<p id="facility-status">${facility.status}</p>
											</div>
										</div>
										<div class="col-md-4" style="height: 380px">
											<form action="${pageContext.request.contextPath}/inslog/${inspectionLog.no}" method="post" class="button-delete-form" >
												<input type="hidden" name="_method" value="delete" />
												<button class="button-submit" type="submit">삭제</button>	
											</form>
										
											<form action="${pageContext.request.contextPath}/inslog/${inspectionLog.no}/form"  method="get" class="button-edit-form">
												<button class="button-submit" type="submit">수정</button>		
											</form>
											<div class="move-buttons">
												<input type="button" class="button-submit" id="button-moveList" onclick="moveInsLogList()" value="목록"/>
											</div>
										</div>
									</div>
								</div>
							</div>
							
							<div class="row">
								<div id="respond" class="comment-respond">
									<h3 class="ins-log-title">점검일지 정보</h3>
									<div class="row">
										<div class="col-md-12">
											<div class="ins-log-detail">
												<p>작성자 ID :	${member.id}</p>
												<p>등록일자  :	${inspectionLog.registrateDate}</p>
												<p class="post-date">
													<i class="fa fa-calender"></i>수정일자  :	${inspectionLog.modifiedDate}
												</p>
											</div>
										</div>
									</div>
									<div class="row">
										<form action="/inslog" method="post" enctype="multipart/form-data" class="comment-form">
											<input type="hidden" name="facilityNo" value="${facility.no}">
											<input type="hidden" name="registrateDate" value="${inspectionLog.registrateDate}">
											<input type="hidden" name="modifiedDate" value="${inspectionLog.modifiedDate}">
											<textarea class="ins-log-note" id="note" name="note" placeholder="점검내용을 작성하세요" required="required" disabled="disabled">${inspectionLog.note}</textarea>
											<div id="image"></div>
											<img class="image-preview" id="image_preview" src="http://localhost/photo/inslog/${inspectionLog.no}" alt="점검일지 사진">
										</form>
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
function moveInsLogList() {
	location.href="/inslog"
}

function checkImg() {
	if ($('#image_preview').attr('src') == '#') {
		$('#image_preview').attr('src', 'https://via.placeholder.com/251x251');
	}
}

function setFacilityInfo() {
	var facilityType = $("#facility-type");
	if (facilityType.text() == 'F') {
		facilityType.text('종류 : 급식소');
	} else if (facilityType.text() == 'H') {
		facilityType.text('종류 : 집');
	} else {
		facilityType.text('종류 : 쉼터');
	}
	
	var facilityStatus = $("#facility-status");
	if (facilityStatus.text() == 'O') {
		facilityStatus.text('상태 : 정상');
	} else if (facilityStatus.text() == 'X') {
		facilityStatus.text('상태 : 고장');
	} else {
		facilityStatus.text('상태 : 고장');
	}
}

$(document).ready(function() {
	drawAccessMap();
	setFacilityInfo();
});
	function drawAccessMap() {
		$.ajax({
	        url: "${pageContext.request.contextPath}/facility/${facility.no}",
	        type: "get",
	        data: { },
	        headers: { "Content-Type" : "application/json" },
	        success: function() {
	        	var script = "";
	        	
				if (${facility.uid} != null) {
					script += "<div class='map' id='map' style='width:350px;height:350px;'></div>";
					
		           $("#resource").html(script);
		           
		           var position = new naver.maps.LatLng(${facility.latitude}, ${facility.longitude});

			       	var mapOptions = {
			       		//지도 좌표
			           	center: position,
			           	zoom: 19
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