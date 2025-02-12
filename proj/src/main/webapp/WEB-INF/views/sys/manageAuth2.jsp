<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<%@ include file="../include/header.jsp"%>


<link rel="stylesheet" href="/resources/css/styles.css">
<link rel="stylesheet" href="/dist/assets/compiled/css/app-dark.css">
<link rel="stylesheet" href="/dist/assets/compiled/css/iconly.css">


<!-- sweetAlert -->
<!-- <link rel="stylesheet" href="/css/sweetalert2.min.css"> -->
<script type="text/javascript" src="/js/sweetalert2.min.js"></script>

<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>

<script src="/dist/assets/static/js/components/dark.js"></script>
<script src="/dist/assets/extensions/perfect-scrollbar/perfect-scrollbar.min.js"></script>
<script src="/dist/assets/compiled/js/app.js"></script>
<script src="/dist/assets/static/js/pages/dashboard.js"></script>

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
    font-size: 16px; /* 글씨 크기 키움 
  }
*/
  #udModal h3 {
    font-size: 20px; /* 사용자 이름 글씨 크기 */
  }

  #udModal p.text-small {
    font-size: 14px; /* 소형 글씨 크기 */
  }

</style>
<title>권한 부여 / 관리</title>
<!--  
    <sec:authorize access="isAuthenticated()">
      
        <%-- --%>
    </sec:authorize>
-->
 <div id="main">
    <%@ include file="../include/top.jsp"%>
    <header class="mb-3">
        <a href="#" class="burger-btn d-block d-xl-none">
            <i class="bi bi-justify fs-3"></i>
        </a>
    </header>

    <div class="card">
	  <div class="card-header">
	    <div class="container-fluid">
	      <div class="row align-items-center">
	        
	        <!-- 왼쪽: 제목과 브레드크럼 (col-md-6) -->
	        <div class="col-md-6 d-flex align-items-center">
	          <h2 class="card-title mb-0">권한 부여 / 회원 관리</h2>
	          <nav aria-label="breadcrumb" class="ms-3">
	            <ol class="breadcrumb mb-0">
	              <li class="breadcrumb-item"><a href="/main">Home</a></li>
	              <li class="breadcrumb-item active"><a href="/sys/list">권한 부여 및 회원 관리</a></li>
	            </ol>
	          </nav>
	        </div>
	        
	        <!-- 오른쪽: 카드들 (col-md-6) -->
	        <div class="col-md-6 d-flex justify-content-end">
	          <!-- Flexbox nowrap으로 한 줄에 배치, 넘치면 스크롤 -->
	          <div class="d-flex flex-nowrap" style="overflow-x: auto; width: 100%;">
	            <!-- 인증 카드 -->
	            <div class="card text-center me-2" style="width: 80px;">
	              <div class="card-header bg-light-secondary text-black py-1 px-2 fw-bold">
	                인증
	              </div>
	              <div class="card-body py-1">
	                <h6 id="approvalCnt" class="mb-0">0</h6>
	              </div>
	            </div>
	            
	            <!-- 미인증 카드 -->
	            <div class="card text-center me-2" style="width: 80px;">
	              <div class="card-header bg-light-secondary text-black py-1 px-2 fw-bold">
	                미인증
	              </div>
	              <div class="card-body py-1">
	                <h6 id="pendingCnt" class="mb-0">0</h6>
	              </div>
	            </div>
	            
	            <!-- 정상 회원 카드 -->
	            <div class="card text-center me-2" style="width: 80px;">
	              <div class="card-header bg-light-secondary text-black py-1 px-2 fw-bold">
	                정상
	              </div>
	              <div class="card-body py-1">
	                <h6 id="nomalMem" class="mb-0">0</h6>
	              </div>
	            </div>
	            
	            <!-- 탈퇴 카드 -->
	            <div class="card text-center me-2" style="width: 80px;">
	              <div class="card-header bg-light-secondary text-black py-1 px-2 fw-bold">
	                탈퇴
	              </div>
	              <div class="card-body py-1">
	                <h6 id="delMem" class="mb-0">0</h6>
	              </div>
	            </div>
	            
	            <!-- 본사 카드 -->
	            <div class="card text-center me-2" style="width: 80px;">
	              <div class="card-header bg-light-secondary text-black py-1 px-2 fw-bold">
	                본사
	              </div>
	              <div class="card-body py-1">
	                <h6 id="bonsaEmp" class="mb-0">0</h6>
	              </div>
	            </div>
	            
	            <!-- 가맹점 카드 -->
	            <div class="card text-center me-2" style="width: 80px;">
	              <div class="card-header bg-light-secondary text-black py-1 px-2 fw-bold">
	                가맹점
	              </div>
	              <div class="card-body py-1">
	                <h6 id="storeEmp" class="mb-0">0</h6>
	              </div>
	            </div>
	            
	            <!-- 총 회원 카드 -->
	            <div class="card text-center" style="width: 80px;">
	              <div class="card-header bg-light-secondary text-black py-1 px-2 fw-bold">
	                총 회원
	              </div>
	              <div class="card-body py-1">
	                <h6 id="totalMem" class="mb-0">0</h6>
	              </div>
	            </div>
	            
	          </div> <!-- /.d-flex.flex-nowrap -->
	        </div> <!-- /.col-md-6.d-flex.justify-content-end -->
	        
	      </div> <!-- /.row.align-items-center -->
	    </div> <!-- /.container-fluid -->
	  </div> <!-- /.card-header -->
	</div> <!-- /.card -->


    <!-- 
    =============================================
    요약 표(테이블) - (주석처리된 원본)
    <div class="col-md-6 d-flex justify-content-end">
        <div class="table-responsive" style="width: 100%; max-width: 500px;">
            <table class="table table-bordered mb-0">
                <thead class="table-dark">
                    <tr>
                        <th class="text-center">항목</th>
                        <th class="text-center">수치</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="text-center">권한 대기</td>
                        <td class="text-center" id="pendingCnt">0</td>
                    </tr>
                    ...
                </tbody>
            </table>
        </div>
    </div>
    =============================================
    -->

    <div class="card-content">
        <div class="card-body align-items-center justify-content-between" style="display: flex;">
            <div class="dataTable-top" style="justify-content: right; display: flex; width: 100%;">
                <form id="searchForm" action="/sys/list" method="get"
                      style="display: flex; align-items: center; gap: 10px; width: 100%;">
                    <!-- 대분류 -->
                    <div class="dataTable-dropdown">
                        <select name="mainCategory" id="mainCategory" class="dataTable-selector form-select">
                            <option value="">대분류 선택</option>
                            <option value="enabled">
                                <c:if test="${mainCategory eq 'enabled'}">selected</c:if>
                                인증여부
                            </option>
                            <option value="type">
                                <c:if test="${mainCategory eq 'type'}">selected</c:if>
                                소속
                            </option>
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
                            <c:if test="${mainCategory eq 'enabled'}">
						    <!-- 인증 / 미인증 두 가지 옵션을 항상 노출 -->
						    <option value="1" <c:if test="${subCategory eq '1'}">selected</c:if>>인증</option>
						    <option value="0" <c:if test="${subCategory eq '0'}">selected</c:if>>미인증</option>
						</c:if>
                            <c:if test="${mainCategory eq 'type'}">
                                <c:choose>
                                    <c:when test="${userVO.userCode == 1 || userVO.userCode == 3}">
                                        <option value="1" ${subCategory eq '본사' ? 'selected' : ''}>본사</option>
                                        <option value="3" ${subCategory eq '본사' ? 'selected' : ''}>본사</option>
                                    </c:when>
                                    <c:when test="${userVO.userCode == 2 || userVO.userCode == 4}">
                                        <option value="2" ${subCategory eq '가맹점' ? 'selected' : ''}>가맹점</option>
                                        <option value="4" ${subCategory eq '가맹점' ? 'selected' : ''}>가맹점</option>
                                    </c:when>
                                </c:choose>
                            </c:if>
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
                                <option value="가맹점주" <c:if test="${subCategory eq '점주'}">selected</c:if>>가맹점주</option>
                                <option value="매니저" <c:if test="${subCategory eq '매니저'}">selected</c:if>>매니저</option>
                                <option value="알바" <c:if test="${subCategory eq '알바'}">selected</c:if>>알바</option>
                            </c:if>
                        </select>
                    </div>

                    <!-- 검색어 입력 -->
                    <div class="dataTable-search" style="flex: 1;">
                        <input type="text" id="krd" name="keyword" value="${param.keyword}"
                               class="dataTable-input" placeholder="검색어를 입력하세요" aria-controls="tby">
                        <button type="submit" class="btn btn-dark rounded-pill">검색</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- 유형/본사-부서/직책 선택 탭 (주석)
        <ul class="nav nav-tabs" id="authTab" role="tablist">
            ...
        </ul>
        -->

        <!-- Table with outer spacing -->
        <div class="table-responsive">
            <table class="table table-hover mb-0">
                <thead>
                    <tr>
                        <th class="text-center">번호</th>
                        <th class="text-center">아이디</th>
                        <th class="text-center">회원 이름</th>
                        <th class="text-center">소속</th>
                        <th class="text-center">부서 / 가맹점명</th>
                        <th class="text-center">직책</th>
                        <th class="text-center">회원상태</th>
                        <th class="text-center">권한명</th>
                        <th class="text-center">권한부여일</th>
                        <th class="text-center">인증여부</th>
                        <th class="text-center">권한 변경</th>
                    </tr>
                </thead>
                <tbody id="tby">
                    <c:forEach var="userVO" items="${articlePage.content}" varStatus="stat">
                        <tr>
                            <input type="hidden"  id= "mailvalue" value="${userVO.userMail}">
                            <td class="text-bold-500 text-center">${userVO.rnum}</td>
                            <td class="text-bold-500 text-center">${userVO.userNo}</td>
                            <td class="text-bold-500 text-center">
                                <a href="#" class="userDetail" data-user-no="${userVO.userNo}">
                                    ${userVO.userNm}
                                </a>
                            </td>
                            <td class="text-bold-500 text-center">
                                <c:choose>
                                    <c:when test="${userVO.userCode == 1 || userVO.userCode == 3}">본사</c:when>
                                    <c:when test="${userVO.userCode == 2 || userVO.userCode == 4}">가맹점</c:when>
                                    <c:otherwise>기타</c:otherwise>
                                </c:choose>
                            </td>
                            <!-- 부서 또는 가맹점명 출력 -->
					        <td class="text-bold-500 text-center">
					        	<c:choose>
					                <c:when test="${userVO.userCode == 1 || userVO.userCode == 3}">${userVO.deptNm}</c:when>
					                <c:when test="${userVO.userCode == 2 || userVO.userCode == 4}">${userVO.storeNm}</c:when>
					                <c:otherwise>기타</c:otherwise>
					            </c:choose>
					        </td>
                            <td class="text-bold-500 text-center">${userVO.positionNm}</td>
                            <td class="text-bold-500 text-center">
                                <c:choose>
                                    <c:when test="${userVO.userStatus == '1'}">
                                        <span class="badge bg-primary">정상</span>
                                    </c:when>
                                    <c:when test="${userVO.userStatus == '2'}">
                                        <span class="badge bg-secondary">탈퇴</span>
                                    </c:when>
                                    <c:otherwise>기타</c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-bold-500 text-center">
                                <c:choose>
                                    <c:when test="${userVO.authName == 'ROLE_GY'}">
                                        <span class="badge bg-light-info">경영</span>
                                    </c:when>
                                    <c:when test="${userVO.authName == 'ROLE_IS'}">
                                        <span class="badge bg-light-info">인사/행정</span>
                                    </c:when>
                                    <c:when test="${userVO.authName == 'ROLE_GH'}">
                                        <span class="badge bg-light-info">전략/기획</span>
                                    </c:when>
                                    <c:when test="${userVO.authName == 'ROLE_JJ'}">
                                        <span class="badge bg-light-info">재정/회계</span>
                                    </c:when>
                                    <c:when test="${userVO.authName == 'ROLE_MR'}">
                                        <span class="badge bg-light-info">물류</span>
                                    </c:when>
                                    <c:when test="${userVO.authName == 'ROLE_GMJ'}">
                                        <span class="badge bg-light-warning">가맹점주</span>
                                    </c:when>
                                    <c:when test="${userVO.authName == 'ROLE_ALBA'}">
                                        <span class="badge bg-light-secondary">아르바이트</span>
                                    </c:when>
                                    <c:when test="${userVO.authName == 'ROLE_MANAGER'}">
                                        <span class="badge bg-light-secondary">매니저</span>
                                    </c:when>
                                    <c:when test="${userVO.authName == 'ROLE_SYS'}">
                                        <span class="badge bg-light-primary">시스템관리자</span>
                                    </c:when>
                                    <c:when test="${userVO.authName == 'ROLE_CEO'}">
                                        <span class="badge bg-light-primary">CEO</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-light-danger">권한 대기</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-bold-500 text-center">
                                <fmt:formatDate value="${userVO.authDate}" pattern="yyyy-MM-dd" />
                            </td>
                            <td class="text-bold-500 text-center">
                                <c:choose>
                                    <c:when test="${userVO.enabled == 0}">미인증</c:when>
                                    <c:when test="${userVO.enabled == 1}">인증</c:when>
                                    <c:otherwise>기타</c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text=center">
                                <button type="button" class="btn btn-outline-dark editAuthBtn"
                                        data-bs-toggle="modal"
                                        data-bs-target="#editAuthModal"
                                        data-user-no="${userVO.userNo}"
                                        data-user-code="${userVO.userCode}"
                                        data-dept-nm="${userVO.deptNm}"
                                        data-store-nm="${userVO.storeNm}"
                                        data-position-nm="${userVO.positionNm}"
                                        data-auth-name="${userVO.authName}"
                                        data-enabled="${userVO.enabled}">
                                    권한 변경
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        
		<div class="card-footer">
        <nav aria-label="Page navigation example">
            <ul class="pagination pagination-primary justify-content-center">
                <li class="page-item">
                    <!-- 페이징 처리 -->
                    ${articlePage.pagingArea}
                </li>
            </ul>
        </nav>
        </div>
    </div> <!-- /.card-content -->
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
                                                <input type="text" id="sysUserNo" class="form-control" readonly>
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
                <div class="modal-footer">
<!--                     <div class="d-flex"> -->
                        <button type="button" class="btn btn-outline-dark ms-2" style="display:none" id="ok" data-user-no="${userVO.userNo}">저장</button>
                        <button type="button" class="btn btn-secondary ms-2" id="edit">수정</button>
                        <button type="button" class="btn btn-outline-light ms-2" id="exit" style="display:none">취소</button>
                        <button type="button" class="btn btn-dark ms-2" id="out" data-user-no="${userVO.userNo}">탈퇴</button>
<!--                     </div> -->
                </div>
            </div>
        </div>
    </div>
</div>


<!-- 권한 수정 모달 -->
<div class="modal fade" id="editAuthModal" tabindex="-1" aria-labelledby="editAuthModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-dialog-centered modal-dialog-scrollable">
      <div class="modal-content">
          <div class="modal-header">
              <h5 class="modal-title" id="editAuthModalLabel">권한 수정</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
              <form id="editAuthForm" class="form-group">
                  <div class="mb-3">
                      <label for="modalUserNo" class="form-label">아이디</label>
                      <input type="text" class="form-control" id="modalUserNo" readonly>
                  </div>
                  <div class="mb-3">
                      <label for="modalType" class="form-label">소속</label>
                      <input type="text" class="form-control" id="modalType" readonly>
                  </div>
                  <div class="mb-3" id="deptDiv">
                      <label for="modalDeptNm" class="form-label">부서</label>
                      <input type="text" class="form-control" id="modalDeptNm" readonly>
                  </div>
                  <div class="mb-3" id="storeDiv" style="display: none;">
                      <label for="modalStoreNm" class="form-label">가맹점 이름</label>
                      <input type="text" class="form-control" id="modalStoreNm" readonly>
                  </div>
                  <div class="mb-3">
                      <label for="modalPositionNm" class="form-label">직책</label>
                      <input type="text" class="form-control" id="modalPositionNm">
                  </div>
                  <!-- 권한명 -->
                  <div class="mb-3">
                      <label for="modalAuthName" class="form-label">권한명</label>
                      <select id="modalAuthName" class="form-select">
					      <option value="ROLE_GY" <c:if test="${userVO.authName == 'ROLE_GY'}">selected</c:if>>경영</option>
					      <option value="ROLE_IS" <c:if test="${userVO.authName == 'ROLE_IS'}">selected</c:if>>인사/행정</option>
					      <option value="ROLE_JJ" <c:if test="${userVO.authName == 'ROLE_JJ'}">selected</c:if>>재정/회계</option>
					      <option value="ROLE_GH" <c:if test="${userVO.authName == 'ROLE_GH'}">selected</c:if>>전략/기획</option>
					      <option value="ROLE_MR" <c:if test="${userVO.authName == 'ROLE_MR'}">selected</c:if>>물류</option>
					      <option value="ROLE_GMJ" <c:if test="${userVO.authName == 'ROLE_GMJ'}">selected</c:if>>가맹점주</option>
					      <option value="ROLE_MANAGER" <c:if test="${userVO.authName == 'ROLE_MANAGER'}">selected</c:if>>매니저</option>
					      <option value="ROLE_ALBA" <c:if test="${userVO.authName == 'ROLE_ALBA'}">selected</c:if>>아르바이트생</option>
					      <option value="ROLE_SYS" <c:if test="${userVO.authName == 'ROLE_SYS'}">selected</c:if>>시스템관리자</option>
					      <option value="ROLE_CEO" <c:if test="${userVO.authName == 'ROLE_CEO'}">selected</c:if>>CEO</option>
					      <option value="ROLE_PENDING" <c:if test="${userVO.authName == 'ROLE_PENDING'}">selected</c:if>>권한 대기</option>
					  </select>
                  </div>
                  <!-- 인증여부 -->
                    <div class="mb-3">
                        <label for="modalEnabled" class="form-label">인증여부</label>
                        <select id="modalEnabled" class="form-select">
                            <option value="1">인증</option>
                            <option value="0">미인증</option>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" id="saveAuthChanges" class="btn btn-outline-dark">변경</button>
                <button type="button" class="btn btn-primary" data-bs-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>
<%@ include file="../include/footer.jsp"%>

<script>

$(document).ready(function() {
    let editMode = false;

    /* 모달 닫기 함수
    function mClose(){
        $("#udModal").modal('hide');
    }
	*/
	
    // 써머리
    function updateSummaryTable() {
        $.ajax({
            url: '/sys/summary', 
            method: 'GET',
            dataType: 'json',
            success: function (resp) {
                if (!resp) {
                    console.error("서버로부터 빈 응답을 받았습니다.");
                    return;
                }

                const summary = {
                    pendingCnt: resp.pendingCnt || 0, 
                    approvalCnt: resp.approvalCnt || 0, 
                    totalMem: resp.totalMem || 0, 
                    bonsaEmp: resp.bonsaEmp || 0, 
                    storeEmp: resp.storeEmp || 0, 
                    delMem: resp.delMem || 0, 
                    nomalMem: resp.nomalMem || 0
                };

                $("#pendingCnt").text(summary.pendingCnt);
                $("#approvalCnt").text(summary.approvalCnt);
                $("#nomalMem").text(summary.nomalMem);
                $("#delMem").text(summary.delMem);
                $("#bonsaEmp").text(summary.bonsaEmp);
                $("#storeEmp").text(summary.storeEmp);
                $("#totalMem").text(summary.totalMem);
                
                console.log("summary:", summary);
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.error("요약 데이터를 불러오는 데 실패했습니다.", textStatus, errorThrown);
            }
        });
    }

    // 회원 상세 
    $(document).on("click", ".userDetail", function (e) {
        e.preventDefault();

        const userNo = $(this).data("user-no");
        
        $("#ok").data("user-no", userNo);
        $("#out").data("user-no", userNo);
        console.log("userNo:", userNo);

        $.ajax({
            url: `/sys/userDetail/\${userNo}`,
            method: "POST",
            dataType: "json",
            success: function (response) {
                const userVO = response.userVO;
                const profileUrl = response.profileUrl;
                const signUrl = response.signUrl;

                
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
                $("#sysUserNo").val(userVO.userNo);
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

    // 수정
    $("#edit").on('click', function(){
        editMode = true;
        $("#ok").css('display','block');
        $("#edit").css('display','none');
        $("#exit").css('display','block');
        $("#out").css('display','none');
        $("#btnPost").css('display','block'); 
        $(".able").attr("readonly", false);
        $("#name").focus();
    });

    // 수정 -> 취소
    $("#exit").on('click', function(){
        editMode = false;
        $("#edit").css('display','block');
        $("#out").css('display','block'); 
        $("#exit").css('display','none');
        $("#ok").css('display','none');
        $("#btnPost").css('display','none'); 
        $("input").attr("readonly", true);
    });

    // 수정 모드 아닐 때 전자서명 클릭
    $("#sign").on('click', function(){
        if(!editMode) {
        	swal({
        		icon: 'error',
        		title: "수정 버튼을 눌러주세요!",
        		});
            return;
        }
        else{
            $("#signUpload").click();
        }
    });

    // 전자서명 업로드
    $("#signUpload").on('change', function(){
        $("#signreg").css('display','none');
        const file = this.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function (e) {
                $("#sign").attr("src", e.target.result); // 미리 보기
            };
            reader.readAsDataURL(file);
            console.log("수정 전자서명 :", file);
        }
    });

    // 수정 -> 전자서명
    $("#signreg").on('click', function(){
        $("#signreg").css('display','none');
        $("#edit").click();
        $("#signUpload").click();
    });

    // 수정모드 아닐 때 프로필
    $("#profilepic").on('click', function(){
        if(!editMode) {
        	Swal.fire({
                icon: 'error',
                title: '수정 버튼을 눌러주세요!'
            });
            return;
        }
        else{
            $("#profilePicUpload").click();
        }
    });

    // 프로필 업로드
    $("#profilePicUpload").on('change', function () {
        const file = this.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function (e) {
                $("#profilepic").attr("src", e.target.result); // 미리 보기
            };
            reader.readAsDataURL(file);
            console.log("수정 프로필 :", file);
        }
    });

    // 저장
    $("#ok").on('click', function(){
        const formData = new FormData();

        const userNo = $(this).data("user-no");
        console.log("userNo:", userNo);

        const profile = $("#profilePicUpload")[0].files[0];
        const sign = $("#signUpload")[0].files[0];

        formData.append("userNo", userNo);

        if (profile) {
            formData.append("userProfile", profile); 
        } else{
            formData.append("userProfile", new Blob([]), ""); // 빈 파일 추가
        }

        if (sign) {
            formData.append("userSign", sign);
        } else{
            formData.append("userSign", new Blob([]), ""); // 빈 파일 추가
        }

        console.log(formData.get("userProfile"));
        console.log(formData.get("userSign"));

        let data = { 
            userNm: $("#name").val(),
            userMail: $("#email").val(),
            userPhone: $("#phone").val(),
            userBirth: $("#birthday").val(),
            userZip: $("#userZip").val(),
            userAddr1: $("#userAddr1").val(),
            userAddr2: $("#userAddr2").val(),
        };
        console.log("data", data);
        console.log("userMail", $("#email").val());
        console.log("userBirth", $("#birthday").val());

        formData.append("userData", JSON.stringify(data));

        $.ajax({
            url: '/sys/updProfile',
            type: "POST",
            data: formData,
            contentType: false,
            processData: false,
            success: function(result){
                console.log("수정 완료:", result);
                Swal.fire({
                    icon: 'success',
                    title: '수정 완료',
                    timer: 3000
                }).then(() => {
                	  location.reload();
                });
            },
            error: function () {
            	Swal.fire({
                    icon: 'error',
                    title: '수정 실패'
                });
            },
        });
    });

    // 탈퇴 
    $("#out").on("click", function() {
        const userNo = $(this).data("user-no");
        console.log("userNo:", userNo);

        let data = {"userNo": userNo};

        $.ajax({
            url:"/sys/delUser",
            contentType:"application/json;charset=utf-8",
            data: JSON.stringify(data),
            type:"POST",
            dataType:"json",
            success:function(result){
                if(result > 0){
                  Swal.fire({
                      icon: 'success',
                      title: '탈퇴 처리 완료',
                      timer: 3000
                  }).then(() => {
                	  location.reload();
                  });
                }
            },
            error: function () {
            	Swal.fire({
                    icon: 'error',
                    title: '탈퇴 처리 실패'
                });
            },
        });
    });

    // 권한 수정 
    $(document).on("click", ".editAuthBtn", function() {
        const userNo = $(this).data("user-no");
        const userCode = $(this).data("user-code");
        const deptNm = $(this).data("dept-nm");
        const storeNm = $(this).data("store-nm");
        const positionNm = $(this).data("position-nm");
        const authName = $(this).data("auth-name");
        const enabled = $(this).data("enabled");

        console.log(userNo, userCode, deptNm, storeNm, positionNm, authName, enabled);

        $("#modalUserNo").val(userNo);
        $("#modalType").val((userCode == 1 || userCode == 3) ? "본사" : "가맹점");

        if (userCode == 2 || userCode == 4) {
            $("#modalStoreNm").val(storeNm); // 가맹점 이름
            $("#deptDiv").css("display", "none");
            $("#storeDiv").css("display", "block");
        } else {
            $("#modalDeptNm").val(deptNm); // 부서
            $("#deptDiv").css("display", "block");
            $("#storeDiv").css("display", "none");
        }

        $("#modalPositionNm").val(positionNm);
        $("#modalAuthName").val(authName);
        $("#modalEnabled").val(enabled);

        $("#editAuthModal").modal("show");
    });

    // 권한 변경 저장 
    $("#saveAuthChanges").on("click", function() {
        const userNo = $("#modalUserNo").val();
        const authName = $("#modalAuthName").val();
        const enabled = $("#modalEnabled").val();
        const positionNm = $("#modalPositionNm").val();
        const storeNm = $("#modalStoreNm").val();
        const userMail = $("#mailvalue").val();

        $.ajax({
            url: '/sys/updateUserAuth',
            method: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify({
                userNo: userNo,
                authName: authName,
                enabled: enabled,
                positionNm: positionNm,
                userMail:userMail,
                storeNm: storeNm
            }),
            success: function(response) {
                Swal.fire({
                    icon: 'success',
                    title: '권한이 수정되었습니다.',
                    timer: 3000
                }).then(() => {
                	  location.reload();
                });
            },
            error: function() {
                Swal.fire({
                    icon: 'error',
                    title: '권한 수정에 실패했습니다.'
                });
            }
        });
    });

    // 검색 - 엔터 키
    $("#search").on("keydown", function(event) {
        if (event.keyCode === 13) { 
            const keyword = $("#krd").val();
            ajax(keyword, 1); 
        }
    });

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

    // 초기화 함수 실행
    updateSummaryTable();
});
	        
</script>

