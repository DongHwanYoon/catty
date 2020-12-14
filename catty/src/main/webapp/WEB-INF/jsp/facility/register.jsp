<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>
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
						<div class="register">
							<div class="row">
								<div class="col-md-12">
									<form action="/facility" method="post" id="registerForm">
										<div class="row">
											<div class="col-md-12">
												<h3 class="title">
													시설물 등록
												</h3>
											</div>
										</div>
									
										<div class="row">
											<div class="col-md-12">
												<div class="detail">
													<p><label>이름 : </label><input id="input-name" type="text" name="name" title="특수문자는 입력이 불가능합니다." pattern="[가-힣a-zA-Z0-9]{1,100}" required/></p>
													<p><label>고유번호 : </label><input type="text" id="input-uid" name="uid" readonly="readonly" required>  <input type="button" class="button-renew-uid" value="갱신" onclick="renewUid()" style="margin-left: 20px;padding: 5px 15px"></p>
													<p><label>종류 :</label> <label style="margin-left: 30px">집</label><input type="radio" id="type" name="type" value="H" required/> <label>급식소</label> <input type="radio" id="type" name="type" value="F"/> <label>쉼터</label> <input type="radio" id="type" name="type" value="R"/></p>
													<p><label>위도 : </label><input type="text" name="latitude" id="latitude" readonly="readonly" required/></p>
													<p><label>경도 : </label><input type="text" name="longitude" id="longitude" readonly="readonly" required/></p>
												</div>
											</div>
										</div>
										
										<div class="row">
											<div class="col-md-12">
												<div class="map">
													<label style="margin-top: 30px;margin-left: 80px">지도를 클릭하여 시설물의 위치를 선택해 주세요.</label><br>
													<div id="resource" style="margin-top: 30px;margin-bottom: 60px"></div><br>
												</div>
											</div>
										</div>
										
										<div class="row">
											<div class="col-md-12">
												<div class="optional">
													<p class="select-member-desc">회원 목록에서 담당자를 선택해 주세요</p>
													<select multiple class="select-member" name="fromBox" id="fromBox">
														<optgroup style="background-color: #dedede; font-size:20px" label="회원 목록">
															<c:forEach items="${memberList}" var="member">
																<option style="background-color: white; font-size:14px" value="${member.no}">${member.id}</option>
															</c:forEach>
														</optgroup>
													</select>
													<select multiple class="select-manager" name="toBox" id="toBox">
														<optgroup style="background-color: #dedede; font-size:20px" label="담당자">
														</optgroup>
													</select><br><br>
													
													<div class="foodBarrel" id="foodBarrel">
														<input class="button-feedBarrel-add" id="button_addFeedBarrel" type="button" value="+ 사료통 추가" >
														<input class="button-feedBarrel-delete" id="button_removeFeedBarrel" type="button" value="- 사료통 제거">
														
														<input class="button-waterBarrel-add" id="button_addWaterBarrel" type="button" value="+ 물통 추가">
														<input class="button-waterBarrel-delete" id="button_removeWaterBarrel" type="button" value="- 물통 제거"><br>
														<div class="feedBarrel" id="feedBarrel"></div> <div class="waterBarrel" id="waterBarrel"> </div>
													</div>
													<div id="managementFacility"></div>
													<div id="feed"></div>
													<div id="water"></div>
												</div>
											</div>
										</div>
										
										<div class="row">
											<div class="col-md-12">
												<div class="buttons">
													<input class="button-move-list" type="button" value="목록" onclick="moveList()"> <input class="button-submit" type="button" value="등록" onclick="addManagementFacilityAndSubmit()"/>
												</div>
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
</body>
<script>

function isNotInputFacilityDetail() {
	var uid = $('#input-uid').val();
	var name = $('#input-name').val();
	var latitude = $('#latitude').val();
	var longitude = $('#longitude').val();
	var type = $("input[name='type']:checked").val();
	
	if (uid == "" || uid == null || typeof uid == 'undefined') {
		alert('고유번호를 갱신해 주세요.')
		return true;
	} else if (name == "" || name == null || typeof name == 'undefined') {
		alert('시설물의 이름을 입력해 주세요.')
		return true;
	} else if (latitude == "" || latitude == null || typeof latitude == 'undefined') {
		alert('시설물의 위치를 지도에서 선택해주세요.')
		return true;
	} else if (longitude == "" || longitude == null || typeof longitude == 'undefined') {
		alert('시설물의 위치를 지도에서 선택해주세요.')
		return true;
	} else if (type == "" || type == null || typeof type == 'undefined') {
		alert('시설물의 종류를 선택해주세요.')
		return true;
	}
}

function renewUid() {
	$('#input-uid').val("${tempFacility.uid}");
}

function checkFacilityName() {
	var replaceId  = /[<>()!@#$%^&*_+=,.`~-]/gi;

    $("#input-name").on("focusout", function() {
        var x = $(this).val();
        if (x.length > 0) {
            if (x.match(replaceId)) {
               x = x.replace(replaceId, "");
            }
            $(this).val(x);
        }
    }).on("keyup", function() {
        $(this).val($(this).val().replace(replaceId, ""));
    });
}

function setUid() {
	$("#uid").val("${tempFacility.uid}");
}

function moveList() {
	location.href = "/facility";
}

var feedBarrelCount = 0;
var waterBarrelCount = 0;

function addManagementFacilityAndSubmit() {
	if (isNotInputFacilityDetail()) {
		return null;
	}
	
	var script = [""];
	var feedScript = [""];
	var waterScript = [""];
	
	for (var i = 0 ; i < $("#toBox option").length ; i++) {
		script[i] = "<input type='hidden' name='managementFacilityList["+i+"].memberNo' value='"+$("#toBox option:eq("+i+")").val()+"'/>"
	}
	
	for (var i = 0 ; i < feedBarrelCount ; i++) {
		feedScript[i] = "<input type='hidden' name='feedBarrelList["+i+"].no' value='"+(i+1)+"'/>"
	}
	
	for (var i = 0 ; i < waterBarrelCount ; i++) {
		waterScript[i] = "<input type='hidden' name='waterBarrelList["+i+"].no' value='"+(i+1)+"'/>"
	}
	
	$("#managementFacility").html(script);
	$("#feed").html(feedScript);
	$("#water").html(waterScript);
	document.getElementById("registerForm").submit();
}

$(document).ready(function(){
	drawAccessMap();
	setUid();
	checkFacilityName();
	
	$('input[name=type]').change(function() {
		var checkedRadioVal = $('input[name=type]:checked').val();
	
		if (checkedRadioVal == "F") {
			$("#foodBarrel").show();
		} else {
			$("#foodBarrel").hide();
		}
	});
	
    $("#fromBox").change(function() {
        var selectedId = $("#fromBox option:selected").text();
        var selectedNo = $("#fromBox option:selected").val();
        var index = $("#fromBox option").index($("#fromBox option:selected"));
        
        if ($("#toBox option").length <= 2) {
	        $("#toBox").append("<option style='background-color: white; margin-left: 20px; font-size:14px; ' value='"+selectedNo+"'>"+selectedId+"</option>");
	        $("#fromBox option:eq("+index+")").remove();
        }
    });
    
    $("#toBox").change(function() {
        var selectedId = $("#toBox option:selected").text();
        var selectedNo = $("#toBox option:selected").val();
        var index = $("#toBox option").index($("#toBox option:selected"));
        $("#fromBox").append("<option style='margin-left: 20px' value='"+selectedNo+"'>"+selectedId+"</option>");
        $("#toBox option:eq("+index+")").remove();
        
    });
    
});

function removeTag( str ) {
	return str.replace(/(<([^>]+)>)/gi, "");
}

	var feedBarrelScript = [""];
	$("#button_addFeedBarrel").click(function() {
		if (feedBarrelCount <= 2) {
			feedBarrelScript[feedBarrelCount] = "<label style='margin-left: 25px' class=feedBarrelLabel_"+feedBarrelCount+">"+(feedBarrelCount+1)+"번 사료통 : <select class=feedBarrel_"+feedBarrelCount+" name='feedBarrelList["+feedBarrelCount+"].standard'>"+
			"<option value=500> 500 ml</option>"+
			"<option value=1000>1000 ml</option>"+
			"<option value=1500>1500 ml</option>"+
			"<option value=2000>2000 ml</option>"+
			"</select></label><br>"
			feedBarrelCount++;
			$("#feedBarrel").html(feedBarrelScript);
		}
	});
	
	$("#button_removeFeedBarrel").click(function() {
		if (feedBarrelCount >= 1) {
			feedBarrelCount--;
			$('select').remove('.feedBarrel_'+feedBarrelCount);	
			$('label').remove('.feedBarrelLabel_'+feedBarrelCount);
			feedBarrelScript[feedBarrelCount] = "";
		}
	});
	
	var waterBarrelScript = [""];
	$("#button_addWaterBarrel").click(function() {
		if (waterBarrelCount <= 2) {
			waterBarrelScript[waterBarrelCount] = "<label style='margin-left: 25px' class=waterBarrelLabel_"+waterBarrelCount+">"+(waterBarrelCount+1)+"번 물통 : <select class=waterBarrel_"+waterBarrelCount+"  name='waterBarrelList["+waterBarrelCount+"].standard'>"+
				"<option value=500> 500 ml</option>"+
				"<option value=1000>1000 ml</option>"+
				"<option value=1500>1500 ml</option>"+
				"<option value=2000>2000 ml</option>"+
				"</select></label><br>"
				waterBarrelCount++;
			$("#waterBarrel").html(waterBarrelScript);
		}
	});
	
	$("#button_removeWaterBarrel").click(function() {
		if (waterBarrelCount >= 1) {
			waterBarrelCount--;
			$('select').remove('.waterBarrel_'+waterBarrelCount);	
			$('label').remove('.waterBarrelLabel_'+waterBarrelCount);
			waterBarrelScript[waterBarrelCount] = "";
		}
	});
	
	function drawAccessMap() {
		var script = "";
		$.ajax({
	        url: "${pageContext.request.contextPath}/facility",
	        type: "get",
	        data: "term=" + "",
	        headers: { "Content-Type" : "application/json" },

	        success: function(rows) {
				script += "<div id='map' style='width:75%;height:450px;margin:auto;box-shadow: 0px 0px 15px 3px'></div>";
		        $("#resource").html(script);
	        	
				var position =  new naver.maps.LatLng(36.7991305, 127.0749043);
		
	        	var mapOptions = {
				    zoom: 18,
				    center: position
				};
			
				var map = new naver.maps.Map('map', mapOptions);
				
				//마커 미리 생성
				var marker = new naver.maps.Marker({});
				
				//마커 위치 클릭시 변경
				var listener = naver.maps.Event.addListener(map, 'click', function(e) {
					marker.setMap(map);
				    marker.setPosition(e.coord);
				    $("#latitude").val(e.coord.lat());
				    $("#longitude").val(e.coord.lng());
				});
	        }
	    })
	};
</script>
</html>
<%@ include file="/WEB-INF/jsp/etc/footer.jsp" %>