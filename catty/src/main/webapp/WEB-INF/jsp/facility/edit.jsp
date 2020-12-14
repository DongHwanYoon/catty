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
									<form id="editForm" action="/facility" method="post">
										<input type="hidden" name="_method" value="put"/>
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
														<p><label>이름 : </label><input id="input-name" value="${facility.name}" type="text" name="name" title="특수문자는 입력이 불가능합니다." pattern="[가-힣a-zA-Z0-9]{1,100}" required/></p>
														<p><label>고유번호 : </label><input type="text" value="${facility.uid}" id="input-uid" name="uid" value="${tempFacility.uid}" readonly="readonly" required></p>
														<p><label>종류 :</label> <label style="margin-left: 30px">집</label><input type="radio" id="type-h" name="type" value="H" required/> <label>급식소</label> <input type="radio" id="type-f" name="type" value="F"/> <label>쉼터</label> <input type="radio" id="type-r" name="type" value="R"/></p>
														<p><label>위도 : </label><input type="text" value="${facility.latitude}" name="latitude" id="latitude" readonly="readonly" required/></p>
														<p><label>경도 : </label><input type="text" value="${facility.longitude}" name="longitude" id="longitude" readonly="readonly" required/></p>
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
													<select class="select-member" multiple name="fromBox" id="fromBox">
														<optgroup style="background-color: #dedede; font-size:20px" label="담당 가능한 회원목록">
															<c:forEach items="${memberList}" var="member">
																<option style='background-color: white; font-size:14px;' value="${member.no}">${member.id}</option>
															</c:forEach>
														</optgroup>
													</select>
													
													<select class="select-manager" multiple name="toBox" id="toBox">
														<optgroup style="background-color: #dedede; font-size:20px" label="시설물 담당자 목록">
															<c:forEach items="${managerList}" var="member">
																<option style='background-color: white; font-size:14px;' value="${member.no}">${member.id}</option>
															</c:forEach>
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
												</div>
											</div>
										</div>
										
										<div class="row">
											<div class="col-md-12">
												<div class="buttons">
													<input class="button-move-list" type="button" value="목록으로" onclick="moveList()">
													<input class="button-submit" type="button" value="수정" onclick="editSubmit()"/>
												</div>
											</div>
										</div>
										
										<div id="managementFacility"></div>
										<c:forEach var="i" begin="0" end="3">
											<c:choose> 
												<c:when test="${feedBarrelList[i].no ne null}">
													<input type="hidden" value="${feedBarrelList[i].no}" id="feedBarrelNo_${i}" />
													<input type="hidden" value="${feedBarrelList[i].standard}" id="feedBarrelStandard_${i}" />	
												</c:when>
												
												<c:when test="${feedBarrelList[i].no eq null}">
													<input type="hidden" value="${feedBarrelList[fn:length(feedBarrelList)].no+i+1}" id="feedBarrelNo_${i}"/>
													<input type="hidden" value="500" id="feedBarrelStandard_${i}" />	
												</c:when>
											</c:choose>
											
											<c:choose> 
												<c:when test="${waterBarrelList[i].no ne null}">
													<input type="hidden" value="${waterBarrelList[i].no}" id="waterBarrelNo_${i}"/>
													<input type="hidden" value="${waterBarrelList[i].standard}" id="waterBarrelStandard_${i}" />
												</c:when>
												
												<c:when test="${waterBarrelList[i].no eq null}">
													<input type="hidden" value="${waterBarrelList[fn:length(waterBarrelList)].no+i+1}" id="waterBarrelNo_${i}" />
													<input type="hidden" value="500" id="waterBarrelStandard_${i}" />
												</c:when>
											</c:choose>
										</c:forEach>
										<input type="hidden" name="no" value="${facility.no}">
										<input type="hidden" name="status" value="${facility.status}">
										<div id="feed"></div>
										<div id="water"></div>
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
function moveList() {
	location.href = "/facility";
}

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

function checkedFacilityType() {
	var type = "${facility.type}"
	if (type == "F") {
		$("#type-f").prop("checked", true);
	} else if (type == "H") {
		$("#type-h").prop("checked", true);
	} else {
		$("#type-r").prop("checked", true);
	}
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

var feedBarrelScript = [""];
var feedBarrelCount = ${fn:length(feedBarrelList)};
var waterBarrelScript = [""];
var waterBarrelCount = ${fn:length(waterBarrelList)};

function editSubmit() {
	if (isNotInputFacilityDetail()) {
		return null;
	}
	
	var managerScript = [""];
	var managerCount = 0;
	for (var i = 0 ; i < $("#toBox option").length ; i++) {
		managerScript[i] = "<input type='hidden' name='managementFacilityList["+i+"].memberNo' value='-"+$("#toBox option:eq("+i+")").val()+"'/>"
		managerScript[i] += "<input type='hidden' name='managementFacilityList["+i+"].facilityNo' value='${facility.no}'/>"
		managerCount++;
	}

	for (var i = 0 ; i < $("#fromBox option").length ; i++) {
		var j = i + managerCount;
		managerScript[j] += "<input type='hidden' name='managementFacilityList["+j+"].memberNo' value='"+$("#fromBox option:eq("+i+")").val()+"'/>"
		managerScript[j] += "<input type='hidden' name='managementFacilityList["+j+"].facilityNo' value='${facility.no}'/>"
	}
	
	var feedScript = [""];
	var waterScript = [""];
	for (var i = 0 ; i < feedBarrelCount ; i++) {
		feedScript[i] = "<input type='hidden' name='feedBarrelList["+i+"].no' value='"+$("#feedBarrelNo_"+i).val()+"'/>"
		feedScript[i] += "<input type='hidden' name='feedBarrelList["+i+"].facilityNo' value='${facility.no}'/>"
		feedScript[i] += "<input type='hidden' name='feedBarrelList["+i+"].standard' value='"+$("#feedBarrelStandard_"+i).val()+"'/>"
	}
	
	for (var i = 0 ; i < waterBarrelCount ; i++) {
		waterScript[i] = "<input type='hidden' name='waterBarrelList["+i+"].no' value='"+$("#waterBarrelNo_"+i).val()+"'/>"
		waterScript[i] += "<input type='hidden' name='waterBarrelList["+i+"].facilityNo' value='${facility.no}'/>"
		waterScript[i] += "<input type='hidden' name='waterBarrelList["+i+"].standard' value='"+$("#waterBarrelStandard_"+i).val()+"'/>"
	}
	
		$("#managementFacility").html(managerScript);
		$("#feed").html(feedScript);
		$("#water").html(waterScript);
		document.getElementById("editForm").submit();
}

function getFeedBarrel() {
	for (var i = 0 ; i < feedBarrelCount ; i++) {
		feedBarrelScript[i] = "<label style='margin-left: 20px;' class=feedBarrelLabel_"+i+">"+$("#feedBarrelNo_"+i).val()+"번 사료통 : </label><select class=feedBarrel_"+i+" name='feedBarrelList["+i+"].standard'>"+
		"<option value=500>500 ml</option>"+
		"<option value=1000>1000 ml</option>"+
		"<option value=1500>1500 ml</option>"+
		"<option value=2000>2000 ml</option>"+
		"</select><br>";
		$("#feedBarrel").html(feedBarrelScript);
	}
	
	setFeedBarrel();
}

function setFeedBarrel() {
	for (var i = 0 ; i < feedBarrelCount ; i++) {
		var standard = $("#feedBarrelStandard_"+(i)).val();
		if (standard == "500") {
			$(".feedBarrel_"+i+" option:eq(0)").prop("selected", true);
		} else if (standard == "1000") {
			$(".feedBarrel_"+i+" option:eq(1)").prop("selected", true);
		} else if (standard == "1500") {
			$(".feedBarrel_"+i+" option:eq(2)").prop("selected", true);
		} else if (standard == "2000"){
			$(".feedBarrel_"+i+" option:eq(3)").prop("selected", true);
		} else {
			$(".feedBarrel_"+i+" option:eq(0)").prop("selected", true);
		}
	}
}

function getWaterBarrel() {
	for (var i = 0 ; i < waterBarrelCount ; i++) {
		waterBarrelScript[i] = "<label style='margin-left: 20px;' class=waterBarrelLabel_"+i+">"+$("#waterBarrelNo_"+i).val()+"번 물통 : </label><select class=waterBarrel_"+i+" name='waterBarrelList["+i+"].standard'>"+
		"<option value=500>500 ml</option>"+
		"<option value=1000>1000 ml</option>"+
		"<option value=1500>1500 ml</option>"+
		"<option value=2000>2000 ml</option>"+
		"</select><br>";
		$("#waterBarrel").html(waterBarrelScript);
	}
	
	setWaterBarrel();
}

function setWaterBarrel() {
	for (var i = 0 ; i < waterBarrelCount ; i++) {
		var standard = $("#waterBarrelStandard_"+(i)).val();
		if (standard == "500") {
			$(".waterBarrel_"+i+" option:eq(0)").prop("selected", true);
		} else if (standard == "1000") {
			$(".waterBarrel_"+i+" option:eq(1)").prop("selected", true);
		} else if (standard == "1500") {
			$(".waterBarrel_"+i+" option:eq(2)").prop("selected", true);
		} else if (standard == "2000"){
			$(".waterBarrel_"+i+" option:eq(3)").prop("selected", true);
		} else {
			$(".waterBarrel_"+i+" option:eq(0)").prop("selected", true);
		}
	}
}

$(document).ready(function(){
	drawAccessMap();
	getFeedBarrel();
	getWaterBarrel();
	checkFacilityName();
	checkedFacilityType();
	
	$('input[name=type]').change(function() {
		var checkedRadioVal = $('input[name=type]:checked').val();
	
		if (checkedRadioVal == "F") {
			$("#foodBarrel").show();
		} else {
			feedBarrelCount = 0;
			waterBarrelCount = 0;
			for (var i = 0 ; i < 3 ; i++) {
				$('select').remove('.feedBarrel_'+i);	
				$('label').remove('.feedBarrelLabel_'+i);
				$('select').remove('.waterBarrel_'+i);	
				$('label').remove('.waterBarrelLabel_'+i);
				feedBarrelScript[i] = "";
				waterBarrelScript[i] = "";
			}
			$("#foodBarrel").hide();
		}
	});
	
    $("#fromBox").change(function() {
        var selectedId = $("#fromBox option:selected").text();
        var selectedNo = $("#fromBox option:selected").val();
        var index = $("#fromBox option").index($("#fromBox option:selected"));
        
        if ($("#toBox option").length <= 2) {
	        $("#toBox").append("<option style='background-color: white; margin-left: 20px; font-size:14px;' value='"+selectedNo+"'>"+selectedId+"</option>");
	        $("#fromBox option:eq("+index+")").remove();
        }
    });
    
    $("#toBox").change(function() {
        var selectedId = $("#toBox option:selected").text();
        var selectedNo = $("#toBox option:selected").val();
        var index = $("#toBox option").index($("#toBox option:selected"));
        $("#fromBox").append("<option style='background-color: white; margin-left: 20px; font-size:14px;' value='"+selectedNo+"'>"+selectedId+"</option>");
        $("#toBox option:eq("+index+")").remove();
        
    });
    
    ////////////////////////////////////////////////////////////////

	$("#button_addFeedBarrel").click(function() {
		if (feedBarrelCount <= 2) {
			feedBarrelScript[feedBarrelCount] = "<label style='margin-left: 25px' class=feedBarrelLabel_"+feedBarrelCount+">"+$("#feedBarrelNo_"+feedBarrelCount).val()+"번 사료통 : </label><select class=feedBarrel_"+feedBarrelCount+" name='feedBarrelList["+feedBarrelCount+"].standard'>"+
			"<option value=500> 500 ml</option>"+
			"<option value=1000>1000 ml</option>"+
			"<option value=1500>1500 ml</option>"+
			"<option value=2000>2000 ml</option>"+
			"</select><br>";
			feedBarrelCount++;
			$("#feedBarrel").html(feedBarrelScript);
		}
		setFeedBarrel();
	});
	
	$("#button_removeFeedBarrel").click(function() {
		if (feedBarrelCount >= 1) {
			feedBarrelCount--;
			$('select').remove('.feedBarrel_'+feedBarrelCount);	
			$('label').remove('.feedBarrelLabel_'+feedBarrelCount);
			feedBarrelScript[feedBarrelCount] = "";
		}
	});
	
	$("#button_addWaterBarrel").click(function() {
		if (waterBarrelCount <= 2) {
			waterBarrelScript[waterBarrelCount] = "<label style='margin-left: 25px' class=waterBarrelLabel_"+waterBarrelCount+">"+$("#waterBarrelNo_"+waterBarrelCount).val()+"번 물통 : <select class=waterBarrel_"+waterBarrelCount+"  name='waterBarrelList["+waterBarrelCount+"].standard'>"+
				"<option value=500> 500 ml</option>"+
				"<option value=1000>1000 ml</option>"+
				"<option value=1500>1500 ml</option>"+
				"<option value=2000>2000 ml</option>"+
				"</select><br>";
				waterBarrelCount++;
			$("#waterBarrel").html(waterBarrelScript);
		}
		setWaterBarrel();
	});
	
	$("#button_removeWaterBarrel").click(function() {
		if (waterBarrelCount >= 1) {
			waterBarrelCount--;
			$('select').remove('.waterBarrel_'+ waterBarrelCount);	
			$('label').remove('.waterBarrelLabel_'+ waterBarrelCount);
			waterBarrelScript[waterBarrelCount] = "";
		}
	});
});

function removeTag( str ) {
	return str.replace(/(<([^>]+)>)/gi, "");
}

	function drawAccessMap() {
		var script = "";
		$.ajax({
	        url: "${pageContext.request.contextPath}/facility/${facilityNo}",
	        type: "get",
	        data: "facilityNo=${facilityNo}",
	        headers: { "Content-Type" : "application/json" },

	        success: function() {
				script += "<div id='map' style='width:75%;height:450px;margin:auto;box-shadow: 0px 0px 15px 3px'></div>";
		        $("#resource").html(script);
	        	
				var position =  new naver.maps.LatLng(${facility.latitude}, ${facility.longitude});
		
	        	var mapOptions = {
				    zoom: 18,
				    center: position
				};
			
				var map = new naver.maps.Map('map', mapOptions);
				
				//마커 미리 생성
				var marker = new naver.maps.Marker({
					map: map,
					position: position
				});
				
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