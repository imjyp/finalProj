<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>품목 관리</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    
    <style>
        body {
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        
        .container {
            flex: 1;
            width: 95%;
            max-width: 1400px;
            margin: 20px auto;
            padding: 0 20px;
            box-sizing: border-box;
        }
        
        .page-header {
            padding: 1.5rem 0;
            margin-bottom: 20px;
            border-bottom: 2px solid #ddd;
        }
        
        .search-bar {
            display: flex;
            gap: 10px;
            align-items: center;
            flex-wrap: wrap;
        }
        
        .search-input {
            padding: 8px 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            width: 300px;
            max-width: 100%;
        }
        
        .btn {
            padding: 8px 20px;
            border-radius: 4px;
            border: none;
            cursor: pointer;
            font-weight: 500;
            white-space: nowrap;
        }
        
        .btn-primary,
        #openRegisterModal.btn-primary {
            background-color: #ffc107 !important;
            border-color: #ffc107 !important;
            color: #000 !important;
        }
        
        .btn-primary:hover,
        #openRegisterModal.btn-primary:hover {
            background-color: #ffca2c !important;
            border-color: #ffca2c !important;
            color: #000 !important;
        }
        
        .btn-danger {
            background-color: #dc3545;
            color: white;
        }
        
        .btn-secondary {
            background-color: #FFC107;
            color: #333;
        }
        
        .table-container {
            overflow-x: auto;
            margin-top: 30px;
            margin-bottom: 20px;
        }
        
        .table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            min-width: 800px; 
        }
        
        .table th, .table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        
        .table th {
            background-color: #f8f9fa;
            font-weight: 600;
            white-space: nowrap;
        }
        
        .table td {
            word-break: break-word;
        }
        
        .pagination {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin: 30px 0;
            flex-wrap: wrap;
        }
        
        .page-item {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            color: #333;
        }
        
        .page-item.active {
            background-color: #ffc107;
            color: #000;
            border-color: #ffc107;
        }
        
        .page-item:hover {
            background-color: #ffca2c;
            border-color: #ffca2c;
            color: #000;
            text-decoration: none;
        }
        
        .action-icons {
            display: flex;
            gap: 10px;
            justify-content: center;
        }
        
        .icon-button {
            background: none;
            border: none;
            cursor: pointer;
            color: #666;
            padding: 5px;
        }
        
        .icon-button:hover {
            color: #333;
        }
        
        @media (max-width: 768px) {
            .page-header {
                flex-direction: column;
                align-items: stretch;
            }
            
            .search-bar {
                justify-content: space-between;
            }
            
            .search-input {
                width: 100%;
            }
        }
        
        .item-row {
            cursor: pointer;
        }
        
        .item-row:hover {
            background-color: #f8f9fa;
        }
        
        .modal-dialog {
            max-width: 500px;
        }
        
        .form-group {
            margin-bottom: 1rem;
        }
        
        .form-group label {
            display: block;
            margin-bottom: .5rem;
            font-weight: 500;
        }
        
        .form-control {
            width: 100%;
            padding: .375rem .75rem;
            border: 1px solid #ced4da;
            border-radius: .25rem;
        }
        
        .form-control:read-only {
            background-color: #e9ecef;
        }
        
        .delete-button-container {
            display: flex;
            justify-content: flex-end;
            padding: 1rem;
            margin-top: 1rem;
        }
        
        .delete-button {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 0.5rem 1.5rem;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        
        .delete-button:hover {
            background-color: #c82333;
        }
        
        #main {
            margin-top: 100px;
            padding: 20px;
            margin-left: 300px;
        }
        
        .page-header h2 {
            margin: 0;
            padding: 10px 0;
            color: #333;
        }
        
        .breadcrumb {
            margin: 0;
            padding: 0;
            font-size: 2em;
        }
        
        .breadcrumb-item {
            display: flex;
            align-items: center;
        }
        
        .breadcrumb-item a {
            color: #6c757d;
            text-decoration: none;
            font-size: 1em;
            padding: 0.5rem 0;
        }
        
        .breadcrumb-item a:hover {
            color: #ffc107;
        }
        
        .breadcrumb-item.active a {
            color: #ffc107;
        }
        
        .breadcrumb-item+.breadcrumb-item::before {
            font-size: 1em;
            padding: 0 1rem;
        }
    </style>
    
</head>
<body>
    <%@ include file="/WEB-INF/views/include/header.jsp"%>

    <div id="main">
        <%@ include file="./include/top.jsp" %>
        <div class="page-header">
            <div class="container-fluid">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0">
                        <li class="breadcrumb-item"><a href="/main">Home</a></li>
                        <li class="breadcrumb-item active"><a href="/item/itemList">품목 관리</a></li>
                    </ol>
                </nav>
            </div>
        </div>

        <div class="search-bar" style="margin-bottom: 20px; display: flex; justify-content: space-between;">
            <div style="flex-grow: 1;">
                <input type="text" class="search-input" placeholder="검색어를 입력하세요">
                <button class="btn btn-primary">검색</button>
            </div>
            <button type="button" id="openRegisterModal" class="btn btn-primary">등록</button>
        </div>

        <div class="table-container">
            <table class="table">
                <thead>
                    <tr>
                        <th width="5%">
                            <input type="checkbox" id="checkAll">
                        </th>
                        <th width="15%">번호</th>
                        <th width="40%">품목 이름</th>
                        <th width="20%">원가</th>
                        <th width="20%">판매가격</th>
                    </tr>
                </thead>
                
                <tbody>
                    <c:forEach var="item" items="${list}" varStatus="stat">
                        <tr class="item-row" data-item-no="${item.itemNo}">
                            <td>
                                <input type="checkbox" name="itemCheck" value="${item.itemNo}">
                            </td>
                            <td>${item.itemNo}</td>
                            <td>${item.itemNm}</td>
                            <td><fmt:formatNumber value="${item.itemPrice}" pattern="#,###" /></td>
                            <td><fmt:formatNumber value="${item.salePrice}" pattern="#,###" /></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <div class="pagination">
            <c:if test="${data.prev}">
                <a href="/item/itemList?currentPage=${data.startPage-1}&keyword=${data.keyword}" 
                   class="page-item">&lt;&lt;</a>
            </c:if>
            
            <c:forEach var="pNo" begin="${data.startPage}" end="${data.endPage}">
                <a href="/item/itemList?currentPage=${pNo}&keyword=${data.keyword}" 
                   class="page-item ${data.currentPage == pNo ? 'active' : ''}">${pNo}</a>
            </c:forEach>
            
            <c:if test="${data.next}">
                <a href="/item/itemList?currentPage=${data.endPage+1}&keyword=${data.keyword}" 
                   class="page-item">&gt;&gt;</a>
            </c:if>
        </div>

        <div id="deleteButtonContainer" class="delete-button-container" style="display: none;">
            <button class="delete-button" onclick="deleteSelectedItems()">
                <i class="fas fa-trash-alt me-2"></i>삭제
            </button>
        </div>

        <div class="modal fade" id="detailModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">품목 상세</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label>품목 번호</label>
                            <input type="text" class="form-control" id="detailItemNo" readonly>
                        </div>
                        <div class="form-group">
                            <label>품목명</label>
                            <input type="text" class="form-control" id="detailItemNm" readonly>
                        </div>
                        <div class="form-group">
                            <label>원가</label>
                            <input type="number" class="form-control" id="detailItemPrice" readonly>
                        </div>
                        <div class="form-group">
                            <label>판매가격</label>
                            <input type="number" class="form-control" id="detailSalePrice" readonly>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" onclick="showUpdateModal()">수정</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="updateModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">품목 수정</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label>품목 번호</label>
                            <input type="text" class="form-control" id="updateItemNo" readonly>
                        </div>
                        <div class="form-group">
                            <label>품목명</label>
                            <input type="text" class="form-control" id="updateItemNm">
                        </div>
                        <div class="form-group">
                            <label>원가</label>
                            <input type="number" class="form-control" id="updateItemPrice">
                        </div>
                        <div class="form-group">
                            <label>판매가격</label>
                            <input type="number" class="form-control" id="updateSalePrice">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" onclick="updateItem()">저장</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="registerModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">품목 등록</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label>품목명</label>
                            <input type="text" class="form-control" id="itemNm">
                        </div>
                        <div class="form-group">
                            <label>원가</label>
                            <input type="number" class="form-control" id="itemPrice">
                        </div>
                        <div class="form-group">
                            <label>판매가격</label>
                            <input type="number" class="form-control" id="salePrice">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" onclick="registerItem()">등록</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/views/include/footer.jsp"%>
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // 전역 함수들을 먼저 선언
        function showDetailModal(itemNo) {
            $.ajax({
                url: "/item/detail/" + itemNo,
                type: "GET",
                success: function(response) {
                    if (response) {
                        $("#detailItemNo").val(response.itemNo);
                        $("#detailItemNm").val(response.itemNm);
                        $("#detailItemPrice").val(response.itemPrice);
                        $("#detailSalePrice").val(response.salePrice);
                        
                        const detailModal = new bootstrap.Modal(document.getElementById('detailModal'));
                        detailModal.show();
                    } else {
                        alert("품목 정보를 불러올 수 없습니다.");
                    }
                },
                error: function() {
                    alert("상세 정보를 불러오는데 실패했습니다.");
                }
            });
        }

        function showUpdateModal() {
            $("#updateItemNo").val($("#detailItemNo").val());
            $("#updateItemNm").val($("#detailItemNm").val());
            $("#updateItemPrice").val($("#detailItemPrice").val());
            $("#updateSalePrice").val($("#detailSalePrice").val());
            
            const detailModal = bootstrap.Modal.getInstance(document.getElementById('detailModal'));
            detailModal.hide();
            
            const updateModal = new bootstrap.Modal(document.getElementById('updateModal'));
            updateModal.show();
        }

        function updateItem() {
            if (!validateForm("#updateItemNm", "#updateItemPrice", "#updateSalePrice")) return;
            
            const data = {
                itemNo: parseInt($("#updateItemNo").val()),
                itemNm: $("#updateItemNm").val(),
                itemPrice: parseInt($("#updateItemPrice").val()),
                salePrice: parseInt($("#updateSalePrice").val())
            };
            
            $.ajax({
                url: "/item/update",
                type: "POST",
                data: JSON.stringify(data),
                contentType: "application/json",
                success: function(res) {
                    if(res.result === "success") {
                        alert("수정되었습니다.");
                        const updateModal = bootstrap.Modal.getInstance(document.getElementById('updateModal'));
                        updateModal.hide();
                        location.reload();
                    } else {
                        alert("수정에 실패했습니다.");
                    }
                },
                error: function() {
                    alert("수정 중 오류가 발생했습니다.");
                }
            });
        }

        function validateForm(...fields) {
            for (let field of fields) {
                const value = $(field).val();
                if (!value || value.trim() === "") {
                    alert("모든 필드를 입력해주세요.");
                    $(field).focus();
                    return false;
                }
            }
            return true;
        }

        // 전역 변수로 CSRF 토큰 설정
        const token = $("meta[name='_csrf']").attr("content");
        const header = $("meta[name='_csrf_header']").attr("content");

        // 삭제 버튼 토글 함수
        function toggleDeleteButton() {
            const checkedCount = $("input[name='itemCheck']:checked").length;
            $("#deleteButtonContainer").toggle(checkedCount > 0);
        }

        // 선택된 품목 삭제 함수
        function deleteSelectedItems() {
            const selectedItems = $("input[name='itemCheck']:checked").map(function() {
                return parseInt($(this).val());
            }).get();
            
            if (selectedItems.length === 0) {
                alert('삭제할 품목을 선택해주세요.');
                return;
            }
            
            if (!confirm('선택한 ' + selectedItems.length + '개의 품목을 삭제하시겠습니까?')) {
                return;
            }
            
            // 중복 요청 방지를 위한 플래그
            if (window.isDeleting) return;
            window.isDeleting = true;
            
            $.ajax({
                url: '/item/deleteItems',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(selectedItems),
                beforeSend: function(xhr) {
                    if (header && token) {
                        xhr.setRequestHeader(header, token);
                    }
                },
                success: function(response) {
                    window.isDeleting = false;  // 플래그 초기화
                    if (response.status === 'success' || response.status === 'partial') {
                        alert(response.message);
                        location.reload();
                    } else {
                        alert('삭제 처리 중 오류가 발생했습니다.');
                    }
                },
                error: function(xhr, status, error) {
                    window.isDeleting = false;  // 플래그 초기화
                    console.error('Delete error:', error);
                    alert('삭제 처리 중 오류가 발생했습니다.');
                },
                complete: function() {
                    window.isDeleting = false;  // 플래그 초기화 (안전장치)
                }
            });
        }

        function registerItem() {
            if (!validateForm("#itemNm", "#itemPrice", "#salePrice")) return;
            
            const data = {
                itemNm: $("#itemNm").val().trim(),
                itemPrice: parseInt($("#itemPrice").val()),
                salePrice: parseInt($("#salePrice").val())
            };
            
            $.ajax({
                url: "/item/insert",
                type: "POST",
                data: JSON.stringify(data),
                contentType: "application/json",
                success: function(res) {
                    if(res.result === "success") {
                        alert("등록되었습니다.");
                        const registerModal = bootstrap.Modal.getInstance(document.getElementById('registerModal'));
                        registerModal.hide();
                        location.reload();
                    } else {
                        alert("등록에 실패했습니다.");
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error:", error);
                    alert("등록 중 오류가 발생했습니다.");
                }
            });
        }

        // DOM이 완전히 로드된 후 실행되는 코드
        $(document).ready(function() {
            // 전체 선택 체크박스
            $("#checkAll").on("click", function() {
                $("input[name='itemCheck']").prop("checked", $(this).prop("checked"));
                toggleDeleteButton();
            });
            
            // 개별 체크박스 이벤트
            $(document).on("click", "input[name='itemCheck']", function(e) {
                e.stopPropagation();
                const total = $("input[name='itemCheck']").length;
                const checked = $("input[name='itemCheck']:checked").length;
                
                $("#checkAll").prop("checked", total === checked);
                toggleDeleteButton();
            });
            
            // 행 클릭 시 상세 모달 표시
            $(document).on("click", ".item-row", function(e) {
                if (!$(e.target).is("input[type='checkbox']")) {
                    let itemNo = $(this).data("item-no");
                    showDetailModal(itemNo);
                }
            });

            // 검색 버튼 이벤트
            $(".btn-primary:contains('검색')").on("click", function() {
                const keyword = $(".search-input").val();
                location.href = "/item/list?currentPage=1&keyword=" + encodeURIComponent(keyword);
            });

            // 등록 모달 열기
            $("#openRegisterModal").on("click", function() {
                const registerModal = new bootstrap.Modal(document.getElementById('registerModal'));
                registerModal.show();
            });

            // 초기 삭제 버튼 상태 설정
            toggleDeleteButton();
        });
    </script>
</body>
</html>