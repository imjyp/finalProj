<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!-- 헤더 시작 -->
<header class="header"><!-- 상단 고정 fixed 클래스 추가, 메뉴의 depth1 오버시 open 클래스 추가 -->
    <div class="headArea">
        <strong class="hLogo">
            <a href="/main">
                <img src="/upload/logo.png" alt="로고" class="mainlogo">
            </a>
        </strong>
        <nav class="hMenu">
            <div class="menu">
                <ul class="depth1">
                    <li>
                        <a href="#" class="dth1">CAFE@BEAN</a>
                        <ul class="depth2">
                            <li><a href="/companyInfo/test" class="dth2">회사 소개</a></li>
                            <li><a href="/orgChart/test" class="dth2">조직도</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#" class="dth1">MENU</a>
                        <ul class="depth2">
                            <li><a href="/itdmenu" class="dth2">메뉴 소개</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#" class="dth1">STORE</a>
                        <ul class="depth2">
                            <li><a href="/findingstore" class="dth2">매장 찾기</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#" class="dth1">NEWS</a>
                        <ul class="depth2">
                            <li><a href="/notice/list" class="dth2">공지사항</a></li>
                            <li><a href="/eventBoard/list" class="dth2">이벤트</a></li>
                            <li><a href="/suggest/list" class="dth2">건의게시판</a></li>
                        </ul>
                    </li>
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
                        <sec:authentication property="principal.userVO.alerts" var="alerts" />
                        <a href="/chattingRoom" class="renter">
                            <i class="bi bi-chat-dots-fill"></i>
                            <span>채팅</span>
                        </a>
                        <a href="/alert" class="lang">
                            <span class="alert-badge" id="alertBadge">0</span>
                            알림
                        </a>
                    </sec:authorize>
                </div>
            </form>
            <!-- //util -->
        </nav>
    </div>
    <form>
        <sec:authorize access="isAuthenticated()">
            <input type="hidden" id="userNo" value="<sec:authentication property='principal.userVO.userNo'/>" />
            <input type="hidden" id="csrfToken" value="8b44634f-d2ca-45f2-a86f-3d00547122cf" />
        </sec:authorize>
    </form>
</header>
<!-- 헤더 끝 -->
