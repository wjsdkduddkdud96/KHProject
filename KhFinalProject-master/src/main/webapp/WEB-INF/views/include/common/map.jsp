<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- <div id="map" style="width:1000px;height:500px;"></div> -->
<div id="map"></div>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c7f29813d0150c2927c1529f7d432392&libraries=services"></script>
<script>
			$.getJSON("resources/json/seoul.json", function(geojson) {
				 
			    var data = geojson.features;
			    var coordinates = []; //좌표 저장할 배열
			 
			    $.each(data, function(index,val) {
			        coordinates = val.geometry.coordinates;
			        displayArea(coordinates);
			 
			    })
			})
		
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new daum.maps.LatLng(37.567427, 126.978889), // 지도의 중심좌표
		        level: mapLevel // 지도의 확대 레벨
		    };  

			//마커를 담을 배열입니다.
			var markers = [];
			
			// 지도를 생성합니다    
			var map = new daum.maps.Map(mapContainer, mapOption); 
			
			//행정구역 폴리곤
			function displayArea(coordinates) {
				var path = []; //선 그려줄 path
				$.each(coordinates[0], function(index, coordinate) {
			        var point = new Object(); 
			        point.x = coordinate[1];
			        point.y = coordinate[0];
			        path.push(new daum.maps.LatLng(coordinate[1], coordinate[0]));
			    })
			 	// 지도에 표시할 선을 생성합니다
				var polyline = new daum.maps.Polyline({
				    path: path, // 선을 구성하는 좌표배열 입니다
				    strokeWeight: 3, // 선의 두께 입니다
				    strokeColor: 'red', // 선의 색깔입니다
				    strokeOpacity: 0.7, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
				    strokeStyle: 'solid' // 선의 스타일입니다
				});
				// 지도에 선을 표시합니다 
				polyline.setMap(map);  
			}
			// 주소-좌표 변환 객체를 생성합니다
			var geocoder = new daum.maps.services.Geocoder();
			
			function displayMap(mapLocation, mapContent){
				//console.log("디스플레이 맵 : "+mapContent);
				mapLocation.forEach(function(value,index){
					geocoder.addressSearch(value, function(result, status) {	
					    // 정상적으로 검색이 완료됐으면 
					     if (status === daum.maps.services.Status.OK) {
					    	var coords = new daum.maps.LatLng(result[0].y, result[0].x);
					    	displayMarker(coords,mapContent,index);
					    } 
					});
				});
			}
			
			function displayMarker(coords,mapContent,index) {
		        var marker = new daum.maps.Marker({
		            map: map,
		            position: coords
		        });
		        markers.push(marker);  // 배열에 생성된 마커를 추가합니다
		        //console.log("디스플레이 마커 : "+mapContent[index]);
		     	// 마커에 표시할 인포윈도우를 생성합니다 
				var infowindow = new daum.maps.InfoWindow({
			        content: mapContent[index] // 인포윈도우에 표시할 내용
			    });
				// 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
			    // 이벤트 리스너로는 클로저를 만들어 등록합니다 
			    // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
			    daum.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
			    daum.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
			}
			map.setZoomable(false);
			
			// 지도 위에 표시되고 있는 마커를 모두 제거합니다
			function removeMarker() {
			    for ( var i = 0; i < markers.length; i++ ) {
			        markers[i].setMap(null);
			    }   
			    markers = [];
			}
			
			// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
			function makeOverListener(map, marker, infowindow) {
			    return function() {
			        infowindow.open(map, marker);
			    };
			}

			// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
			function makeOutListener(infowindow) {
			    return function() {
			        infowindow.close();
			    };
			}
			
			//지도를 재졍렬 합니다.
			function relayout(){
				map.relayout();
			}
			
			// 버튼 클릭에 따라 지도 확대, 축소 기능을 막거나 풀고 싶은 경우에는 map.setZoomable 함수를 사용합니다
			function setZoomable(zoomable) {
				// 마우스 휠로 지도 확대,축소 가능여부를 설정합니다
				map.setZoomable(zoomable);    
			}
		</script>
</body>
</html>