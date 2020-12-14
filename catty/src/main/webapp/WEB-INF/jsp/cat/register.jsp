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
				<form name="catForm" action="${pageContext.request.contextPath}/cat" method="post" enctype="multipart/form-data">
					<div class="col-md-12 col-sm-12" >
						<div class="cat-detail-form">
							<div class="row">
								<div class="col-sm-6" >
									<div class="cat-desc"><label for="tagId">태그 아이디:</label>
										<input id="tag_Id" type="text" name="tagId" readonly="readonly" required />
										<input id="button_renew" type="button" value="갱신" />
									</div>
								</div>
								<div class="col-sm-6" align="left">
									<div class="cat-msg" id="tag"></div>
								</div>
							</div>
							<div class="row">
								<div class="detail">
									<div class="row" >
										<div class="col-md-12 col-sm-12" >
											<div class="col-sm-3" >
												<div class="row">
													<div class="cat-image" id="image_preview" ></div>
												</div>
												<div class="row">
													<input id="upload" type="file" name="attach" accept="image/jpg,image/jpeg,image/png" required />
												</div>
											</div>
											<div class="col-sm-9" >
												<div class="col-md-12 col-sm-12" >
													<div class="col-sm-6">
														<div class="cat-desc"><label for="name">이름: </label><input id="name" type="text" name="name" required /></div>
														<div class="cat-desc"><label for="gender">성별: </label> 
															<select name="gender" required>
																<option value="M" selected>수컷</option>
																<option value="F">암컷</option>
															</select>
														</div>
														<div class="cat-desc"><label for="spices">종: </label><input type="text" name="spices" /></div>
													</div>
													<div class="col-sm-6">
														<div class="cat-desc"><label for="birthDate">출생 연월: </label><input type="date" name="birthDate" /></div>
														<div class="cat-desc" ><label for="tnrStatus">중성화 여부: </label>
															<select name="tnrStatus" required>
																<option value="Y" selected>예</option>
																<option value="N">아니오</option>
															</select>
														</div>
														<div class="cat-desc"><label for="tnrStatus">특징: </label> <input type="text" name="feature" /></div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-6"></div>
										<div class="col-sm-6">
											<div class="btn-container">
												<div class="row" align="right">
													<div class="col-sm-8"></div>
													<div class="col-sm-4">
														<input class="common-btn" type="button" onclick="validationForm()" value="등록" />
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
			
		</div>
	</section>

	<jsp:include page="/WEB-INF/jsp/etc/footer.jsp" />
	
</body>

<script>
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
})();

var today = new Date();
var dd = today.getDate();
var mm = today.getMonth() + 1;
var yyyy = today.getFullYear();

if (dd < 10) {
	dd = "0" + dd;
}
if (mm < 10) {
	mm = "0" + mm;	
}

today = yyyy + "-" + mm + "-" + dd;
$("input[name=birthDate]").attr("max", today);

$(document).ready(function() {
	
	$("#button_renew").click(function() {
		renewTagId();
	});
});
const isUsable = true;
	
	function renewTagId() {
		$.ajax({
	        url: "${pageContext.request.contextPath}/cat/-1",
	        type: "get",
	        headers: { "Content-Type" : "application/json;charset=UTF-8" },
	        success: function(map) {
				if (map.cat.tagId.trim() != "" && map.cat.tagId != null) {
					for (var i = 0; i < map.catList; i++) {
						if (map.catList[i].tagId == map.cat.tagId) {
							isUsable = false;
							break;
						}
					}
					
					if (isUsable == true) {
						$('#tag_Id').val(map.cat.tagId);
						$('#tag').html("사용 가능");
						$('#tag').attr("style", "color:green;");
					} else {
						$('#tag').html("사용 불가능");
						$('#tag').attr("style", "color:red;");
					}
				} else {
					$('#tag').html("등록된 태그 아이디가 없습니다!!");
					$('#tag').attr("style", "color:red;");
				}      	
	        }
	    })
	};
	
    //사진을 업로드하면 실행되는 이벤트리스너 추가
    upload.addEventListener('change',function (e) {
        var get_file = e.target.files;
 
        if(get_file){
            reader.readAsDataURL(get_file[0]);
        }
 
        preview.appendChild(image);
    })
    
    function validationForm() {
    	var catForm = document.catForm;
    	var tagId = $('#tag_Id').val();
    	var catImage = $('#upload').val();
    	var name = $('#name').val();
    	var birthDate = $('#birthDate').val();
    	
    	if (!tagId) {
    		window.alert("태그 아이디 갱신이 필요합니다!!");
    		return;
    	} else if (tagId != '' && isUsable == false) {
    		window.alert("사용 할 수 없는 태그 아이디입니다!!");
    		return;
    	} else if (!catImage) {
    		window.alert("고양이 이미지를 등록해주세요!!");
    		return;
    	} else if (name == null || name == "") {
    		window.alert("고양이 이름을 입력해주세요!!");
    		return;
    	} else {
    		if (!birthDate) {
    			birthDate = null;
    		}
    		
    		var ext = catImage.split('.').pop().toLowerCase();
    		
    		if($.inArray(ext, ['gif','png','jpg','jpeg']) == -1) {
   			 alert('gif,png,jpg,jpeg 파일만 업로드 할수 있습니다.');

   			 return;
  		    }
    		
    		catForm.submit();
    	}
    };
</script>
</html>