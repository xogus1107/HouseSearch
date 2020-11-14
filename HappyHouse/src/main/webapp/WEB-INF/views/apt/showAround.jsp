<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
<script
  src="https://code.jquery.com/jquery-3.5.1.js"
  integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
  crossorigin="anonymous"></script>
<meta charset="UTF-8">
<%@ include file="../style/page.jsp"%>
<title>Insert title here</title>
<style>
  table {
    width: 100%;
    border: 1px solid #444444;
    border-collapse: collapse;
  }
  th, td {
    border: 1px solid #444444;
  }
</style>
</head>
<body>
	<br>
	<center><h4>${aptName}주변상가</h4></center>
	<br>
	<center>
	<button id= "food" onclick= "changeMarker('food')">음식점</button>
	<button id= "service" onclick= "changeMarker('service')">생활서비스</button>
	<button id= "study" onclick= "changeMarker('study')">학문/학원</button>
	<button id= "all" onclick= "changeMarker('all')">전체</button>
	</center>
	<br>
	<center>
		<div id="map" style="width: 45%; height: 450px; align: center;"></div>
	</center>
	
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=667ddf1990b5dcc4edb5072a40839180"></script>
	<br>
	<div class="container" align="center">
		<div class="col-lg-8" align="center">
			<table  class="table table-active" style=" border: 1px solid #444444;">
				<tbody>
				<tr style=" border: 1px solid #444444;">
					<td>상호명</td>
					<td class="table-info">주소</td>	
					<td class="table-danger">업종명</td>					
				</tr>
				</tbody>
				<tbody id = "list">
				
				</tbody>
			</table>
		</div>
	</div>
	<script>

//functions


var lat = ${houseLat};
var lng = ${houseLng};
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
mapOption = { 
    center: new kakao.maps.LatLng(lat, lng), // 지도의 중심좌표
    level: 5 // 지도의 확대 레벨
};

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
var food_positions  = new Array();
var medic_positions = new Array();
var service_positions = new Array();
var study_positions = new Array();
var positions = new Array();
<c:forEach items="${storeList}" var = "item1">
var latp = "${item1.lat}";
var lngp = "${item1.lng}"

if("${item1.indsLclsCd}"=='Q') {// 음식
	
	food_positions.push(
		{content:'<div style="padding:5px;">'+ "${item1.bizesNm}"+'</div>'
		
		,bizesNm : "${item1.bizesNm}"
		, rdnmAdr : "${item1.rdnmAdr}"
		, indsLclsNm : "${item1.indsLclsNm}"
		,latlng:  new kakao.maps.LatLng(latp, lngp) })

}
else if("${item1.indsLclsCd}"=='R'){ // 학문
	study_positions.push(
		{content:'<div style="padding:5px;">'+ "${item1.bizesNm}"+'</div>'
			,bizesNm : "${item1.bizesNm}"
				, rdnmAdr : "${item1.rdnmAdr}"
				, indsLclsNm : "${item1.indsLclsNm}"
		, latlng:  new kakao.maps.LatLng(latp, lngp) })

}else if("${item1.indsLclsCd}"=='F'){// 생활 서비스
	service_positions.push(
		{content:'<div style="padding:5px;">'+ "${item1.bizesNm}"+'</div>'
			,bizesNm : "${item1.bizesNm}"
				, rdnmAdr : "${item1.rdnmAdr}"
				, indsLclsNm : "${item1.indsLclsNm}"
		, latlng:  new kakao.maps.LatLng(latp, lngp) })

}
positions.push(
		{content:'<div style="padding:5px;">'+ "${item1.bizesNm}"+'</div>'
			,bizesNm : "${item1.bizesNm}"
				, rdnmAdr : "${item1.rdnmAdr}"
				, indsLclsNm : "${item1.indsLclsNm}"
		, latlng:  new kakao.maps.LatLng(latp, lngp) })

</c:forEach>
var foodMarkers = [];
var serviceMarkers = [];
var studyMarkers=[];
var Markers=[];
var foodMarkerimage = "/ssafy/static/img/fast-food.png";
var serviceMarkerimage = "/ssafy/static/img/laundry.png";
var studyMarkerimage = "/ssafy/static/img/book.png";

if(food_positions.length>0){
	createFoodMarkers();
}
if(service_positions.length>0){

	createServiceMarkers();
}
if(study_positions.length>0){

	createStudyMarkers();
}
createallMarkers();

changeMarker('all');
  
function createMarkerImage(src, size) {
	   var markerImage = new kakao.maps.MarkerImage(src, size);
	   return markerImage;            
	}
function createMarker(position, image) {
	    var marker = new kakao.maps.Marker({
	        position: position,
	        image: image
	    });
	    
	   return marker;  
}   

function createallMarkers() {
    
    for (var i = 0; i < positions.length; i++) {  
        //console.log(food_positions[i]);
        var imageSize = new kakao.maps.Size(22, 26);
          
        
        // 마커이미지와 마커를 생성합니다
       var marker = new kakao.maps.Marker({
  	  map: map, // 마커를 표시할 지도
   	 position: positions[i].latlng // 마커의 위치
	});
        var infowindow = new kakao.maps.InfoWindow({
    	  	  content: positions[i].content // 인포윈도우에 표시할 내용
    		});

    	// 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
    	// 이벤트 리스너로는 클로저를 만들어 등록합니다 
    	// for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
    		kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
    		kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));

        // 생성된 마커를 커피숍 마커 배열에 추가합니다
        Markers.push(marker);
    }     
}
function setallMarkers(map) {        
 
    for (var i = 0; i < Markers.length; i++) {  
    	Markers[i].setMap(map);

    }        
}

function createFoodMarkers() {
    
    for (var i = 0; i < food_positions.length; i++) {  
        //console.log(food_positions[i]);
        var imageSize = new kakao.maps.Size(40, 40);     
        
        // 마커이미지와 마커를 생성합니다
        var markerImage = createMarkerImage(foodMarkerimage, imageSize),    
            marker = createMarker(food_positions[i].latlng, markerImage);  
    	
        var infowindow = new kakao.maps.InfoWindow({
    	  	  content: food_positions[i].content // 인포윈도우에 표시할 내용
    		});

    	// 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
    	// 이벤트 리스너로는 클로저를 만들어 등록합니다 
    	// for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
    		kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
    		kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));

        // 생성된 마커를 커피숍 마커 배열에 추가합니다
        foodMarkers.push(marker);
    }     
}
function setFoodMarkers(map) {    

    for (var i = 0; i < foodMarkers.length; i++) {  
    	foodMarkers[i].setMap(map);
    	
    }        
}
function createServiceMarkers() {
    
    for (var i = 0; i < service_positions.length; i++) {  
        //console.log(food_positions[i]);
        var imageSize = new kakao.maps.Size(40, 40);     
        
        // 마커이미지와 마커를 생성합니다
        var markerImage = createMarkerImage(serviceMarkerimage, imageSize),    
            marker = createMarker(service_positions[i].latlng, markerImage);  
    	
        var infowindow = new kakao.maps.InfoWindow({
    	  	  content: service_positions[i].content // 인포윈도우에 표시할 내용
    		});

    	// 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
    	// 이벤트 리스너로는 클로저를 만들어 등록합니다 
    	// for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
    		kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
    		kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));

        // 생성된 마커를 커피숍 마커 배열에 추가합니다
        serviceMarkers.push(marker);
    }     
}
function setServiceMarkers(map) {    
 
    for (var i = 0; i < serviceMarkers.length; i++) {  
    	serviceMarkers[i].setMap(map);
    }        
}
function createStudyMarkers() {
    
    for (var i = 0; i < study_positions.length; i++) {  
        //console.log(food_positions[i]);
        var imageSize = new kakao.maps.Size(40, 40);     
        
        // 마커이미지와 마커를 생성합니다
        var markerImage = createMarkerImage(studyMarkerimage, imageSize),    
            marker = createMarker(study_positions[i].latlng, markerImage);  
    	
        var infowindow = new kakao.maps.InfoWindow({
    	  	  content: study_positions[i].content // 인포윈도우에 표시할 내용
    		});

    	// 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
    	// 이벤트 리스너로는 클로저를 만들어 등록합니다 
    	// for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
    		kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
    		kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));

        // 생성된 마커를 커피숍 마커 배열에 추가합니다
        studyMarkers.push(marker);
    }     
}
function setStudyMarkers(map) {  
 	
    for (var i = 0; i < studyMarkers.length; i++) {  
    	studyMarkers[i].setMap(map);
    }        
}

function setList(type){
	$("#list").empty();
	var cate = {
			"food" : food_positions,
			"service" : service_positions,
			"study" : study_positions,
			"all" : positions
	}
	for (var i = 0; i < cate[type].length; i++) {
		var name = cate[type][i].bizesNm;
		var addr = cate[type][i].rdnmAdr;
		var category = cate[type][i].indsLclsNm;

		$("#list").append("<tr>");
		$("#list").append("<td>"+name+"</td>");
		$("#list").append("<td>"+addr+"</td>");
		$("#list").append("<td>"+category+"</td>");
		$("#list").append("</tr>");
	}
}

function changeMarker(type){
    

     setList(type);
    // 커피숍 카테고리가 클릭됐을 때
    if (type === 'food') {
    
        // 커피숍 카테고리를 선택된 스타일로 변경하고
    //    coffeeMenu.className = 'menu_selected';
        
        // 편의점과 주차장 카테고리는 선택되지 않은 스타일로 바꿉니다
        //storeMenu.className = '';
     //   carparkMenu.className = '';
        
        // 커피숍 마커들만 지도에 표시하도록 설정합니다
        setFoodMarkers(map);
        setallMarkers(null);
        setServiceMarkers(null);
        setStudyMarkers(null);
       
    }else if(type === 'all'){
    	 setFoodMarkers(null);
         setallMarkers(map);
         setServiceMarkers(null);
         setStudyMarkers(null);
    } else if(type === 'service'){
   	 setFoodMarkers(null);
     setallMarkers(null);
     setServiceMarkers(map);
     setStudyMarkers(null);
	} else if(type === 'study'){
	   	 setFoodMarkers(null);
	     setallMarkers(null);
	     setServiceMarkers(null);
	     setStudyMarkers(map);
	} 
} 

var imageSrc = "/ssafy/static/img/house.png", // 마커이미지의 주소입니다    
imageSize = new kakao.maps.Size(28, 36), // 마커이미지의 크기입니다
imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
 
var latt = "${houseLat}"
var lngt = "${houseLng}"
var marker= new kakao.maps.Marker({
	map : map,
	position : new kakao.maps.LatLng(latt, lngt),
	image : createMarkerImage(imageSrc,imageSize,imageOption)
});

function makeOverListener(map, marker, infowindow) {
	return function() {
    	infowindow.open(map, marker);
	};
}

//인포윈도우를 닫는 클로저를 만드는 함수입니다 
function makeOutListener(infowindow) {
return function() {
    infowindow.close();
};
}
</script>
	
</body>
</html>