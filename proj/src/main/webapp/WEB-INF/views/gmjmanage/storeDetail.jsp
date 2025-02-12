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
<script src="/dist/assets/extensions/perfect-scrollbar/perfect-scrollbar.min.js"></script>
<script src="/dist/assets/compiled/js/app.js"></script>
<script src="/dist/assets/extensions/apexcharts/apexcharts.min.js"></script>
<script src="/dist/assets/static/js/pages/dashboard.js"></script>


<div id="main">
<%@ include file="../include/top.jsp" %>
	<header class="mb-3">
		<a href="#" class="burger-btn d-block d-xl-none"> <i
			class="bi bi-justify fs-3"></i>
		</a>
	</header>
	
	
	<div class="page-heading">
	<section id="basic-vertical-layouts">
        <div class="row match-height">
            <div class="col-md-6 col-12">
                <div class="card">
                    <div class="card-header">
                        <h4 class="card-title">${store.storeNo }호점 (${store.storeNm})</h4>
                        <div class="row align-items-center">
	                <div class=" d-flex align-items-center">
	                    <nav aria-label="breadcrumb" class="ms-3">
	                        <ol class="breadcrumb mb-0">
	                            <li class="breadcrumb-item"><a href="/main">Home</a></li>
	                            <li class="breadcrumb-item active"><a href="/gmjGR">가맹점관리</a></li>
	                            <li class="breadcrumb-item active"><a href="/store/detail?storeNo=${store.storeNo }">상세정보</a></li>
	                        </ol>
	                    </nav>
	                </div>
	            </div>
                    </div>
                    <div class="card-content">
                        <div class="card-body">
                            <form class="form form-vertical">
                                <div class="form-body">
                                    <div class="row">
                                        <div class="col-12">
                                            <div class="form-group">
                                                <label for="storeNm">가맹점명</label>
                                                <input type="text" id="storeNm" class="form-control" name="storeNm" value="${store.storeNm }" placeholder="First Name" readonly>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="form-group">
                                                <label for="zip">우편번호</label>
                                                <button type="button" id="btnPost" style="display:none">우편번호 검색</button>
                                                <input type="text" id="userZip" class="form-control" name="userZip" value="${store.storeZip }" readonly placeholder="Mobile">
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="form-group">
                                                <label for="addr1">주소</label>
                                                <input type="text" id="userAddr1" class="form-control" name="userAddr1" value="${store.storeAddr1 }" readonly placeholder="Email">
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="form-group">
                                                <label for="addr2">주소</label>
                                                <input type="text" id="userAddr2" class="form-control" name="userAddr2" value="${store.storeAddr2 }" readonly placeholder="Email">
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="form-group">
                                                <label for="opendate">가맹일자</label>
                                                <input type="date" id="opendate" class="form-control" name="storeOpenDate" value="${store.storeOpenDate }" readonly placeholder="Password">
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="col-12">
											    <div class="form-group">
											        <label for="budget">지출액</label>
											        <small>해당 가맹점이 이번달에 발주 요청한 총 지출액입니다.</small>
											        <input type="text" id="budget" class="form-control" name="budget" 
											               value="<fmt:formatNumber value='${total.total}' pattern='#,###'/>" 
											               readonly placeholder="예산 사용 없음">
											    </div>
											</div>
                                        </div>
                                        
                                        <div class="col-12 d-flex justify-content-end">
                                            <button type="button" class="btn btn-warning me-1 mb-1" id="ok" style="display:none">저장</button>
                                            <button type="button" class="btn btn-warning me-1 mb-1" id="edit">수정</button>
                                            <button type="button" class="btn btn-dark me-1 mb-1" onclick="list()">목록</button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6 col-12" >
                <div class="card">
                    <div id="map" style="width:600px;height:500px; top:150px; margin-left:100px;"></div>
                </div>
            </div>
        </div>
    </section>
</div>
</div>
</body>
</html>
<script type="text/javascript" src="/js/signup.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=86230698ce774a3d05d0780b53b5009b"></script>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
var container = document.getElementById('map'); 
let lat = ${store.storeLat};
let lon= ${store.storeLot};
let storeNo=${store.storeNo };

console.log("lat",lat);
console.log("lon",lon);

var options = { 
	center: new kakao.maps.LatLng(lat,lon), 
	level: 2
};

var map = new kakao.maps.Map(container, options);
var markerPosition = new kakao.maps.LatLng(lat, lon);

var marker = new kakao.maps.Marker({
	 position: markerPosition,
	    image: new kakao.maps.MarkerImage(
	        'data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="24" height="37"><path fill="red" d="M12 0C5.383 0 0 5.383 0 12c0 6.016 11.5 24 12 25 .5-1 12-19 12-25 0-6.617-5.383-12-12-12z"/></svg>',
	        new kakao.maps.Size(24, 37)
	    )
});

marker.setMap(map);




$("#ok").on('click',function(){
	let storeName = $("#storeNm").val();
	let storeZip = $("#userZip").val();
	let storeAddr1 = $("#userAddr1").val();
	let storeAddr2 = $("#userAddr2").val();
	let storeOpenDate = $("#opendate").val();
    
    let data={
        	storeNo:storeNo,
            storeNm: storeName,
            storeAddr1: storeAddr1,
            storeAddr2: storeAddr2,
            storeZip: storeZip,
            storeOpenDate: storeOpenDate,
        };
    
    $.ajax({
        type: "POST",
        url: "/saveStoreDetails",
        contentType:"application/json;charset=utf-8",
    	data:JSON.stringify(data),
    	dataType:"json",
        success: function(response) {
        	
        	 if (response==1) {
        		 $("#edit").css('display', 'block');
                 $("#ok").css('display', 'none');
                 
        		 var Toast = Swal.mixin({
	   			      toast: true,
	   			      position: 'top-end',
	   			      showConfirmButton: false,
	   			      timer: 1000
	   			    });
	   			
	   			Toast.fire({
	   				icon:'success',
	   				title:'수정 완료'
	   			});
        }
        }
        })  
})

function list(){
	location.href="/gmjGR"
}

$("#edit").on('click',function(){
	$("#btnPost").css("display","block");
    $("#storeNm").attr("readonly",false);
    $("#userZip").attr("readonly",false);
    $("#userAddr1").attr("readonly",false);
    $("#userAddr2").attr("readonly",false);
    $("#opendate").attr("readonly",false);
    
	$("#ok").css('display','block');
	$("#edit").css('display','none');
 	$("#storeNm").focus();
})
</script>