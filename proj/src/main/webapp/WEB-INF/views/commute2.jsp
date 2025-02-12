<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>가맹점 직원 출퇴근 조회</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', 'Malgun Gothic', sans-serif;
        }

        body {
            background-color: var(--dark-bg);
            color: var(--text-primary);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .content-wrapper {
            padding-left: 250px;
            width: 100%;
            min-height: 100vh;
            transition: padding-left 0.3s ease;
            padding-top: 80px;
        }

        .main-content {
            padding: 2rem 3rem;
            margin-top: 20px;
            max-width: 1600px;
            margin-left: auto;
            margin-right: auto;
            width: 95%;
        }

        .page-header {
            margin-bottom: 2.5rem;
            padding-top: 20px;
        }

        .page-title {
            font-size: 1.8rem;
            font-weight: 600;
            color: #333;
            margin: 0;
        }

        .filter-section {
            display: flex;
            gap: 20px;
            margin-bottom: 30px;
        }

        select, button {
            padding: 10px 20px;
            border-radius: 6px;
            font-size: 16px;
            transition: all 0.3s ease;
        }

        select:hover, button:hover {
            border-color: var(--blue-accent);
        }

        .stats-box {
            background-color: white;
            padding: 25px;
            border-radius: 10px;
            margin-bottom: 35px;
            display: flex;
            justify-content: space-around;
            color: #333;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .stats-item {
            text-align: center;
            padding: 0 25px;
            font-size: 17px;
        }

        .stats-item strong {
            font-size: 24px;
            display: block;
            margin-top: 12px;
            font-weight: 500;
        }

        .table-container {
            border-radius: 10px;
            padding: 25px;
            width: 100%;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .attendance-table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
        }

        .attendance-table th,
        .attendance-table td {
            padding: 20px 30px;
            font-size: 18px;
            white-space: nowrap;
        }

        /* 테이블 열 정렬 및 너비 조정 */
        .attendance-table th:nth-child(1),
        .attendance-table td:nth-child(1) { 
            width: 20%;
            text-align: left;
        }
        .attendance-table th:nth-child(2),
        .attendance-table td:nth-child(2) { 
            width: 15%;
            text-align: center;
        }
        .attendance-table th:nth-child(3),
        .attendance-table td:nth-child(3) { 
            width: 15%;
            text-align: center;
        }
        .attendance-table th:nth-child(4),
        .attendance-table td:nth-child(4) { 
            width: 15%;
            text-align: center;
        }
        .attendance-table th:nth-child(5),
        .attendance-table td:nth-child(5) { 
            width: 20%;
            text-align: center;
        }
        .attendance-table th:nth-child(6),
        .attendance-table td:nth-child(6) { 
            width: 15%;
            text-align: center;
        }

        .status {
            display: inline-block;
            padding: 8px 20px;
            border-radius: 20px;
            font-size: 15px;
            font-weight: 500;
            letter-spacing: 0.5px;
        }

        .status-normal {
            color: #4CAF50;
            border: 2px solid #4CAF50;
            background-color: rgba(76, 175, 80, 0.1);
        }

        .status-late {
            color: #FFC107;
            border: 2px solid #FFC107;
            background-color: rgba(255, 193, 7, 0.1);
        }

        /* 테이블 헤더 강조 */
        .attendance-table th {
            background-color: var(--table-header);
            color: var(--text-secondary);
            font-size: 18px;
            padding: 20px 30px;
            border-bottom: 2px solid var(--border-color);
        }

        @media (max-width: 1400px) {
            .main-content {
                padding: 1.5rem;
            }
            
            .search-category .row {
                flex-wrap: wrap;
            }
            
            .search-category .col-auto {
                margin-bottom: 0.5rem;
            }
            
            .stats-item {
                padding: 0 20px;
                font-size: 16px;
            }
            
            .stats-item strong {
                font-size: 22px;
            }
            
            .attendance-table th,
            .attendance-table td {
                padding: 15px 20px;
                font-size: 15px;
            }
        }

        @media (max-width: 1200px) {
            .main-content {
                max-width: 100%;
                margin-left: 0;
                padding: 30px;
            }
            
            .content-wrapper {
                padding-left: 0;
            }
        }

        /* Table with outer spacing */
        .tableType01 {
            margin-top: 1.5rem;
            overflow-x: auto;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            padding: 1rem;
        }

        .tableType01 .board {
            width: 100%;
            border-top: 2px solid #333;
            border-bottom: 2px solid #333;
        }

        .tableType01 th {
            background-color: #f8f9fa;
            font-weight: 600;
            padding: 1.2rem;
            font-size: 1.1rem;
        }

        .tableType01 td {
            padding: 1.2rem;
            font-size: 1.1rem;
            line-height: 1.5;
        }

        .tableType01 .noline {
            border-right: none;
        }

        /* 행 호버 효과 */
        .tableType01 tbody tr:hover {
            background-color: #f8f9fa;
            cursor: pointer;
        }

        /* 테이블 내 텍스트 정렬 */
        .tableType01 td, .tableType01 th {
            text-align: center;
            vertical-align: middle;
        }

        /* 뱃지 스타일 */
        .badge.bg-light-info {
            background-color: #e6f3ff !important;
            color: #0d6efd !important;
        }

        .badge.bg-warning {
            background-color: #fff3cd !important;
            color: #ffc107 !important;
        }

        /* 테이블 반응형 */
        @media (max-width: 1600px) {
            .main-content {
                max-width: 1400px;
            }
        }

        @media (max-width: 1200px) {
            .main-content {
                padding: 2rem;
            }
            
            .search-category .form-control,
            .search-category .form-select {
                width: 200px !important;
            }
        }

        @media (max-width: 768px) {
            .content-wrapper {
                padding-left: 0;
            }
            
            .search-category .row {
                flex-wrap: wrap;
            }
            
            .search-category .form-control,
            .search-category .form-select {
                width: 100% !important;
            }
        }

        /* 검색 카테고리 스타일 수정 */
        .search-category {
            margin-top: 20px;
            background-color: #fff;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            margin-bottom: 2.5rem;
        }

        .search-category .row {
            display: flex;
            flex-wrap: nowrap;
            gap: 2rem;
            align-items: center;
            justify-content: flex-start;
        }

        .search-category .col-auto {
            flex: 0 0 auto;
        }

        .search-category .input-group {
            width: auto;
            margin-right: 0;
        }

        .search-category .form-control,
        .search-category .form-select {
            width: 250px !important;
            height: 45px;
            font-size: 1rem;
        }

        /* 뱃지만 개별적으로 가운데 정렬 */
        .tableType01 td .badge {
            display: inline-block !important;
            text-align: center;
            width: 100%; /* 뱃지가 전체 영역에서 중앙에 오도록 설정 */
        }

        /* 테이블 디자인 수정 */
        .tableType01 {
            margin-top: 1.5rem;
        }

        .tableType01 .board {
            width: 100%;
            border-collapse: collapse;
        }

        .tableType01 th {
            background-color: #f8f9fa;
            padding: 15px;
            font-weight: 500;
            border-top: 2px solid #333;
            border-bottom: 1px solid #dee2e6;
        }

        .tableType01 td {
            padding: 15px;
            border-bottom: 1px solid #dee2e6;
        }

        .tableType01 tr:hover {
            background-color: #f8f9fa;
        }

        /* 뱃지 스타일 */
        .badge {
            padding: 8px 12px;
            border-radius: 4px;
            font-weight: 500;
        }

        .bg-light-info {
            background-color: #e3f2fd !important;
            color: #0d6efd !important;
        }

        .bg-warning {
            background-color: #fff3cd !important;
            color: #ffc107 !important;
        }
    </style>
</head>
<body>
    <%@ include file="/WEB-INF/views/include/header.jsp"%>
    <div class="content-wrapper">
        <div class="main-content">
            <%@ include file="./include/top.jsp" %>
            <div class="page-header">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb mb-0">
                                <li class="breadcrumb-item"><a href="/main">Home</a></li>
                                <li class="breadcrumb-item"><a href="/commute2">가맹점 직원 출퇴근 조회</a></li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>

            <!-- 검색 카테고리 -->
            <div class="search-category">
                <div class="row">
                    <div class="col-auto">
                        <div class="input-group">
                            <input type="month" class="form-control" value="2025-02">
                        </div>
                    </div>
                    <div class="col-auto">
                        <div class="input-group">
                            <select class="form-select">
                                <option selected>전체 부서</option>
                                <option>경영본부</option>
                                <option>인사/행정과</option>
                                <option>재정/회계과</option>
                                <option>전략/기획과</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-auto">
                        <div class="input-group">
                            <select class="form-select">
                                <option selected>전체 상태</option>
                                <option>정상</option>
                                <option>지각</option>
                                <option>조퇴</option>
                                <option>결근</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 기존 테이블 -->
            <div class="tableType01">
                <table class="board">
                    <colgroup>
                        <col width="15%">
                        <col width="10%">
                        <col width="15%">
                        <col width="15%">
                        <col width="15%">
                        <col width="10%">
                    </colgroup>
                    <thead>
                        <tr>
                            <th scope="col" class="noline">근무일</th>
                            <th scope="col" class="noline">이름</th>
                            <th scope="col" class="noline">출근시각</th>
                            <th scope="col" class="noline">퇴근시각</th>
                            <th scope="col" class="noline">근무시간</th>
                            <th scope="col">상태</th>
                        </tr>
                    </thead>
                    <tbody id="tby">
                        <tr>
                            <td class="noline" style="text-align:center;">2025-01-31</td>
                            <td class="noline" style="text-align:center;">박지영</td>
                            <td class="noline" style="text-align:center;">08:30:00</td>
                            <td class="noline" style="text-align:center;">17:30:00</td>
                            <td class="noline" style="text-align:center;">9시간 0분</td>
                            <td class="noline" style="text-align:center;">
                                <span class="badge bg-light-info">정상</span>
                            </td>
                        </tr>
                        <tr>
                            <td class="noline" style="text-align:center;">2025-01-30</td>
                            <td class="noline" style="text-align:center;">김가비</td>
                            <td class="noline" style="text-align:center;">09:10:00</td>
                            <td class="noline" style="text-align:center;">18:15:00</td>
                            <td class="noline" style="text-align:center;">9시간 5분</td>
                            <td class="noline" style="text-align:center;">
                                <span class="badge bg-warning">지각</span>
                            </td>
                        </tr>
                        <tr>
                            <td class="noline" style="text-align:center;">2025-01-29</td>
                            <td class="noline" style="text-align:center;">전완근</td>
                            <td class="noline" style="text-align:center;">08:45:00</td>
                            <td class="noline" style="text-align:center;">17:45:00</td>
                            <td class="noline" style="text-align:center;">9시간 0분</td>
                            <td class="noline" style="text-align:center;">
                                <span class="badge bg-light-info">정상</span>
                            </td>
                        </tr>
                        <tr>
                            <td class="noline" style="text-align:center;">2025-01-29</td>
                            <td class="noline" style="text-align:center;">이떵개</td>
                            <td class="noline" style="text-align:center;">09:20:00</td>
                            <td class="noline" style="text-align:center;">18:30:00</td>
                            <td class="noline" style="text-align:center;">9시간 10분</td>
                            <td class="noline" style="text-align:center;">
                                <span class="badge bg-warning">지각</span>
                            </td>
                        </tr>
                        <tr>
                            <td class="noline" style="text-align:center;">2025-01-28</td>
                            <td class="noline" style="text-align:center;">박연진</td>
                            <td class="noline" style="text-align:center;">08:30:00</td>
                            <td class="noline" style="text-align:center;">17:30:00</td>
                            <td class="noline" style="text-align:center;">9시간 0분</td>
                            <td class="noline" style="text-align:center;">
                                <span class="badge bg-light-info">정상</span>
                            </td>
                        </tr>
                        <tr>
                            <td class="noline" style="text-align:center;">2025-01-28</td>
                            <td class="noline" style="text-align:center;">안유진</td>
                            <td class="noline" style="text-align:center;">08:25:00</td>
                            <td class="noline" style="text-align:center;">17:30:00</td>
                            <td class="noline" style="text-align:center;">9시간 5분</td>
                            <td class="noline" style="text-align:center;">
                                <span class="badge bg-light-info">정상</span>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>