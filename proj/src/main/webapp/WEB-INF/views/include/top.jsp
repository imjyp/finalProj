<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>CAFE@BEAN</title>
<link rel="shortcut icon" type="image/x-icon"
	href="/kor/images/favicon.ico">
<link rel="stylesheet" href="/dist/assets/compiled/css/app.css">
<link rel="stylesheet" href="/css/common.css">
<!-- 	<link rel="stylesheet" href="/dist/assets/compiled/css/app-dark.css"> -->
<link rel="stylesheet" href="/dist/assets/compiled/css/iconly.css">
</head>
<style>

/* alert-badge */
.alert-badge {
	position: absolute;
	top: -4px !important;
	right: -7px !important;
	transform: translate(50%, -50%);
	background-color: yellow;
	color: black;
	border-radius: 20%;
	padding: 5px 15px;;
	gmj03 font-size: 15px;
	line-height: 1;
	width: 48px;
	height: 25px !important;
}
</style>
<!-- 헤더 시작 -->
<header class="header">
	<!-- 상단 고정 fixed 클래스 추가, 메뉴의 depth1 오버시 open 클래스 추가 -->
	<div class="headArea">
		<strong class="hLogo"> <a href="/main"> <img
				src="/upload/logo.png" alt="로고" class="mainlogo">
		</a>
		</strong>
		<nav class="hMenu">
			<div class="menu">
				<ul class="depth1">
					<li><a href="#" class="dth1">CAFE@BEAN</a>
						<ul class="depth2">
							<li><a href="/companyInfo/test" class="dth2">회사 소개</a></li>
							<li><a href="/orgChart/test" class="dth2">조직도</a></li>
						</ul></li>
					<li><a href="#" class="dth1">MENU</a>
						<ul class="depth2">
							<li><a href="/itdmenu" class="dth2">메뉴 소개</a></li>
						</ul></li>
					<li><a href="#" class="dth1">STORE</a>
						<ul class="depth2">
							<li><a href="/findingstore" class="dth2">매장 찾기</a></li>
						</ul></li>
					<li><a href="#" class="dth1">NEWS</a>
						<ul class="depth2">
							<li><a href="/notice/list" class="dth2">공지사항</a></li>
							<li><a href="/eventBoard/list" class="dth2">이벤트</a></li>
							<li><a href="/suggest/list" class="dth2">건의게시판</a></li>
						</ul></li>
				</ul>
			</div>
			<!-- //menu -->
			<form>
				<div class="util">
					<sec:authorize access="!isAuthenticated()">
						<a href="/login" class="renter">LOGIN</a>
						<a href="/signup" class="lang">SIGNUP</a>
					</sec:authorize>
					<sec:authorize access="isAuthenticated()">
						<sec:authentication property="principal.userVO.alerts"
							var="alerts" />
						<a href="/chattingRoom" class="renter"> <i
							class="bi bi-chat-dots-fill"></i> <span>채팅</span>
						</a>
						<a href="/alert" class="lang"> 
						<i class="bi bi-bell"></i>
						<span class="alert-badge"
							id="alertBadge">0</span> 알림
						</a>
					</sec:authorize>
				</div>
			</form>
			<!-- //util -->
		</nav>
	</div>
	<form>
		<sec:authorize access="isAuthenticated()">
			<input type="hidden" id="userNo"
				value="<sec:authentication property='principal.userVO.userNo'/>" />
			<input type="hidden" id="csrfToken"
				value="8b44634f-d2ca-45f2-a86f-3d00547122cf" />
		</sec:authorize>
	</form>



	<!-- 토스트 알림 
	<div class="toast-container position-fixed top-0 end-0 p-4"
		style="z-index: 1055;">
		<div id="liveToast"
			class="toast align-items-center text-white bg-warning border-0"
			role="alert" aria-live="assertive" aria-atomic="true"
			data-bs-delay="5000">
			<div class="d-flex">
				<div class="toast-body" id="toast-body">
					<strong class="me-auto" id="toast-alert-ty">알림</strong>
					<p class="mb-0" id="toast-alert-cn">새로운 알림이 도착했습니다.</p>
					<small id="toast-create">방금</small>
				</div>
				<button type="button" class="btn-close btn-close-white me-2 m-auto"
					data-bs-dismiss="toast" aria-label="Close"></button>
			</div>
		</div>
	</div>
	-->
	
	
	<div id="liveToast" class="toast fade hide position-fixed top-0 end-0 p-4" style="z-index: 1055;" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header">
            <svg class="bd-placeholder-img rounded me-2" width="20" height="20" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false"><rect width="100%" height="100%" fill="#007aff"></rect></svg>
            <strong class="me-auto" id="toast-alert-ty">알림</strong>
            <small id="toast-create">방금</small>
            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
        <div class="toast-body" id="toast-alert-cn">
           새로운 알림이 도착했습니다.
        </div>
    </div>
</header>


<!-- 헤더 끝 -->



<style>
.toast {
	min-width: 350px; /* 토스트의 최소 너비를 설정 */
	max-width: 500px; /* 토스트의 최대 너비를 설정 */
	padding: 1.5rem; /* 패딩을 늘려 토스트를 더 크게 만듦 */
	border-radius: 0.5rem; /* 둥근 모서리 */
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15); /* 그림자 효과 */
	font-size: 1.1rem; /* 폰트 크기 조정 */
}

.toast-body {
	display: flex;
	flex-direction: column;
}

.toast-container {
	top: 1rem; /* 상단 여백 */
	right: 1rem; /* 오른쪽 여백 */
}

@media ( max-width : 576px) {
	.toast {
		min-width: 90%; /* 작은 화면에서는 너비를 90%로 설정 */
	}
}
</style>


<!-- jQuery 먼저 포함 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- axios -->
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<!--!!!! Bootstrap JS 필요한 사람만 가져가기!!!-->
<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script> -->

<!-- stompjs 먼저 포함 -->
<script src="https://cdn.jsdelivr.net/npm/@stomp/stompjs@7.0.0/bundles/stomp.umd.min.js"></script>

<!-- sweetAlert 버전 1 -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<!-- sweetAlert 버전2 -->
<!-- sweetAlert -->
<link rel="stylesheet" href="/css/sweetalert2.min.css">
<script type="text/javascript" src="/js/sweetalert2.min.js"></script>
<!-- <link rel="stylesheet" href="/css/sweetalert3.min.css"> -->


<!-- 커스텀 스크립트 포함 -->
<script src="/dist/assets/compiled/js/app.js"></script>
<!-- <script src="/dist/assets/static/js/components/dark.js"></script> -->
<script src="/dist/assets/static/js/pages/horizontal-layout.js"></script>
<script
	src="/dist/assets/extensions/perfect-scrollbar/perfect-scrollbar.min.js"></script>
<script src="/dist/assets/extensions/apexcharts/apexcharts.min.js"></script>
<script src="/dist/assets/static/js/pages/dashboard.js"></script>

<!-- 알림 스크립트 포함 -->
<script type="text/javascript" src="/js/alert.js"></script>

<!-- 테마 초기화 스크립트 -->
<script src="assets/static/js/initTheme.js"></script>

<!-- 맥날 스크립트 -->
<script src="/js/libs.js"></script>
<script src="/js/common.js"></script>
<script src="/js/popup.js"></script>
