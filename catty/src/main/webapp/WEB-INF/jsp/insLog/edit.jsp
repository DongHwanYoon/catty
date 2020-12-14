<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/etc/top.jsp" %>  
<!DOCTYPE html>
<html>
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
									<div class="edit">
										<form action="${pageContext.request.contextPath}/inslog" method="post" enctype="multipart/form-data" class="comment-form" id="editSubmit">
											<input type="hidden" name="_method" value="put"/>
											<input type="hidden" name="facilityNo" value="${facility.no}">
											<input type="hidden" name="no" value="${inspectionLog.no}">
											<input type="hidden" name="registrateDate" value="${inspectionLog.registrateDate}">
											<input type="hidden" name="modifiedDate" value="${inspectionLog.modifiedDate}">
											
											<textarea class="ins-log-note" id="note" name="note" placeholder="점검내용을 작성하세요">${inspectionLog.note}</textarea>
											<img class="image-preview" id="image" src="${pageContext.request.contextPath}/photo/inslog/${inspectionLog.no}" alt="점검일지 사진" >
											<div class="row">
												<input id="upload" type="file" name="attach" accept="image/jpg,image/jpeg,image/png" style="margin-left:30px;float:left"/>
											</div>
											<div class="row">
												<input type="button" class="button-move" id="button-moveList" onclick="moveInsLogList()" value="목록" style="margin-left:30px;margin-bottom:30px;float:left"/>
												<button class="button-submit" type="button" style="float:right;margin-bottom:30px;margin-right:30px;" onclick="inslogSubmit()">수정</button>
											</div>	
										</form>
											<div class="rows">
												<div class="buttons">
													<form action="${pageContext.request.contextPath}/inslog/${inspectionLog.no}" method="post" class="button-delete-form" >
														<input type="hidden" name="_method" value="delete" />
														<button class="button-submit" style="float:right" type="submit">삭제</button>	
													</form>
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
function inslogSubmit() {
	if (isNotInputNote()) {
		return null;
	} else {
		document.getElementById('editForm').submit();
	}
}

function isNotInputNote() {
	if ($('#note').val() == "") {
		alert('점검내용을 작성해 주세요.');
		return true;
	}
	return false;
}

function moveInsLogList() {
	location.href="/inslog";
}

function editSubmit() {
	document.getElementById("editForm").submit();
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

//사진 미리보기
var upload = document.querySelector('#upload');
var preview = document.querySelector('#image_preview');

var reader = new FileReader();

reader.onload = (function () {

	this.image = document.getElementById('image');
	var vm = this;
    
	return function (e) {
    	vm.image.src = e.target.result
	}
})()

//사진을 업로드하면 실행되는 이벤트리스너 추가
upload.addEventListener('change',function (e) {
    var get_file = e.target.files;

    if(get_file){
        reader.readAsDataURL(get_file[0]);
    }

    preview.appendChild(image);
})

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
					script += "<div id='map' class='map' style='width:350;height:350px;'></div>";
					
		           $("#resource").html(script);
		           
		           var position = new naver.maps.LatLng(${facility.latitude}, ${facility.longitude});

			       	var mapOptions = {
			       		//지도 좌표
			           	center: position,
			           	zoom: 18
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