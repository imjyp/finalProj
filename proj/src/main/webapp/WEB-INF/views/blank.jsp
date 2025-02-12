<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>
<!DOCTYPE html>
<!-- 로그인 권한 -->
<sec:authorize access="isAuthenticated()">
 <!-- 로그인 시 사이드바 시작-->
<%@ include file="./include/header.jsp" %>
<%@ include file="./include/top.jsp" %>
       <!-- <div id="main"> -->
            <header class="mb-3">
                <a href="#" class="burger-btn d-block d-xl-none">
                    <i class="bi bi-justify fs-3"></i>
                </a>
            </header>
</sec:authorize>
 <!-- 로그인 시 사이드바 끝-->
 
 <!-- 비회원 메인 페이지(사이드바 없음) 시작 -->
<%@ include file="./include/top.jsp" %>
 <!-- 비회원 메인 페이지(사이드바 없음) 끝 -->

	

<%@ include file="./include/footer.jsp" %>