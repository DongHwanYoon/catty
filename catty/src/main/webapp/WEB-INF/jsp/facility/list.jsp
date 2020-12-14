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
</head>
<body>
	<section class="main-content post-single">
		<div class="container" >
			<div class="col-md-12">
				<div class="post-item">
					<div class="facility">
						<div class="list">
							<div class="row">
								<div class="col-md-12">
									<h3 class="title">시설물 목록</h3>
								</div>
								<div class="col-md-7">
									<div class="map">
										<div id="resource"></div>
									</div>
								</div>
								
								<div class="col-md-5">
									<div class="table-list">
										<div id="display"></div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12">
									<div class="buttons">
										<div class="row">
											<input class="button-search" type="button" id="btn" value="검색" style="float:right;margin-right:50px;margin-left:35px"/>
											<input class="text-search" placeholder="검색어를 입력하세요" type="text" id="term" name="term" style="float:right"/>
											<input class="button-move" type="button" value="점검일지 목록" onclick="moveInsLogList()" style="float:left;margin-left: 55px;"/>
											<input class="button-move" type="button" value="시설물 등록" onclick="moveRegistFacility()" style="float:left;margin-left: 50px;"/>
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
function moveRegistFacility() {
	location.href="facility/form"
}

function moveInsLogList() {
	location.href="inslog"
}

function setSupplementStatus() {
	if ($('supplement-status').text() == "undefined") {
		$('supplement-status').text("-");
	}
}

$(document).ready(function() {
	ajax_call();
});


	document.getElementById('btn').addEventListener('click', ajax_call);
	
	function ajax_call() {
		var term = document.getElementById('term').value;
		$.ajax({
			url: "${pageContext.request.contextPath}/facility",
			data: "term=" + term,
			type: "GET",
			headers: { "Content-Type" : "application/json" },
			success : function(rows){
				var html = "<table class='table table-hover'>";
				html += "	<th style='background-color: #DEDEDE'>";
				html += "시설물 명";
				html += "	</th>";
				html += "	<th style='background-color: #DEDEDE;text-align: center'>";
				html += "사료 보충 필요 여부";
				html += "	</th>";
				html += "	<th style='background-color: #DEDEDE'>";
				html += "종류";
				html += "	</th>";
				
				for (var i = 0 ; i < rows.facilityList.length; i++) {
					var j = i + 1;
					html += "<tr onclick=\"location.href='${pageContext.request.contextPath}/facility/"+rows.facilityList[i].no+"'\" style='cursor:pointer;'>";
					html += "	<td>";
					html += rows.facilityList[i].name;
					html += "	</td>";
					
					var supplement = rows[i];
					if (typeof supplement == "undefined") {
						html += "	<td style='color:nomal;font-size:18px;text-align: center'>";
						supplement = "-";
					} else if (supplement == "X") {
						html += "	<td style='color: #00B915;font-size:18px;text-align: center'>";
						supplement = "●";
					} else if (supplement == "O") {
						html += "	<td style='color:red;font-size:18px;text-align: center'>";
						supplement = "●";
					}
					html += supplement;
					html += "	</td>";
					
					var type = rows.facilityList[i].type;
					if (type == "F") {
						type = "급식소";
					} else if (type == "H") {
						type = "집";
					} else {
						type = "쉼터";
					}
					html += "	<td>";
					html += type;
					html += "	</td>";
					html += "</tr>";
				}
				
				html +="</table>";
				 $("#display").html(html);
				 
				/*  여기부터 지도  */
				 
				 var script = "";
		        	
					if (rows.facilityList.length != null) {
						script += "<div id='map' style='width:85%;height:400px;margin:auto'></div>";
						
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
			           		positions[i] =  new naver.maps.LatLng(rows.facilityList[i].latitude, rows.facilityList[i].longitude);
			           		
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