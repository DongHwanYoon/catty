<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<jsp:include page="/WEB-INF/jsp/etc/top.jsp" />

	<section class="main-content post-single" >
		<div class="container" >
			<div class="cat-list-form">
				<div class="row">
					<div class="cat-header">
						<table class='col-md-12 col-sm-12'>
				        	<tr>
				        		<td class='col-md-3 col-sm-3'><p class='pragh' align='center'>사진</p></td>
				        		<td class='col-md-2 col-sm-2'><p class='pragh' align='center'>이름</p></td>
								<td class='col-md-2 col-sm-2'><p class='pragh' align='center'>성별</p></td>
								<td class='col-md-2 col-sm-2'><p class='pragh' align='left'>나이</p></td>
								<td class='col-md-3 col-sm-3'><p class='pragh' align='left'>최근 위치</p></td>
							</tr>
						</table>
					</div>
				</div>
			
				<div class="row">
					<div id="list" class="cat-list"></div>
			    </div>
			    
			    <div class="row">
					<div class="cat-btn">
						<div class="row">
							<div class="col-md-4 col-sm-4" >
								<div class="btn-left" >
									<button class="registe-btn" type="submit" name="obs" id="button_obs" hidden="hidden" >관찰일지</button>
									<button class="registe-btn" type="submit" name="registe" id="button_add" hidden="hidden" >등록</button>
								</div>
							</div>
							<div class="col-md-2 col-sm-2" ></div>
							<div class="col-md-6 col-sm-6" align="right">
								<div class="btn-right" >
							
									<select class="sort-option" name="sort">
										<optgroup label="정렬 순서">
											<option value="2">이름</option>
											<option value="4">성별</option>
											<option value="6">나이</option>
										</optgroup>
									</select>
									<input class="search-input" type="search" placeholder="검색어를 입력하세요" name="name" />
									<button class="search-btn" type="submit" name="search" id="button_search" >검색</button>
									
								</div>	
							</div>
						</div>
					</div>
				</div>
			</div>
		    
        </div>
		
	</section>
	
<jsp:include page="/WEB-INF/jsp/etc/footer.jsp" />

</body>

<script>
	$(document).ready(function() {
		var session = "${sessionScope.id}"
		if (session) {
			var isAdmin = "${sessionScope.isAdmin}"
			if (isAdmin) {
				$("#button_add").show();
			} else {
				$("#button_add").hide();
			}
			$("#button_obs").show();
		} else {
			$("#button_obs").hide();
		}
		
		drawList();
		
		$("#button_search").click(function() {
			drawList();
		});
		
		$("#button_add").click(function() {
			$(location).attr("href", "${pageContext.request.contextPath}/cat/form");
		});
		
		$("#button_obs").click(function() {
			$(location).attr("href", "${pageContext.request.contextPath}/obslog");
		});
	});
	
	function drawList() {
		$.ajax({
	        url: "${pageContext.request.contextPath}/cat",
	        type: "get",
	        data: { name : $("input[name=name]").val(), sort : $("select[name=sort]").val() },
	        headers: { "Content-Type" : "application/json;charset=UTF-8" },
	        success: function(rows) {
	        	var script = "";
				
	        	script += "<div class='row'>";
				var catList = rows.catList;
				for (var i = 0; i < catList.length; i++) {
					script += "<div class='col-md-12 col-sm-12'>";
					script += "    <div class='widget about-widget'>";
					script += "        <table class='col-md-12 col-sm-12' align='center'>";
					script += "         <td class='col-md-3 col-sm-3'><div class='cat-image' align='center'>";
					//사진
					script += "			<a href='${pageContext.request.contextPath}/cat/" + catList[i].no + "'>";
					script += "				<img class='img-responsive' src='${pageContext.request.contextPath}/photo/cat/" + catList[i].no + "'  alt='" + catList[i].no + "'>";
					script += "			</a>";
					script += "        </div></td>";
					
					script += "        <div class='cat-info'>";
					//이름
					script += "            <td class='col-md-2 col-sm-2'><h3 class='cat-name' align='center'><a href='${pageContext.request.contextPath}/cat/" + catList[i].no + "'>" + catList[i].name + "</a></h3></td>";
					
					//성별
					if (catList[i].gender == "M") {
						script += "        	<td class='col-md-2 col-sm-2'><p class='cat-desc' align='center'><i class='fa fa-mars' ></i></p></td>";
					} else {
						script += "        	<td class='col-md-2 col-sm-2'><p class='cat-desc' align='center'><i class='fa fa-venus' ></i></p></td>";
					}
					
					//나이
					script += "      		<td class='col-md-2 col-sm-2'><p class='cat-desc' align='left'><i class='fa fa-calendar' ></i>";
					if (catList[i].birthDate != null) {
						var now = new Date();
						var age = new Date(catList[i].birthDate);
						script += " " + (((now.getYear() - age.getYear()) * 12) + (now.getMonth() - age.getMonth())) + "개월";
					} else {
						script += "  ???";
					}
					script += "				</p></td>";
					
					//최근 접근 시설
					script += "      		<td class='col-md-3 col-sm-3'><p class='cat-desc' align='left'>";
					var accessList = rows.accessList;
					var status = false;
					for(var j = 0; j < accessList.length; j++) {
						if (status == true) {
							break;
						} else if (catList[i].no == accessList[j].catNo) {
							var facilityList = rows.facilityList;
							for (var k = 0; k < facilityList.length; k++) {
								if (accessList[j].facilityNo == facilityList[k].no) {
									script += "    <a href='${pageContext.request.contextPath}/facility/" + facilityList[k].no + "' class='comment-url'><i class='fa fa-home' ></i>" + facilityList[k].name + "</a></td>";
									status = true;
									break;
								}
							}
						} else if ((j == (accessList.length - 1))) {
							script += "<a><i class='fa fa-home' ></i>정보 없음</a></td>";
						}
					}
					script += "				</p>";
					script += "	          </tr>";
					script += "       </div>";
					script += "      </table>";
					
					script += "    </div>";
					script += "</div>";
				}
				script += "</div>";
			
			   $('#list').html(script);
	        }
	    })
	};
</script>
</html>