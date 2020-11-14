<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>검색</title>
<%@ include file="../style/page.jsp"%>
<script type="text/javascript">
	function searchAll() {
		document.location.href = "${root}/apt/searchAll?pg=1";
	}
	function search() {

		document.getElementById("searchform").action = "${root}/apt/search";
		document.getElementById("searchform").submit();
	}
	function pageMove(pg) {
		document.getElementById("pg").value = pg;
		document.getElementById("pageform").action = "${root}/apt/search";
		document.getElementById("pageform").submit();
	}
</script>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
    $(document).ready(function() {  
        $("#searchInput").autocomplete({ 
            source : '${root}/apt/json',
            select : function(event, ui) {  
                console.log(ui.item);
            },
            focus : function(event, ui) { 
                return false;
            }
        });
    });
</script>

</head>

<body>
<c:if test="${null ne infolist}">
<br>
	<center><div id="map" style="width:40%;height:350px;align :center;"></div></center>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=667ddf1990b5dcc4edb5072a40839180"></script>
<script>

var lat = ${infolist[0].lat}
var lng = ${infolist[0].lng}
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(lat, lng), // 지도의 중심좌표
        level: 6 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
var positions  = new Array();

<c:forEach items="${infolist}" var = "item1">
var latp = "${item1.lat}";
var lngp = "${item1.lng}"
positions.push(
{content:'<div style="padding:5px;">'+ "${item1.getAptName()}"+'</div>'
, latlng:  new kakao.maps.LatLng(latp, lngp) })

</c:forEach>

for (var i = 0; i < positions.length; i ++) {
    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({
        map: map, // 마커를 표시할 지도
        position: positions[i].latlng // 마커의 위치
    });

    // 마커에 표시할 인포윈도우를 생성합니다 
    var infowindow = new kakao.maps.InfoWindow({
        content: positions[i].content // 인포윈도우에 표시할 내용
    });

    // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
    // 이벤트 리스너로는 클로저를 만들어 등록합니다 
    // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
    kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
}
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
</script>

</c:if>
  

	<form name="pageform" id="pageform" method="GET" action="">
		<input type="hidden" name="pg" id="pg" value="">
		<input type="hidden" name="key" id="key" value="${key}"> 
		<input type="hidden" name="word" id="word" value="${word}">
	</form>
	<div class="container" align="center">
		<div class="col-lg-8" align="center">
			<br>
			<h2>실거래가 목록</h2>
			<br>
			<form id="searchform" method="get" class="form-inline" action="">
				<input type="hidden" name="act" id="act" value="search"> <input
					type="hidden" name="pg" id="pg" value="1">
				<table class="table table-borderless">
					<tr>
						<td align="right">
							<button type="button" class="btn btn-primary"
								onclick="javascript:searchAll();">전체 조회</button> 
								<select class="form-control" name="key" id="key">
								<option value="aptname" selected="selected">아파트 이름</option>
								<option value="dongname">동 이름</option>
						</select> <input type="text" class="form-control" placeholder="검색어 입력."
							name="word" id="word">
							<button type="button" class="btn btn-primary"
								onclick="javascript:search();">검색</button>
						</td>
					</tr>
				</table>
			</form>


			<c:forEach var="deal" items="${deals}">
				<table class="table table-active">
					<tbody>
						<tr
							onclick="document.location.href='${root}/apt/show?no=${deal.no}'"
							style="cursor: pointer;">
							<td><strong>${deal.no}</strong></td>
						</tr>
						<tr class="table-info">
							<td>동 : ${deal.dong}</td>
							<td align="right">아파트 이름 : ${deal.aptName}</td>
						</tr>
						<tr>
							<td class="table-danger"><strong>거래액 :
									${deal.dealAmount} 거래일자 :
									${deal.dealYear}-${deal.dealMonth}-${deal.dealDay}</strong></td>
							<td>건축년도 : ${deal.buildYear} 면적 : ${deal.area} 층 :
								${deal.floor} 지번 : ${deal.jibun}</td>
						</tr>
					</tbody>
				</table>
			</c:forEach>
			<table>
				<tr>
					<td>${navigation.navigator}</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>