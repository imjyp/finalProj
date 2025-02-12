<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="/css/common2.css">
<!DOCTYPE html>

<style>
#main {
  margin-top: 141px; 
}
</style>

<!-- 로그인 권한 -->
<sec:authorize access="isAuthenticated()">
 <!-- 로그인 시 사이드바 시작-->
<%@ include file="../include/header.jsp" %>
       <!-- <div id="main"> -->
            <header class="mb-3">
                <a href="#" class="burger-btn d-block d-xl-none">
                    <i class="bi bi-justify fs-3"></i>
                </a>
            </header>
</sec:authorize>
 <!-- 로그인 시 사이드바 끝-->

<div id="main">
<%@ include file="../include/top.jsp" %>
	 <div class="card">
	     <div class="card-header">
	     
	     <div class="row mb-2 align-items-center">
         <ol class="breadcrumb float-sm-end">
            <li class="breadcrumb-item" style="font-size:2rem"><a href="/main">Home</a></li>
            <li class="breadcrumb-item active" style="font-size:2rem"><a href="/companyInfo/test">회사정보</a></li>
         </ol>
   </div>
   
	         
         </div>
     </div>
<iframe src="http://localhost:8888/" style="width:100%; height:200vh; border:none;"></iframe>

<!-- 
    <header>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="#">ERP 시스템</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item active">
                        <a class="nav-link" href="#">홈</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">가맹점 관리</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">보고서</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">설정</a>
                    </li>
                </ul>
            </div>
        </nav>
    </header>

    가맹점 관리 시스템 소개 섹션
    <div class="container mt-5">
        <h1 class="mb-4">가맹점 관리 ERP 시스템</h1>
        <p>우리의 ERP 시스템은 다양한 가맹점의 정보를 통합 관리하고, 운영 효율성을 높이는 데 도움을 줍니다. 이 시스템을 통해 가맹점의 실시간 상태를 파악하고, 재고 관리, 매출 분석 등 다양한 기능을 제공합니다.</p>

        <h2>주요 기능</h2>
        <ul>
            <li><strong>가맹점 정보 관리:</strong> 가맹점의 주소, 연락처, 담당자 등의 정보를 한 곳에서 관리합니다.</li>
            <li><strong>매출 분석:</strong> 가맹점별 매출 데이터를 실시간으로 분석하고, 트렌드를 파악할 수 있습니다.</li>
            <li><strong>재고 관리:</strong> 가맹점별 재고 현황을 실시간으로 모니터링하고, 부족한 재고를 자동으로 알림을 보냅니다.</li>
            <li><strong>가맹점 통합 대시보드:</strong> 모든 가맹점의 상태를 한 눈에 확인할 수 있는 대시보드를 제공합니다.</li>
        </ul>

        <h2>가맹점 예시 데이터</h2>
        <div class="table-responsive">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>가맹점 ID</th>
                        <th>가맹점명</th>
                        <th>주소</th>
                        <th>매출</th>
                        <th>재고 상태</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>001</td>
                        <td>가맹점 A</td>
                        <td>서울시 강남구</td>
                        <td>₩5,000,000</td>
                        <td>충족</td>
                    </tr>
                    <tr>
                        <td>002</td>
                        <td>가맹점 B</td>
                        <td>부산시 해운대구</td>
                        <td>₩3,200,000</td>
                        <td>부족</td>
                    </tr>
                    <tr>
                        <td>003</td>
                        <td>가맹점 C</td>
                        <td>대전시 유성구</td>
                        <td>₩4,500,000</td>
                        <td>충족</td>
                    </tr>
                </tbody>
            </table>
        </div>

        <h2>실시간 분석 대시보드</h2>
        <p>가맹점들의 실시간 데이터를 기반으로 한 분석 결과를 대시보드에서 바로 확인할 수 있습니다. 이를 통해 각 가맹점의 상태를 빠르게 파악하고 대응할 수 있습니다.</p>

        <h3>가맹점 매출 현황</h3>
        <div class="row">
            <div class="col-md-6">
                <div class="alert alert-info">
                    <h4>가맹점 A</h4>
                    <p><strong>매출:</strong> ₩5,000,000</p>
                    <p><strong>재고 상태:</strong> 충족</p>
                </div>
            </div>
            <div class="col-md-6">
                <div class="alert alert-warning">
                    <h4>가맹점 B</h4>
                    <p><strong>매출:</strong> ₩3,200,000</p>
                    <p><strong>재고 상태:</strong> 부족</p>
                </div>
            </div>
        </div>
    </div> -->
    </div> <!-- main 끝 부분 -->
    <!-- JavaScript (Bootstrap JS, jQuery) -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>


<%@ include file="../include/footer.jsp" %>