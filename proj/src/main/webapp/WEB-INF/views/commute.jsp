<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>출퇴근 조회</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <!-- jQuery 추가 -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- CSRF 토큰 메타 정보 추가 -->
    <meta name="_csrf" content="${_csrf.token}">
    <meta name="_csrf_header" content="${_csrf.headerName}">
</head>
<body>
    <%@ include file="/WEB-INF/views/include/header.jsp"%>
    
<div id="main">

<%@ include file="./include/top.jsp" %>
	<header class="mb-3">
		<a href="#" class="burger-btn d-block d-xl-none"><i
			class="bi bi-justify fs-3"></i></a>
	</header>
	
		<div class="row mb-2 align-items-center">
         <ol class="breadcrumb float-sm-end">
            <li class="breadcrumb-item" style="font-size:2rem"><a href="/main">Home</a></li>
            <li class="breadcrumb-item active" style="font-size:2rem"><a href="/bonsa/sellingGMJ">가맹점별 매출</a></li>
         </ol>
   </div>
    <div class="container-fluid">
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">출퇴근 기록 관리</h3>
                    </div>
                    <div class="card-body">
                        <div class="row mb-3" style="margin-top:30px">
                            <div class="col-md-2">
                                <input type="month" id="searchDate" class="form-control" >
                            </div>
                            <div class="col-md-2">
                                <select id="deptFilter" class="form-control">
                                    <option value="">전체 부서</option>
                                    <c:forEach items="${deptList}" var="dept">
                                        <option value="${dept}">${dept}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <select id="statusFilter" class="form-control">
                                    <option value="">전체 상태</option>
                                    <option value="정상">정상</option>
                                    <option value="지각">지각</option>
                                    <option value="조기퇴근">조기퇴근</option>
                                </select>
                            </div>
                        </div>
                        <!-- 출퇴근 기록 테이블 -->
                        <div class="table-responsive tableType01" style="margin-top:30px">
                            <table class="table table-hover board">
                                <thead>
                                    <tr>
                                        <th style="width:15%">날짜</th>
                                        <th style="width:10%">부서</th>
                                        <th style="width:10%">직책</th>
                                        <th style="width:10%">이름</th>
                                        <th style="width:15%">출근시각</th>
                                        <th style="width:15%">퇴근시각</th>
                                        <th style="width:15%">근무시간</th>
                                        <th style="width:10%">상태</th>
                                    </tr>
                                </thead>
                                <tbody id="commuteBody">
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
    <script>
    $(document).ready(function() {
        // CSRF 토큰 정보 가져오기
        const csrfToken = $('meta[name="_csrf"]').attr('content');
        const csrfHeader = $('meta[name="_csrf_header"]').attr('content');
        
        // 현재 날짜로 초기화
        const today = new Date();
        const yearMonth = today.getFullYear() + "-" + String(today.getMonth() + 1).padStart(2, '0');
        $("#searchDate").val(yearMonth);
        
        // 초기 데이터 로드
        loadData();
        
        // 필터 변경 이벤트
        $("#searchDate, #deptFilter, #statusFilter").on("change", function() {
            loadData();
        });

        function loadData() {
            const searchDate = $("#searchDate").val();
            const deptNm = $("#deptFilter").val();
            const status = $("#statusFilter").val();
            const page = $("#currentPage").val() || 1;
            const size = 10;
            
            // CSRF 토큰 가져오기
            const token = $("meta[name='_csrf']").attr("content");
            const header = $("meta[name='_csrf_header']").attr("content");

            
            let data = {
                searchDate: searchDate,
                deptNm: deptNm,
                status: status,
                page: page,
                size: size
            };
            
            console.log("개똥이 data : ", data);
            
            $.ajax({
                url: "/commute/list",
                type: "GET",
                data:data,
                beforeSend: function(xhr) {
                    // CSRF 토큰을 헤더에 추가
                    if(header && token) {
                        xhr.setRequestHeader(header, token);
                    }
                },
                success: function(response) {
					console.log("response.commuteList : ", response.commuteList);
                    if(response && response.commuteList) {
                        updateTable(response.commuteList);
                    }
                },
                error: function(xhr, status, error) {
                    console.error("데이터 로드 실패:", error);
                }
            });

            // 통계 데이터 로드
            $.ajax({
                url: "/commute/stats",
                type: "POST",
                data: {
                    searchDate: searchDate,
                    deptNm: deptNm,
                    _csrf: csrfToken
                },
                headers: {
                    [csrfHeader]: csrfToken
                },
                success: function(response) {
					console.log("response : ", response);
                    if(response) {
                        updateStats(response);
                    }
                },
                error: function(xhr, status, error) {
                    console.error("통계 데이터 로드 실패:", error);
                }
            });
        }

        // 테이블 업데이트 함수
        function updateTable(commuteList) {
            let html = '';
            
            if (commuteList && commuteList.length > 0) {
                commuteList.forEach(function(item) {
                    // 부서나 직책이 미배정이거나 null인 경우 건너뛰기
                    if (item.deptNm && item.deptNm !== '미배정' && 
                        item.positionNm && item.positionNm !== '미배정') {
                        html += `
                            <tr>
                                <td>\${item.schdulDate}</td>
                                <td>\${item.deptNm}</td>
                                <td>\${item.positionNm}</td>
                                <td>\${item.userNm}</td>
                                <td>\${item.attend}</td>
                                <td>\${item.leave}</td>
                                <td>\${item.workingTime}</td>
                                <td>\${item.status}</td>
                            </tr>
                        `;
                    }
                });
            }
            
            if (html === '') {
                html = '<tr><td colspan="8" class="text-center">데이터가 없습니다.</td></tr>';
            }
            
            $("#commuteBody").html(html);
        }

        // 통계 테이블 업데이트 함수
        function updateStats(statsList) {
            let html = '';
            if (statsList && statsList.length > 0) {
                statsList.forEach(function(stats) {
                    // 부서가 미배정이 아닌 경우만 표시
                    if (stats.deptNm && stats.deptNm !== '미배정') {
                        html += `
                            <tr>
                                <td>${stats.deptNm || '전체'}</td>
                                <td>${stats.totalRecords}</td>
                                <td>${stats.normalCount}</td>
                                <td>${stats.lateCount}</td>
                                <td>${stats.earlyLeaveCount}</td>
                                <td>${stats.avgWorkingHours}시간</td>
                            </tr>
                        `;
                    }
                });
            }
            
            if (html === '') {
                html = '<tr><td colspan="6" class="text-center">통계 데이터가 없습니다.</td></tr>';
            }
            
            $("#statsBody").html(html);
        }
    });
    </script>

    <%@ include file="/WEB-INF/views/include/footer.jsp"%>
</html>

<style>
.tableType01 tr:hover {transform: translateY(-3px); box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1); cursor: pointer !important;}
</style>