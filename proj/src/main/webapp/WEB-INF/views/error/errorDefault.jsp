<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
	<!-- 로그인 시 사이드바 시작-->
	<%@ include file="../include/header.jsp"%>
	<div id="main">
	<header class="mb-3">
		<a href="#" class="burger-btn d-block d-xl-none"> <i
			class="bi bi-justify fs-3"></i>
		</a>
	</header>
<div class="container-fluid">

    <!-- Exception Error Image -->
    <div class="text-center">
		<h4>${exception.getMessage()}</h4>
    	<img src="/resources/images/exception.jpg" />
    	<ul>
	    	<c:forEach var="stack" items="${exception.getStackTrace()}">
	    		<li>${stack.toString()}</li>
	    	</c:forEach>
    	</ul>
    </div>
	
</div>