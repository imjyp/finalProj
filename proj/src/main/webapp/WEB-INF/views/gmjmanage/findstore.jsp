<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<%@ include file="../include/header.jsp"%>
<link rel="stylesheet" href="/css/common2.css">
<script src="/dist/assets/static/js/components/dark.js"></script>
<script
	src="/dist/assets/extensions/perfect-scrollbar/perfect-scrollbar.min.js"></script>
<script src="/dist/assets/compiled/js/app.js"></script>
<script src="/dist/assets/extensions/apexcharts/apexcharts.min.js"></script>
<script src="/dist/assets/static/js/pages/dashboard.js"></script>

<style>
.value{
	margin-left:20px;
}

</style>
<div id="main">
	<%@ include file="../include/top.jsp"%>

	<div class="card">
		<div class="card-header">
			<div class="container-fluid">

				<header class="mb-3">
					<a href="#" class="burger-btn d-block d-xl-none"> <i
						class="bi bi-justify fs-3"></i>
					</a>
				</header>
				<div class="page-heading row"
					style="margin-top: 130px; margin-bottom: 0px">

					<div class="col-6 d-flex align-items-center">
						<nav aria-label="breadcrumb" class="ms-3">
							<ol class="breadcrumb mb-0">
								<li class="breadcrumb-item"><a href="/main">Home</a></li>
								<li class="breadcrumb-item active"><a href="/findingstore">매장찾기</a></li>
							</ol>
						</nav>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div>
		<table>
			<tr >
				<td>본사</td>
			</tr>
			<tr>
				<td>주소</td>
				<td  class="value">대전광역시 중구 계룡로 846, 401호 (대덕인재개발원)</td>
			</tr>
			<tr >
				<td >가맹문의</td>
				<td class="value">010-6362-8372</td>
			</tr>
			<tr>
				<td >대표 이메일</td>
				<td class="value">a001@naver.com</td>
			</tr>
		</table>
		  <br><br>
	</div>
	
	<section id="basic-vertical-layouts" >
		<div class="row match-height">
			<div class="col-12">
				<div id="map"
					style="width: 100%; height: 500px; position: relative; overflow: hidden;"></div>
			</div>
		</div>
	</section>
</div>

<div id="modal">
	<div
		class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-sm"
		role="document">
		<div class="modal-content">
			<div class="modal-header">
				<input id="search" value="" placeholder="검색" />
			</div>
			<div class="modal-body">
				<div class="list-group" id="list"></div>
			</div>
		</div>
	</div>
</div>
</div>
</body>
</html>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=86230698ce774a3d05d0780b53b5009b"></script>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>
<script>
var map; 
let data = {};
let markers = [];

function loadMapData() {
    markers.forEach(function(marker) {
        marker.setMap(null);
    });
    markers = []; 

    $.ajax({
        url: "/mapgmj",
        type: "post",
        contentType: "application/json;charset=utf-8",
        data: JSON.stringify(data),
        dataType: "json",
        success: function(result) {
            console.log("응답 데이터:", result);
            
            let str = "";
            if(result && result.length > 0) {
                var bounds = new kakao.maps.LatLngBounds();
                
                result.forEach(function(m) {
                    str += `<span data-lat="\${m.storeLat}" data-lot="\${m.storeLot}" class="list-group-item">\${m.storeNm} \${m.storeAddr1} \${m.storeAddr2}</span>`;
                    
                    if(m.storeLat && m.storeLot) {
                        var position = new kakao.maps.LatLng(m.storeLat, m.storeLot);
                        var marker = new kakao.maps.Marker({
                            map: map,
                            position: position
                        });
                        
                        markers.push(marker); 
                        
                        var infowindow = new kakao.maps.InfoWindow({
                            content: '<div style="padding:5px;font-size:12px;">' + m.storeNm + '</div>'
                        });
                        
                        kakao.maps.event.addListener(marker, 'mouseover', function() {
                            infowindow.open(map, marker);
                        });
                        
                        kakao.maps.event.addListener(marker, 'mouseout', function() {
                            infowindow.close();
                        });
                        
                        bounds.extend(position);
                    }
                });
                
                
                $(document).on('click', '.list-group-item', function() {
                    markers.forEach(function(marker) {
                        marker.setMap(null);
                    });
                    markers = [];
                    
                    const lat = $(this).data('lat');
                    const lot = $(this).data('lot');
                    const name = $(this).data('name');
                    
                    var position = new kakao.maps.LatLng(lat, lot);
                    var marker = new kakao.maps.Marker({
                        map: map,
                        position: position
                    });
                    
                    markers.push(marker);
                    
                    var infowindow = new kakao.maps.InfoWindow({
                        content: '<div style="padding:5px;font-size:12px;">' + name + '</div>'
                    });
                    
                    kakao.maps.event.addListener(marker, 'mouseover', function() {
                        infowindow.open(map, marker);
                    });
                    
                    kakao.maps.event.addListener(marker, 'mouseout', function() {
                        infowindow.close();
                    });
                    
                    map.setCenter(position);
                    map.setLevel(3); 
                });
                
                
                $("#list").html(str);
                console.log("arr",arr); //이거 없애면 지도가 안나오는 아이러니..
                if(markers.length > 0) { 
                    map.setBounds(bounds);
                }
            } 
        },
        error: function(xhr, status, error) {
            console.log("AJAX 요청 실패:", error);
        }
    });
}

window.onload = function() {
    var container = document.getElementById('map'); 
    
    var options = { 
        center: new kakao.maps.LatLng(36.3250154, 127.4088838), 
        level: 6
    };
    
    map = new kakao.maps.Map(container, options);
    loadMapData(); 
};

/* function loadMapData() {
    $.ajax({
        url: "/mapgmj",
        type: "post",
        contentType:"application/json;charset=utf-8",
    	data:JSON.stringify(data),
    	dataType:"json",
        
        success: function(result) {
            console.log("응답 데이터:", result);
            
            let str = "";
            if(result && result.length > 0) {
                var bounds = new kakao.maps.LatLngBounds();
                
                result.forEach(function(m) {
                    str += `<span class="list-group-item">\${m.storeNm} \${m.storeAddr1} \${m.storeAddr2}</span>`;
                    console.log("위도:", m.storeLat, "경도:", m.storeLot);
                    
                    if(m.storeLat && m.storeLot) {
                        var position = new kakao.maps.LatLng(m.storeLat, m.storeLot);
                        var marker = new kakao.maps.Marker({
                            map: map,
                            position: position
                        });
                        var infowindow = new kakao.maps.InfoWindow({
                            content: '<div style="padding:5px;font-size:12px;">' + m.storeNm + '</div>'
                        });
                        kakao.maps.event.addListener(marker, 'mouseover', function() {
                            infowindow.open(map, marker);
                        });
                        
                        kakao.maps.event.addListener(marker, 'mouseout', function() {
                            infowindow.close();
                        });
                        
                        bounds.extend(position);
                    }
                });
                
                $("#list").html(str);
                console.log("arr",arr);  //이거 없애면 지도가 안나오는 아이러니..
                map.setBounds(bounds);
            } 
        },
        error: function(xhr, status, error) {
            console.log("AJAX 요청 실패:", error);
        }
    });
} */

$("#search").on('keypress', function(e) {
    if (e.which === 13) { 
        console.log("검색", $("#search").val());
        data.keyword=$("#search").val();
        loadMapData();
    }
});






</script>
<style>
#modal {
	position: absolute;
	z-index: 1000;
	top: 500px;
	left: 340px;
	width: 300px;
	margin: 0;
}

.modal-content {
	border: 1px solid black;
	border-radius: 5px;
	background-color: white;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
	max-height: 400px;
}

.modal-header {
	padding: 10px;
	border-bottom: 1px solid #ddd;
}

.modal-body {
	padding: 10px;
	max-height: 300px;
	overflow-y: auto;
}

#search {
	width: 100%;
	padding: 5px;
	border: 1px solid #ddd;
	border-radius: 4px;
}

.list-group {
	max-height: 100%;
	overflow-y: auto;
}

.list-group-item {
	padding: 8px;
	border-bottom: 1px solid #ddd;
}
</style>


