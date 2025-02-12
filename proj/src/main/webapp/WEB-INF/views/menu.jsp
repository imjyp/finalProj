<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>메뉴 관리</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="/css/common2.css">
    <link rel="stylesheet" href="/dist/assets/compiled/css/app-dark.css">
    <link rel="stylesheet" href="/dist/assets/compiled/css/iconly.css">
    
    <style>
        :root {
            --primary: #2C3E50;
            --secondary: #34495E;
            --accent: #3498DB;
            --success: #27AE60;
            --warning: #F39C12;
            --danger: #E74C3C;
            --light-gray: #ECF0F1;
            --dark-gray: #95A5A6;
        }

        body {
            background-color: #f8f9fa;
            color: var(--primary);
        }

        .main-content {
            padding: 2rem;
            margin-left: 300px;
        }

        .page-heading {
            margin-bottom: 2rem;
            border-bottom: 2px solid var(--accent);
            padding-bottom: 1rem;
        }

        .page-heading h3 {
            color: var(--primary);
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.05);
        }

        .card-header {
            background-color: white;
            border-bottom: 1px solid var(--light-gray);
            padding: 1.5rem;
            border-radius: 15px 15px 0 0;
        }

        .search-container {
            display: flex;
            gap: 1rem;
            align-items: center;
            margin-bottom: 1rem;
        }

        .search-container select,
        .search-container input {
            min-width: 150px;
            height: 42px;
            border-radius: 20px;
            border: 1px solid var(--light-gray);
            padding: 0.5rem 1rem;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
        }

        .search-container input {
            background-color: #f8f9fa;
            font-size: 14px;
            color: #6c757d;
        }

        .btn {
            height: 42px;
            padding: 0 1.5rem;
            border-radius: 20px;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background-color: #ffc107;
            border-color: #ffc107;
            color: white;
        }

        .btn-primary:hover {
            background-color: #e0a800;
            border-color: #e0a800;
            transform: translateY(-1px);
        }

        .table {
            margin: 0;
        }

        .table th {
            background-color: var(--light-gray);
            color: var(--primary);
            font-weight: 600;
            padding: 1rem;
            border: none;
        }

        .table td {
            padding: 1rem;
            vertical-align: middle;
            border-color: var(--light-gray);
        }

        .action-column {
            width: 150px;
            text-align: center;
        }

        .badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 500;
        }

        /* 체크박스 스타일 추가 */
        .checkbox-column {
            width: 40px;
            min-width: 40px;
            text-align: center;
            cursor: pointer;
        }
        
        .form-check-input {
            cursor: pointer;
        }
        
        /* 삭제 버튼 컨테이너 스타일 */
        .delete-button-container {
            display: flex;
            justify-content: flex-end;
            padding: 1rem;
            margin-top: 1rem;
        }
        
        .delete-button {
            background-color: var(--danger);
            color: white;
            border: none;
            padding: 0.5rem 1.5rem;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        
        .delete-button:hover {
            background-color: #c0392b;
        }
        
        /* 메뉴 행 호버 효과 */
        .menu-row {
            cursor: pointer;
        }
        
        .menu-row:hover {
            background-color: rgba(0,0,0,0.05);
        }
        
        /* 체크박스 클릭 영역 스타일 */
        .checkbox-column .form-check-input {
            cursor: pointer;
            pointer-events: auto;
        }

        /* 이미지 미리보기 컨테이너 스타일 */
        #imagePreview {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 10px;
        }

        /* 이미지 컨테이너 스타일 */
        .image-preview-container {
            position: relative;
            width: 150px;
            height: 150px;
            border-radius: 8px;
            overflow: hidden;
        }

        /* 이미지 스타일 */
        .preview-image {
            width: 100%;
            height: 100%;
            object-fit: contain;
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            padding: 5px;
        }

        /* 삭제 버튼 스타일 */
        .remove-image-btn {
            position: absolute;
            top: 5px;
            right: 5px;
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 50%;
            padding: 4px;
            cursor: pointer;
            z-index: 1;
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
        
        @media (max-width: 768px) {
            .search-bar {
                justify-content: space-between;
            }
            
            .search-input {
                width: 100%;
            }
        }

        /* 모달 크기 조정 */
        #udModal .modal-dialog {
            max-width: 900px; /* 모달의 너비를 키움 */
        }
        
        /* 글씨 크기 조정 */
        #udModal .form-label,
        #udModal input,
        #udModal p,
        #udModal h5 {
            font-size: 15px; /* 글씨 크기 키움 */
        }
        #udModal h3 {
            font-size: 20px; /* 사용자 이름 글씨 크기 */
        }
        #udModal p.text-small {
            font-size: 14px; /* 소형 글씨 크기 */
        }
        
        /* 검색 폼 아래에 여백 추가 */
        .dataTable-top {
            margin-bottom: 50px !important; /* 필요에 따라 값 조정 */
        }
        
        /* 페이지네이션 위에 여백 추가 */
        .card-footer {
            margin-top: 50px; /* 필요에 따라 값 조정 */
        }
        
        /* 뱃지만 개별적으로 가운데 정렬 (만약 필요하면) */
        .tableType01 td .badge {
            display: inline-block !important;
            text-align: center;
            width: 100%; /* 뱃지가 전체 영역에서 중앙에 오도록 설정 */
        }
        
        .swal-body {
            font-family: 'NotoSansKR'; 
            font-size: 500 !important;
        }

        /* 검색 버튼에만 적용되는 특정 스타일 */
        .search-bar .btn-primary {
            background-color: #ffc107 !important;
            border-color: #ffc107 !important;
            color: #000 !important;
        }

        .search-bar .btn-primary:hover {
            background-color: #ffca2c !important;
            border-color: #ffca2c !important;
            color: #000 !important;
        }

        /* 페이지네이션 스타일 */
        .pagination .page-item.active .page-link {
            background-color: #ffc107 !important;
            border-color: #ffc107 !important;
            color: #000 !important;
        }

        .pagination .page-link {
            color: #000 !important;
        }

        .pagination .page-link:hover {
            background-color: #fff3cd !important;
            border-color: #ffc107 !important;
            color: #000 !important;
        }

        .pagination .page-link:focus {
            box-shadow: 0 0 0 0.2rem rgba(255, 193, 7, 0.25) !important;
        }
    </style>
</head>
<body>

	<%@ include file="/WEB-INF/views/include/header.jsp"%>

    <div class="main-content">
    <%@ include file="./include/top.jsp" %>
    
        <div class="page-heading">
            <h3><i class="fas fa-coffee"></i> 메뉴 관리</h3>
        </div>

        <div class="card">
            <div class="card-header">
                <div class="container-fluid">
                    <div class="row align-items-center">
                        <div class="col-md-6 d-flex align-items-center">
                            <nav aria-label="breadcrumb" class="ms-3">
                                <ol class="breadcrumb mb-0">
                                    <li class="breadcrumb-item"><a href="/main">Home</a></li>
                                    <li class="breadcrumb-item active"><a href="/menu/manage">메뉴 관리</a></li>
                                </ol>
                            </nav>
                        </div>
                        <div class="col-md-6 d-flex justify-content-end">
                            <div class="d-flex flex-nowrap" style="overflow-x: auto; width: 100%; margin-left:90px">
                                <!-- 인증 카드 -->
                                <!-- ... other cards ... -->
                            </div> <!-- /.d-flex.flex-nowrap -->
                        </div> <!-- /.col-md-6.d-flex.justify-content-end -->
                    </div> <!-- /.row.align-items-center -->
                </div> <!-- /.container-fluid -->
            </div> <!-- /.card-header -->

            <div class="card-body">
                <div class="search-bar">
                    <div style="flex-grow: 1;">
                        <select class="search-input" id="categorySelect" style="width: auto; margin-right: 10px; height:40px;">
                            <option value="">전체 카테고리</option>
                            <option value="1" ${category == '1' ? 'selected' : ''}>신메뉴</option>
                            <option value="2" ${category == '2' ? 'selected' : ''}>커피</option>
                            <option value="3" ${category == '3' ? 'selected' : ''}>음료</option>
                            <option value="4" ${category == '4' ? 'selected' : ''}>티</option>
                            <option value="5" ${category == '5' ? 'selected' : ''}>디저트</option>
                        </select>
                        <input type="text" class="search-input" id="searchInput" placeholder="검색어를 입력하세요" style="height:40px;">
                        <button class="btn btn-primary" onclick="searchMenu()">검색</button>
                    </div>
                    <button class="btn btn-primary" onclick="openNewMenuModal()">
                        등록
                    </button>
                </div>

                <div class="table-responsive">
                    <table class="table">
                        <thead>
						    <tr>
						        <th class="checkbox-column">
						            <input type="checkbox" class="form-check-input" id="selectAll">
						        </th>
						        <th>번호</th>
						        <th>이름</th>
						        <th>카테고리</th>
						        <th>가격</th>
						        <th>설명</th>
						        <th>등록일</th>
						    </tr>
						</thead>
                        <tbody>
                           <c:forEach var="menu" items="${menuList}">
							        <tr class="menu-row" data-menu-no="${menu.menuNo}">
							            <td class="checkbox-column" onclick="event.stopPropagation()">
							                <input type="checkbox" class="form-check-input menu-check" value="${menu.menuNo}">
							            </td>
							            <td>${menu.menuNo}</td>
							            <td>${menu.menuNm}</td>
							            <td>${menu.ctgryNm}</td>
							            <td><fmt:formatNumber value="${menu.menuPrice}" pattern="#,###" />원</td>
							            <td>${menu.menuCn}</td>
							            <td><fmt:formatDate value="${menu.menuRegist}" pattern="yyyy-MM-dd"/></td>
							        </tr>
							</c:forEach>
                        </tbody>
                    </table>
                </div>
                
                <div class="d-flex justify-content-center mt-4">
                    <nav aria-label="Page navigation">
                        <ul class="pagination">
                            <!-- 페이징 부분 수정 -->
							<c:if test="${currentPage > 1}">
							    <li class="page-item">
							        <a class="page-link" href="?page=${currentPage-1}&keyword=${keyword}&category=${category}">이전</a>
							    </li>
							</c:if>
							
							<c:forEach begin="1" end="${totalPages}" var="pageNum">
							    <li class="page-item ${pageNum == currentPage ? 'active' : ''}">
							        <a class="page-link" href="?page=${pageNum}&keyword=${keyword}&category=${category}">${pageNum}</a>
							    </li>
							</c:forEach>
							
							<c:if test="${currentPage < totalPages}">
							    <li class="page-item">
							        <a class="page-link" href="?page=${currentPage+1}&keyword=${keyword}&category=${category}">다음</a>
							    </li>
							</c:if>
                        </ul>
                    </nav>
                </div>
                
                <!-- 삭제 버튼 컨테이너 -->
                <div class="delete-button-container">
                    <button class="delete-button" onclick="deleteSelectedMenu()">
                        <i class="fas fa-trash-alt me-2"></i>삭제
                    </button>
                </div>
            </div>
        </div>
    </div>
    
    <%@ include file="/WEB-INF/views/include/footer.jsp"%>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        let menuModal;
        let currentMenuNo;

        $(document).ready(function() {
            menuModal = new bootstrap.Modal(document.getElementById('menuModal'));
            
            $('#menuModal').on('hidden.bs.modal', function () {
                $('#uploadFiles').prop('hidden', true);
            });

            
            // 메뉴 행 클릭 이벤트
            $(document).on('click', '.menu-row', function(e) {
                if (!$(e.target).is('input[type="checkbox"]') && !$(e.target).closest('.checkbox-column').length) {
                    const menuNo = $(this).data('menu-no');
                    //menu-row->menuNo :  64
                    console.log("menu-row->menuNo : ", menuNo);
                    viewMenuDetail(menuNo);
                }
            });

            // 전체 선택 체크박스 이벤트
            $('#selectAll').change(function(e) {
                e.stopPropagation();  // 이벤트 전파 중지
                const isChecked = $(this).prop('checked');
                $('.menu-check').prop('checked', isChecked);
                updateDeleteButtonVisibility();
            });

            // 개별 체크박스 이벤트
            $('.menu-check').change(function(e) {
                e.stopPropagation();  // 이벤트 전파 중지
                const totalCheckboxes = $('.menu-check').length;
                const checkedCheckboxes = $('.menu-check:checked').length;
                
                // 전체 선택 체크박스 상태 업데이트
                $('#selectAll').prop('checked', totalCheckboxes === checkedCheckboxes);
                updateDeleteButtonVisibility();
            });
            
            // 초기 삭제 버튼 상태 설정
            updateDeleteButtonVisibility();

            // 체크박스 클릭 시 행 클릭 이벤트 전파 방지
            $('.checkbox-column').click(function(e) {
                e.stopPropagation();
            });

            // 파일 입력 이벤트 리스너 추가
            $('#uploadFiles').on('change', function() {
				console.log("파일 변경 감지!");
                handleFileUpload(this);
            });
            
            //모달창의 이미지 삭제
            $(document).on("click",".btnDeleteImage",function(){
				let menuNo = $(this).data("menuNo");
				
				console.log("btnDeleteImage->menuNo : ", menuNo);
				
				$(this).parent().prev().remove();
				
				$(this).parent().remove();
				
				$.ajax({
					url:"/menu/deleteImage",
					data:{"menuNo":menuNo},
					type:"post",
					dataType:"text",
					success:function(result){
						console.log("btnDeleteImage->result : ", result);
						
					}
				});
				
			});
        });//end ready

        function viewMenuDetail(menuNo) {
            currentMenuNo = menuNo;
            fetch('/menu/detail/' + menuNo)
                .then(response => response.json())
                .then(menu => {
                    console.log('Menu Detail:', menu);
                    fillMenuForm(menu);
                    $('#modalTitle').text('메뉴 상세 정보');
                    $('#menuForm input, #menuForm select, #menuForm textarea').prop('readonly', true);
                    $('#editButton').show();
                    $('#saveButton').hide();
                    $('.btnDeleteImage').prop('hidden', true);

                    menuModal.show();
                })
                .catch(error => console.error('Error:', error));
        }

        function fillMenuForm(menu) {
			console.log("fillMenuForm->menu : ", menu);
            $('#menuNo').val(menu.menuNo);
            $('#menuNm').val(menu.menuNm);
            $('#ctgryNo').val(menu.ctgryNo);
            $('#menuPrice').val(menu.menuPrice);
            $('#menuCn').val(menu.menuCn);
            
            // 이미지 미리보기 처리
            const preview = $('#imagePreview');
            preview.empty();
            
            if (menu.fileDetailList && menu.fileDetailList.length > 0) {
                menu.fileDetailList.forEach(file => {
                    console.log("fillMenuForm->file : ", file);
                    // 이미지 URL을 /display 엔드포인트를 통해 처리
                    //const imageUrl = `/display?fileName=${file.filePath}`;
                    const imageUrl = `/resources\${file.fileSaveLocate}`;
                    console.log("fillMenuForm->imageUrl : ", imageUrl);
                    preview.append(`
                        <div class="image-preview-container" data-file-no="\${file.fileNo}">
                            <img src="\${imageUrl}" 
                                 class="preview-image"
                                 alt="메뉴 이미지"
                                 onerror="handleImageError(this)">
                        </div>
                        <div><button type="button" data-menu-no="\${menu.menuNo}" class="btn btn-warning btn-xs btnDeleteImage " hidden>삭제</button></div>
                    `);
                });
            }
        }

        function enableEdit() {
            $('#menuNm').prop('readonly', false);
            $('#ctgryNo').prop('disabled', false);
            $('#menuPrice').prop('readonly', false);
            $('#menuCn').prop('readonly', false);
            $('#editButton').hide();
            $('#saveButton').show();
            $('#uploadFiles').prop('hidden', false);
            $('.btnDeleteImage').prop('hidden', false);
        }

        function validateForm() {
            const menuNm = $('#menuNm').val().trim();
            const ctgryNo = parseInt($('#ctgryNo').val());
            const menuPrice = parseInt($('#menuPrice').val());

            if (!menuNm) {
                alert('메뉴명을 입력해주세요.');
                $('#menuNm').focus();
                return false;
            }
            if (isNaN(ctgryNo) || ctgryNo < 1 || ctgryNo > 5) {
                alert('유효한 카테고리를 선택해주세요.');
                $('#ctgryNo').focus();
                return false;
            }
            if (isNaN(menuPrice) || menuPrice <= 0) {
                alert('유효한 가격을 입력해주세요.');
                $('#menuPrice').focus();
                return false;
            }
            return true;
        }

        function saveMenu() {
            // 새로운 FormData 객체 생성
            let formData = new FormData();
            
            // 기본 데이터 한 번만 추가
            formData.append('menuNm', $('#menuNm').val());
            formData.append('ctgryNo', $('#ctgryNo').val());
            formData.append('menuPrice', $('#menuPrice').val());
            formData.append('menuCn', $('#menuCn').val());
            
            // 파일 처리
            const fileInput = document.querySelector('#uploadFiles');
            if (fileInput.files.length > 0) {
                for (let i = 0; i < fileInput.files.length; i++) {
                    formData.append('uploadFiles', fileInput.files[i]);
                }
            }

            // 디버깅을 위한 FormData 내용 출력
            console.log('=== FormData 최종 내용 ===');
            for (let pair of formData.entries()) {
                if (pair[1] instanceof File) {
                    console.log(`${pair[0]}: File(${pair[1].name}, ${pair[1].type}, ${pair[1].size})`);
                } else {
                    console.log(`${pair[0]}: ${pair[1]}`);
                }
            }

            $.ajax({
                url: '/menu/insert',
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                success: function(response) {
                    alert('저장되었습니다.');
                    location.reload();
                },
                error: function(xhr, status, error) {
                    console.error('Error:', error);
                    alert('처리 중 오류가 발생했습니다.');
                }
            });
        }

        function openNewMenuModal() {
            currentMenuNo = null;
            $('#menuForm')[0].reset();
            $('#modalTitle').text('신규 메뉴 등록');
            $('#menuForm input, #menuForm select, #menuForm textarea').prop('readonly', false);
            $('#editButton').hide();
            $('#saveButton').show();
            $('#uploadFiles').prop('hidden', false);
            menuModal.show();
            $('#imagePreview').empty();
        }

        function editMenu(menuNo) {
            event.stopPropagation();
            currentMenuNo = menuNo;
            fetch('/menu/detail/' + menuNo)
                .then(response => response.json())
                .then(menu => {
                    fillMenuForm(menu);
                    $('#modalTitle').text('메뉴 수정');
                    $('#menuForm input, #menuForm select, #menuForm textarea').prop('readonly', false);
                    $('#ctgryNo').prop('disabled', false);
                    $('#editButton').hide();
                    $('#saveButton').show();
                    menuModal.show();
                });
        }

        function deleteMenu(menuNo) {
            if (confirm('정말로 삭제하시겠습니까?')) {
                $.ajax({
                    url: '/menu/delete/' + menuNo,
                    type: 'POST',
                    success: function(response) {
                        if(response.status === 'success') {
                            alert('메뉴가 삭제되었습니다.');
                            location.reload();
                        } else {
                            alert('삭제 처리 중 오류가 발생했습니다.');
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error('Error:', error);
                        alert('삭제 처리 중 오류가 발생했습니다.');
                    }
                });
            }
        }

        function deleteSelectedMenu() {
            const selectedMenus = [];
            $('.menu-check:checked').each(function() {
                selectedMenus.push($(this).val());
            });

            if (selectedMenus.length === 0) {
                alert('삭제할 메뉴를 선택해주세요.');
                return;
            }

            if (confirm('선택한 ' + selectedMenus.length + '개의 메뉴를 삭제하시겠습니까?')) {
                $.ajax({
                    url: '/menu/deleteMenus',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(selectedMenus),
                    success: function(response) {
                        if(response.status === 'success') {
                            alert('선택한 메뉴가 삭제되었습니다.');
                            location.reload();
                        } else {
                            alert('삭제 처리 중 오류가 발생했습니다.');
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error('Error:', error);
                        alert('삭제 처리 중 오류가 발생했습니다.');
                    }
                });
            }
        }

        // 삭제 버튼 표시/숨김 처리
        function updateDeleteButtonVisibility() {
            const checkedCount = $('.menu-check:checked').length;
            const deleteButton = $('.delete-button');
            
            if (checkedCount > 0) {
                deleteButton.fadeIn();
            } else {
                deleteButton.fadeOut();
            }
        }

        // 이미지 미리보기 함수
        function previewImages(input) {
            const preview = $('#imagePreview');
            preview.empty();

            if (input.files && input.files.length > 0) {
                Array.from(input.files).forEach(file => {
                    if (!file.type.match("image.*")) {
                        alert("이미지 파일만 업로드 가능합니다.");
                        return;
                    }
                    
                    const reader = new FileReader();
                    reader.onload = function(e) {

                        preview.append(`
                            <div class="image-preview-container">
                                <div class="remove-image-btn">
                                    <button type="button" class="btn-close" 
                                            onclick="removePreview(this)"></button>
                                </div>
                                <img src="${e.target.result}" 
                                     class="preview-image"
                                     alt="${file.name}">
                            </div>
                        `);
                    }
                    reader.readAsDataURL(file);
                });
            }
        }

        // 이미지 미리보기 제거
        function removePreview(button) {
            $(button).closest('.position-relative').remove();
        }

        // 메뉴 상세 정보 표시 함수
        function showMenuDetail(menu) {
            // ... 기존 필드 설정 ...
            
            // 이미지 표시
            const preview = $('#imagePreview');
            preview.empty();
            
            if (menu.fileDetails && menu.fileDetails.length > 0) {
                menu.fileDetails.forEach(file => {
                    preview.append(`
                        <div class="position-relative" data-file-no="${file.fileNo}">
                            <img src="/download?fileName=${file.fileSaveLocate}/${file.fileSaveName}" 
                                 class="img-thumbnail" 
                                 style="width: 150px; height: 150px; object-fit: cover;"
                                 alt="${file.fileOriginalName}">
                            <button type="button" class="btn-close position-absolute top-0 end-0 m-1" 
                                    onclick="removeImage(${file.fileNo}, ${menu.menuNo})"></button>
                        </div>
                    `);
                });
            }
        }

        // 이미지 에러 핸들링 함수 수정
        function handleImageError(img) {
            if (!img.dataset.errorHandled) {
                img.dataset.errorHandled = true;
                img.src = '/resources/images/no-image.png';  // 기본 이미지 경로
                img.onerror = null;  // 추가 에러 핸들링 방지
                console.error('이미지 로드 실패:', img.src);
            }
        }

        // 이미지 삭제 함수 수정
        function removeImage(fileNo, menuNo) {  
            if (!confirm('이미지를 삭제하시겠습니까?')) return;
            
            $.ajax({
                url: '/menu/removeImage',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ 
                    fileNo: fileNo,
                    menuNo: menuNo 
                }),
                success: function(response) {
                    if (response.status === 'success') {
                        $(`[data-file-no="${fileNo}"]`).remove();
                        alert('이미지가 삭제되었습니다.');
                    } else {
                        alert('이미지 삭제에 실패했습니다.');
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Error:', error);
                    alert('이미지 삭제 중 오류가 발생했습니다.');
                }
            });
        }

        // 파일 업로드 처리 함수 수정
        function handleFileUpload(input) {
			console.log("handleFileUpload->input.files.length : " + input.files.length);
            if (input.files && input.files.length > 0) {
				//<div id="imagePreview"..
                const preview = $('#imagePreview');
                Array.from(input.files).forEach(file => {
                    if (!file.type.startsWith('image/')) {
                        alert('이미지 파일만 업로드 가능합니다.');
                        return;
                    }
                    
                    const reader = new FileReader();
                    reader.onload = function(e) {

                        preview.append(`
                            <div class="image-preview-container">
                                <img src="\${e.target.result}" 
                                     class="preview-image"
                                     alt="\${file.name}">
                            </div>
                        `);
                    };
                    reader.readAsDataURL(file);
                });
            }
        }

        // 카테고리 선택 시 검색 실행
        $('#categorySelect').change(function() {
            searchMenu();
        });

        // 검색 함수
        function searchMenu() {
            const keyword = $('#searchInput').val();
            const category = $('#categorySelect').val();
            
            // 현재 URL 가져오기
            let url = new URL(window.location.href);
            
            // 쿼리 파라미터 설정
            url.searchParams.set('page', '1'); // 페이지를 1로 리셋
            url.searchParams.set('keyword', keyword);
            url.searchParams.set('category', category);
            
            // 페이지 이동
            window.location.href = url.toString();
        }
    </script>

    <!-- 상세 조회 모달 -->
    <div class="modal fade" id="detailModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">메뉴 상세</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <p><strong>메뉴명:</strong> <span id="detailMenuNm"></span></p>
                            <p><strong>카테고리:</strong> <span id="detailCtgryNm"></span></p>
                            <p><strong>가격:</strong> <span id="detailMenuPrice"></span>원</p>
                            <p><strong>등록일:</strong> <span id="detailMenuRegist"></span></p>
                        </div>
                        <div class="col-md-6">
                            <p><strong>설명:</strong></p>
                            <p id="detailMenuCn"></p>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" onclick="openEditModal()">수정</button>
                    <button type="button" class="btn btn-danger" onclick="deleteMenuFromDetail()">삭제</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 수정 모달 -->
    <div class="modal fade" id="editModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">메뉴 수정</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form id="editForm">
                    <div class="modal-body">
                        <input type="hidden" id="editMenuNo" name="menuNo">
                        <div class="mb-3">
                            <label class="form-label">메뉴명</label>
                            <input type="text" class="form-control" id="editMenuNm" name="menuNm" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">카테고리</label>
                            <select class="form-select" id="editCtgryNo" name="ctgryNo" required>
                                <option value="1">신메뉴</option>
                                <option value="2">커피</option>
                                <option value="3">음료</option>
                                <option value="4">티</option>
                                <option value="5">디저트</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">가격</label>
                            <input type="number" class="form-control" id="editMenuPrice" name="menuPrice" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">설명</label>
                            <textarea class="form-control" id="editMenuCn" name="menuCn" rows="3"></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">저장</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- 메뉴 상세/수정 모달 -->
    <div class="modal fade" id="menuModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalTitle">메뉴 상세</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="menuForm" enctype="multipart/form-data">
                        <input type="hidden" id="menuNo" name="menuNo">
                        <div class="mb-3">
                            <label class="form-label">메뉴명</label>
                            <input type="text" class="form-control" id="menuNm" name="menuNm" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">카테고리</label>
                            <select class="form-select" id="ctgryNo" name="ctgryNo" required>
                                <option value="1">신메뉴</option>
                                <option value="2">커피</option>
                                <option value="3">음료</option>
                                <option value="4">티</option>
                                <option value="5">디저트</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">가격</label>
                            <input type="number" class="form-control" id="menuPrice" name="menuPrice" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">설명</label>
                            <textarea class="form-control" id="menuCn" name="menuCn" rows="3"></textarea>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">메뉴 이미지</label>
                            <input type="file" class="form-control" id="uploadFiles" name="uploadFiles" hidden multiple accept="image/*">
                        </div>
                        <!-- 이미지 미리보기 영역 -->
                        <div id="imagePreview" class="mb-3 d-flex flex-wrap gap-2">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" id="editButton" onclick="enableEdit()">수정</button>
                    <button type="button" class="btn btn-primary" id="saveButton" onclick="saveMenu()">저장</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>