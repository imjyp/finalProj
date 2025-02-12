<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>


<!DOCTYPE html>
<head>

	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>권한 부여/회원 관리</title>
	<link rel="stylesheet" href="/dist/assets/compiled/css/app.css">
	<link rel="stylesheet" href="/css/common2.css">
	<link rel="shortcut icon" type="image/x-icon" href="/kor/images/favicon.ico">
<!-- 	<link rel="stylesheet" href="/dist/assets/compiled/css/app-dark.css"> -->
	<link rel="stylesheet" href="/dist/assets/compiled/css/iconly.css">
<!-- 	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"> -->
	
	
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/top.jsp"%>
	
</head>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>d
<style>
/* 모달 크기 조정 */
#udModal .modal-dialog {
  max-width: 900px; /* 모달의 너비를 키움 */
}

/* 글씨 크기 조정 */
#udModal .form-label,
#udModal input,
#udModal p,
#udModal h5 {
  font-size: 15px; 
}

#udModal h3 {
  font-size: 20px; 
}

#udModal p.text-small {
  font-size: 14px; 
}

.dataTable-top {
  margin-bottom: 20px !important;
  margin-left:32px;
  
}

/* 뱃지만 개별적으로 가운데 정렬 */
.tableType01 td .badge {
    display: inline-block !important;
    text-align: center;
    width: 100%; /* 뱃지가 전체 영역에서 중앙에 오도록 설정 */
}

.swal-body{
	font-family : 'NotoSansKR' ; 
	font-size :500 !important;
}

#main {
  margin-top: 141px; 
}


</style>

<body>
<div id="main">

    <header class="mb-3">
        <a href="#" class="burger-btn d-block d-xl-none">
            <i class="bi bi-justify fs-3"></i>
        </a>
    </header>

    <div class="container-fluid">
        <div class="main-content">
            <div class="card">
                <div class="card-header">
                    <div class="container-fluid">
                        <div class="row align-items-center">
                            <!-- 왼쪽: 제목과 브레드크럼 (col-md-6) -->
                            <div class="col-md-6 d-flex align-items-center">
                                <nav aria-label="breadcrumb" class="ms-3">
                                    <ol class="breadcrumb mb-0">
                                        <li class="breadcrumb-item">
                                            <a href="/main">Home</a>
                                        </li>
                                        <li class="breadcrumb-item active">
                                            <a href="/hr/manage">본사 직원 조회</a>
                                        </li>
                                    </ol>
                                </nav>
                            </div>
                        </div> <!-- /.row.align-items-center -->
                    </div> <!-- /.container-fluid -->
                </div> <!-- /.card-header -->
            </div> <!-- /.card -->

            <!-- 검색 영역 -->
            <div class="card-body align-items-center justify-content-between" style="display: flex;">
                <div class="dataTable-top" style="justify-content: right; display: flex; width: 100%;">
                    <form id="searchForm" action="/hr/manage" method="get"
                          style="display: flex; align-items: center; gap: 10px; width: 100%;">
                         <!-- 대분류 -->
	                    <div class="dataTable-dropdown">
	                        <select name="mainCategory" id="mainCategory" class="dataTable-selector form-select">
	                            <option value="">대분류 선택</option>
	                            <option value="dept">
	                                <c:if test="${mainCategory eq 'dept'}">selected</c:if>
	                                본사_부서
	                            </option>
	                            <option value="position">
	                                <c:if test="${mainCategory eq 'position'}">selected</c:if>
	                                직책
	                            </option>
	                        </select>
	                    </div>
	
	                    <!-- 중분류 -->
	                    <div class="dataTable-dropdown">
	                        <select name="subCategory" id="subCategory" class="dataTable-selector form-select">
	                            <option value="">중분류 선택</option>
	                            <c:if test="${mainCategory eq 'dept'}">
	                                <option value="경영" <c:if test="${subCategory eq '경영'}">selected</c:if>>경영본부</option>
	                                <option value="인사/행정" <c:if test="${subCategory eq '인사/행정'}">selected</c:if>>인사/행정과</option>
	                                <option value="재정/회계" <c:if test="${subCategory eq '재정/회계'}">selected</c:if>>재정/회계과</option>
	                                <option value="전략/기획" <c:if test="${subCategory eq '전략/기획'}">selected</c:if>>전략/기획과</option>
	                                <option value="물류" <c:if test="${subCategory eq '물류'}">selected</c:if>>물류과</option>
	                            </c:if>
	                            <c:if test="${mainCategory eq 'position'}">
	                                <option value="본부장" <c:if test="${subCategory eq '본부장'}">selected</c:if>>본부장</option>
	                                <option value="과장" <c:if test="${subCategory eq '과장'}">selected</c:if>>과장</option>
	                                <option value="사원" <c:if test="${subCategory eq '사원'}">selected</c:if>>사원</option>
	                            </c:if>
	                        </select>
	                    </div>

                        <!-- 검색어 입력 -->
                        <div class="dataTable-search" style="flex: 1;">
                            <input type="text" id="krd" name="keyword" value="${param.keyword}"
                                   class="dataTable-input" placeholder="검색어를 입력하세요" aria-controls="tby">
                            <button type="submit" class="btn btn-warning rounded-pill">검색</button>
                        </div>
                    </form>
                </div>
            </div> <!-- /.card-body -->

            <!-- 테이블 영역 -->
            <div class="card-body">
                <div class="tableType01">
                    <table class="board">
                    <colgroup>
		       			<col width="3%">
		       			        			<col>
		       			<col width="8%">
		       		</colgroup>
                        <thead>
                            <tr>
                                <th scope="col" class="noline">순번</th>
                                <th scope="col" class="noline">아이디</th>
                                <th scope="col" class="noline">이름</th>
                                <th scope="col" class="noline">부서</th>
                                <th scope="col" class="noline">직책</th>
                                <th scope="col" class="noline">이메일</th>
                                <th scope="col" class="noline">연락처</th>
                                <th scope="col" class="noline">입사일</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="user" items="${userList}" varStatus="status">
                                <tr>
                                    <td class="noline" style="text-align:center;">${user.rnum}</td>
                                    <td class="noline" style="text-align:center;">${user.userNo}</td>
                                    <!-- 상세 보기 -->
                                    <td class="noline" style="text-align:center;">
                                        <a href="#" class="userDetail" data-user-no="${user.userNo}">
                                            ${user.userNm}
                                        </a>
                                    </td>
                                    <!-- 부서 표시 -->
                                    <td class="noline" style="text-align:center;">
                                        <c:choose>
                                            <c:when test="${user.deptNm == '경영'}">
                                                <span class="badge bg-light-primary" style="display: inline-block;" >경영</span>
                                            </c:when>
                                            <c:when test="${user.deptNm == '인사/행정'}">
                                                <span class="badge bg-light-success" style="display: inline-block;">인사/행정</span>
                                            </c:when>
                                            <c:when test="${user.deptNm == '전략/기획'}">
                                                <span class="badge bg-light-warning" style="display: inline-block;">전략/기획</span>
                                            </c:when>
                                            <c:when test="${user.deptNm == '재정/회계'}">
                                                <span class="badge bg-light-info" style="display: inline-block;">재정/회계</span>
                                            </c:when>
                                            <c:when test="${user.deptNm == '물류'}">
                                                <span class="badge bg-light-danger" style="display: inline-block;">물류</span>
                                            </c:when>
                                            <c:when test="${user.deptNm == 'CEO'}">
                                                <span class="badge bg-light-primary" style="display: inline-block;">CEO</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-light-secondary" style="display: inline-block;">기타</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="noline" style="text-align:center;">${user.positionNm}</td>
                                    <td class="noline" style="text-align:left;">${user.userMail}</td>
                                    <td class="noline" style="text-align:center;">
                                    	${fn:substring(user.userPhone, 0, 3)}-${fn:substring(user.userPhone, 3, 7)}-${fn:substring(user.userPhone, 7, 11)}
                                    </td>
                                    <td class="noline" style="text-align:center;">
                                        <fmt:formatDate value="${user.userIndate}" pattern="yyyy-MM-dd"/>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- 페이징 영역 -->
               <div class="card-footer">
               <nav aria-label="Page navigation example">
	            <ul class="pagination pagination-warning justify-content-center">
	                <li class="page-item">
	                    <!-- 페이징 처리 -->
	                    ${articlePage.pagingArea}
	                </li>
	            </ul>
	        </nav>
			</div>
            </div> <!-- /.card-body -->
        </div> <!-- /.main-content -->
    </div> <!-- /.container-fluid -->
</div> <!-- /#main -->


<!-- 회원 상세 모달 -->
<div class="modal fade" id="udModal" tabindex="-1" aria-labelledby="userDetailModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">회원 상세 정보</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id="modalContent">
                <div class="row">
                    <div class="col-12 col-lg-4">
                        <div class="card">
                            <div class="card-body">
                                <div class="d-flex justify-content-center align-items-center flex-column">
                                    <div class="avatar avatar-2xl" id="pic">
                                        <img src="" alt="프로필 이미지" id="profilepic" 
                                        	style="cursor: pointer; width: 150px; height: 150px; border-radius: 50%; object-fit: cover;">
                                     	<input type="file" id="profilePicUpload" style="display: none;" accept="image/*">
                                    </div>
                                    <h3 class="mt-3" id="detailUserNm"></h3>
                                    <p class="text-small" id="detailDeptNm"></p>
                                    <hr>
                                    <div id="signplace" class="text-center">
                                        <h5 class="mb-2">전자서명</h5>
                                        <img src="" alt="전자서명" id="sign" 
                                        	style="cursor: pointer; width: 200px; height: 100px; object-fit: contain;">
                                       	<input type="file" id="signUpload" style="display: none;" accept="image/*">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-lg-8">
                        <div class="card">
                            <div class="card-body">
                                <form id="profileForm" method="post">
                                    <div class="row">
                                        <div class="col-12 col-lg-6">
                                            <div class="form-group">
                                                <label for="name" class="form-label">이름</label>
                                                <input type="text" id="name" class="form-control able" readonly>
                                            </div>
                                            <div class="form-group">
                                                <label for="userNo" class="form-label">아이디</label>
                                                <input type="text" id="bonsaUserNo" class="form-control" readonly>
                                            </div>
                                            <div class="form-group">
                                                <label for="dept" class="form-label">부서</label>
                                                <input type="text" id="dept" class="form-control" readonly>
                                            </div>
                                            <div class="form-group">
                                                <label for="position" class="form-label">직책</label>
                                                <input type="text" id="position" class="form-control" readonly>
                                            </div>
                                            <div class="form-group">
                                                <label for="email" class="form-label">이메일</label>
                                                <input type="text" id="email" class="form-control able" readonly>
                                            </div>
                                        </div>
                                        <div class="col-12 col-lg-6">
                                            <div class="form-group">
                                                <label for="phone" class="form-label">연락처</label>
                                                <input type="text" id="phone" class="form-control able" readonly>
                                            </div>
                                            <div class="form-group">
                                                <label for="birthday" class="form-label">생일</label>
                                                <input type="date" id="birthday" class="form-control able" readonly>
                                            </div>
                                            <div class="form-group">
                                                <label for="userZip" class="form-label">우편번호</label>
                                                <input type="text" id="userZip" class="form-control able" readonly>
                                            </div>
                                            <div class="form-group">
                                                <label for="addr1" class="form-label">주소</label>
                                                <input type="text" id="addr1" class="form-control" readonly>
                                            </div>
                                            <div class="form-group">
                                                <label for="addr2" class="form-label">상세주소</label>
                                                <input type="text" id="addr2" class="form-control able" readonly>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>



<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>


<script>
    $(document).ready(function() {

    	 // 대분류 변경 시 중분류 옵션 업데이트
        $('#mainCategory').on('change', function() {
            const selected = $(this).val();
            let options = '';
    		
            
            if(selected === 'enabled'){
                options = '<option value="1">인증</option><option value="0">미인증</option>';
            } else if(selected === 'type'){
                options = '<option value="본사">본사</option><option value="가맹점">가맹점</option>';
            } else if (selected === 'dept') {
                options = '<option value="경영">경영본부</option>' +
                          '<option value="인사/행정">인사/행정과</option>' +
                          '<option value="재정/회계">재정/회계과</option>' +
                          '<option value="전략/기획">전략/기획과</option>' +
                          '<option value="물류">물류과</option>';
            } else if (selected === 'position') {
                options = '<option value="본부장">본부장</option>' +
                          '<option value="과장">과장</option>' +
                          '<option value="사원">사원</option>' +
                          '<option value="점주">가맹점주</option>' +
                          '<option value="매니저">매니저</option>' +
                          '<option value="알바">알바</option>';
            }

            $('#subCategory').html(options);
        });
    	 
    	// 검색 - 엔터 키
        $("#search").on("keydown", function(event) {
            if (event.keyCode === 13) { 
                const keyword = $("#krd").val();
                ajax(keyword, 1);
            }
        });

    	
    	 // 회원 상세 
        $(document).on("click", ".userDetail", function (e) {
            e.preventDefault();

            const userNo = $(this).data("user-no");
            
            $("#ok").data("user-no", userNo);
            $("#out").data("user-no", userNo);
            console.log("userNo:", userNo);

            $.ajax({
                url: `/hr/hrUserDetail/\${userNo}`,
                method: "POST",
                dataType: "json",
                success: function (response) {

                	console.log("response :", response);
                	 
                    const userVO = response.userVO;
                    const profileUrl = response.profileUrl;
                    const signUrl = response.signUrl;
                    
                    console.log("userVO :", userVO);
                    
                    let phone = userVO.userPhone; 
                    if (phone && phone.length === 11) {
                      phone = phone.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
                    } else if (phone && phone.length === 10) {
                      phone = phone.replace(/(\d{3})(\d{3,4})(\d{4})/, '$1-$2-$3');
                    }
                    $("#phone").val(phone);
                    

                    const birth = userVO.userBirth; 
                    if(birth && birth.length >= 10) {
                      const fmtBirth = birth.substring(0, 10); 
                      $("#birthday").val(fmtBirth);
                    } else {
                      $("#birthday").val("");
                    }
                    
                    $("#profilepic").attr("src", profileUrl);
                    $("#detailUserNm").text(userVO.userNm);
                    $("#detailDeptNm").text(userVO.deptNm || userVO.storeNm);
                    $("#sign").attr("src", signUrl);

                    $("#name").val(userVO.userNm);
                    $("#bonsaUserNo").val(userVO.userNo);
                    $("#dept").val(userVO.deptNm);
                    $("#position").val(userVO.positionNm);
                    $("#email").val(userVO.userMail);
                    $("#userZip").val(userVO.userZip);
                    $("#addr1").val(userVO.userAddr1);
                    $("#addr2").val(userVO.userAddr2);

                    $("#udModal").modal("show");
                },
                error: function () {
                    Swal.fire({
                        icon: "error",
                        title: "회원 상세 조회 실패",
                        text: "회원 정보를 불러오는데 실패했습니다.",
                    });
                },
            });
        });
    	 
    	 
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

    });

    /*
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
    
    */
</script>

