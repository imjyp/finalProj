<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>


<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    
   <!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">-->
    
    <link rel="shortcut icon" href="/dist/assets/compiled/svg/favicon.svg" type="image/x-icon">
    <link rel="shortcut icon" href="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACEAAAAiCAYAAADRcLDBAAAEs2lUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4KPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iWE1QIENvcmUgNS41LjAiPgogPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4KICA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIgogICAgeG1sbnM6ZXhpZj0iaHR0cDovL25zLmFkb2JlLmNvbS9leGlmLzEuMC8iCiAgICB4bWxuczp0aWZmPSJodHRwOi8vbnMuYWRvYmUuY29tL3RpZmYvMS4wLyIKICAgIHhtbG5zOnBob3Rvc2hvcD0iaHR0cDovL25zLmFkb2JlLmNvbS9waG90b3Nob3AvMS4wLyIKICAgIHhtbG5zOnhtcD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLyIKICAgIHhtbG5zOnhtcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIgogICAgeG1sbnM6c3RFdnQ9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZUV2ZW50IyIKICAgZXhpZjpQaXhlbFhEaW1lbnNpb249IjMzIgogICBleGlmOlBpeGVsWURpbWVuc2lvbj0iMzQiCiAgIGV4aWY6Q29sb3JTcGFjZT0iMSIKICAgdGlmZjpJbWFnZVdpZHRoPSIzMyIKICAgdGlmZjpJbWFnZUxlbmd0aD0iMzQiCiAgIHRpZmY6UmVzb2x1dGlvblVuaXQ9IjIiCiAgIHRpZmY6WFJlc29sdXRpb249Ijk2LjAiCiAgIHRpZmY6WVJlc29sdXRpb249Ijk2LjAiCiAgIHBob3Rvc2hvcDpDb2xvck1vZGU9IjMiCiAgIHBob3Rvc2hvcDpJQ0NQcm9maWxlPSJzUkdCIElFQzYxOTY2LTIuMSIKICAgeG1wOk1vZGlmeURhdGU9IjIwMjItMDMtMzFUMTA6NTA6MjMrMDI6MDAiCiAgIHhtcDpNZXRhZGF0YURhdGU9IjIwMjItMDMtMzFUMTA6NTA6MjMrMDI6MDAiPgogICA8eG1wTU06SGlzdG9yeT4KICAgIDxyZGY6U2VxPgogICAgIDxyZGY6bGkKICAgICAgc3RFdnQ6YWN0aW9uPSJwcm9kdWNlZCIKICAgICAgc3RFdnQ6c29mdHdhcmVBZ2VudD0iQWZmaW5pdHkgRGVzaWduZXIgMS4xMC4xIgogICAgICBzdEV2dDp3aGVuPSIyMDIyLTAzLTMxVDEwOjUwOjIzKzAyOjAwIi8+CiAgICA8L3JkZjpTZXE+CiAgIDwveG1wTU06SGlzdG9yeT4KICA8L3JkZjpEZXNjcmlwdGlvbj4KIDwvcmRmOlJERj4KPC94OnhtcG1ldGE+Cjw/eHBhY2tldCBlbmQ9InIiPz5V57uAAAABgmlDQ1BzUkdCIElFQzYxOTY2LTIuMQAAKJF1kc8rRFEUxz9maORHo1hYKC9hISNGTWwsRn4VFmOUX5uZZ36oeTOv954kW2WrKLHxa8FfwFZZK0WkZClrYoOe87ypmWTO7dzzud97z+nec8ETzaiaWd4NWtYyIiNhZWZ2TvE946WZSjqoj6mmPjE1HKWkfdxR5sSbgFOr9Ll/rXoxYapQVik8oOqGJTwqPL5i6Q5vCzeo6dii8KlwpyEXFL519LjLLw6nXP5y2IhGBsFTJ6ykijhexGra0ITl5bRqmWU1fx/nJTWJ7PSUxBbxJkwijBBGYYwhBgnRQ7/MIQIE6ZIVJfK7f/MnyUmuKrPOKgZLpEhj0SnqslRPSEyKnpCRYdXp/9++msneoFu9JgwVT7b91ga+LfjetO3PQ9v+PgLvI1xkC/m5A+h7F32zoLXug38dzi4LWnwHzjeg8UGPGbFfySvuSSbh9QRqZ6H+Gqrm3Z7l9zm+h+iafNUV7O5Bu5z3L/wAdthn7QIme0YAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAJTSURBVFiF7Zi9axRBGIefEw2IdxFBRQsLWUTBaywSK4ubdSGVIY1Y6HZql8ZKCGIqwX/AYLmCgVQKfiDn7jZeEQMWfsSAHAiKqPiB5mIgELWYOW5vzc3O7niHhT/YZvY37/swM/vOzJbIqVq9uQ04CYwCI8AhYAlYAB4Dc7HnrOSJWcoJcBS4ARzQ2F4BZ2LPmTeNuykHwEWgkQGAet9QfiMZjUSt3hwD7psGTWgs9pwH1hC1enMYeA7sKwDxBqjGnvNdZzKZjqmCAKh+U1kmEwi3IEBbIsugnY5avTkEtIAtFhBrQCX2nLVehqyRqFoCAAwBh3WGLAhbgCRIYYinwLolwLqKUwwi9pxV4KUlxKKKUwxC6ZElRCPLYAJxGfhSEOCz6m8HEXvOB2CyIMSk6m8HoXQTmMkJcA2YNTHm3congOvATo3tE3A29pxbpnFzQSiQPcB55IFmFNgFfEQeahaAGZMpsIJIAZWAHcDX2HN+2cT6r39GxmvC9aPNwH5gO1BOPFuBVWAZue0vA9+A12EgjPadnhCuH1WAE8ivYAQ4ohKaagV4gvxi5oG7YSA2vApsCOH60WngKrA3R9IsvQUuhIGY00K4flQG7gHH/mLytB4C42EgfrQb0mV7us8AAMeBS8mGNMR4nwHamtBB7B4QRNdaS0M8GxDEog7iyoAguvJ0QYSBuAOcAt71Kfl7wA8DcTvZ2KtOlJEr+ByyQtqqhTyHTIeB+ONeqi3brh+VgIN0fohUgWGggizZFTplu12yW8iy/YLOGWMpDMTPXnl+Az9vj2HERYqPAAAAAElFTkSuQmCC" type="image/png">
    

<!-- Bootstrap CSS 추가 
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"> -->
  <link rel="stylesheet" href="/dist/assets/compiled/css/app.css">
  <link rel="stylesheet" href="/dist/assets/compiled/css/app-dark.css">
  <link rel="stylesheet" href="/dist/assets/compiled/css/iconly.css">


</head>
<style>
.mainlogo {
    display: flex !important; /* 이미지와 텍스트를 한 줄로 배치 */
    flex-direction: row !important; /* 수평 방향으로 배치 */
    align-items: center !important; /* 이미지와 텍스트를 수직 중앙 정렬 */
    justify-content: center !important; /* 수평 중앙 정렬 (선택사항) */
}

.mainlogoimg {
    width: 150px !important; /* 이미지 너비 */
    height: auto !important; /* 비율 유지 */
    margin-right: 10px !important; /* 텍스트와 이미지 간격 */
}


.mainlogo:hover {
    color: #555 !important; /* 마우스 오버 시 텍스트 색상 변경 */
}


/* alert-badge 클래스: 아이콘 오른쪽 상단에 배지를 위치 */
.alert-badge {
    position: absolute;
    top: -4px !important;
    right: -7px !important;
    transform: translate(50%, -50%);
    background-color: yellow;
    color: black;
    border-radius: 20%;
    padding: 5px 15px;;gmj03
    font-size: 15px;
    line-height: 1;
    width: 40px;
    height: 25px !important;
}

</style>
<body>
<%--
<%
    String currentURI = (String) request.getAttribute("javax.servlet.forward.request_uri");
    if (currentURI == null) {
        currentURI = request.getRequestURI();
    }
    request.setAttribute("currentURI", currentURI);
%>
 --%>
<!--     <script src="/dist/assets/static/js/initTheme.js"></script> -->
    <div id="app">
    <div id="main" class="layout-horizontal" style="min-height:0px;">
        <header class="mb-5">
            <nav class="main-navbar">
                <div class="container" style="display: flex; justify-content: space-between; align-items: center; width: 100%;">
                    <div class="mainlogo">
                        <a href="/main" style="color: #fff;">
                            <img src="/upload/logo.png" class="mainlogoimg" alt="Logo" srcset=""> 
                            CAFE@BEAN
<%--                             <p>현재 URI: ${currentURI}</p> --%>
                        </a>
                    </div>
                    <!-- 메뉴 항목을 ul로 감싸서 수평으로 배치 -->
                    <ul style="display: flex; list-style: none; align-items: center; margin: 0; padding: 0; gap:-10px;">
                        <!-- /// 404 NOT COFFEE 시작 /// -->
                        <li class="menu-item has-sub">
                            <a href="#" class='menu-link'>
                                <span style="width:155px;height:20px;"><i class="bi bi-stack"></i> 404 NOT COFFEE</span>
                            </a>
                            <div class="submenu">
                                <div class="submenu-group-wrapper">
                                    <ul class="submenu-group">
                                        <li class="submenu-item">
                                            <a href="/companyInfo/test" class='submenu-link'>회사 소개</a>
                                        </li>
                                        <li class="submenu-item">
                                            <a href="/orgChart/test" class='submenu-link'>조직도</a>
                                        </li>
                                        <!-- <li class="submenu-item">
                                            <a href="component-alert.html" class='submenu-link'>뉴스</a>
                                        </li> -->
                                       
                                    </ul>
                                </div>
                            </div>
                        </li>
                        <!-- /// 404 NOT COFFEE 끝 /// -->
                        <!-- /// 메뉴 시작 /// -->
                        <li class="menu-item has-sub">
                            <a href="#" class='menu-link'>
                                <span style="width:58px;height:20px;"><i class="bi bi-stack"></i> 메뉴</span>
                            </a>
                            <div class="submenu">
                                <div class="submenu-group-wrapper">
                                    <ul class="submenu-group">
                                        <li class="submenu-item">
                                            <a href="/itdmenu" class='submenu-link'>메뉴 소개</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </li>
                        <!-- /// 메뉴 끝 /// -->
                        <!-- /// 매장안내 시작 /// -->
                        <li class="menu-item has-sub">
                            <a href="#" class='menu-link'>
                                <span style="width:88px;height:20px;"><i class="bi bi-stack"></i> 매장안내</span>
                            </a>
                            <div class="submenu">
                                <div class="submenu-group-wrapper">
                                    <ul class="submenu-group">
                                        <li class="submenu-item">
                                            <a href="/findingstore" class='submenu-link'>매장 찾기</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </li>
                        <!-- /// 매장안내 끝 /// -->
                        <!-- /// 소식 시작 /// -->
                        <li class="menu-item has-sub">
                            <a href="#" class='menu-link'>
                                <span style="width:60px;height:20px;"><i class="bi bi-stack"></i> 소식</span>
                            </a>
                            <div class="submenu">
                                <div class="submenu-group-wrapper">
                                    <ul class="submenu-group">
                                        <li class="submenu-item">
                                            <a href="/notice/list" class='submenu-link'>공지사항</a>
                                        </li>
                                        <li class="submenu-item">
                                            <a href="/eventBoard/list" class='submenu-link'>이벤트</a>
                                        </li>
                                        <li class="submenu-item">
                                            <a href="/suggest/list" class='submenu-link'>건의게시판</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </li>
                        <!-- /// 소식 끝 /// -->
                       <sec:authorize access="!isAuthenticated()">
                        <!-- /// 로그인 시작 // -->
                        <li class="menu-item">
                            <button type="submit" class="btn btn-warning" onclick="location.href='/login'" style="width:95px;height:39px;">로그인</button>
                        </li>
                        <!-- /// 로그인 끝 // -->
                        <!-- /// 회원가입 시작 // -->
                        <li class="menu-item">
                            <button type="button" class="btn btn-info" onclick="location.href='/signup'" style="width:95px;height:39px;">회원가입</button>
                        </li>
                        <!-- /// 회원가입 끝 // -->
                        </sec:authorize>
                        <sec:authorize access="isAuthenticated()">
                        	<sec:authentication property="principal.userVO.alerts" var="alerts" />
                        <!-- /// 채팅 시작 /// -->
			        	<li class="menu-item  ">
			                <a href="/chattingRoom" class='menu-link'>
			                    <i class="bi bi-chat-dots-fill"></i>
			                    <span>채팅</span>
			                </a>
			            </li>
			        	<!-- /// 채팅 끝 /// -->
			        	<!-- /// 알림 시작 /// -->	
			        	<li class="menu-item">
                            <a href="/alert" class="menu-link" style="position: relative; display: inline-block;">
                                <i class="bi bi-bell"></i>
                                <span class="alert-badge" id="alertBadge">0</span>
                                알림
                            </a>
                        </li>
			        	
			        	<!-- 알림 top 다른 페이지에서 알림 가리는 코드 -->
<%-- 			        	<c:set var="currentURI" value="${pageContext.request.requestURI}" /> --%>
<%-- 							<c:if test="${not (fn:startsWith(currentURI, '/suggest')  --%>
<%-- 						    or fn:startsWith(currentURI, '/notice')  --%>
<%-- 						    or fn:startsWith(currentURI, '/eventBoard'))}"> --%>

						<!-- 알림 서브메뉴 버전  
			        	<li class="menu-item has-sub">
                            <a href="#" class='menu-link'>
                                <span style="width:90px;height:20px;"><i class="bi bi-bell"></i>${alerts.size()}&nbsp;알림</span>
                            </a>
                            <div class="submenu">
                                <div class="submenu-group-wrapper">
                                    <ul class="submenu-group">
                                        <li class="submenu-item">
                                        	 <c:forEach var="alert" items="${alerts}">
										        <a class="dropdown-item" href="/alert" onclick="updAlertChk(${alert.alertNo})">
										            ${alert.alertCn}
										            <br><small>${fn:substring(alert.alertCreate, 0, 16)}</small>
										        </a>
										    </c:forEach>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </li>
                        -->
                        
<%-- 			        	</c:if> --%>
			        	<%--
			        	<div class="btn-group mb-1">
                           <div class="dropdown">
                               <button class="btn btn-warning dropdown-toggle me-1" type="button" id="dropdownMenuButton5" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
								    <i class="bi bi-bell"></i>${alerts.size()}
 								    <span id="alert-count-top" class="badge bg-danger">${alerts.size()}</span> 
								    알림
								</button>
								<div class="dropdown-menu dropdown-menu-end" id="alert-dropdown-top" aria-labelledby="dropdownMenuButton5" style="position: absolute; inset: 0px 0px auto auto; margin: 0px; transform: translate3d(-851.2px, 2.4px, 0px);" data-popper-placement="bottom-end" data-popper-reference-hidden="" data-popper-escaped="">
								    <c:forEach var="alert" items="${alerts}">
								        <a class="dropdown-item" href="/alert" onclick="markAsRead(${alert.alertNo})">
								            ${alert.alertCn}
								            <br><small>${fn:substring(alert.alertCreate, 0, 16)}</small>
								        </a>
								    </c:forEach>
								</div>

                           </div>
                       </div>
                       --%>
                       
                       <!--  
			        	<div class="navbar navbar-expand-lg navbar-light bg-light">
						    <ul class="navbar-nav ms-auto">
						        <li class="nav-item dropdown">
						            <a class="nav-link dropdown-toggle" href="#" id="dropdownMenuButtonTop" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						                <i class="bi bi-bell"></i>
						                <span id="alert-count-top" class="badge bg-danger">${alerts.size()}</span>
						            </a>
						            <div class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownMenuButtonTop" id="alert-dropdown-top">
						                <c:forEach var="alert" items="${alerts}">
						                    <a class="dropdown-item" href="/userAlertList" onclick="markAsRead(${alert.alertNo})">
						                        ${alert.alertCn}
						                        <br><small>${alert.alertCreate}</small>
						                    </a>
						                </c:forEach>
						            </div>
						        </li>
						    </ul>
						</div>
						-->
	                     <!-- 
			        	<nav class="navbar navbar-expand-lg navbar-light bg-light">
						    <ul class="navbar-nav ms-auto">
						        <li class="nav-item dropdown">
						            <a class="nav-link dropdown-toggle" href="#" id="alertDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
						                <i class="bi bi-bell"></i>
						                <span id="alert-count" class="badge bg-danger">0</span>
						            </a>
						            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="alertDropdown" id="alert-dropdown">
						                <li>
						                    <a href="/alert" class="dropdown-item">
						                        주문 번호 159가 업데이트되었습니다.
						                        <br><small>2025-01-30 15:33:10</small>
						                    </a>
						                </li>
						            </ul>
						        </li>
						    </ul>
						</nav>
						-->
						<!--  
			        	<li class="menu-item  ">
			        		<a class="menu-link" href="/alert">
			        			<i class="bi bi-bell-fill"></i>
			        			<span>알림</span>
			        		</a>
			        	</li>
	                    -->
	                 	</sec:authorize>
                    </ul>
                    
				    <sec:authorize access="isAuthenticated()">
					    <input type="hidden" id="userNo" value="<sec:authentication property='principal.userVO.userNo'/>" />
					    <input type="hidden" id="csrfToken" value="8b44634f-d2ca-45f2-a86f-3d00547122cf" />
				    </sec:authorize>
                </div>
            </nav>
        </header>
    </div>
</div>

<!-- jQuery 먼저 포함 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- Bootstrap JS 한 번만 포함 -->
<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script> -->

<!-- SockJS 및 StompJS 포함 
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>-->
<script src="https://cdn.jsdelivr.net/npm/stompjs@2.3.3/lib/stomp.min.js"></script>

<!-- 커스텀 스크립트 포함 -->
<script src="/dist/assets/static/js/components/dark.js"></script>
<script src="/dist/assets/static/js/pages/horizontal-layout.js"></script>
<script src="/dist/assets/extensions/perfect-scrollbar/perfect-scrollbar.min.js"></script>
<script src="/dist/assets/extensions/apexcharts/apexcharts.min.js"></script>
<script src="/dist/assets/static/js/pages/dashboard.js"></script>

<!-- 알림 스크립트 포함 -->
<script type="text/javascript" src="/js/alert.js"></script>

<!-- jstree CSS (기본 스타일) -->
<link rel="stylesheet" href="/dist/themes/default/style.min.css" />
<!-- jstree JS (jQuery 이후에 로드) -->
 <script type="text/javascript" src="/dist/jstree.min.js"></script>
 
 <!-- stompjs 먼저 포함 -->
<script src="https://cdn.jsdelivr.net/npm/@stomp/stompjs@7.0.0/bundles/stomp.umd.min.js"></script>

</body>


<script>

	// input hidden에서 userNo와 csrfToken 값을 가져오기
	var userNo = $('#userNo').val();
	var csrfToken = $('#csrfToken').val();
	/*  
    // 소식 서브메뉴 이동 시 알림 메뉴 안 보이게 시작 //////////////////////////
	
    var userNo = '<c:out value="${userNo}" />';
    
   document.addEventListener("DOMContentLoaded", function () {
    let hiddenPaths = ["/suggest", "/notice", "/eventBoard"];
    let currentPath = window.location.pathname;
    console.log("현재 경로:", currentPath); // 경로 확인

    if (hiddenPaths.some(path => currentPath.startsWith(path))) {
        document.querySelectorAll(".menu-item.has-sub").forEach(menu => {
            let alertIcon = menu.querySelector("i.bi-bell");
            if (alertIcon) {
                menu.style.display = "none"; // 알림 메뉴 숨기기
                console.log("알림 메뉴 숨김 처리 완료");
            }
        });
    }
	/////////// 소식 서브메뉴 이동 시 알림 메뉴 안 보이게 끝 //////////////////////////
	});

    // 초기 알림 카운트를 JSP에서 전달된 alerts.size()로 설정
    $('#alert-count-top').text('${alerts.size()}');
    
    
 	// 드롭다운 버튼 클릭 시 드롭다운 메뉴 토글 (필요 시)
    $("#dropdownMenuButton5").on("click", function(){
        $(".dropdown-menu dropdown-menu-end").toggleClass("show");
    });
    */
 	
    
</script>


</html>