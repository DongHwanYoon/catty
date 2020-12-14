$(document).ready(function() {
	drawAccessMap();
});
	function drawAccessMap() {
		$.ajax({
	        url: "${pageContext.request.contextPath}/facility",
	        type: "get",
	        data: "term=" + "",
	        headers: { "Content-Type" : "application/json" },

	        success: function(rows) {
				var position =  new naver.maps.LatLng(rows.facilityList[0].latitude, rows.facilityList[0].longitude);
		
	        	var mapOptions = {
				    zoom: 10,
				    center: position
				};
			
				var map = new naver.maps.Map('map', mapOptions);
			
				var listener = naver.maps.Event.addListener(map, 'click', function(e) {
				    var marker = new naver.maps.Marker({
				        position: e.coord,
				        map: map
				    });
				});
	        }
	    })
	};