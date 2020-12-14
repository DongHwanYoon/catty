<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<jsp:include page="/WEB-INF/jsp/etc/top.jsp" />

	<section class="main-content" >
		<div id="list" class="random-posts">
		</div>
		
		<div class=container>
			<div id="list" class=cat-list>
			
				<div class='col-md-4 col-sm-12'>
					<div class='widget about-widget'>
						<h3 class='widget-title'><i class='fa fa-paw' ></i> Info</h3>
			            <div class='cat-image' align='center'>
							<a href='cat'><img class='img-responsive' src='${pageContext.request.contextPath}/photo/cat/2' ></a>
			            </div>
			            <div class="cat-info">
			            	<h3 class='cat-name' align='center'><a href='cat'>석순이</a></h3>
			            	<p class='cat-desc' align='center'>수컷<i class='fa fa-mars' ></i></p>
			          		<p class='cat-desc' align='center'><i class='fa fa-calendar' ></i>2개월</p>
			          		<p class='cat-desc' align='center'><i class='fa fa-home' ></i><a href='cat'>인문관 급식소</a></p>
			            </div>
			        </div>
		        </div>
		        
	        </div>
        </div>
		
	</section>
	
	<div align="right" style='width:78%;'>
		<button id="button_add" type="button" onclick="location.href='/cat/form'">등록</button>
		<button type="button" onclick="location.href='/obslog'">관찰일지</button>
		<input id="index" type="text" name="name" />
		<input id="button_search" type="button" value="검색" />
	</div>
	
<jsp:include page="/WEB-INF/jsp/etc/footer.jsp" />

</body>

<script>
	$(document).ready(function() {
		drawTable();
		
		$("#button_search").click(function() {
			drawTable();
		});
		
		$("#button_add").click(function() {
			$(location).attr("href", "${pageContext.request.contextPath}/cat/form");
		});
		
		$("#button_obs").click(function() {
			$(location).attr("href", "${pageContext.request.contextPath}/obslog");
		});
	});
	
	function drawTable() {
		$.ajax({
	        url: "${pageContext.request.contextPath}/cat",
	        type: "get",
	        data: { name : $("input[name=name]").val() },
	        headers: { "Content-Type" : "application/json;charset=UTF-8" },
	        success: function(rows) {
	        	var script = "";
	        	
				var catList = rows.catList;
				for (var i = 0; i < catList.length; i++) {
					script += "<div class='item-box'>";
					script += "    <div class='overlay'>";
					script += "";
					
					//사진
					script += "        <div class='post-thumbnail'>";
					script += "	           <a href='${pageContext.request.contextPath}/cat/1'>";
					script += "    	           <img class='img-responsive' src='${pageContext.request.contextPath}/photo/cat/" + catList[i].no + "'  alt='" + catList[i].no + "' />";
					script += "	           </a>";
					script += "        </div>";
					
					
					script += "        <div class='item-box-content'>";
					
					script += "            <div class='categories'>";
					script += "	               <div class='post-category'>";
					script += "    		           <ul class='post-categories'>";
					script += "        		           <li>";
					script += "					           <a href='${pageContext.request.contextPath}/cat'>고양이</a>";
					script += "				           </li>";
					script += "			           </ul>";
					script += "		           </div>";
					script += "		       </div>";
					
					//이름
					script += "            <h3 class='post-title'>";
					script += "	               <a href='${pageContext.request.contextPath}/photo/cat/" + catList[i].no + "'"
										          + "alt='" + catList[i].no + "'>" + catList[i].name + "</a>";
					script += "            </h3>";
					
					script += "            <div class='author-info'>";
					script += "                <span class='author-avatar'>";
					script += "	                   <img class='img-responsive' src='https://via.placeholder.com/251x251' alt='' >";
					script += "                </span>";
					
					//성별
					script += "                <span class='author-name'>";
					script += "		               <a>" + catList[i].gender + "</a>";
					script += "	               </span>";
					script += "            </div>";
					
					//나이
					script += "            <span class='post-date'>";
					script += "	               <i class='fa fa-calendar'></i>";
						if (catList[i].birthDate != null) {
							var now = new Date();
							var age = new Date(catList[i].birthDate);
					script += "                    <a>" + (((now.getYear() - age.getYear()) * 12) + (now.getMonth() - age.getMonth())) + "개월</a>";
						} else {
					script += "                    <a>???</a>";
						}
					script += "            </span>";
					
					//최근 접근 위치
					script += "            <span class='post-comments'>";
					script += "	               <i class='fa fa-comments-o'></i>";
					var accessList = rows.accessList;
					for(var j = 0; j < accessList.length; j++) {
						if (catList[i].no == accessList[j].catNo) {
							var facilityList = rows.facilityList;
							for (var k = 0; k < facilityList.length; k++) {
								if (accessList[j].facilityNo == facilityList[k].no) {
					script += "                     <a href='${pageContext.request.contextPath}/facility/" + facilityList[k].no + "' class='comment-url'>" + facilityList[k].name + "</a>";
									break;
								}
							}
						}
					}
					script += "            </span>";
					script += "        </div>";
					script += "    </div>";
					script += "</div>";
				}
			
			   $('#list').slick('slickAdd',script);
	        }
	    })
	};
</script>
</html>