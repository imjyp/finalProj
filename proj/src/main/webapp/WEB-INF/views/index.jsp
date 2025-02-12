<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html></html>

<head>
    <meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>CAFE@BEAN</title>
	<link rel="shortcut icon" type="image/x-icon" href="/kor/images/favicon.ico">
	<link rel="stylesheet" href="/css/common.css">
	<link rel="stylesheet" href="/css/common2.css">
	<link rel="stylesheet" href="/dist/assets/compiled/css/app.css">
	<link rel="stylesheet" href="/dist/assets/compiled/css/app-dark.css">
	<link rel="stylesheet" href="/dist/assets/compiled/css/iconly.css">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
	
	<sec:authorize access="isAuthenticated()"> 
        <%@ include file="./include/header.jsp" %>
    </sec:authorize>  
    	<%@ include file="./include/top.jsp" %>	
</head>	
    
<style>

#main{
	margin-top: 141px;
}


/* alert-badge 클래스: 아이콘 오른쪽 상단에 배지를 위치 */
.alert-badge {
    position: fixed;
    top: -4px !important;
    right: -7px !important;
    transform: translate(50%, -50%);
    background-color: yellow;
    color: black;
    border-radius: 20%;
    padding: 5px 15px;
    font-size: 15px;
    line-height: 1;
    width: 40px;
    height: 25px !important;
}
</style>
    
    

<body>   
   
    <div id="wrapper">
    
    <!-- 콘텐츠가 header 아래에 위치하도록 여백 적용 -->
    <div id="main">
   
   
       <div class="card-header">
           <!-- 카드 헤더 내용 -->
       </div>
       <div class="card-body">
           <div id="carouselExampleCaptions" class="carousel slide" data-bs-ride="carousel">
               <h4>메뉴 사진 슬라이드</h4>
               <ol class="carousel-indicators">
                   <li data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0"></li>
                   <li data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1" class="active" aria-current="true"></li>
                   <li data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2"></li>
               </ol>
               <div class="carousel-inner">
                   <div class="carousel-item">
                       <img src="./dist/assets/compiled/png/1.png" class="d-block w-100" alt="..." style="max-height: 300px; object-fit: cover;">
                       <div class="carousel-caption d-none d-md-block">
                           <h5>First slide label</h5>
                           <p>Nulla vitae elit libero, a pharetra augue mollis interdum.</p>
                       </div>
                   </div>
                   <div class="carousel-item active">
                       <img src="./dist/assets/compiled/png/2.png" class="d-block w-100" alt="..." style="max-height: 300px; object-fit: cover;">
                       <div class="carousel-caption d-none d-md-block">
                           <h5>Second slide label</h5>
                           <p>Nulla vitae elit libero, a pharetra augue mollis interdum.</p>
                       </div>
                   </div>
                   <div class="carousel-item">
                       <img src="./dist/assets/compiled/png/3.png" class="d-block w-100" alt="..." style="max-height: 300px; object-fit: cover;">
                       <div class="carousel-caption d-none d-md-block">
                           <h5>Third slide label</h5>
                           <p>Nulla vitae elit libero, a pharetra augue mollis interdum.</p>
                       </div>
                   </div>
               </div>
               <a class="carousel-control-prev" href="#carouselExampleCaptions" role="button" data-bs-slide="prev">
                   <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                   <span class="visually-hidden">Previous</span>
               </a>
               <a class="carousel-control-next" href="#carouselExampleCaptions" role="button" data-bs-slide="next">
                   <span class="carousel-control-next-icon" aria-hidden="true"></span>
                   <span class="visually-hidden">Next</span>
               </a>
           </div>
       </div>
   
   <div style="display:flex; gap:30px; align-items:center; flex-direction:row; justify-content: center">
       <div class="card col-md-6">
           <div class="card-body">
               <div id="carouselExampleCaptions2" class="carousel slide" data-bs-ride="carousel">
                   <ol class="carousel-indicators">
                       <li data-bs-target="#carouselExampleCaptions2" data-bs-slide-to="0"></li>
                       <li data-bs-target="#carouselExampleCaptions2" data-bs-slide-to="1" class="active" aria-current="true"></li>
                       <li data-bs-target="#carouselExampleCaptions2" data-bs-slide-to="2"></li>
                   </ol>
                   <div class="carousel-inner">
                       <div class="carousel-item">
                           <img src="./dist/assets/compiled/png/1.png" class="d-block w-100" alt="...">
                           <div class="carousel-caption d-none d-md-block">
                               <h5>First slide label</h5>
                               <p>Nulla vitae elit libero, a pharetra augue mollis interdum.</p>
                           </div>
                       </div>
                       <div class="carousel-item active">
                           <img src="./dist/assets/compiled/png/2.png" class="d-block w-100" alt="...">
                           <div class="carousel-caption d-none d-md-block">
                               <h5>Second slide label</h5>
                               <p>Nulla vitae elit libero, a pharetra augue mollis interdum.</p>
                           </div>
                       </div>
                       <div class="carousel-item">
                           <img src="./dist/assets/compiled/png/3.png" class="d-block w-100" alt="...">
                           <div class="carousel-caption d-none d-md-block">
                               <h5>Third slide label</h5>
                               <p>Nulla vitae elit libero, a pharetra augue mollis interdum.</p>
                           </div>
                       </div>
                   </div>
                   <a class="carousel-control-prev" href="#carouselExampleCaptions2" role="button" data-bs-slide="prev">
                       <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                       <span class="visually-hidden">Previous</span>
                   </a>
                   <a class="carousel-control-next" href="#carouselExampleCaptions2" role="button" data-bs-slide="next">
                       <span class="carousel-control-next-icon" aria-hidden="true"></span>
                       <span class="visually-hidden">Next</span>
                   </a>
               </div>
           </div>
       </div>
       
       <div class="card col-md-6">
           <div class="card-header">
               <h4>이벤트</h4>
           </div>
           <div class="card-body">
               <div id="carouselExampleCaptions3" class="carousel slide" data-bs-ride="carousel">
                   <ol class="carousel-indicators">
                       <li data-bs-target="#carouselExampleCaptions3" data-bs-slide-to="0"></li>
                       <li data-bs-target="#carouselExampleCaptions3" data-bs-slide-to="1" class="active" aria-current="true"></li>
                       <li data-bs-target="#carouselExampleCaptions3" data-bs-slide-to="2"></li>
                   </ol>
                   <div class="carousel-inner">
                       <div class="carousel-item">
                           <img src="./dist/assets/compiled/png/1.png" class="d-block w-100" alt="...">
                           <div class="carousel-caption d-none d-md-block">
                               <h5>First slide label</h5>
                               <p>Nulla vitae elit libero, a pharetra augue mollis interdum.</p>
                           </div>
                       </div>
                       <div class="carousel-item active">
                           <img src="./dist/assets/compiled/png/2.png" class="d-block w-100" alt="...">
                           <div class="carousel-caption d-none d-md-block">
                               <h5>Second slide label</h5>
                               <p>Nulla vitae elit libero, a pharetra augue mollis interdum.</p>
                           </div>
                       </div>
                       <div class="carousel-item">
                           <img src="./dist/assets/compiled/png/3.png" class="d-block w-100" alt="...">
                           <div class="carousel-caption d-none d-md-block">
                               <h5>Third slide label</h5>
                               <p>Nulla vitae elit libero, a pharetra augue mollis interdum.</p>
                           </div>
                       </div>
                   </div>
                   <a class="carousel-control-prev" href="#carouselExampleCaptions3" role="button" data-bs-slide="prev">
                       <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                       <span class="visually-hidden">Previous</span>
                   </a>
                   <a class="carousel-control-next" href="#carouselExampleCaptions3" role="button" data-bs-slide="next">
                       <span class="carousel-control-next-icon" aria-hidden="true"></span>
                       <span class="visually-hidden">Next</span>
                   </a>
               </div>
           </div>
       </div>
   </div> 
   </div>

 <%@ include file="./include/footer.jsp" %>
 </div>
    <!-- Bootstrap JS (필요 시 추가) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>


<!-- stompjs 먼저 포함 -->
<script src="https://cdn.jsdelivr.net/npm/@stomp/stompjs@7.0.0/bundles/stomp.umd.min.js"></script>

<!-- jQuery 먼저 포함 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- Bootstrap JS 한 번만 포함 -->
<script src="https://cdn.jsdelivr.net/nCpm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>


<!-- 커스텀 스크립트 포함 -->
<script src="/dist/assets/compiled/js/app.js"></script>
<script src="/dist/assets/static/js/components/dark.js"></script>
<script src="/dist/assets/static/js/pages/horizontal-layout.js"></script>
<script src="/dist/assets/extensions/perfect-scrollbar/perfect-scrollbar.min.js"></script>
<script src="/dist/assets/extensions/apexcharts/apexcharts.min.js"></script>
<script src="/dist/assets/static/js/pages/dashboard.js"></script>

<script src="/js/libs.js"></script>
<script src="/js/common.js"></script>
<script src="/js/popup.js"></script>

<!-- 알림 스크립트 포함 -->
<script type="text/javascript" src="/js/alert.js"></script>

<!-- 테마 초기화 스크립트 -->
<script src="assets/static/js/initTheme.js"></script>
</html>
