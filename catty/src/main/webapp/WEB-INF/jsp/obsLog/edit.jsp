<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<jsp:include page="/WEB-INF/jsp/etc/top.jsp" />
	<section class="main-content post-single" >
		<div class="container">
			<div class="row" >
				<div class="col-md-12 col-sm-12" >
					<form name="obsForm" action="${pageContext.request.contextPath}/obslog/${ row.obsLog.no }" method="post" enctype="multipart/form-data">
						<input hidden="true" type="text" name="memberNo" value="${sessionScope.no}" />
						<input type="hidden" name="_method" value="put" />
						<input type="hidden" name="no" value="${ row.obsLog.no }" />
						<div class="cat-detail-form">
							<div class="row">
								<h3 class="log-title">관찰일지 수정</h3>
								<div class="detail">
									<div class="row" >
										<div class="col-sm-3" >
											<div class="cat-image">
												<img id="cat-preview" onerror="" />
											</div>
										</div>
										<div class="col-sm-9" >
											<div class="col-md-12 col-sm-12" >
												<div class="col-sm-6">
													<div class="cat-desc">이름: <select id="selectCat" name="catNo" required >
															<option disabled>선택</option>
															<c:forEach var="cat" items="${ row.catList }" >
																<option value="${ cat.no }" <c:if test="${ row.obsLog.catNo == cat.no }" >selected</c:if>>${ cat.name }</option>
															</c:forEach>
														</select>
													</div>
													<div class="cat-desc" id="gender">성별:</div>
													<div class="cat-desc" id="spices">종:</div>
												</div>
												<div class="col-sm-6">
													<div class="cat-desc" id="birthDate">출생 연월:</div>
													<div class="cat-desc" id="tnrStatus">중성화 여부:</div>
													<div class="cat-desc" id="feature">특징:</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							
							<div class="row" >
								<div class="obs-detail-form">
									<div class="row">
										<div class="col-md-6 col-sm-6">
											<div id="image_preview" ><img id="image" src="${pageContext.request.contextPath}/photo/obslog/${ row.obsLog.no }" onerror="this.style.display='none'"/></div>
										</div>
										<div class="col-md-6 col-sm-6">
											<div class="note">
												<textarea id="note" name="note" placeholder="내용을 입력하세요..." required>${ row.obsLog.note }</textarea>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-6 col-sm-6">
											<input id="upload" type="file" name="attach" accept="image/jpg,image/jpeg,image/png" />
										</div>
										<div class="col-md-6 col-sm-6" align="right">
											<input class="common-btn" type="submit" value="수정" onclick="validationForm()">
										</div>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>
	
	<jsp:include page="/WEB-INF/jsp/etc/footer.jsp" />
		
</body>
<script>
	$(document).ready(function() {
		var sessionValid = "${sessionScope.no}" == "${ row.obsLog.memberNo }";
		var isAdmin = "${ sessionScope.isAdmin }";
		
		if (sessionValid || isAdmin) {
			renewCat(${row.obsLog.catNo});
		} else {
			window.alert("관찰일지 수정 권한이 없습니다!!");
			$(location).attr("href", "${pageContext.request.contextPath}/obslog");
			return;
		}
	});

	$("#selectCat").change(function() {
		var selectedCat = $("#selectCat option:selected").val();
		
		renewCat(selectedCat);
	});
	
	//사진 미리보기
    var upload = document.querySelector('#upload');
    var preview = document.querySelector('#image_preview');
 
    var reader = new FileReader();
 
    reader.onload = (function () {
 
    	this.image = document.createElement('img');
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
    
    function renewCat(no) {
		$.ajax({
	        url: "${pageContext.request.contextPath}/cat/" + no,
	        type: "get",
	        data: { },
	        headers: { "Content-Type" : "application/json;charset=UTF-8" },
	        success: function(rows) {
	        	var cat = rows.cat;
	        	
	        	$("#cat-preview").attr("src", "${pageContext.request.contextPath}/photo/cat/" + cat.no);
				if (cat.gender == "M") {
					$("#gender").html("성별: " + "<i class='fa fa-mars' ></i>");
				} else {
					$("#gender").html("성별: " + "<i class='fa fa-venus' ></i>");
				}
				$("#spices").html("종: " + cat.spices);
				$("#tnrStatus").html("중성화 여부: " + cat.tnrStatus);
				$("#feature").html("특징: " + cat.feature);
				var birthDate = cat.birthDate;
				if (birthDate) {
					$("#birthDate").html("출생 연월: " + cat.birthDate);
				} else {
					$("#birthDate").html("출생 연월: 알수 없음");
				}	
				
	        }
	    })
	};
	
	function validationForm() {
		var obsForm = document.obsForm;
		var selectCat = $('#selectCat').val();
		var obsImage = $('#upload').val();
		var note = $('#note').val();
		
		var sessionValid = "${sessionScope.no}" == "${ row.obsLog.memberNo }";
		var isAdmin = "${ sessionScope.isAdmin }";
		
		if (!sessionValid || !isAdmin) {
			window.alert("관찰일지 수정 권한이 없습니다!!");
			return;
		} else if (!selectCat) {
			window.alert("관찰한 고양이를 선택하세요!!");
			return;
		} else if (!note) {
			window.alert("내용을 입력하세요!!");
			return;
		} else {
			if (obsImage) {
				var ext = obsImage.split('.').pop().toLowerCase();
			
				if($.inArray(ext, ['gif','png','jpg','jpeg']) == -1) {
				 	alert('gif,png,jpg,jpeg 파일만 업로드 할수 있습니다!!');
	
				 return;
			    }
			}			
			
			obsForm.submit();
		}
	};
</script>
</body>
</html>