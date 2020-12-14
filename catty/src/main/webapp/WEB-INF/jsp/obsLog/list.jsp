<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<jsp:include page="/WEB-INF/jsp/etc/top.jsp" />
	
	<section class="main-content post-single">
		<div class="container">
			<div class="row">
				<div class="col-md-12 col-sm-12">
					<div class="obs-list-form">
						<div class="log-title">관찰일지 목록</div>
						<div class="row">
							<div class="table-form">
								<div class='col-md-12 col-sm-12'>
									<div class="row">
										<div class="table-resource" id="resource"></div>
									</div>
								</div>
								<div class="col-md-4">
									<input type="button" class="common-btn" value="고양이 목록" id="button_cat"/>
									<input type="button" class="common-btn" value="등록" id="button_registe"/>
								</div>
								<div class="col-md-2 col-sm-2" ></div>
								<div class="col-md-6 col-sm-6" align="right">
									<input type="text" placeholder="검색어를 입력하세요" name="name"/>
									<input type="button" class="search-btn" value="검색" id="button_search" />
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
	drawObsLogList();
	
	$("#button_registe").click(function() {
		$(location).attr("href", "${pageContext.request.contextPath}/obslog/form");
	});
	
	$("#button_cat").click(function() {
		$(location).attr("href", "${pageContext.request.contextPath}/cat");
	});
	
	$("#button_search").click(function() {
		drawObsLogList();
	});
});

function drawObsLogList() {
	$.ajax({
        url: "${pageContext.request.contextPath}/obslog",
        type: "get",
        data: { name : $("input[name=name]").val() },
        headers: { "Content-Type" : "application/json;charset=UTF-8" },
        success: function(rows) {
        	var obsLogList = rows.obsLogList;
			
			var script = "<table class='table table-hover'>";
				script += "<tr style='background-color: #DEDEDE'>";
				script += "<th >번호</th>";
				script += "<th>고양이</th>";
				script += "<th>작성 일자</th>";
				script += "<th>수정 일자</th>";
				script += "<th>작성자</th>";
				script += "</tr>";
			
			if (obsLogList) {
				for (var i = 0; i < obsLogList.length; i++) {
					script += "<tr onclick=\"location.href='${pageContext.request.contextPath}/obslog/"+obsLogList[i].no+"'\" style='cursor:pointer;'>";
					script += "<td>" + (i + 1) + "</td>";
					
					var catList = rows.catList;
					for (var j = 0; j < catList.length; j++) {
						if (obsLogList[i].catNo == catList[j].no) {
							script += "<td>" + catList[j].name + "</td>";
							break;
						}
					}
					script += "<td>" + obsLogList[i].registrateDate + "</td>";
					script += "<td>" + obsLogList[i].modifiedDate + "</td>";
					
					var memberList = rows.memberList;
					for (var j = 0; j < memberList.length; j++) {
						if (obsLogList[i].memberNo == memberList[j].no) {
							script += "<td>" + memberList[j].id + "(" + memberList[j].name + ")</td>";
							break;
						}
					}
					
					script += "</tr>";
				}
			} else {
				script += "<tr>";
				script += "<td colspan='5'>관찰일지가 존재하지 않습니다!</td>";
				script += "</tr>";
			}
				
			$("#resource").html(script);
        }
    })
};
</script>
</html>