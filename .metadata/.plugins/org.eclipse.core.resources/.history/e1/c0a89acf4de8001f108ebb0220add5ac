<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<head>
	<meta charset="UTF-8">
	<meta name="csrf-token" content="${_csrf.token}" />
	 
	 
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
	
	<link rel="shortcut icon" href="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACEAAAAiCAYAAADRcLDBAAAEs2lUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4KPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iWE1QIENvcmUgNS41LjAiPgogPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4KICA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIgogICAgeG1sbnM6ZXhpZj0iaHR0cDovL25zLmFkb2JlLmNvbS9leGlmLzEuMC8iCiAgICB4bWxuczp0aWZmPSJodHRwOi8vbnMuYWRvYmUuY29tL3RpZmYvMS4wLyIKICAgIHhtbG5zOnBob3Rvc2hvcD0iaHR0cDovL25zLmFkb2JlLmNvbS9waG90b3Nob3AvMS4wLyIKICAgIHhtbG5zOnhtcD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLyIKICAgIHhtbG5zOnhtcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIgogICAgeG1sbnM6c3RFdnQ9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZUV2ZW50IyIKICAgZXhpZjpQaXhlbFhEaW1lbnNpb249IjMzIgogICBleGlmOlBpeGVsWURpbWVuc2lvbj0iMzQiCiAgIGV4aWY6Q29sb3JTcGFjZT0iMSIKICAgdGlmZjpJbWFnZVdpZHRoPSIzMyIKICAgdGlmZjpJbWFnZUxlbmd0aD0iMzQiCiAgIHRpZmY6UmVzb2x1dGlvblVuaXQ9IjIiCiAgIHRpZmY6WFJlc29sdXRpb249Ijk2LjAiCiAgIHRpZmY6WVJlc29sdXRpb249Ijk2LjAiCiAgIHBob3Rvc2hvcDpDb2xvck1vZGU9IjMiCiAgIHBob3Rvc2hvcDpJQ0NQcm9maWxlPSJzUkdCIElFQzYxOTY2LTIuMSIKICAgeG1wOk1vZGlmeURhdGU9IjIwMjItMDMtMzFUMTA6NTA6MjMrMDI6MDAiCiAgIHhtcDpNZXRhZGF0YURhdGU9IjIwMjItMDMtMzFUMTA6NTA6MjMrMDI6MDAiPgogICA8eG1wTU06SGlzdG9yeT4KICAgIDxyZGY6U2VxPgogICAgIDxyZGY6bGkKICAgICAgc3RFdnQ6YWN0aW9uPSJwcm9kdWNlZCIKICAgICAgc3RFdnQ6c29mdHdhcmVBZ2VudD0iQWZmaW5pdHkgRGVzaWduZXIgMS4xMC4xIgogICAgICBzdEV2dDp3aGVuPSIyMDIyLTAzLTMxVDEwOjUwOjIzKzAyOjAwIi8+CiAgICA8L3JkZjpTZXE+CiAgIDwveG1wTU06SGlzdG9yeT4KICA8L3JkZjpEZXNjcmlwdGlvbj4KIDwvcmRmOlJERj4KPC94OnhtcG1ldGE+Cjw/eHBhY2tldCBlbmQ9InIiPz5V57uAAAABgmlDQ1BzUkdCIElFQzYxOTY2LTIuMQAAKJF1kc8rRFEUxz9maORHo1hYKC9hISNGTWwsRn4VFmOUX5uZZ36oeTOv954kW2WrKLHxa8FfwFZZK0WkZClrYoOe87ypmWTO7dzzud97z+nec8ETzaiaWd4NWtYyIiNhZWZ2TvE946WZSjqoj6mmPjE1HKWkfdxR5sSbgFOr9Ll/rXoxYapQVik8oOqGJTwqPL5i6Q5vCzeo6dii8KlwpyEXFL519LjLLw6nXP5y2IhGBsFTJ6ykijhexGra0ITl5bRqmWU1fx/nJTWJ7PSUxBbxJkwijBBGYYwhBgnRQ7/MIQIE6ZIVJfK7f/MnyUmuKrPOKgZLpEhj0SnqslRPSEyKnpCRYdXp/9++msneoFu9JgwVT7b91ga+LfjetO3PQ9v+PgLvI1xkC/m5A+h7F32zoLXug38dzi4LWnwHzjeg8UGPGbFfySvuSSbh9QRqZ6H+Gqrm3Z7l9zm+h+iafNUV7O5Bu5z3L/wAdthn7QIme0YAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAJTSURBVFiF7Zi9axRBGIefEw2IdxFBRQsLWUTBaywSK4ubdSGVIY1Y6HZql8ZKCGIqwX/AYLmCgVQKfiDn7jZeEQMWfsSAHAiKqPiB5mIgELWYOW5vzc3O7niHhT/YZvY37/swM/vOzJbIqVq9uQ04CYwCI8AhYAlYAB4Dc7HnrOSJWcoJcBS4ARzQ2F4BZ2LPmTeNuykHwEWgkQGAet9QfiMZjUSt3hwD7psGTWgs9pwH1hC1enMYeA7sKwDxBqjGnvNdZzKZjqmCAKh+U1kmEwi3IEBbIsugnY5avTkEtIAtFhBrQCX2nLVehqyRqFoCAAwBh3WGLAhbgCRIYYinwLolwLqKUwwi9pxV4KUlxKKKUwxC6ZElRCPLYAJxGfhSEOCz6m8HEXvOB2CyIMSk6m8HoXQTmMkJcA2YNTHm3congOvATo3tE3A29pxbpnFzQSiQPcB55IFmFNgFfEQeahaAGZMpsIJIAZWAHcDX2HN+2cT6r39GxmvC9aPNwH5gO1BOPFuBVWAZue0vA9+A12EgjPadnhCuH1WAE8ivYAQ4ohKaagV4gvxi5oG7YSA2vApsCOH60WngKrA3R9IsvQUuhIGY00K4flQG7gHH/mLytB4C42EgfrQb0mV7us8AAMeBS8mGNMR4nwHamtBB7B4QRNdaS0M8GxDEog7iyoAguvJ0QYSBuAOcAt71Kfl7wA8DcTvZ2KtOlJEr+ByyQtqqhTyHTIeB+ONeqi3brh+VgIN0fohUgWGggizZFTplu12yW8iy/YLOGWMpDMTPXnl+Az9vj2HERYqPAAAAAElFTkSuQmCC" type="image/png">
	<link rel="shortcut icon" href="/dist/assets/compiled/svg/favicon.svg" type="image/x-icon">
	<link rel="shortcut icon" href="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACEAAAAiCAYAAADRcLDBAAAEs2lUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4KPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iWE1QIENvcmUgNS41LjAiPgogPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4KICA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIgogICAgeG1sbnM6ZXhpZj0iaHR0cDovL25zLmFkb2JlLmNvbS9leGlmLzEuMC8iCiAgICB4bWxuczp0aWZmPSJodHRwOi8vbnMuYWRvYmUuY29tL3RpZmYvMS4wLyIKICAgIHhtbG5zOnBob3Rvc2hvcD0iaHR0cDovL25zLmFkb2JlLmNvbS9waG90b3Nob3AvMS4wLyIKICAgIHhtbG5zOnhtcD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLyIKICAgIHhtbG5zOnhtcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIgogICAgeG1sbnM6c3RFdnQ9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZUV2ZW50IyIKICAgZXhpZjpQaXhlbFhEaW1lbnNpb249IjMzIgogICBleGlmOlBpeGVsWURpbWVuc2lvbj0iMzQiCiAgIGV4aWY6Q29sb3JTcGFjZT0iMSIKICAgdGlmZjpJbWFnZVdpZHRoPSIzMyIKICAgdGlmZjpJbWFnZUxlbmd0aD0iMzQiCiAgIHRpZmY6UmVzb2x1dGlvblVuaXQ9IjIiCiAgIHRpZmY6WFJlc29sdXRpb249Ijk2LjAiCiAgIHRpZmY6WVJlc29sdXRpb249Ijk2LjAiCiAgIHBob3Rvc2hvcDpDb2xvck1vZGU9IjMiCiAgIHBob3Rvc2hvcDpJQ0NQcm9maWxlPSJzUkdCIElFQzYxOTY2LTIuMSIKICAgeG1wOk1vZGlmeURhdGU9IjIwMjItMDMtMzFUMTA6NTA6MjMrMDI6MDAiCiAgIHhtcDpNZXRhZGF0YURhdGU9IjIwMjItMDMtMzFUMTA6NTA6MjMrMDI6MDAiPgogICA8eG1wTU06SGlzdG9yeT4KICAgIDxyZGY6U2VxPgogICAgIDxyZGY6bGkKICAgICAgc3RFdnQ6YWN0aW9uPSJwcm9kdWNlZCIKICAgICAgc3RFdnQ6c29mdHdhcmVBZ2VudD0iQWZmaW5pdHkgRGVzaWduZXIgMS4xMC4xIgogICAgICBzdEV2dDp3aGVuPSIyMDIyLTAzLTMxVDEwOjUwOjIzKzAyOjAwIi8+CiAgICA8L3JkZjpTZXE+CiAgIDwveG1wTU06SGlzdG9yeT4KICA8L3JkZjpEZXNjcmlwdGlvbj4KIDwvcmRmOlJERj4KPC94OnhtcG1ldGE+Cjw/eHBhY2tldCBlbmQ9InIiPz5V57uAAAABgmlDQ1BzUkdCIElFQzYxOTY2LTIuMQAAKJF1kc8rRFEUxz9maORHo1hYKC9hISNGTWwsRn4VFmOUX5uZZ36oeTOv954kW2WrKLHxa8FfwFZZK0WkZClrYoOe87ypmWTO7dzzud97z+nec8ETzaiaWd4NWtYyIiNhZWZ2TvE946WZSjqoj6mmPjE1HKWkfdxR5sSbgFOr9Ll/rXoxYapQVik8oOqGJTwqPL5i6Q5vCzeo6dii8KlwpyEXFL519LjLLw6nXP5y2IhGBsFTJ6ykijhexGra0ITl5bRqmWU1fx/nJTWJ7PSUxBbxJkwijBBGYYwhBgnRQ7/MIQIE6ZIVJfK7f/MnyUmuKrPOKgZLpEhj0SnqslRPSEyKnpCRYdXp/9++msneoFu9JgwVT7b91ga+LfjetO3PQ9v+PgLvI1xkC/m5A+h7F32zoLXug38dzi4LWnwHzjeg8UGPGbFfySvuSSbh9QRqZ6H+Gqrm3Z7l9zm+h+iafNUV7O5Bu5z3L/wAdthn7QIme0YAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAJTSURBVFiF7Zi9axRBGIefEw2IdxFBRQsLWUTBaywSK4ubdSGVIY1Y6HZql8ZKCGIqwX/AYLmCgVQKfiDn7jZeEQMWfsSAHAiKqPiB5mIgELWYOW5vzc3O7niHhT/YZvY37/swM/vOzJbIqVq9uQ04CYwCI8AhYAlYAB4Dc7HnrOSJWcoJcBS4ARzQ2F4BZ2LPmTeNuykHwEWgkQGAet9QfiMZjUSt3hwD7psGTWgs9pwH1hC1enMYeA7sKwDxBqjGnvNdZzKZjqmCAKh+U1kmEwi3IEBbIsugnY5avTkEtIAtFhBrQCX2nLVehqyRqFoCAAwBh3WGLAhbgCRIYYinwLolwLqKUwwi9pxV4KUlxKKKUwxC6ZElRCPLYAJxGfhSEOCz6m8HEXvOB2CyIMSk6m8HoXQTmMkJcA2YNTHm3congOvATo3tE3A29pxbpnFzQSiQPcB55IFmFNgFfEQeahaAGZMpsIJIAZWAHcDX2HN+2cT6r39GxmvC9aPNwH5gO1BOPFuBVWAZue0vA9+A12EgjPadnhCuH1WAE8ivYAQ4ohKaagV4gvxi5oG7YSA2vApsCOH60WngKrA3R9IsvQUuhIGY00K4flQG7gHH/mLytB4C42EgfrQb0mV7us8AAMeBS8mGNMR4nwHamtBB7B4QRNdaS0M8GxDEog7iyoAguvJ0QYSBuAOcAt71Kfl7wA8DcTvZ2KtOlJEr+ByyQtqqhTyHTIeB+ONeqi3brh+VgIN0fohUgWGggizZFTplu12yW8iy/YLOGWMpDMTPXnl+Az9vj2HERYqPAAAAAElFTkSuQmCC" type="image/png">
	
	<link rel="stylesheet" href="/dist/assets/compiled/css/app-dark.css">
	<link rel="stylesheet" href="/dist/assets/compiled/css/iconly.css">
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet" />


</head>
<style>
.avatar.avatar-xl img{
	width:80px !important; 
} 
</style>
<body>
    <div id="app">
        <div id="sidebar">
            <div class="sidebar-wrapper ">
    <div class="sidebar-header position-relative" >
        <div class="d-flex justify-content-between align-items-center">
        
            <div class="sidebar-toggler  x">
                <a href="#" class="sidebar-hide d-xl-none d-block"><i class="bi bi-x bi-middle"></i></a>
            </div>
        </div>
        <div class="header-top">
	     <div class="container">
	      <div class="header-top-right">
			<!-- /// 로그인 했을 때 시작 /// -->
	      	<sec:authorize access="isAuthenticated()">
	      	<sec:authentication property="principal.userVO" var="userVO"/>
                <div class="dropdown">
                    <a href="#" id="topbarUserDropdown" class="user-dropdown d-flex align-items-center dropend dropdown-toggle " data-bs-toggle="dropdown" aria-expanded="false">
                        <div class="avatar avatar-xl" >
                   			<img src="/resources${userVO.fileGroupVO.fileDetailVOList[0].fileSaveLocate }" alt="profile">
               			</div>
               <!-- 프로필 -->
               <div class="card-body py-4 px-4">
                 <div class="d-flex align-items-center">
                    	<c:if test="${userVO.userCode == '1' || userVO.userCode == '3'}"><!-- emp -->
                    		<div class="ms-3 name">
	                            <h5 class="font-bold">${userVO.userNm}&nbsp;님</h5>
	                            <h6 class="text-muted mb-0">${userVO.deptNm}&nbsp;| &nbsp;${userVO.positionNm}</h6>
	                        </div>
                    	</c:if>
                    	<c:if test="${userVO.userCode == '2' || userVO.userCode == '4'}"><!-- store -->
                    		<div class="ms-3 name">
	                            <h5 class="font-bold">${userVO.userNm}님</h5>
	                            <h6 class="text-muted mb-0">${userVO.storeNm} &nbsp;| ${userVO.positionNm}</h6>
	                        </div>
                    	</c:if>
                    </div>
                </div>
                  </a>
                  <ul class="dropdown-menu dropdown-menu-end shadow-lg" aria-labelledby="topbarUserDropdown">
                    <li><a class="dropdown-item" href="/mypage">마이페이지</a></li>
                  </ul>
              </div>
		</sec:authorize>
            <!-- Burger button responsive -->
            <a href="#" class="burger-btn d-block d-xl-none">
                <i class="bi bi-justify fs-3"></i>
            </a>
           </div>
	     </div>
	     </div>
        <!-- /// 마이페이지 / 알림 / 로그아웃 버튼 시작 /// -->
        <div class="d-flex justify-content-between align-items-center" style="font-size:15px;">
        
        <!--      <div class="logo">
                 마이페이지 
             </div> 
             <div class="logo" onclick="location.href='/alert'">
             <a href="/alert" class="logo"> 
             	<svg class="bi" width="1em" height="1em" fill="currentColor">
                    <use xlink:href="assets/static/images/bootstrap-icons.svg#bell-fill"></use> 
                </svg> 
            	알림 
             </a> 
             </div>  -->
            
            <div class="theme-toggle d-flex gap-2  align-items-center mt-2">
                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true"
                    role="img" class="iconify iconify--system-uicons" width="20" height="20"
                    preserveAspectRatio="xMidYMid meet" viewBox="0 0 21 21">
                    <g fill="none" fill-rule="evenodd" stroke="currentColor" stroke-linecap="round"
                        stroke-linejoin="round">
                        <path
                            d="M10.5 14.5c2.219 0 4-1.763 4-3.982a4.003 4.003 0 0 0-4-4.018c-2.219 0-4 1.781-4 4c0 2.219 1.781 4 4 4zM4.136 4.136L5.55 5.55m9.9 9.9l1.414 1.414M1.5 10.5h2m14 0h2M4.135 16.863L5.55 15.45m9.899-9.9l1.414-1.415M10.5 19.5v-2m0-14v-2"
                            opacity=".3"></path>
                        <g transform="translate(-210 -1)">
                            <path d="M220.5 2.5v2m6.5.5l-1.5 1.5"></path>
                            <circle cx="220.5" cy="11.5" r="4"></circle>
                            <path d="m214 5l1.5 1.5m5 14v-2m6.5-.5l-1.5-1.5M214 18l1.5-1.5m-4-5h2m14 0h2"></path>
                        </g>
                    </g>
                </svg>
                <div class="form-check form-switch fs-6">
                    <input class="form-check-input  me-0" type="checkbox" id="toggle-dark" style="cursor: pointer">
                    <label class="form-check-label"></label>
                </div>
                
            </div>
            <sec:authorize access="isAuthenticated()">
            <div class="logo">
               <form action="/logout" method="post">
              	<button type="submit" id="logout" class= "btn btn-block btn-outline-dark btn-xs">로그아웃</button>
           	</form>
            </div>
            </sec:authorize>
        </div>
        <!-- /// 마이페이지 / 알림 / 로그아웃 버튼 끝 /// -->
    </div>
    
    <!-- 출퇴근 버튼 -->
        <div style="padding-left:50px;">
            <div>
                <p>현재시각: <span id="now"></span></p>
                <h5 class="time-display" id="currentTime"></h5>
                <p>근무시간: <span id="workingHours"></span></p>
            </div>
            <sec:authorize access="isAuthenticated()">
            <div class="button-group">
                <button class="btn btn-warning" id="start" style="width:40%">
                    <i class="fas fa-sign-in-alt"></i>
                    출근
                </button>
                <button class="btn btn-dark" id="end" style="width:40%">
                    <i class="fas fa-sign-out-alt"></i>
                    퇴근
                </button>
            </div>
            </sec:authorize>
        </div>
       <!-- 출퇴근 끝 -->
       
    <div class="sidebar-menu">
        <ul class="menu">
        	
        	<!-- /// 전자결재 시작 /// -->
        	<sec:authorize access = "hasAnyRole('GY','IS','JJ','GH','MR','SYS','CEO')">
        	<li class="sidebar-item has-sub ">
                <a href="/dist/application-chat.html" class='sidebar-link'>
                    <i class="bi bi-clipboard-minus-fill"></i></i>
                    <span>전자결재</span>
                </a>
                <ul class="submenu">
                    <li class="submenu-item  ">
                        <a href="/sanction/form" 
                        	class="submenu-link">기안서작성</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/sanction/mysanc" 
                        	class="submenu-link">내문서함</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/sanction/pending" 
                        	class="submenu-link">결재대기함</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/sanction/list" 
                        	class="submenu-link">문서검색</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/resource/list" 
                        	class="submenu-link">자료실</a>
                    </li>
                </ul>
            </li>
            </sec:authorize>
        	<!-- /// 전자결재 끝 /// -->
        	
        	<!-- /// 시스템관리자 시작 /// -->
            <sec:authorize access = "hasAnyRole('SYS','CEO')">
            <li class="sidebar-title">시스템관리자</li>
            <!-- <li class="sidebar-item">
                <a href="/sys/list" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>시스템 관리</span>
                </a>
            </li> -->
            <li class="sidebar-item">
                <a href="/sys/list" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>권한 부여 및 회원 관리</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="/deptManage/test" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>부서 관리</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="/positionManage/test" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>직책 관리</span>
                </a>
            </li>
                <!-- <ul class="submenu">
                    <li class="submenu-item  ">
                        <a href="/sys/list" 
                        	class="submenu-link">권한 부여 및 회원 관리</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/membership" 
                        	class="submenu-link">회원 관리</a>
                    </li>
                    <li class="submenu-item  ">
						<a href="/deptManage/test"
                        	class="submenu-link">부서 관리</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/positionManage/test" 
                        	class="submenu-link">직책 관리</a>
                    </li>
                </ul> -->
            
            </sec:authorize>
            <!-- /// 재정/회계 시작 /// -->
            <sec:authorize access = "hasAnyRole('JJ','SYS','CEO')">
            <li class="sidebar-title">재정/회계</li>
			<li class="sidebar-item">
			                <a href="/bonsa/order" class='sidebar-link'>
			                    <i class="bi bi-grid-fill"></i>
			                    <span>계산서 발행</span>
			                </a>
			            </li> 
<!--             <li class="sidebar-item has-sub"> -->
<!--                 <a href="/dist/index.html" class='sidebar-link'> -->
<!--                     <i class="bi bi-grid-fill"></i> -->
<!--                     <span>계산서 관리</span> -->
<!--                 </a> -->
<!--                 <ul class="submenu"> -->
<!--                     <li class="submenu-item  "> -->
<!--                         <a href="/bonsa/bill"  -->
<!--                         	class="submenu-link">계산 요청 조회</a> -->
<!--                     </li> -->
<!--                     <li class="submenu-item  "> -->
<!--                         <a href="/dist/component-accordion.html"  -->
<!--                         	class="submenu-link">계산</a> -->
<!--                     </li> -->
<!--                 </ul> -->
<!--             </li> -->
            <li class="sidebar-item has-sub">
                <a href="/dist/index.html" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>본사 수익 분석</span>
                </a>
                <ul class="submenu">
                	<!-- <li class="submenu-item  ">
                        <a href="/bonsa/selling" 
                        	class="submenu-link">원래 매출 페이지</a>
                    </li> -->
                    <li class="submenu-item  ">
                        <a href="/bonsa/sellingMenu" 
                        	class="submenu-link">메뉴별 판매현황</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/bonsa/sellingItem" 
                        	class="submenu-link">품목별 판매현황</a>
                    </li>
                    
                    <li class="submenu-item  ">
                        <a href="/bonsa/sellingDate" 
                        	class="submenu-link">기간별 매출</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/bonsa/sellingGMJ" 
                        	class="submenu-link">가맹점별 매출</a>
                    </li>
                    
                    <li class="submenu-item  ">
                        <a href="/bonsa/budget" 
                        	class="submenu-link">예산 관리</a>
                    </li>
                </ul>
            </li>
            <li class="sidebar-item">
                <a href="/bonsa/salary" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>급여 지급 관리</span>
                </a>
            </li>
            </sec:authorize>
            <!-- /// 재정/회계 끝 /// -->
        	<!-- /// 경영본부 시작 /// -->
        	<sec:authorize access = "hasAnyRole('GY','SYS','CEO')">
            <li class="sidebar-title">경영본부</li>
            <li class="sidebar-item  ">
                <a href="/gmjGR" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>가맹점 관리</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="/calendar/test" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>이벤트 관리</span>
                </a>
            </li>
            <!-- <li class="sidebar-item">
                <a href="/companyInfo/test" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>회사 정보 관리</span>
                </a>
            </li> -->
            <li class="sidebar-item">
                <a href="/sanction/reportList" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>업무 보고</span>
                </a>
            </li>
            </sec:authorize>
            <!-- /// 경영본부 끝 /// -->
            <!-- /// 물류 시작 /// -->
            <sec:authorize access = "hasAnyRole('MR','SYS','CEO')">
            <li class="sidebar-title">물류</li>
             <li class="sidebar-item">
                <a href="/inventory/list" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>재고 현황</span>
                </a>
            </li>
            
            <!-- <li class="sidebar-item ">
                <a href="/inventory/incoming" class='sidebar-link'>
					<a href="/receivingCheck/test" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>입고 내역</span>
                </a>
            </li> -->
            <li class="sidebar-item">
                <a href="/inventory/gmjGR" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>가맹점별 출고</span>
                </a>
	            <%-- <ul class="submenu">
	                
	                	<li class="submenu-item  ">
	                        <a href="/gmj/gmj${userVO.storeNo}/selling"
	                        	class="submenu-link">원래 매출 분석/조회</a>
	                    </li>
	                    
	                    <li class="submenu-item  ">
	                        <a href="/inventory/outcoming" 
	                        	class="submenu-link">품목별 출고</a>
	                    </li>
	                    <li class="submenu-item  ">
	                        <a href="/inventory/outcoming" 
	                        	class="submenu-link">가맹점별 출고</a>
	                    </li>
	                    
	                    <li class="submenu-item  ">
	                        <a href="/inventory/outcoming" 
	                        	class="submenu-link">날짜별 출고</a>
	                    </li>
	                   
	                </ul> --%>
            </li>
<!--             <li class="sidebar-item"> -->
<!--                 <a href="/bonsa/order" class='sidebar-link'> -->
<!--                     <i class="bi bi-grid-fill"></i> -->
<!--                     <span>견적 관리</span> -->
<!--                 </a> -->
<!--             </li>     -->
<!--                 <ul class="submenu"> -->
<!--                     <li class="submenu-item  "> -->
<!--                         <a href="/bonsa/order"  -->
<!--                         	class="submenu-link">견적 요청 조회</a> -->
<!--                     </li> -->
<!--                     <li class="submenu-item  "> -->
<!--                         <a href="/dist/component-accordion.html"  -->
<!--                         	class="submenu-link">견적</a> -->
<!--                     </li> -->
<!--                     <li class="submenu-item  "> -->
<!--                         <a href="/dist/component-accordion.html"  -->
<!--                         	class="submenu-link">발주/주문 관리</a> -->
<!--                     </li> -->
<!--                 </ul> -->
            
           
            </sec:authorize>
            <!-- /// 물류 끝 /// -->
             <!-- /// 전략/기획 시작 /// -->
            <sec:authorize access = "hasAnyRole('GH','SYS','CEO')">
            <li class="sidebar-title">전략/기획</li>
            <li class="sidebar-item">
                <a href="/menu/manage" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>메뉴 관리</span>
                </a>
            </li>    
            <li class="sidebar-item">
                <a href="/item/itemList" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>품목 관리</span>
                </a>
            </li>    
            
            </sec:authorize>
            <!-- /// 전략/기획 끝 /// -->
        	<!-- /// 인사/행정 시작 /// -->
        	<sec:authorize access = "hasAnyRole('IS','SYS','CEO')">
            <li class="sidebar-title">인사/행정</li>
            <li class="sidebar-item ">
                <a href="/commute" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>출퇴근 조회</span>
                </a>
                <!-- <ul class="submenu">
                    <li class="submenu-item">
                        <a href="/commute" 
                        	class="submenu-link">출퇴근 조회</a>
                    </li>
                </ul> -->
            </li>
            <li class="sidebar-item">
                <a href="/hr/manage" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>본사 직원 조회</span>
                </a>
            </li>
            </sec:authorize>
            <!-- /// 인사/행정 끝 /// -->
            <!-- /// 가맹점 시작 /// -->
            <sec:authorize access = "hasAnyRole('GMJ','SYS','CEO')">
            <sec:authentication property="principal.userVO" var="userVO"/>
            <li class="sidebar-title">가맹점</li>
            <li class="sidebar-item">
                <a href="/gmj/order" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>발주</span>
                </a>
            </li>
            
            <li class="sidebar-item has-sub">
                <a href="/dist/index.html" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>영업 관리</span>
                </a>
                 
                <ul class="submenu">
                
                	<%-- <li class="submenu-item  ">
                        <a href="/gmj/gmj${userVO.storeNo}/selling"
                        	class="submenu-link">원래 매출 분석/조회</a>
                    </li>
                     --%>
                    <li class="submenu-item  ">
                        <a href="/gmj/gmj${userVO.storeNo}/sellingMenu" 
                        	class="submenu-link">메뉴별 판매현황</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/gmj/gmj${userVO.storeNo}/sellingDate" 
                        	class="submenu-link">기간별 매출</a>
                    </li>
                    
                    <li class="submenu-item  ">
                        <a href="/gmj/gmj${userVO.storeNo}/sellingInsert" 
                        	class="submenu-link">보정계수 관리</a>
                    </li>
                    
                    <li class="submenu-item  ">
                        <a href="/gmj/gmj${userVO.storeNo}/budget" 
                        	class="submenu-link">예산 관리</a>
                    </li>
                    <!-- <li class="submenu-item  ">
                        <a href="/menu/manage" 
                        	class="submenu-link">메뉴 관리</a>
                    </li> -->
                </ul>
                </sec>
            </li>
            <li class="sidebar-item has-sub ">
                <a href="/dist/index.html" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>직원 관리</span>
                </a>
                <ul class="submenu">
                    <li class="submenu-item  ">
                        <a href="/commute2" 
                        	class="submenu-link">근태 관리</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/gmj/gmj${userVO.storeNo}/salary" 
                        	class="submenu-link">급여 지급 관리</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/calendarStore/test" 
                        	class="submenu-link">근무 일정 관리</a>
                    </li>
                </ul>
            </li>
             <!-- /// 가맹점직원 시작 /// -->
            <%-- --%>
            <sec:authorize access = "hasAnyRole('ALBA','SYS','CEO')">
            <li class="sidebar-title">가맹점직원</li>
            <li class="sidebar-item ">
                <a href="/calendarStore/test" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>근무 일정 조회</span>
                </a>
            </li>
            </sec:authorize> 
            <!-- /// 가맹점직원 끝 /// -->
<!--             <li class="sidebar-item has-sub"> -->
<!--                 <a href="/dist/index.html" class='sidebar-link'> -->
<!--                     <i class="bi bi-grid-fill"></i> -->
<!--                     <span>발주/주문</span> -->
<!--                 </a> -->
<!--                 <ul class="submenu"> -->
<!--                     <li class="submenu-item  "> -->
<%--                         <a href="/gmj${userVO.storeNo}/order"  --%>
<!--                         	class="submenu-link">발주/주문</a> -->
<!--                     </li> -->
<!--                     <li class="submenu-item  "> -->
<%--                         <a href="/gmj${userVO.storeNo}/estimate"  --%>
<!--                         	class="submenu-link">견적</a> -->
<!--                     </li> -->
<!--                     <li class="submenu-item  "> -->
<%--                         <a href="/gmj${userVO.storeNo}/bill"  --%>
<!--                         	class="submenu-link">계산</a> -->
<!--                     </li> -->
<!--                     <li class="submenu-item  "> -->
<!--                         <a href="/dist/component-accordion.html"  -->
<!--                         	class="submenu-link">발주/주문 관리</a> -->
<!--                     </li> -->
<!--                 </ul> -->
<!--             </li> -->
            </sec:authorize>
            <!-- /// 가맹점 끝 /// -->
            <!-- /// 가맹점직원 시작 /// -->
            <%-- <sec:authorize access = "hasAnyRole('ALBA','SYS','CEO')">
            <li class="sidebar-title">가맹점직원</li>
            <li class="sidebar-item ">
                <a href="/calendarStore/test" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>근무 일정 조회</span>
                </a>
            </li>
            </sec:authorize> --%>
            <!-- /// 가맹점직원 끝 /// -->
           
            
            
            
            
            <!-- 
             <li class="sidebar-item has-sub">
                <a href="/dist/index.html" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>[본사 직원]</span>
                </a>
                <ul class="submenu">
                    <li class="submenu-item  ">
                        <a href="/dist/component-accordion.html" 
                        	class="submenu-link">경영</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/gmj/budget" 
                        	class="submenu-link">인사/행정</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/dist/component-accordion.html" 
                        	class="submenu-link">재정/회계</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/dist/component-accordion.html" 
                        	class="submenu-link">전략/기획</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/dist/component-accordion.html" 
                        	class="submenu-link">물류</a>
                    </li>
                </ul>
            </li>
            <li class="sidebar-item has-sub">
                <a href="/dist/index.html" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>[가맹점주]</span>
                </a>
                <ul class="submenu">
                    <li class="submenu-item  ">
                        <a href="/dist/component-accordion.html" 
                        	class="submenu-link">직원 관리</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/gmj/budget" 
                        	class="submenu-link">예산 관리</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/dist/component-accordion.html" 
                        	class="submenu-link">메뉴 관리</a>
                    </li>
                </ul>
            </li>
            <li class="sidebar-item has-sub">
                <a href="/dist/index.html" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>[가맹점 직원]</span>
                </a>
                <ul class="submenu">
                    <li class="submenu-item  ">
                        <a href="calendarStore/test" 
                        	class="submenu-link">근무 일정 조회</a>
                    </li>
                </ul>
            </li>
            <li class="sidebar-item">
                <a href="/dist/index.html" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>업무 보고</span>
                </a>
            </li>
            <li class="sidebar-item has-sub">
                <a href="/dist/index.html" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>발주/재고 조회</span>
                </a>
                <ul class="submenu">
                    <li class="submenu-item  ">
                        <a href="/bonsa/bonsaOrderList" 
                        	class="submenu-link">발주/주문 관리</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/dist/component-accordion.html" 
                        	class="submenu-link">재고 조회</a>
                    </li>
                </ul>
            </li>
            -->
            <!-- /// 시스템관리자 끝 /// -->
	        </ul>
	    </div>
	</div>
</div>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
let today = new Date();
let year = today.getFullYear();
let month = ('0' + (today.getMonth() + 1)).slice(-2);
let date = today.getDate();
let day = today.getDay();
var week = ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'];         
let todayLabel = week[day]; 
let str = year + '/' + month + '/' + date + '/' + todayLabel;
$("#now").html(str);


let timerInterval = null; // setInterval() ID 보관
let workStartTime = null; // 출근 버튼 누른 시점(Date)

function formatTimeDiff(ms) {
    let totalSeconds = Math.floor(ms / 1000);
    let hours = Math.floor(totalSeconds / 3600);
    let minutes = Math.floor((totalSeconds % 3600) / 60);
    let seconds = totalSeconds % 60;
    
    // 두 자리 숫자로 만들기
    let hh = hours.toString().padStart(2, '0');
    let mm = minutes.toString().padStart(2, '0');
    let ss = seconds.toString().padStart(2, '0');
    return hh + ":" + mm + ":" + ss;
}

function startTimer() {
    // workStartTime이 로컬 저장소에 이미 있는지 확인
    const savedStartTime = localStorage.getItem('workStartTime');
    if (savedStartTime) {
        workStartTime = new Date(savedStartTime);
    } else {
        workStartTime = new Date(); // 출근 버튼 누른 시점
        localStorage.setItem('workStartTime', workStartTime); // 저장
    }

    // 이미 돌고 있는 interval 있으면 정리
    if (timerInterval) {
        clearInterval(timerInterval);
    }

/*     let now = new Date();
    let diff = now - workStartTime;
    // 화면 표시 (#workingHours)
    $("#workingHours").text(formatTimeDiff(diff)); */
     
    
    timerInterval = setInterval(() => {
        let now = new Date();
        let diff = now - workStartTime;
        // 화면 표시 (#workingHours)
        $("#workingHours").text(formatTimeDiff(diff));
    }, 1000);
}

//타이머 종료
function stopTimer() {
    if(timerInterval) {
        clearInterval(timerInterval);
        timerInterval = null;
    }
    localStorage.removeItem('workStartTime');
}

$(document).ready(function () {
    const savedStartTime = localStorage.getItem('workStartTime');
    if (savedStartTime) {
        workStartTime = new Date(savedStartTime);
        startTimer();
    }
});


function updateTime() {
    const now = new Date();
    const timeString = now.toLocaleTimeString('ko-KR', {
        hour: '2-digit',
        minute: '2-digit',
        second: '2-digit',
        hour12: false
    });
    document.getElementById('currentTime').textContent = timeString;
}

setInterval(updateTime, 1000);
updateTime(); 


$("#start").on('click',function(){
	var today = new Date();
	var year = today.getFullYear();
	var month = ('0' + (today.getMonth() + 1)).slice(-2);
	var day = ('0' + today.getDate()).slice(-2);
	var dateString = year + '/' + month  + '/' + day;
	var hours = ('0' + today.getHours()).slice(-2); 
	var minutes = ('0' + today.getMinutes()).slice(-2);
	var seconds = ('0' + today.getSeconds()).slice(-2); 
	var timeString = hours + ':' + minutes  + ':' + seconds;

	console.log("출근 날짜:",dateString);
	console.log("출근 시간:",timeString);
	
	let data={
		schdulDate:dateString,
		attend:timeString
	};
	console.log("출근 데이터", data);
	
	$.ajax({
		url:"/start",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(data),
		type:"post",
		dataType:"json",
		success:function(result){
			if(result>0){
				alert("출석처리됐어용");
				startTimer();
			}
			else{
				alert("이미 처리됐어용");
			}
		},
		
	})
	
})

$("#end").on('click',function(){
	 if (!workStartTime) {
	        alert("출근 기록이 없습니다. 먼저 출근하기 버튼을 눌러주세요.");
	        return;
	    }

		var today = new Date();
		var year = today.getFullYear();
		var month = ('0' + (today.getMonth() + 1)).slice(-2);
		var day = ('0' + today.getDate()).slice(-2);
		var dateString = year + '/' + month  + '/' + day;
		var hours = ('0' + today.getHours()).slice(-2); 
		var minutes = ('0' + today.getMinutes()).slice(-2);
		var seconds = ('0' + today.getSeconds()).slice(-2); 
		var timeString = hours + ':' + minutes  + ':' + seconds;
		
		console.log("퇴근 날짜:",dateString);
		console.log("퇴근 시간:",timeString);
		
	    let diffMs = today - workStartTime; 
	    let workingTimeStr = formatTimeDiff(diffMs);
	    
		let data={
				schdulDate:dateString,
				leave:timeString,
				workingTime: workingTimeStr
			};
		
		console.log("퇴근 데이터", data);
			$.ajax({
				url:"/end",
				contentType:"application/json;charset=utf-8",
				data:JSON.stringify(data),
				type:"post",
				dataType:"json",
				success:function(result){
					if(result>0){
						alert("퇴근 처리됐어용");
		                $("#workingHours").text(workingTimeStr);
		                stopTimer();
					}
				}
				
			})
})



$("#logout").on('click', function(){
    if (workStartTime) {
        var today = new Date();
        var year = today.getFullYear();
        var month = ('0' + (today.getMonth() + 1)).slice(-2);
        var day = ('0' + today.getDate()).slice(-2);
        var dateString = year + '/' + month + '/' + day;
        var hours = ('0' + today.getHours()).slice(-2); 
        var minutes = ('0' + today.getMinutes()).slice(-2);
        var seconds = ('0' + today.getSeconds()).slice(-2); 
        var timeString = hours + ':' + minutes + ':' + seconds;

        console.log("퇴근 날짜:", dateString);
        console.log("퇴근 시간:", timeString);

        let diffMs = today - workStartTime; 
        let workingTimeStr = formatTimeDiff(diffMs);
        
        let data = {
            schdulDate: dateString,
            leave: timeString,
            workingTime: workingTimeStr
        };

        console.log("퇴근 데이터", data);
        $.ajax({
            url: "/end",
            contentType: "application/json;charset=utf-8",
            data: JSON.stringify(data),
            type: "post",
            dataType: "json",
            success: function(result){
                if(result > 0){
                    alert("퇴근 처리됐어용");
                    $("#workingHours").text(workingTimeStr);
                    stopTimer();
                }
            },
            error: function(xhr, status, error){
                console.error("퇴근 처리 오류:", error);
                alert("퇴근 처리 중 오류가 발생했습니다.");
            },
            complete: function () {
                stopTimer(); // 타이머 멈춤 및 초기화
                localStorage.clear(); // 로컬스토리지 초기화
                window.location.href = "/logout"; // 로그아웃 요청
            }
        });
        
    }
});

document.addEventListener('DOMContentLoaded', function() {
    console.log("DOM loaded");
    const currentPath = window.location.pathname;
    const sidebarItems = document.querySelectorAll('.sidebar-item.has-sub');
    
    // 모든 서브메뉴 닫기
    function closeAllSubmenus() {
        sidebarItems.forEach(item => {
            const submenu = item.querySelector('.submenu');
            if (submenu && item !== this) {  // 현재 클릭한 항목 제외
                submenu.style.display = 'none';
                item.classList.remove('active');
            }
        });
    }
    
    // 활성 메뉴로 스크롤
    function scrollToActiveMenu() {
        const activeItem = document.querySelector('.sidebar-item.active');
        if (activeItem) {
            activeItem.scrollIntoView({
                behavior: 'smooth',
                block: 'center'
            });
        }
    }

    // 사이드바 아이템 이벤트 처리
    sidebarItems.forEach(item => {
        const submenu = item.querySelector('.submenu');
        const link = item.querySelector('.sidebar-link');
        
        if (link && submenu) {
            link.addEventListener('click', function(e) {
                e.preventDefault();
                e.stopPropagation();
                
                closeAllSubmenus.call(item); // 다른 서브메뉴 닫기
                
                // 현재 서브메뉴 토글
                const isOpen = submenu.style.display === 'block';
                submenu.style.display = isOpen ? 'none' : 'block';
                item.classList.toggle('active');
            });

            // 현재 경로와 일치하는 서브메뉴 링크 활성화
            const submenuLinks = submenu.querySelectorAll('.submenu-link');
            submenuLinks.forEach(subLink => {
                if (subLink.getAttribute('href') === currentPath) {
                    subLink.parentElement.classList.add('active');
                    item.classList.add('active');
                    submenu.style.display = 'block';
                    scrollToActiveMenu();
                }
            });
        }
    });

    // 메인 링크 활성화
    const mainLinks = document.querySelectorAll('.sidebar-link');
    mainLinks.forEach(link => {
        if (link.getAttribute('href') === currentPath) {
            const sidebarItem = link.closest('.sidebar-item');
            if (sidebarItem) {
                sidebarItem.classList.add('active');
                scrollToActiveMenu();
            }
        }
    });
});



</script>   
<style>
/* 사이드바 전체 스타일 수정 */
.sidebar-wrapper {
    height: 100vh;
    overflow-y: auto;
    padding-bottom: 60px;
    position: fixed; /* 고정 위치 */
    left: 0;
    top: 0;
    width: 300px; /* 사이드바 너비 */
    z-index: 1000;
}

/* 서브메뉴 스타일 수정 */
.submenu {
    position: relative;
    display: none;
    background: #fff;
    padding: 0;
    margin: 0;
    max-height: none !important; /* 높이 제한 제거 */
    overflow: visible !important; /* 오버플로우 제거 */
    transition: all 0.3s ease;
}

/* 서브메뉴 아이템 스타일 */
.submenu-item {
    width: 100%;
    margin: 0;
    position: relative;
    list-style: none;
}

/* 활성화된 서브메뉴 표시 */
.sidebar-item.has-sub.active .submenu {
    display: block;
}

/* 스크롤바 스타일링 */
.sidebar-wrapper::-webkit-scrollbar {
    width: 5px;
}

.sidebar-wrapper::-webkit-scrollbar-track {
    background: #f1f1f1;
}

.sidebar-wrapper::-webkit-scrollbar-thumb {
    background: #888;
    border-radius: 5px;
}
.sidebar-wrapper .menu .sidebar-item.active>.sidebar-link {
    background-color: #ffc107 !important;
}

</style>