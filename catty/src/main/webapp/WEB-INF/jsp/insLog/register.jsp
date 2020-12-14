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
										<div class="col-md-10" >
											<div class="map" id="resource"></div>
											<div class="facility-info">
												<div class="cat-desc">
													이름: <select id="selectFacility" name="facilityName" required >
															<option disabled selected >선택</option>
															<c:forEach var="facility" items="${ facilityList }" >
																<option id="facility-name" value="${ facility.no }">${ facility.name }</option>
															</c:forEach>
														</select>
												</div>
												<p id="facility-type"></p>
												<p id="facility-status"></p>
											</div>
										</div>
										<div class="col-md-2">
											<input type="button" class="button-move" id="button-moveFacilityDetail" onclick="moveFacilityDetail()" value="시설물 상세정보" style="margin-top: 300px">
											<input type="button" class="button-move" id="button-moveList" onclick="moveList()" value="점검일지 목록">
										</div>
									</div>
								</div>
							</div>
							<form action="/inslog" method="post" enctype="multipart/form-data" class="comment-form" id="registerForm">
								<div id="respond" class="comment-respond">
									<div class="row">
										<h3 class="ins-log-title">점검일지 정보</h3>
											<input type="hidden" id="facility-no" name="facilityNo">
											<input type="hidden" id="registrateDate" name="registrateDate">
											<input type="hidden" id="modifiedDate" name="modifiedDate">
											<textarea class="ins-log-note" id="note" name="note" placeholder="점검내용을 작성하세요" style="margin-top: 70px;"></textarea>
											<div id="image"></div>
											<img class="image-preview" id="image_preview" src="https://via.placeholder.com/251x251" alt="점검일지 사진">
										
									</div>
									<div class="row">
										<input id="upload" type="file" name="attach" accept="image/jpg,image/jpeg,image/png" style="float:left;"/>
										<input type="button" class="button-move" value="등록" onclick="inslogSubmit()" style="float:right; margin-right: 20px; margin-bottom:0px">
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>	
</body>
<script>
function inslogSubmit() {
	if (isNotSelected() || isNotInputNote()) {
		return null;
	} else {
		document.getElementById('registerForm').submit();
	}
}

function isNotSelected() {
	if ($('#selectFacility option:selected').val() == '선택') {
		alert('시설물을 선택해 주세요.');
		return true;
	}
	return false;
}

function isNotInputNote() {
	if ($('#note').val() == "") {
		alert('점검내용을 작성해 주세요.');
		return true;
	}
	return false;
}

function moveFacilityDetail() {
	location.href="/facility/"+$("#facility-no").val();
}

function moveList() {
	location.href="/inslog";
}

var upload = document.querySelector('#upload');
var preview = document.querySelector('#image');

var reader = new FileReader();

reader.onload = (function () {

	this.image = document.getElementById('image_preview');
	var vm = this;
    
	return function (e) {
    	vm.image.src = e.target.result
	}
})()

upload.addEventListener('change',function (e) {
     var get_file = e.target.files;

     if(get_file){
         reader.readAsDataURL(get_file[0]);
     }

     preview.appendChild(image);
 })
 
function setFacilityInfo() {
	var facilityType = $("#facility-type");
	var facilityStatus = $("#facility-status");
	
	if (facilityType.text() == 'F') {
		facilityType.text('종류 : 급식소');
	} else if (facilityType.text() == 'H') {
		facilityType.text('종류 : 집');
	} else {
		facilityType.text('종류 : 쉼터');
	}
	
	if (facilityStatus.text() == 'O') {
		facilityStatus.text('상태 : 정상');
	} else if (facilityStatus.text() == 'X') {
		facilityStatus.text('상태 : 고장');
	} else {
		facilityStatus.text('상태 : 고장');
	}
}


var facilityLatitude;
var facilityLongitude;
var facilityName;
var facilityUid;

$("#selectFacility").change(function() {
	var selectedFacility = $("#selectFacility option:selected").val();
	
	renewFacility(selectedFacility);
	
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
	        	
				if (facilityUid != null) {
					script += "<div class='map' id='map' style='width:350px;height:350px;'></div>";
					
		           $("#resource").html(script);
		       		
		           var position = new naver.maps.LatLng(facilityLatitude, facilityLongitude);

			       	var mapOptions = {
			       		//지도 좌표
			           	center: position,
			           	zoom: 19
			       	};
			       	
			       	var contentString = [
			       	    '<div class="iw_inner">',
			       	  	'<h3>'+facilityName+'</h3>',
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
					script += "<div class='ins-log-map-title'><h3>시설물의 정보가 존재하지 않습니다!</h3></div>";
					
					$("#resource").html(script);
				}
	        }
	    })
	};
	
	function renewFacility(no) {
		$.ajax({
	        url: "${pageContext.request.contextPath}/facility/" + no,
	        type: "get",
	        data: { },
	        headers: { "Content-Type" : "application/json" },
	        success: function(rows) {
	        	var facility = rows.facility;
	        	facilityUid = facility.uid;
	        	facilityLatitude = facility.latitude
	        	facilityLongitude = facility.longitude
	        	facilityName = facility.name
	        	
	        	$("#facility-no").val(facility.no);
	        	$("#facility-type").text(facility.type);
	        	$("#facility-status").text(facility.status);
	        	
	        	setFacilityInfo();
	        }
	    })
	};
</script>

</html>
<%@ include file="/WEB-INF/jsp/etc/footer.jsp" %>