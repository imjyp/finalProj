<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
	<%@ include file="../include/header.jsp"%>
<div id="main">
    <%@ include file="../include/top.jsp" %>
<!--     <div class="container"> -->
</head>
<body>
    
        <div class="page-header">
            <h2>재고 조회</h2>
            <div class="search-bar">
                <input type="text" class="search-input" placeholder="검색어를 입력하세요">
                <button class="btn btn-primary">검색</button>
            </div>
        </div>

        <table class="table">
            <thead>
                <tr>
                    <th class="checkbox-column">
                        <input type="checkbox" id="selectAll">
                    </th>
                    <th>번호</th>
                    <th>품목 이름</th>
                    <th>가격</th>
                    <th>수량</th>
                    <th>안전재고 수량</th>
                    <th>판매여부</th>
                    <th>유통기한</th>
                    <th>관리</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="checkbox-column">
                        <input type="checkbox" name="selectedItems">
                    </td>
                    <td>1</td>
                    <td>원두 500g</td>
                    <td>35,000</td>
                    <td>150</td>
                    <td>20</td>
                    <td>Y</td>
                    <td>25/10/10</td>
                    <td class="action-icons">
                        <button class="icon-button" title="수정">
                            <i class="fas fa-edit"></i>
                        </button>
                        <button class="icon-button" title="삭제">
                            <i class="fas fa-trash-alt"></i>
                        </button>
                    </td>
                </tr>
                <tr>
                    <td class="checkbox-column">
                        <input type="checkbox" name="selectedItems">
                    </td>
                    <td>2</td>
                    <td>굵은 빨대 200개입</td>
                    <td>6,000</td>
                    <td class="stock-warning">10</td>
                    <td>20</td>
                    <td>Y</td>
                    <td>28/10/10</td>
                    <td class="action-icons">
                        <button class="icon-button" title="수정">
                            <i class="fas fa-edit"></i>
                        </button>
                        <button class="icon-button" title="삭제">
                            <i class="fas fa-trash-alt"></i>
                        </button>
                    </td>
                </tr>
            </tbody>
        </table>

        <div class="pagination">
            <span class="page-item"><<</span>
            <span class="page-item"><</span>
            <span class="page-item active">1</span>
            <span class="page-item">2</span>
            <span class="page-item">3</span>
            <span class="page-item">4</span>
            <span class="page-item">5</span>
            <span class="page-item">></span>
            <span class="page-item">>></span>
        </div>

        <div style="margin-top: 20px; display: flex; gap: 10px;">
            <button class="btn btn-secondary">
                <i class="fas fa-plus"></i> 등록
            </button>
            <button class="btn btn-secondary">
                <i class="fas fa-edit"></i> 수정
            </button>
            <button class="btn btn-primary">
                <i class="fas fa-trash-alt"></i> 삭제
            </button>
            <button class="btn btn-secondary" style="margin-left: auto;">
                <i class="fas fa-exclamation-triangle"></i> 안전재고 수량 변경
            </button>
        </div>
    </div>
<!-- </div> -->
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	
    <script>
        // 전체 선택 체크박스 기능
        document.getElementById('selectAll').addEventListener('change', function() {
            const checkboxes = document.getElementsByName('selectedItems');
            checkboxes.forEach(checkbox => {
                checkbox.checked = this.checked;
            });
        });

        // 재고 수량이 안��재고 수량보다 적을 경우 경고 표시
        document.addEventListener('DOMContentLoaded', function() {
            const rows = document.querySelectorAll('tbody tr');
            rows.forEach(row => {
                const stockAmount = parseInt(row.children[4].textContent);
                const safetyStock = parseInt(row.children[5].textContent);
                if (stockAmount < safetyStock) {
                    row.children[4].classList.add('stock-warning');
                } else {
                    row.children[4].classList.add('stock-normal');
                }
            });
        });
    </script>
</body>
</html>