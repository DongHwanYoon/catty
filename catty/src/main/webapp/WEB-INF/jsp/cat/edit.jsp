<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<jsp:include page="/WEB-INF/jsp/etc/top.jsp" />

	<section class="main-content post-single" >
		<div class="container">
			<div class="row" >
				<form name="catForm" action="${pageContext.request.contextPath}/cat/${ cat.no }" method="post" enctype="multipart/form-data">
					<input type="hidden" name="_method" value="put" />
					<input type="hidden" name="no" value="${ cat.no }" />
					<div class="col-md-12 col-sm-12" >
						<div class="cat-detail-form">
							<div class="row">
								<div class="col-sm-5" >
									<div class="cat-desc">태그 아이디:
										<input id="tag_Id" type="text" name="tagId" value="${ cat.tagId }" readonly required />
									</div>
								</div>
							</div>
							<div class="row">
								<div class="detail">
									<div class="row" >
										<div class="col-md-12 col-sm-12" >
											<div class="col-sm-3" >
												<div class="row">
													<div class="cat-image" id="image_preview" ><img id="image" src="${pageContext.request.contextPath}/photo/cat/${ cat.no }" /></div>
												</div>
												<div class="row">
													<input id="upload" type="file" name="attach" accept="image/jpg,image/jpeg,image/png" />
												</div>
											</div>
											<div class="col-sm-9" >
												<div class="col-md-12 col-sm-12" >
													<div class="col-sm-6">
														<div class="cat-desc">이름: <input type="text" name="name" value="${ cat.name }" required /></div>
														<div class="cat-desc">성별: 
															<select name="gender" required>
																<option value="M" <c:if test="${ cat.gender eq 'M' }" >selected</c:if>>수컷</option>
																<option value="F" <c:if test="${ cat.gender eq 'F' }" >selected</c:if>>암컷</option>
															</select>
														</div>
														<div class="cat-desc">종: <input type="text" name="spices" value="${ cat.spices }" /></div>
													</div>
													<div class="col-sm-6">
														<div class="cat-desc">출생 연월: <input type="date" name="birthDate" value="${ cat.birthDate }" /></div>
														<div class="cat-desc" >중성화 여부: 
															<select name="tnrStatus" required>
																<option value="Y" <c:if test="${ cat.tnrStatus eq 'Y' }" >selected</c:if>>예</option>
																<option value="N" <c:if test="${ cat.tnrStatus eq 'N' }" >selected</c:if>>아니오</option>
															</select>
														</div>
														<div class="cat-desc">특징: <input type="text" name="feature" value="${ cat.feature }" /></div>
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
														<input class="common-btn" type="submit" onclick="validationForm()" value="수정" />
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
</body>
</html>