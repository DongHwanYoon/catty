<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 목록</title>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/etc/top.jsp"%>

	<section class="main-content post-single">
		<div class="container">
				<div class="col-md-12">
					<div class="row">
							<div class="member-list">
								<h3 class="member-list-title">회원 목록</h3>

								<div class="members">
									<div class="table" id="table"></div>
									<input type="text" id="index" name="name" placeholder="검색어를 입력하세요" >
									<input type="submit" id="button_search" value="검색">
								</div>
							</div>
					</div>
					<div class="clearfix"></div>
				</div>
		</div>
	</section>

	<%@ include file="/WEB-INF/jsp/etc/footer.jsp"%>
</body>

<script>
	$(function(){
		    var responseMessage = "<c:out value="${message}" />";
		    if(responseMessage == "isDeleted"){
		        alert("회원 삭제 완료")
		    }
		    
		    if(responseMessage == "rejected"){
		        alert("관리자는 탈퇴가 불가능합니다")
		    }
		}) 

	$(document).ready(function() {
		drawTable();

		$("#button_search").click(function() {
			drawTable();
		});
	});

	function drawTable() {
		$.ajax({
					url : "${pageContext.request.contextPath}/member",
					type : "GET",
					data : {
						name : $("input[name=name]").val(),
						key : $("input[key=key]").val()
					},
					headers : {
						"Content-Type" : "application/json;charset=UTF-8"
					},
					success : function(rows) {
						var script = "";

						script += "<table class='table table-hover'>";
						script += "<th style='background-color: #DEDEDE'>";
						script += "No";
						script += "</th>";
						script += "<th style='background-color: #DEDEDE'>";
						script += "아이디";
						script += "</th>";
						script += "<th style='background-color: #DEDEDE'>";
						script += "이름";
						script += "</th>";
						script += "<th style='background-color: #DEDEDE'>";
						script += "전화번호";
						script += "</th>";
						script += "<th style='background-color: #DEDEDE'>";
						script += "권한";
						script += "</th>";

						var no = 1;
						var memberList = rows.memberList;
						
						if (memberList.length > 0) {
							for (var i = 0; i < memberList.length; i++) {
								var authority = memberList[i].authority;
	
								if (authority == "A") {
									authority = "관리자";
								} else {
									authority = "회원";
								}
								
								script += "<tr ";
								script += "onClick=\"location.href='${pageContext.request.contextPath}/member/" + memberList[i].no + "'\" ";
								script += "style=\"cursor:pointer;\"";
								script += ">";
								script += "<td>" + no + "</td>";
								script += "<td><a href='/member/" + memberList[i].no + "' >"
										+ memberList[i].id + "</a></td>";
								script += "<td>" + memberList[i].name + "</td>";
								script += "<td>" + memberList[i].phoneNo + "</td>";
								script += "<td>" + authority + "</td>";
								script += "</tr>";
								
								no = no + 1;
							}
						} else {
							script += "<tr>";
							script += "<td colspan='3'>회원 정보가 존재하지 않습니다!</td>";
							script += "</tr>";
						}
						
						script += "</table>";

						$("#table").html(script);
					}
				})
			};
</script>
</html>