<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>


<!DOCTYPE html>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link rel="stylesheet" href="/resources/css/styles.css">
<link rel="stylesheet" href="/dist/assets/compiled/css/app-dark.css">
<link rel="stylesheet" href="/dist/assets/compiled/css/iconly.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

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
    border-radius: 8px;
    box-shadow: 0 0 20px rgba(0,0,0,0.05);
}

.card-header {
    background-color: white;
    border-bottom: 1px solid var(--light-gray);
    padding: 1.5rem;
    border-radius: 15px 15px 0 0;
}

/* 수정된 검색 컨테이너 스타일 */
.search-container {
    display: flex;
    gap: 1rem;
    align-items: center;
    padding: 1.5rem;
    border-radius: 8px;
}

.search-container select,
.search-container input {
    min-width: 150px;
    height: 42px;
    border-radius: 8px;
    border: 1px solid var(--light-gray);
    padding: 8px 15px;
    font-size: 14px;
    background-color: white;
    transition: all 0.3s ease;
}

.search-container select:hover,
.search-container input:hover {
    border-color: var(--accent);
}

.search-container select:focus,
.search-container input:focus {
    outline: none;
    border-color: var(--accent);
    box-shadow: 0 0 0 2px rgba(52, 152, 219, 0.2);
}

.input-group {
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.input-group .btn-primary {
    height: 42px;
    padding: 0 1.25rem;
    background-color: var(--accent);
    border: none;
    border-radius: 8px;
    transition: all 0.3s ease;
}

.input-group .btn-primary:hover {
    background-color: #2980b9;
    transform: translateY(-1px);
}

/* 수정된 본사/가맹점 버튼 스타일 */
.office-type-buttons {
    background-color: var(--light-gray);
    padding: 4px;
    border-radius: 8px;
    display: inline-flex;
    gap: 4px;
}

.office-type-button {
    padding: 10px 24px;
    border: none;
    border-radius: 6px;
    font-weight: 500;
    transition: all 0.3s ease;
    background: none;
    color: var(--primary);
}

.office-type-button.active {
    background-color: white;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    color: var(--accent);
}

.office-type-button:hover:not(.active) {
    background-color: rgba(255,255,255,0.5);
}

/* 수정된 액션 버튼 스타일 */
.action-icons {
    display: flex;
    gap: 12px;
    justify-content: center;
}

.icon-button {
    background: none;
    border: none;
    cursor: pointer;
    color: #666;
    padding: 8px;
    border-radius: 4px;
    transition: all 0.3s ease;
}

.icon-button:hover {
    background-color: rgba(52, 152, 219, 0.1);
    color: var(--accent);
}

.icon-button.edit {
    color: var(--warning);
}

.icon-button.view {
    color: var(--accent);
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

.badge-department {
    background-color: var(--accent);
    color: white;
    padding: 0.5rem 1rem;
    border-radius: 20px;
    font-weight: 500;
}

/* 테이블 스타일 개선 */
.table {
    margin-top: 1rem;
}

/* 페이지네이션 스타일 개선 */
.pagination {
    margin-top: 2rem;
}

.pagination .page-link {
    color: var(--primary);
    border: none;
    padding: 0.5rem 1rem;
    margin: 0 0.25rem;
    border-radius: 6px;
    transition: all 0.3s ease;
}

.pagination .page-item.active .page-link {
    background-color: var(--accent);
    color: white;
}

.pagination .page-link:hover {
    background-color: var(--light-gray);
    color: var(--accent);
}

</style>    
<title>본사 직원 조회</title>

<%@ include file="/WEB-INF/views/include/header.jsp"%>

<div class="container-fluid">
    <div class="main-content">
    <%@ include file="./include/top.jsp" %>
        <div class="page-heading">
<!--             <h3><i class="fas fa-users"></i> 인사 관리</h3> -->
            <h3>인사 관리</h3>
        </div>
        
        <div class="toolbar">
            <button class="btn btn-primary" onclick="openNewUserModal()">
                <i class="fas fa-user-plus"></i> 신규 등록
            </button>
        </div>

        <div class="card">
            <div class="card-header">
                <div class="d-flex justify-content-between align-items-center">
                    <div class="office-type-buttons">
                        <button type="button" class="office-type-button active" id="btnHeadOffice">
                            <i class="fas fa-building"></i> 본사
                        </button>
                        <button type="button" class="office-type-button" id="btnFranchise">
                            <i class="fas fa-store"></i> 가맹점
                        </button>
                    </div>
                    
                    <div class="search-container">
                        <input type="text" class="form-control" id="searchInput" placeholder="검색어를 입력하세요">
                        <select class="form-select" id="deptSelect">
                            <option value="">부서 선택</option>
                            <c:forEach var="dept" items="${deptList}">
                                <option value="${dept.deptNo}" ${dept.deptNo eq deptNo ? 'selected' : ''}>${dept.deptNm}</option>
                            </c:forEach>
                        </select>
                        <select class="form-select" id="positionSelect">
                            <option value="">직책 선택</option>
                            <c:forEach var="position" items="${positionList}">
                                <option value="${position.positionNo}" ${position.positionNo eq positionNo ? 'selected' : ''}>${position.positionNm}</option>
                            </c:forEach>
                        </select>
                        <button class="btn btn-primary" onclick="searchUsers()">검색</button>
                    </div>
                </div>
            </div>
            
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th class="checkbox-column">
                                    <input type="checkbox" class="form-check-input" id="selectAll">
                                </th>
                                <th>이름</th>
                                <th>아이디</th>
                                <th>이메일</th>
                                <th>연락처</th>
                                <th>입사일</th>
                                <th>부서</th>
                                <th>직책</th>
                                <th class="action-column">관리</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="user" items="${userList}" varStatus="status">
                                <tr>
                                    <td class="checkbox-column">
                                        <input type="checkbox" class="form-check-input user-check" 
                                               value="${user.userNo}">
                                    </td>
                                    <td>${user.userNm}</td>
                                    <td>${user.userNo}</td>
                                    <td>${user.userMail}</td>
                                    <td>${user.userPhone}</td>
                                    <td><fmt:formatDate value="${user.userIndate}" pattern="yyyy-MM-dd"/></td>
                                    <td><span class="badge badge-department">${user.deptNm}</span></td>
                                    <td>${user.positionNm}</td>
                                    <td>
                                        <div class="action-icons">
                                            <button class="icon-button view" onclick="viewUserDetail('${user.userNo}')">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                            <button class="icon-button edit" onclick="editUser('${user.userNo}')">
                                                <i class="fas fa-edit"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                
                <div class="d-flex justify-content-center mt-4">
                    <nav aria-label="Page navigation">
                        <ul class="pagination">
                            <c:if test="${currentPage > 1}">
                                <li class="page-item">
                                    <a class="page-link" href="?page=${currentPage-1}">이전</a>
                                </li>
                            </c:if>
                            
                            <c:forEach begin="1" end="${totalPages}" var="pageNum">
                                <li class="page-item ${pageNum == currentPage ? 'active' : ''}">
                                    <a class="page-link" href="?page=${pageNum}">${pageNum}</a>
                                </li>
                            </c:forEach>
                            
                            <c:if test="${currentPage < totalPages}">
                                <li class="page-item">
                                    <a class="page-link" href="?page=${currentPage+1}">다음</a>
                                </li>
                            </c:if>
                        </ul>
                    </nav>
                </div>

                <div class="d-flex justify-content-end mt-4">
                    <button class="btn btn-danger" id="deleteSelectedBtn" onclick="deleteSelectedUsers()">
                        <i class="fas fa-trash"></i> 삭제
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/include/footer.jsp"%>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
    $(document).ready(function() {
        // 전체 선택 체크박스 이벤트
        $('#selectAll').change(function() {
            $('.user-check').prop('checked', $(this).prop('checked'));
            updateDeleteButton();
        });

        // 개별 체크박스 이벤트
        $('.user-check').change(function() {
            var allChecked = $('.user-check:checked').length === $('.user-check').length;
            $('#selectAll').prop('checked', allChecked);
            updateDeleteButton();
        });

        // 검색 엔터 이벤트
        $('#searchInput').keypress(function(e) {
            if (e.which == 13) {
                searchUsers();
            }
        });

        // 수정된 본사/가맹점 버튼 토글
        $('.office-type-button').click(function() {
            $('.office-type-button').removeClass('active');
            $(this).addClass('active');
            
            // 버튼 클릭 시 부드러운 전환 효과
            $(this).css('transform', 'scale(0.95)');
            setTimeout(() => {
                $(this).css('transform', 'scale(1)');
            }, 100);
        });
    });

    function searchUsers() {
        const keyword = document.getElementById('searchInput').value;
        const deptNo = document.getElementById('deptSelect').value;
        const positionNo = document.getElementById('positionSelect').value;
        
        // URL 파라미터 구성
        const params = new URLSearchParams();
        if (keyword) params.append('keyword', keyword);
        if (deptNo) params.append('deptNo', deptNo);
        if (positionNo) params.append('positionNo', positionNo);
        
        // 페이지 이동
        window.location.href = '/hr/manage?' + params.toString();
    }

    // 모달 객체 생성
    const userDetailModal = new bootstrap.Modal(document.getElementById('userDetailModal'));
    const userFormModal = new bootstrap.Modal(document.getElementById('userFormModal'));

    // 상세 조회
    function viewUserDetail(userNo) {
        fetch(`/hr/user/${userNo}`)
            .then(response => response.json())
            .then(data => {
                // 모달에 데이터 채우기
                document.getElementById('detailUserNm').textContent = data.userNm || '';
                document.getElementById('detailUserNo').textContent = data.userNo || '';
                document.getElementById('detailUserMail').textContent = data.userMail || '';
                document.getElementById('detailUserPhone').textContent = data.userPhone || '';
                document.getElementById('detailDeptNm').textContent = data.deptNm || '';
                document.getElementById('detailPositionNm').textContent = data.positionNm || '';
                document.getElementById('detailAddress').textContent = 
                    data.userZip ? `(${data.userZip}) ${data.userAddr1 || ''} ${data.userAddr2 || ''}` : '';
                
                // 모달 표시
                const userDetailModal = new bootstrap.Modal(document.getElementById('userDetailModal'));
                userDetailModal.show();
            })
            .catch(error => {
                console.error('Error:', error);
                alert('상세 정보를 불러오는 중 오류가 발생했습니다.');
            });
    }

    // 신규 등록 모달 열기
    function openNewUserModal() {
        document.getElementById('modalTitle').textContent = '사용자 등록';
        document.getElementById('userForm').reset();
        document.getElementById('userNo').value = '';
        document.getElementById('userId').readOnly = false;
        userFormModal.show();
    }

    // 수정 모달 열기
    function editUser(userNo) {
        document.getElementById('modalTitle').textContent = '사용자 수정';
        document.getElementById('userId').readOnly = true;
        
        fetch(`/hr/user/${userNo}`)
            .then(response => response.json())
            .then(data => {
                document.getElementById('userNo').value = data.userNo;
                document.getElementById('userNm').value = data.userNm;
                document.getElementById('userId').value = data.userNo;
                document.getElementById('userMail').value = data.userMail;
                document.getElementById('userPhone').value = data.userPhone;
                document.getElementById('deptNo').value = data.deptNo;
                document.getElementById('positionNo').value = data.positionNo;
                document.getElementById('userZip').value = data.userZip;
                document.getElementById('userAddr1').value = data.userAddr1;
                document.getElementById('userAddr2').value = data.userAddr2;
                
                userFormModal.show();
            })
            .catch(error => {
                console.error('Error:', error);
                alert('데이터를 불러오는 중 오류가 발생했습니다.');
            });
    }

    // 폼 제출 처리
    document.getElementById('userForm').addEventListener('submit', function(e) {
        e.preventDefault();
        
        const formData = new FormData(this);
        const userNo = formData.get('userNo');
        const url = userNo ? `/hr/user/edit/${userNo}` : '/hr/user/new';
        
        fetch(url, {
            method: 'POST',
            headers: {
                'X-CSRF-TOKEN': document.querySelector('meta[name="_csrf"]').content
            },
            body: JSON.stringify(formData)
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert('저장되었습니다.');
                location.reload();
            } else {
                alert(data.message || '처리 중 오류가 발생했습니다.');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('처리 중 오류가 발생했습니다.');
        });
    });

    // 주소 검색 (다음 우편번호 서비스)
    function searchAddress() {
        new daum.Postcode({
            oncomplete: function(data) {
                document.getElementById('userZip').value = data.zonecode;
                document.getElementById('userAddr1').value = data.address;
                document.getElementById('userAddr2').focus();
            }
        }).open();
    }

    function deleteSelectedUsers() {
        const selectedUsers = Array.from(document.querySelectorAll('.user-check:checked'))
            .map(checkbox => checkbox.value);

        if (selectedUsers.length === 0) {
            alert('삭제할 사용자를 선택하세요.');
            return;
        }

        if (confirm('선택한 사용자를 정말로 삭제하시겠습니까?')) {
            fetch('/hr/user/delete', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ userNos: selectedUsers })
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('선택한 사용자가 삭제되었습니다.');
                    location.reload();
                } else {
                    alert('삭제 중 오류가 발생했습니다.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('오류가 발생했습니다.');
            });
        }
    }
</script>

<!-- 상세 조회 모달 -->
<div class="modal fade" id="userDetailModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">사용자 상세 정보</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">이름</label>
                        <p id="detailUserNm" class="form-control-plaintext"></p>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">아이디</label>
                        <p id="detailUserNo" class="form-control-plaintext"></p>
                    </div>
                </div>
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">이메일</label>
                        <p id="detailUserMail" class="form-control-plaintext"></p>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">연락처</label>
                        <p id="detailUserPhone" class="form-control-plaintext"></p>
                    </div>
                </div>
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">부서</label>
                        <p id="detailDeptNm" class="form-control-plaintext"></p>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">직책</label>
                        <p id="detailPositionNm" class="form-control-plaintext"></p>
                    </div>
                </div>
                <div class="row mb-3">
                    <div class="col-12">
                        <label class="form-label">주소</label>
                        <p id="detailAddress" class="form-control-plaintext"></p>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>

<!-- 등록/수정 모달 -->
<div class="modal fade" id="userFormModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalTitle">사용자 등록</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form id="userForm">
                <div class="modal-body">
                    <input type="hidden" id="userNo" name="userNo">
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label class="form-label">이름 <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="userNm" name="userNm" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">아이디 <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="userId" name="userId" required>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label class="form-label">이메일 <span class="text-danger">*</span></label>
                            <input type="email" class="form-control" id="userMail" name="userMail" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">연락처 <span class="text-danger">*</span></label>
                            <input type="tel" class="form-control" id="userPhone" name="userPhone" required>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label class="form-label">부서 <span class="text-danger">*</span></label>
                            <select class="form-select" id="deptNo" name="deptNo" required>
                                <option value="">선택하세요</option>
                                <c:forEach var="dept" items="${deptList}">
                                    <option value="${dept.deptNo}">${dept.deptNm}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">직책 <span class="text-danger">*</span></label>
                            <select class="form-select" id="positionNo" name="positionNo" required>
                                <option value="">선택하세요</option>
                                <c:forEach var="position" items="${positionList}">
                                    <option value="${position.positionNo}">${position.positionNm}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label class="form-label">우편번호</label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="userZip" name="userZip" readonly>
                                <button type="button" class="btn btn-secondary" onclick="searchAddress()">
                                    주소 검색
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-12">
                            <label class="form-label">기본주소</label>
                            <input type="text" class="form-control" id="userAddr1" name="userAddr1" readonly>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-12">
                            <label class="form-label">상세주소</label>
                            <input type="text" class="form-control" id="userAddr2" name="userAddr2">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <button type="submit" class="btn btn-primary">저장</button>
                </div>
            </form>
        </div>
    </div>
</div>


