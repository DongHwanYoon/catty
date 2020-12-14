<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/etc/top.jsp"%>

	<section class="main-content post-single">
		<div class="container">
			<div class="row">
				<div class="col-sm-12">
					<div class="row">
						<div class="col-xs-12">
							<div class="comments">
								<h3 class="comments-count">회원 목록</h3>

								<div id="table"></div>




							</div>
						</div>
					</div>
					<div class="clearfix"></div>
				</div>
			</div>
		</div>
	</section>

	<%@ include file="/WEB-INF/jsp/etc/footer.jsp"%>
</body>

<script>
	$(document).ready(function() {
		drawTable();
		
		$("#button_search").click(function() {
			drawTable();
		});
	});
	
	function drawTable() {
		$.ajax({
	        url: "${pageContext.request.contextPath}/member",
	        type: "GET",
	        data: { name : $("input[name=name]").val(), key : $("input[key=key]").val() },
	        headers: { "Content-Type" : "application/json;charset=UTF-8" },
	        success: function(rows) {
	        	var script = "";

	        	script += "<table border='1' style='width: 70%;'>";
	        	script += "<tr>";
	        	script +=     "<th>No</th>";
				script +=     "<th>아이디</th>";
				script +=     "<th>이름</th>";
				script +=     "<th>전화번호</th>";
				script +=     "<th>권한</th>";
				script += "</tr>";
				
				var memberList = rows.memberList;
				for (var i = 0; i < memberList.length; i++) {
					var authority = memberList[i].authority;
					
					if (authority == "A") {
						authority = "관리자";
					} else {
						authority = "회원";
					}
					
					script += "<tr>";
					script +=     "<td>" + memberList[i].no + "</td>";
					script +=     "<td><a href='/member/" + memberList[i].no + "' >" + memberList[i].id + "</a></td>";
					script +=     "<td>" + memberList[i].name + "</td>";
					script +=     "<td>" + memberList[i].phoneNo + "</td>";
					script +=     "<td>" + authority + "</td>";
					script += "</tr>";
				}

				script += "</table>";
	            
	           $("#table").html(script);
	        }
	    })
	};
</script>

</html>