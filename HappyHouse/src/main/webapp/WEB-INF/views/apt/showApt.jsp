<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<%@ include file="../style/page.jsp"%>
<title>거래 상세정보 조회</title>
</head>
<body>
<br>
	<center><div id="map" style="width:40%;height:350px;align :center;"></div></center>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=667ddf1990b5dcc4edb5072a40839180"></script>
<script>
var lat = ${houseinfo.lat}
var lng = ${houseinfo.lng}
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(lat, lng), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

// 마커가 표시될 위치입니다 
var markerPosition  = new kakao.maps.LatLng(lat, lng); 

// 마커를 생성합니다
var marker = new kakao.maps.Marker({
    position: markerPosition
});

// 마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);

// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
// marker.setMap(null);    
</script>
	<div class="container" align="center">
		<div class="col-lg-6" align="center">
			<form id="loginform" method="post" action="">
				<input type="hidden" name="act" value="login"> <br>
				<div class="form-group" align="left">
					<label for=""><strong>거래번호 : </strong> ${deal.no}</label>
				</div>
				<div class="form-group" align="left">
					<label for=""><strong>동 : </strong> ${deal.dong}</label>
				</div>
				<div class="form-group" align="left">
					<label for=""><strong>아파트 이름 : </strong> ${deal.aptName}</label>
				</div>
				<div class="form-group" align="left">
					<label for=""><strong>거래액 : </strong>${deal.dealAmount}</label>
				</div>
				<div class="form-group" align="left">
					<label for=""><strong>거래일자 : </strong>${deal.dealYear}-${deal.dealMonth}-${deal.dealDay}</label>
				</div>
				<div class="form-group" align="left">
					<label for=""><strong>건축년도 : </strong>${deal.buildYear} </label>
				</div>
				<div class="form-group" align="left">
					<label for=""><strong>면적 : </strong>${deal.area} </label>
				</div>
				<div class="form-group" align="left">
					<label for=""><strong>층 : </strong>${deal.floor} </label>
				</div>
				<div class="form-group" align="left">
					<label for=""><strong>지번 : </strong>${deal.jibun} </label>
				</div>
			 	 <a href="${root}/apt/showaroud?name=${deal.aptName}&lat= ${houseinfo.lat}&lng= ${houseinfo.lng}">주변 시설 탐색</a>
			</form>
		</div>
	</div>
</body>
</html>