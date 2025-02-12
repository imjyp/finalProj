<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <title>Dashboard - Mazer Admin Dashboard</title>
    
    
    
    <link rel="shortcut icon" href="/dist/assets/compiled/svg/favicon.svg" type="image/x-icon">
    <link rel="shortcut icon" href="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACEAAAAiCAYAAADRcLDBAAAEs2lUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4KPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iWE1QIENvcmUgNS41LjAiPgogPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4KICA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIgogICAgeG1sbnM6ZXhpZj0iaHR0cDovL25zLmFkb2JlLmNvbS9leGlmLzEuMC8iCiAgICB4bWxuczp0aWZmPSJodHRwOi8vbnMuYWRvYmUuY29tL3RpZmYvMS4wLyIKICAgIHhtbG5zOnBob3Rvc2hvcD0iaHR0cDovL25zLmFkb2JlLmNvbS9waG90b3Nob3AvMS4wLyIKICAgIHhtbG5zOnhtcD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLyIKICAgIHhtbG5zOnhtcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIgogICAgeG1sbnM6c3RFdnQ9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZUV2ZW50IyIKICAgZXhpZjpQaXhlbFhEaW1lbnNpb249IjMzIgogICBleGlmOlBpeGVsWURpbWVuc2lvbj0iMzQiCiAgIGV4aWY6Q29sb3JTcGFjZT0iMSIKICAgdGlmZjpJbWFnZVdpZHRoPSIzMyIKICAgdGlmZjpJbWFnZUxlbmd0aD0iMzQiCiAgIHRpZmY6UmVzb2x1dGlvblVuaXQ9IjIiCiAgIHRpZmY6WFJlc29sdXRpb249Ijk2LjAiCiAgIHRpZmY6WVJlc29sdXRpb249Ijk2LjAiCiAgIHBob3Rvc2hvcDpDb2xvck1vZGU9IjMiCiAgIHBob3Rvc2hvcDpJQ0NQcm9maWxlPSJzUkdCIElFQzYxOTY2LTIuMSIKICAgeG1wOk1vZGlmeURhdGU9IjIwMjItMDMtMzFUMTA6NTA6MjMrMDI6MDAiCiAgIHhtcDpNZXRhZGF0YURhdGU9IjIwMjItMDMtMzFUMTA6NTA6MjMrMDI6MDAiPgogICA8eG1wTU06SGlzdG9yeT4KICAgIDxyZGY6U2VxPgogICAgIDxyZGY6bGkKICAgICAgc3RFdnQ6YWN0aW9uPSJwcm9kdWNlZCIKICAgICAgc3RFdnQ6c29mdHdhcmVBZ2VudD0iQWZmaW5pdHkgRGVzaWduZXIgMS4xMC4xIgogICAgICBzdEV2dDp3aGVuPSIyMDIyLTAzLTMxVDEwOjUwOjIzKzAyOjAwIi8+CiAgICA8L3JkZjpTZXE+CiAgIDwveG1wTU06SGlzdG9yeT4KICA8L3JkZjpEZXNjcmlwdGlvbj4KIDwvcmRmOlJERj4KPC94OnhtcG1ldGE+Cjw/eHBhY2tldCBlbmQ9InIiPz5V57uAAAABgmlDQ1BzUkdCIElFQzYxOTY2LTIuMQAAKJF1kc8rRFEUxz9maORHo1hYKC9hISNGTWwsRn4VFmOUX5uZZ36oeTOv954kW2WrKLHxa8FfwFZZK0WkZClrYoOe87ypmWTO7dzzud97z+nec8ETzaiaWd4NWtYyIiNhZWZ2TvE946WZSjqoj6mmPjE1HKWkfdxR5sSbgFOr9Ll/rXoxYapQVik8oOqGJTwqPL5i6Q5vCzeo6dii8KlwpyEXFL519LjLLw6nXP5y2IhGBsFTJ6ykijhexGra0ITl5bRqmWU1fx/nJTWJ7PSUxBbxJkwijBBGYYwhBgnRQ7/MIQIE6ZIVJfK7f/MnyUmuKrPOKgZLpEhj0SnqslRPSEyKnpCRYdXp/9++msneoFu9JgwVT7b91ga+LfjetO3PQ9v+PgLvI1xkC/m5A+h7F32zoLXug38dzi4LWnwHzjeg8UGPGbFfySvuSSbh9QRqZ6H+Gqrm3Z7l9zm+h+iafNUV7O5Bu5z3L/wAdthn7QIme0YAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAJTSURBVFiF7Zi9axRBGIefEw2IdxFBRQsLWUTBaywSK4ubdSGVIY1Y6HZql8ZKCGIqwX/AYLmCgVQKfiDn7jZeEQMWfsSAHAiKqPiB5mIgELWYOW5vzc3O7niHhT/YZvY37/swM/vOzJbIqVq9uQ04CYwCI8AhYAlYAB4Dc7HnrOSJWcoJcBS4ARzQ2F4BZ2LPmTeNuykHwEWgkQGAet9QfiMZjUSt3hwD7psGTWgs9pwH1hC1enMYeA7sKwDxBqjGnvNdZzKZjqmCAKh+U1kmEwi3IEBbIsugnY5avTkEtIAtFhBrQCX2nLVehqyRqFoCAAwBh3WGLAhbgCRIYYinwLolwLqKUwwi9pxV4KUlxKKKUwxC6ZElRCPLYAJxGfhSEOCz6m8HEXvOB2CyIMSk6m8HoXQTmMkJcA2YNTHm3congOvATo3tE3A29pxbpnFzQSiQPcB55IFmFNgFfEQeahaAGZMpsIJIAZWAHcDX2HN+2cT6r39GxmvC9aPNwH5gO1BOPFuBVWAZue0vA9+A12EgjPadnhCuH1WAE8ivYAQ4ohKaagV4gvxi5oG7YSA2vApsCOH60WngKrA3R9IsvQUuhIGY00K4flQG7gHH/mLytB4C42EgfrQb0mV7us8AAMeBS8mGNMR4nwHamtBB7B4QRNdaS0M8GxDEog7iyoAguvJ0QYSBuAOcAt71Kfl7wA8DcTvZ2KtOlJEr+ByyQtqqhTyHTIeB+ONeqi3brh+VgIN0fohUgWGggizZFTplu12yW8iy/YLOGWMpDMTPXnl+Az9vj2HERYqPAAAAAElFTkSuQmCC" type="image/png">
    


  <link rel="stylesheet" href="/dist/assets/compiled/css/app.css">
  <link rel="stylesheet" href="/dist/assets/compiled/css/app-dark.css">
  <link rel="stylesheet" href="/dist/assets/compiled/css/iconly.css">
</head>

<body>
    <script src="assets/static/js/initTheme.js"></script>
    <div id="app">
        <div id="sidebar">
            <div class="sidebar-wrapper active">
    <div class="sidebar-header position-relative">
        <div class="d-flex justify-content-between align-items-center">
            <div class="logo">
                <a href="/dist/index.html"><img src="/dist/assets/compiled/svg/logo.svg" alt="Logo" srcset=""></a>
            </div>
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
                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true"
                    role="img" class="iconify iconify--mdi" width="20" height="20" preserveAspectRatio="xMidYMid meet"
                    viewBox="0 0 24 24">
                    <path fill="currentColor"
                        d="m17.75 4.09l-2.53 1.94l.91 3.06l-2.63-1.81l-2.63 1.81l.91-3.06l-2.53-1.94L12.44 4l1.06-3l1.06 3l3.19.09m3.5 6.91l-1.64 1.25l.59 1.98l-1.7-1.17l-1.7 1.17l.59-1.98L15.75 11l2.06-.05L18.5 9l.69 1.95l2.06.05m-2.28 4.95c.83-.08 1.72 1.1 1.19 1.85c-.32.45-.66.87-1.08 1.27C15.17 23 8.84 23 4.94 19.07c-3.91-3.9-3.91-10.24 0-14.14c.4-.4.82-.76 1.27-1.08c.75-.53 1.93.36 1.85 1.19c-.27 2.86.69 5.83 2.89 8.02a9.96 9.96 0 0 0 8.02 2.89m-1.64 2.02a12.08 12.08 0 0 1-7.8-3.47c-2.17-2.19-3.33-5-3.49-7.82c-2.81 3.14-2.7 7.96.31 10.98c3.02 3.01 7.84 3.12 10.98.31Z">
                    </path>
                </svg>
            </div>
            <div class="sidebar-toggler  x">
                <a href="#" class="sidebar-hide d-xl-none d-block"><i class="bi bi-x bi-middle"></i></a>
            </div>
        </div>
        <!-- /// 마이페이지 / 알림 / 로그아웃 버튼 시작 /// -->
        <div class="d-flex justify-content-between align-items-center">
            <div class="logo">
                마이페이지
            </div>
            <div class="logo">
            	알림
            </div>
            <div class="logo">
                로그아웃
            </div>
        </div>
        <!-- /// 마이페이지 / 알림 / 로그아웃 버튼 끝 /// -->
    </div>
    <div class="sidebar-menu">
        <ul class="menu">
        	<!-- /// 채팅 시작 /// -->
        	<li class="sidebar-item  ">
                <a href="/dist/application-chat.html" class='sidebar-link'>
                    <i class="bi bi-chat-dots-fill"></i>
                    <span>채팅</span>
                </a>
            </li>
        	<!-- /// 채팅 끝 /// -->
        	<!-- /// 전자결재 시작 /// -->
        	<li class="sidebar-item  ">
                <a href="/dist/application-chat.html" class='sidebar-link'>
                    <i class="bi bi-chat-dots-fill"></i>
                    <span>전자결재</span>
                </a>
            </li>
        	<!-- /// 전자결재 끝 /// -->
        	<!-- /// 경영본부 시작 /// -->
            <li class="sidebar-title">경영본부</li>
            <li class="sidebar-item active ">
                <a href="/dist/index.html" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>가맹점 관리</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="/dist/index.html" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>이벤트 관리</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="/dist/index.html" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>회사 정보 관리</span>
                </a>
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
                        <a href="/dist/component-accordion.html" 
                        	class="submenu-link">발주/주문 관리</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/dist/component-accordion.html" 
                        	class="submenu-link">재고 조회</a>
                    </li>
                </ul>
            </li>
            <!-- /// 경영본부 끝 /// -->
        	<!-- /// 인사/행정 시작 /// -->
            <li class="sidebar-title">인사/행정</li>
            <li class="sidebar-item has-sub active">
                <a href="/dist/index.html" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>근태 관리</span>
                </a>
                <ul class="submenu">
                    <li class="submenu-item">
                        <a href="/dist/component-accordion.html" 
                        	class="submenu-link">출퇴근 조회</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/dist/component-accordion.html" 
                        	class="submenu-link">후가 조회 / 관리</a>
                    </li>
                </ul>
            </li>
            <li class="sidebar-item">
                <a href="/dist/index.html" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>인사 관리</span>
                </a>
            </li>
            <li class="sidebar-item has-sub">
                <a href="/dist/index.html" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>발주/재고 조회</span>
                </a>
                <ul class="submenu">
                    <li class="submenu-item  ">
                        <a href="/dist/component-accordion.html" 
                        	class="submenu-link">발주/주문 관리</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/dist/component-accordion.html" 
                        	class="submenu-link">재고 조회</a>
                    </li>
                </ul>
            </li>
            <!-- /// 인사/행정 끝 /// -->
            <!-- /// 재정/회계 시작 /// -->
            <li class="sidebar-title">재정/회계</li>
            <li class="sidebar-item active ">
                <a href="/dist/index.html" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>계산서 관리</span>
                </a>
            </li>
            <li class="sidebar-item has-sub">
                <a href="/dist/index.html" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>본사 수익 분석</span>
                </a>
                <ul class="submenu">
                    <li class="submenu-item  ">
                        <a href="/dist/component-accordion.html" 
                        	class="submenu-link">수익 분석/조회</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/dist/component-accordion.html" 
                        	class="submenu-link">예산 관리</a>
                    </li>
                </ul>
            </li>
            <li class="sidebar-item">
                <a href="/dist/index.html" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>급여 관리</span>
                </a>
            </li>
            <li class="sidebar-item has-sub">
                <a href="/dist/index.html" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>발주/재고 조회</span>
                </a>
                <ul class="submenu">
                    <li class="submenu-item  ">
                        <a href="/dist/component-accordion.html" 
                        	class="submenu-link">발주/주문 관리</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/dist/component-accordion.html" 
                        	class="submenu-link">재고 조회</a>
                    </li>
                </ul>
            </li>
            <!-- /// 재정/회계 끝 /// -->
            <!-- /// 전략/기획 시작 /// -->
            <li class="sidebar-title">전략/기획</li>
            <li class="sidebar-item has-sub active">
                <a href="/dist/index.html" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>매출 분석/조회</span>
                </a>
                <ul class="submenu">
                    <li class="submenu-item  ">
                        <a href="/dist/component-accordion.html" 
                        	class="submenu-link">메뉴 관리</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/dist/component-accordion.html" 
                        	class="submenu-link">품목 관리</a>
                    </li>
                </ul>
            </li>
            <li class="sidebar-item has-sub">
                <a href="/dist/index.html" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>발주/재고 조회</span>
                </a>
                <ul class="submenu">
                    <li class="submenu-item  ">
                        <a href="/dist/component-accordion.html" 
                        	class="submenu-link">발주/주문 관리</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/dist/component-accordion.html" 
                        	class="submenu-link">재고 조회</a>
                    </li>
                </ul>
            </li>
            <!-- /// 전략/기획 끝 /// -->
            <!-- /// 물류 시작 /// -->
            <li class="sidebar-title">물류</li>
            <li class="sidebar-item active ">
                <a href="/dist/index.html" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>입고 조회</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="/dist/index.html" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>출고 조회</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="/dist/index.html" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>발주/주문 관리</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="/dist/index.html" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>재고 조회</span>
                </a>
            </li>
            <!-- /// 물류 끝 /// -->
            <!-- /// 가맹점 시작 /// -->
            <li class="sidebar-title">가맹점</li>
            <li class="sidebar-item has-sub active ">
                <a href="/dist/index.html" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>직원 관리</span>
                </a>
                <ul class="submenu">
                    <li class="submenu-item  ">
                        <a href="/dist/component-accordion.html" 
                        	class="submenu-link">근태 관리</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/dist/component-accordion.html" 
                        	class="submenu-link">급여 조회</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/dist/component-accordion.html" 
                        	class="submenu-link">근무 일정 관리</a>
                    </li>
                </ul>
            </li>
            <li class="sidebar-item has-sub">
                <a href="/dist/index.html" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>영업 관리</span>
                </a>
                <ul class="submenu">
                	<li class="submenu-item  ">
                        <a href="/dist/component-accordion.html" 
                        	class="submenu-link">매출 분석/조회</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/dist/component-accordion.html" 
                        	class="submenu-link">예산 관리</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/dist/component-accordion.html" 
                        	class="submenu-link">메뉴 관리</a>
                    </li>
                </ul>
            </li>
            <li class="sidebar-item">
                <a href="/dist/index.html" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>회사 정보 관리</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="/dist/index.html" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>발주/주문 보고</span>
                </a>
            </li>
            <!-- /// 가맹점 끝 /// -->
            <!-- /// 가맹점직원 시작 /// -->
            <li class="sidebar-title">가맹점직원</li>
            <li class="sidebar-item active ">
                <a href="/dist/index.html" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>근무 일정 조회</span>
                </a>
            </li>
            <!-- /// 가맹점직원 끝 /// -->
            <!-- /// 시스템관리자 시작 /// -->
            <li class="sidebar-title">시스템관리자</li>
            <li class="sidebar-item has-sub active">
                <a href="/dist/index.html" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>시스템 관리</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="/dist/index.html" class='sidebar-link'>
                    <i class="bi bi-grid-fill"></i>
                    <span>[본사 직원]</span>
                </a>
                <ul class="submenu">
                    <li class="submenu-item  ">
                        <a href="/dist/component-accordion.html" 
                        	class="submenu-link">권한 부여/관리</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/dist/component-accordion.html" 
                        	class="submenu-link">회원 관리</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/dist/component-accordion.html" 
                        	class="submenu-link">부서/직책 관리</a>
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
                        <a href="/dist/component-accordion.html" 
                        	class="submenu-link">예산 관리</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/dist/component-accordion.html" 
                        	class="submenu-link">메뉴 관리</a>
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
                        <a href="/dist/component-accordion.html" 
                        	class="submenu-link">발주/주문 관리</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/dist/component-accordion.html" 
                        	class="submenu-link">재고 조회</a>
                    </li>
                </ul>
            </li>
            <!-- /// 시스템관리자 끝 /// -->
            <li class="sidebar-item has-sub">
                <a href="#" class='sidebar-link'>
                    <i class="bi bi-stack"></i>
                    <span>Components</span>
                </a>
                <ul class="submenu ">
                    <li class="submenu-item  ">
                        <a href="/dist/component-accordion.html" class="submenu-link">Accordion</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/dist/component-alert.html" class="submenu-link">Alert</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/dist/component-badge.html" class="submenu-link">Badge</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/dist/component-breadcrumb.html" class="submenu-link">Breadcrumb</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/dist/component-button.html" class="submenu-link">Button</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/dist/component-card.html" class="submenu-link">Card</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/dist/component-carousel.html" class="submenu-link">Carousel</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/dist/component-collapse.html" class="submenu-link">Collapse</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/dist/component-dropdown.html" class="submenu-link">Dropdown</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/dist/component-list-group.html" class="submenu-link">List Group</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/dist/component-modal.html" class="submenu-link">Modal</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/dist/component-navs.html" class="submenu-link">Navs</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/dist/component-pagination.html" class="submenu-link">Pagination</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/dist/component-progress.html" class="submenu-link">Progress</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/dist/component-spinner.html" class="submenu-link">Spinner</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/dist/component-toasts.html" class="submenu-link">Toasts</a>
                    </li>
                    <li class="submenu-item  ">
                        <a href="/dist/component-tooltip.html" class="submenu-link">Tooltip</a>
                    </li>
                </ul>
            </li>
            
            <li
                class="sidebar-item  has-sub">
                <a href="#" class='sidebar-link'>
                    <i class="bi bi-collection-fill"></i>
                    <span>Extra Components</span>
                </a>
                
                <ul class="submenu ">
                    
                    <li class="submenu-item  ">
                        <a href="/dist/extra-component-avatar.html" class="submenu-link">Avatar</a>
                        
                    </li>
                    
                    <li class="submenu-item  ">
                        <a href="/dist/extra-component-divider.html" class="submenu-link">Divider</a>
                        
                    </li>
                    
                    <li class="submenu-item  ">
                        <a href="/dist/extra-component-date-picker.html" class="submenu-link">Date Picker</a>
                        
                    </li>
                    
                    <li class="submenu-item  ">
                        <a href="/dist/extra-component-sweetalert.html" class="submenu-link">Sweet Alert</a>
                        
                    </li>
                    
                    <li class="submenu-item  ">
                        <a href="/dist/extra-component-toastify.html" class="submenu-link">Toastify</a>
                        
                    </li>
                    
                    <li class="submenu-item  ">
                        <a href="/dist/extra-component-rating.html" class="submenu-link">Rating</a>
                        
                    </li>
                    
                </ul>
                

            </li>
            
            <li
                class="sidebar-item  has-sub">
                <a href="#" class='sidebar-link'>
                    <i class="bi bi-grid-1x2-fill"></i>
                    <span>Layouts</span>
                </a>
                
                <ul class="submenu ">
                    
                    <li class="submenu-item  ">
                        <a href="/dist/layout-default.html" class="submenu-link">Default Layout</a>
                        
                    </li>
                    
                    <li class="submenu-item  ">
                        <a href="/dist/layout-vertical-1-column.html" class="submenu-link">1 Column</a>
                        
                    </li>
                    
                    <li class="submenu-item  ">
                        <a href="/dist/layout-vertical-navbar.html" class="submenu-link">Vertical Navbar</a>
                        
                    </li>
                    
                    <li class="submenu-item  ">
                        <a href="/dist/layout-rtl.html" class="submenu-link">RTL Layout</a>
                        
                    </li>
                    
                    <li class="submenu-item  ">
                        <a href="/dist/layout-horizontal.html" class="submenu-link">Horizontal Menu</a>
                        
                    </li>
                    
                </ul>
                

            </li>
            
            <li class="sidebar-title">Forms &amp; Tables</li>
            
            <li
                class="sidebar-item  has-sub">
                <a href="#" class='sidebar-link'>
                    <i class="bi bi-hexagon-fill"></i>
                    <span>Form Elements</span>
                </a>
                
                <ul class="submenu ">
                    
                    <li class="submenu-item  ">
                        <a href="/dist/form-element-input.html" class="submenu-link">Input</a>
                        
                    </li>
                    
                    <li class="submenu-item  ">
                        <a href="/dist/form-element-input-group.html" class="submenu-link">Input Group</a>
                        
                    </li>
                    
                    <li class="submenu-item  ">
                        <a href="/dist/form-element-select.html" class="submenu-link">Select</a>
                        
                    </li>
                    
                    <li class="submenu-item  ">
                        <a href="/dist/form-element-radio.html" class="submenu-link">Radio</a>
                        
                    </li>
                    
                    <li class="submenu-item  ">
                        <a href="/dist/form-element-checkbox.html" class="submenu-link">Checkbox</a>
                        
                    </li>
                    
                    <li class="submenu-item  ">
                        <a href="/dist/form-element-textarea.html" class="submenu-link">Textarea</a>
                        
                    </li>
                    
                </ul>
                

            </li>
            
            <li
                class="sidebar-item  ">
                <a href="/dist/form-layout.html" class='sidebar-link'>
                    <i class="bi bi-file-earmark-medical-fill"></i>
                    <span>Form Layout</span>
                </a>
                

            </li>
            
            <li
                class="sidebar-item  has-sub">
                <a href="#" class='sidebar-link'>
                    <i class="bi bi-journal-check"></i>
                    <span>Form Validation</span>
                </a>
                
                <ul class="submenu ">
                    
                    <li class="submenu-item  ">
                        <a href="/dist/form-validation-parsley.html" class="submenu-link">Parsley</a>
                        
                    </li>
                    
                </ul>
                

            </li>
            
            <li
                class="sidebar-item  has-sub">
                <a href="#" class='sidebar-link'>
                    <i class="bi bi-pen-fill"></i>
                    <span>Form Editor</span>
                </a>
                
                <ul class="submenu ">
                    
                    <li class="submenu-item  ">
                        <a href="/dist/form-editor-quill.html" class="submenu-link">Quill</a>
                        
                    </li>
                    
                    <li class="submenu-item  ">
                        <a href="/dist/form-editor-ckeditor.html" class="submenu-link">CKEditor</a>
                        
                    </li>
                    
                    <li class="submenu-item  ">
                        <a href="/dist/form-editor-summernote.html" class="submenu-link">Summernote</a>
                        
                    </li>
                    
                    <li class="submenu-item  ">
                        <a href="/dist/form-editor-tinymce.html" class="submenu-link">TinyMCE</a>
                        
                    </li>
                    
                </ul>
                

            </li>
            
            <li
                class="sidebar-item  ">
                <a href="/dist/table.html" class='sidebar-link'>
                    <i class="bi bi-grid-1x2-fill"></i>
                    <span>Table</span>
                </a>
                

            </li>
            
            <li
                class="sidebar-item  has-sub">
                <a href="#" class='sidebar-link'>
                    <i class="bi bi-file-earmark-spreadsheet-fill"></i>
                    <span>Datatables</span>
                </a>
                
                <ul class="submenu ">
                    
                    <li class="submenu-item  ">
                        <a href="/dist/table-datatable.html" class="submenu-link">Datatable</a>
                        
                    </li>
                    
                    <li class="submenu-item  ">
                        <a href="/dist/table-datatable-jquery.html" class="submenu-link">Datatable (jQuery)</a>
                        
                    </li>
                    
                </ul>
                

            </li>
            
            <li class="sidebar-title">Extra UI</li>
            
            <li
                class="sidebar-item  has-sub">
                <a href="#" class='sidebar-link'>
                    <i class="bi bi-pentagon-fill"></i>
                    <span>Widgets</span>
                </a>
                
                <ul class="submenu ">
                    
                    <li class="submenu-item  ">
                        <a href="/dist/ui-widgets-chatbox.html" class="submenu-link">Chatbox</a>
                        
                    </li>
                    
                    <li class="submenu-item  ">
                        <a href="/dist/ui-widgets-pricing.html" class="submenu-link">Pricing</a>
                        
                    </li>
                    
                    <li class="submenu-item  ">
                        <a href="/dist/ui-widgets-todolist.html" class="submenu-link">To-do List</a>
                        
                    </li>
                    
                </ul>
                

            </li>
            
            <li
                class="sidebar-item  has-sub">
                <a href="#" class='sidebar-link'>
                    <i class="bi bi-egg-fill"></i>
                    <span>Icons</span>
                </a>
                
                <ul class="submenu ">
                    
                    <li class="submenu-item  ">
                        <a href="/dist/ui-icons-bootstrap-icons.html" class="submenu-link">Bootstrap Icons </a>
                        
                    </li>
                    
                    <li class="submenu-item  ">
                        <a href="/dist/ui-icons-fontawesome.html" class="submenu-link">Fontawesome</a>
                        
                    </li>
                    
                    <li class="submenu-item  ">
                        <a href="/dist/ui-icons-dripicons.html" class="submenu-link">Dripicons</a>
                        
                    </li>
                    
                </ul>
                

            </li>
            
            <li
                class="sidebar-item  has-sub">
                <a href="#" class='sidebar-link'>
                    <i class="bi bi-bar-chart-fill"></i>
                    <span>Charts</span>
                </a>
                
                <ul class="submenu ">
                    
                    <li class="submenu-item  ">
                        <a href="/dist/ui-chart-chartjs.html" class="submenu-link">ChartJS</a>
                        
                    </li>
                    
                    <li class="submenu-item  ">
                        <a href="/dist/ui-chart-apexcharts.html" class="submenu-link">Apexcharts</a>
                        
                    </li>
                    
                </ul>
                

            </li>
            
            <li
                class="sidebar-item  ">
                <a href="/dist/ui-file-uploader.html" class='sidebar-link'>
                    <i class="bi bi-cloud-arrow-up-fill"></i>
                    <span>File Uploader</span>
                </a>
                

            </li>
            
            <li
                class="sidebar-item  has-sub">
                <a href="#" class='sidebar-link'>
                    <i class="bi bi-map-fill"></i>
                    <span>Maps</span>
                </a>
                
                <ul class="submenu ">
                    
                    <li class="submenu-item  ">
                        <a href="/dist/ui-map-google-map.html" class="submenu-link">Google Map</a>
                        
                    </li>
                    
                    <li class="submenu-item  ">
                        <a href="/dist/ui-map-jsvectormap.html" class="submenu-link">JS Vector Map</a>
                        
                    </li>
                    
                </ul>
                

            </li>
            
            <li
                class="sidebar-item  has-sub">
                <a href="#" class='sidebar-link'>
                    <i class="bi bi-three-dots"></i>
                    <span>Multi-level Menu</span>
                </a>
                
                <ul class="submenu ">
                    
                    <li class="submenu-item  has-sub">
                        <a href="#" class="submenu-link">First Level</a>
                        
                        <ul class="submenu submenu-level-2 ">

                            
                            <li class="submenu-item ">
                                <a href="/dist/ui-multi-level-menu.html" class="submenu-link">Second Level</a>
                            </li>
                            
                            <li class="submenu-item ">
                                <a href="#" class="submenu-link">Second Level Menu</a>
                            </li>
                            

                        </ul>
                        
                    </li>
                    
                    <li class="submenu-item  has-sub">
                        <a href="#" class="submenu-link">Another Menu</a>
                        
                        <ul class="submenu submenu-level-2 ">

                            
                            <li class="submenu-item ">
                                <a href="#" class="submenu-link">Second Level Menu</a>
                            </li>
                            

                        </ul>
                        
                    </li>
                    
                </ul>
                

            </li>
            
            <li class="sidebar-title">Pages</li>
            
            <li
                class="sidebar-item  ">
                <a href="/dist/application-email.html" class='sidebar-link'>
                    <i class="bi bi-envelope-fill"></i>
                    <span>Email Application</span>
                </a>
                

            </li>
            
            <li class="sidebar-item  ">
                <a href="/dist/application-chat.html" class='sidebar-link'>
                    <i class="bi bi-chat-dots-fill"></i>
                    <span>Chat Application</span>
                </a>
            </li>
            
            <li
                class="sidebar-item  ">
                <a href="/dist/application-gallery.html" class='sidebar-link'>
                    <i class="bi bi-image-fill"></i>
                    <span>Photo Gallery</span>
                </a>
                

            </li>
            
            <li
                class="sidebar-item  ">
                <a href="/dist/application-checkout.html" class='sidebar-link'>
                    <i class="bi bi-basket-fill"></i>
                    <span>Checkout Page</span>
                </a>
                

            </li>
            
            <li
                class="sidebar-item  has-sub">
                <a href="#" class='sidebar-link'>
                    <i class="bi bi-person-badge-fill"></i>
                    <span>Authentication</span>
                </a>
                
                <ul class="submenu ">
                    
                    <li class="submenu-item  ">
                        <a href="/dist/auth-login.html" class="submenu-link">Login</a>
                        
                    </li>
                    
                    <li class="submenu-item  ">
                        <a href="/dist/auth-register.html" class="submenu-link">Register</a>
                        
                    </li>
                    
                    <li class="submenu-item  ">
                        <a href="/dist/auth-forgot-password.html" class="submenu-link">Forgot Password</a>
                        
                    </li>
                    
                </ul>
                

            </li>
            
            <li
                class="sidebar-item  has-sub">
                <a href="#" class='sidebar-link'>
                    <i class="bi bi-x-octagon-fill"></i>
                    <span>Errors</span>
                </a>
                
                <ul class="submenu ">
                    
                    <li class="submenu-item  ">
                        <a href="/dist/error-403.html" class="submenu-link">403</a>
                        
                    </li>
                    
                    <li class="submenu-item  ">
                        <a href="/dist/error-404.html" class="submenu-link">404</a>
                        
                    </li>
                    
                    <li class="submenu-item  ">
                        <a href="/dist/error-500.html" class="submenu-link">500</a>
                        
                    </li>
                    
                </ul>
                

            </li>
            
            <li class="sidebar-title">Raise Support</li>
            
            <li
                class="sidebar-item  ">
                <a href="https://zuramai.github.io/mazer/docs" class='sidebar-link'>
                    <i class="bi bi-life-preserver"></i>
                    <span>Documentation</span>
                </a>
                

            </li>
            
            <li
                class="sidebar-item  ">
                <a href="https://github.com/zuramai/mazer/blob/main/CONTRIBUTING.md" class='sidebar-link'>
                    <i class="bi bi-puzzle"></i>
                    <span>Contribute</span>
                </a>
                

            </li>
            
            <li
                class="sidebar-item  ">
                <a href="https://github.com/zuramai/mazer#donation" class='sidebar-link'>
                    <i class="bi bi-cash"></i>
                    <span>Donate</span>
                </a>
                

            </li>
            
        </ul>
    </div>
</div>
        </div>