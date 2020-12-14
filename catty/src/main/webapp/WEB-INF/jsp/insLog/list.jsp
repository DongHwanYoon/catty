<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
							<h3 class="ins-log-list-title">점검일지 목록</h3>
							<div class="col-md-5">
								<div class="map-inslog-list">
									<div id="resource"></div>
									<input type="button" class="button-move" value="시설물 목록" onclick="moveFacilityList()" style="float: left; margin-top: 30px; margin-right: 50px;"/>	
									<input type="button" class="button-move" value="점검일지 등록" onclick="moveInspectionRegist()" style="float: left; margin-top: 30px;"/>	
								</div>
							</div>
							<div class="col-md-7">
								<div class="ins-log-list" id="display"></div>
								<div class="row" style="margin-top: 35px;">
									<input type="button" class="button-search" id="btn" value="검색"/>
									<input type="text" class="text-search" id="term" name="term"/>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</body>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>

<script>

function moveFacilityList() {
	location.href="/facility";
}

function moveInspectionRegist() {
	location.href="/inslog/form";
}

$(document).ready(function() {
	ajax_call();
});

	document.getElementById('btn').addEventListener('click', ajax_call);
	
	function ajax_call() {
		var term = document.getElementById('term').value;
		
		$.ajax({
			url: "${pageContext.request.contextPath}/inslog",
			data: "term=" + term,
			type: "GET",
			headers: { "Content-Type" : "application/json" },
			success : function(rows){
				var html = "<table class='table table-hover'>";
				html += "	<th style='background-color: #DEDEDE'>";
				html += "시설물 명";
				html += "	</th>";
				html += "	<th style='background-color: #DEDEDE'>";
				html += "작성자";
				html += "	</th>";
				html += "	<th style='background-color: #DEDEDE'>";
				html += "마지막 수정 일자";
				html += "	</th>";
				html += "	<th style='background-color: #DEDEDE'>";
				html += "등록 일자";
				html += "	</th>";
				for (var i = 0 ; i < rows.inspectionLogList.length; i++) {
					html += "<tr onclick=\"location.href='${pageContext.request.contextPath}/inslog/"+rows.inspectionLogList[i].no+"'\" style='cursor:pointer;'>";
					html += "	<td id='facility-no-"+rows.inspectionLogList[i].no+"'>";
					html += rows.inspectionLogList[i].facilityNo;
					html += "	</td>";
					html += "	<td>";
					html += rows.memberList[i].id;
					html += "	</td>";
					html += "	<td>";
					html += rows.inspectionLogList[i].modifiedDate;
					html += "	</td>";
					html += "	<td>";
					html += rows.inspectionLogList[i].registrateDate;
					html += "	</td>";
					html += "</tr>";
				}
				html +="</table>";
				 $("#display").html(html);
				 
				 var facilityNo = 0;
				 for (var i = 0 ; i < rows.inspectionLogList.length; i++) {
					 facilityNo = $("#facility-no-"+rows.inspectionLogList[i].no).text();
					 for (var j = 0 ; j < rows.facilityList.length; j++) {
						 if (facilityNo == rows.facilityList[j].no) {
							 $("#facility-no-"+rows.inspectionLogList[i].no).text(rows.facilityList[j].name);
						 }
					 }
				 }
				 
				 var script = "";
		        	
					if (rows.inspectionLogList.length != null) {
						script += "<div id='map' style='width:500;height:470px;'></div>";
						
			           $("#resource").html(script);
			           
			           //위치
			           var positions = new Array();
			           
			           //마커에 들어갈 말풍선?
			           var contentStrings = new Array();
			           
			           //마커 객체
			           var markers = new Array();
			           
			       	   var infoWindows = new Array();
			           
			       		//지도 설정
				       	var mapOptions = {
				       		//처음 지도 좌표 는 첫번째 시설물로 설정
				           	zoom : 18,
				           	center : new naver.maps.LatLng(36.7991305, 127.0749043)
				       	};
			       	   
			           var map = new naver.maps.Map(document.getElementById('map'), mapOptions);
				       	
				    	function getClickHandler(seq) {
				       	    return function(e) {
				       	        var marker = markers[seq],
				       	            infoWindow = infoWindows[seq];
	
				       	        if (infoWindow.getMap()) {
				       	            infoWindow.close();
				       	        } else {
				       	            infoWindow.open(map, marker);
				       	        }
				       	    }
				       	}
			    	
				    	//마커 여러개 위해 for문
			           for (var i = 0 ; i < rows.facilityList.length; i++) {
			           		positions[i] = new naver.maps.LatLng(rows.facilityList[i].latitude, rows.facilityList[i].longitude);
			           		
			           		contentStrings[i] = [
					       	    '<div class="iw_inner">',
					       	  	'<h3>'+rows.facilityList[i].name+'</h3>',
					       	    '</div>'
					       	].join('');
			           		
			           		markers[i] = new naver.maps.Marker({
					       	    position : positions[i],
					       	    map: map
					       	});
			           		
			           		naver.maps.Event.addListener(markers[i], 'click', getClickHandler(i));	
			           		
			           		infoWindows[i] = new naver.maps.InfoWindow({
					       	    content : contentStrings[i]
					       	});
			           		
			           		infoWindows[i].open(map, markers[i]);
			           }
			           
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