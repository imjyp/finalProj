<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>휴가 관리</title>
    <style>
        .container {
            width: 80%;
            margin: 0 auto;
            padding: 20px;
        }
        .section {
            margin-bottom: 30px;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .vacation-summary {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 20px;
            margin-bottom: 20px;
        }
        .summary-item {
            flex: 1;
            min-width: 200px;
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 5px;
            text-align: center;
        }
        .summary-title {
            color: #666;
            margin-bottom: 10px;
        }
        .summary-value {
            font-size: 1.5rem;
            font-weight: bold;
            color: #007bff;
        }
        .btn {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
        }
        .btn-secondary {
            background-color: #6c757d;
        }
        .vacation-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .vacation-table th,
        .vacation-table td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }
        .vacation-table th {
            background-color: #f8f9fa;
            font-weight: normal;
        }
        .status-badge {
            padding: 5px 10px;
            border-radius: 3px;
            font-size: 0.9rem;
        }
        .status-pending {
            background-color: #fef3c7;
            color: #92400e;
        }
        .status-approved {
            background-color: #d1fae5;
            color: #065f46;
        }
        .status-rejected {
            background-color: #fee2e2;
            color: #991b1b;
        }
        .filter-section {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }
        .filter-input {
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
        }
        .modal-content {
            background-color: white;
            width: 500px;
            margin: 100px auto;
            padding: 20px;
            border-radius: 5px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #666;
        }
        .form-control {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
        }
        .modal-buttons {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 20px;
        }
        @media (max-width: 768px) {
            .vacation-summary {
                flex-direction: column;
            }
            .filter-section {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <%@ include file="./include/header.jsp"%>
<div id="main">
    <%@ include file="./include/top.jsp" %>
<!--     <div class="container"> -->
        <div class="section">
            <div class="vacation-summary">
                <div class="summary-item">
                    <div class="summary-title">총 연차</div>
                    <div class="summary-value">15일</div>
                </div>
                <div class="summary-item">
                    <div class="summary-title">사용 연차</div>
                    <div class="summary-value">7일</div>
                </div>
                <div class="summary-item">
                    <div class="summary-title">잔여 연차</div>
                    <div class="summary-value">8일</div>
                </div>
            </div>
            
            <button class="btn" onclick="openVacationModal()">휴가 신청</button>
        </div>

        <div class="section">
            <div class="filter-section">
                <select class="filter-input">
                    <option value="">전체 기간</option>
                    <option value="2024">2024년</option>
                    <option value="2023">2023년</option>
                </select>
                <select class="filter-input">
                    <option value="">전체 상태</option>
                    <option value="pending">승인 대기</option>
                    <option value="approved">승인</option>
                    <option value="rejected">반려</option>
                </select>
            </div>

            <table class="vacation-table">
                <thead>
                    <tr>
                        <th>신청일</th>
                        <th>휴가 기간</th>
                        <th>휴가 종류</th>
                        <th>사유</th>
                        <th>상태</th>
                        <th>관리</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>2024-01-15</td>
                        <td>2024-01-20 ~ 2024-01-22</td>
                        <td>연차</td>
                        <td>개인 사유</td>
                        <td><span class="status-badge status-pending">승인 대기</span></td>
                        <td><button class="btn btn-secondary" onclick="cancelVacation()">취소</button></td>
                    </tr>
                    <tr>
                        <td>2024-01-10</td>
                        <td>2024-01-12</td>
                        <td>반차</td>
                        <td>병원 방문</td>
                        <td><span class="status-badge status-approved">승인</span></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>2024-01-05</td>
                        <td>2024-01-08 ~ 2024-01-09</td>
                        <td>연차</td>
                        <td>가족 행사</td>
                        <td><span class="status-badge status-rejected">반려</span></td>
                        <td></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
<!-- </div> -->
    <!-- 휴가 신청 모달 -->
    <div id="vacationModal" class="modal">
        <div class="modal-content">
            <h2 style="margin-bottom: 20px">휴가 신청</h2>
            <form id="vacationForm">
                <div class="form-group">
                    <label>휴가 종류</label>
                    <select class="form-control">
                        <option value="annual">연차</option>
                        <option value="half">반차</option>
                        <option value="sick">병가</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>시작일</label>
                    <input type="date" class="form-control">
                </div>
                <div class="form-group">
                    <label>종료일</label>
                    <input type="date" class="form-control">
                </div>
                <div class="form-group">
                    <label>사유</label>
                    <textarea class="form-control" rows="3"></textarea>
                </div>
                <div class="modal-buttons">
                    <button type="button" class="btn btn-secondary" onclick="closeVacationModal()">취소</button>
                    <button type="submit" class="btn">신청</button>
                </div>
            </form>
        </div>
    </div>

    <%@ include file="/WEB-INF/views/include/footer.jsp"%>

    <script>
        function openVacationModal() {
            document.getElementById('vacationModal').style.display = 'block';
        }

        function closeVacationModal() {
            document.getElementById('vacationModal').style.display = 'none';
        }

        function cancelVacation() {
            if(confirm('휴가 신청을 취소하시겠습니까?')) {
                alert('취소되었습니다.');
            }
        }

        // 모달 외부 클릭시 닫기
        window.onclick = function(event) {
            if (event.target == document.getElementById('vacationModal')) {
                closeVacationModal();
            }
        }

        // 휴가 신청 폼 제출
        document.getElementById('vacationForm').onsubmit = function(e) {
            e.preventDefault();
            alert('휴가가 신청되었습니다.');
            closeVacationModal();
        }
    </script>
</body>
</html>