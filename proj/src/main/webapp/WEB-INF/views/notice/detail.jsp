<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>
<!DOCTYPE html>
<sec:authorize access="isAuthenticated()">
	<!-- 로그인 시 사이드바 시작-->
	<%@ include file="../include/header.jsp"%>
	<div id="main">
	<header class="mb-3">
		<a href="#" class="burger-btn d-block d-xl-none"> <i
			class="bi bi-justify fs-3"></i>
		</a>
	</header>
</sec:authorize>
<!-- 로그인 시 사이드바 끝-->

<!-- 비회원 메인 페이지(사이드바 없음) 시작 -->
<%@ include file="../include/top.jsp"%>
<!-- 비회원 메인 페이지(사이드바 없음) 끝 -->

<div id="main" style="margin-left: 0">
	<header class="mb-3">
		<a href="#" class="burger-btn d-block d-xl-none"> <i
			class="bi bi-justify fs-3"></i>
		</a>
	</header>
	
	<div class="page-heading">
		<div class="page-title">
			<div class="row">
				<div class="col-12 order-md-1 order-last">
					<nav aria-label="breadcrumb">
						nav aria-label="breadcrumb">
						<ol class="breadcrumb mb-0">
							<li class="breadcrumb-item"><a href="/main">Home</a></li>
							<li class="breadcrumb-item"><a href="/notice/list">공지사항</a></li>
							<li class="breadcrumb-item"><a href="/notice/detail?boardNo=103&currentPage=">상세보기</a></li>
						</ol>
					</nav>
					</nav>
				</div>
			</div>
		</div>
		<section class="section" style="margin-top:50px;">
			<div class="card">
				<div class="card-body">
					<form id="frm" action="/notice/update" method="post">
						<input type="hidden" name="boardNo" value="${noticeVO.boardNo}">
						<div class="row">
							<div class="col-md-12 mb-3">
								<div class="form-group">
									<label for="boardTitle" class="form-label">제목</label>
									<input type="text" class="form-control" id="boardTitle" name="boardTitle" 
										value="${noticeVO.boardTitle}" readonly>
								</div>
							</div>
							<div class="col-md-6 mb-3">
								<div class="form-group">
									<label for="userNm" class="form-label">작성자</label>
									<input type="text" class="form-control" id="userNm" name="userNm"
										value="${noticeVO.userNm}" readonly>
								</div>
							</div>
							<div class="col-md-6 mb-3">
								<div class="form-group">
									<label for="boardRegDate" class="form-label">작성일</label>
									<input type="date" class="form-control" id="boardRegDate" name="boardRegDate"
										value="${noticeVO.boardRegDate}" readonly>
								</div>
							</div>
							<div class="col-md-12 mb-3">
								<div class="form-group">
									<label for="boardCn" class="form-label">내용</label>
									<textarea class="form-control" id="boardCn" name="boardCn"
										rows="10" readonly>${noticeVO.boardCn}</textarea>
								</div>
							</div>
							<div class="col-md-6 mb-3">
								<div class="form-group">
									<label for="boardStart" class="form-label">게시 시작일</label>
									<input type="date" class="form-control" id="boardStart" name="boardStart"
										value="${noticeVO.boardStart}" readonly>
								</div>
							</div>
							<div class="col-md-6 mb-3">
								<div class="form-group">
									<label for="boardEnd" class="form-label">게시 종료일</label>
									<input type="date" class="form-control" id="boardEnd" name="boardEnd"
										value="${noticeVO.boardEnd}" readonly>
								</div>
							</div>
						</div>

						<!-- 버튼 영역 -->
						<div class="card-footer" style="background-color: transparent; border-top: 1px solid #eee; padding-top: 1rem;">
							<div class="d-flex justify-content-between">
								<!-- 일반모드 버튼 -->
								<div id="normalBtns">
									<c:if test="${userId eq noticeVO.userNo or userId eq 'a999'}">
										<button type="button" id="edit" class="btn btn-warning">
											수정
										</button>
										<button type="button" id="delete" class="btn btn-danger">
											삭제
										</button>
									</c:if>
								</div>
								
								<!-- 수정모드 버튼 -->
								<div id="editBtns" style="display: none;">
									<button type="submit" class="btn btn-warning">
										확인
									</button>
								</div>
								
								<!-- 공통 버튼 -->
								<div>
									<a href="/notice/list?currentPage=${param.currentPage}&keyword=${param.keyword}" 
									   class="btn btn-brown" id="listBtn">
										목록
									</a>
									<a href="/notice/detail?boardNo=${param.boardNo}" 
									   class="btn btn-secondary" id="cancelBtn" style="display: none;">
										취소
									</a>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</section>
	</div>

</div>

<style>
/* 카드 스타일 수정 */
.card {
	margin-bottom: 2rem;
	border: none;
	box-shadow: 0 0 15px rgba(0,0,0,0.1);
}

.card-body {
	padding: 2rem;
}

/* 폼 요소 스타일 수정 */
.form-group {
	margin-bottom: 1.5rem;
}

.form-control {
	padding: 0.75rem;
	border: 1px solid #dee2e6;
	border-radius: 0.375rem;
	width: 100%;
	font-size: 0.95rem;
}

/* 입력 필드 크기 통일 */
.form-control:not(textarea) {
	height: 45px;
}

/* 내용 텍스트영역 */
#boardCn {
	min-height: 200px;
	resize: vertical;
}

/* 버튼 스타일 */
.btn {
	padding: 0.7rem 1.5rem;
	font-size: 1.1rem;
	min-width: 100px;
}

/* Breadcrumb 스타일 수정 */
.breadcrumb {
    display: flex;
    padding: 1rem 0;
    margin-top: 1rem;
    list-style: none;
}

.breadcrumb-item {
    font-size: 1.5rem !important;  /* 크기 증가 */
    color: #6c757d;
    padding: 0.5rem 0;
}

.breadcrumb-item a {
    color: #6c757d;
    text-decoration: none;
    font-size: 1.5rem;  /* 링크 텍스트 크기도 동일하게 증가 */
}

.breadcrumb-item a:hover {
    color: #4B2F24;
}

.breadcrumb-item + .breadcrumb-item::before {
    content: ">";
    padding: 0 1rem;  /* 구분자 간격 증가 */
    font-size: 1.5rem;  /* 구분자 크기도 증가 */
}

.breadcrumb-item.active {
    color: #495057;
    font-size: 1.5rem;  /* active 상태 텍스트 크기도 증가 */
}

/* 페이지 헤더 여백 조정 */
.page-title {
	margin-bottom: 2rem;
}

.page-heading h3 {
	margin-bottom: 0.5rem;
}

/* 버튼 스타일 수정 */
.card-footer {
	padding: 1rem 2rem;
}

.card-footer .btn {
	min-width: 80px;
	margin-left: 8px;
}

.card-footer .btn:first-child {
	margin-left: 0;
}

/* 버튼 그룹 정렬 */
.d-flex.justify-content-between {
	align-items: center;
}

/* 버튼 아이콘 간격 */
.btn i {
	margin-right: 5px;
}

/* 페이지 헤더 스타일 수정 */
.page-heading {
	margin-bottom: 2.5rem;
	padding: 1rem 0;
}

.page-title h3 {
	font-size: 2rem !important;
	font-weight: 600;
	color: #333;
	margin-bottom: 1rem;
}

/* Breadcrumb 크기 수정 */
.breadcrumb-item {
	font-size: 1rem;
}

/* 버튼 스타일 수정 */
.btn-dark {
	color: #ffffff !important;
	background-color: #343a40;
	border-color: #343a40;
}

.btn-dark:hover {
	color: #ffffff !important;
	background-color: #23272b;
	border-color: #1d2124;
}

/* 버튼 아이콘 색상 */
.btn-dark i {
	color: #ffffff;
}

/* 갈색 버튼 스타일 (목록 버튼용) */
.btn-brown {
    color: #ffffff !important;
    background-color: #4B2F24 !important;
    border-color: #4B2F24 !important;
}

.btn-brown:hover {
    color: #ffffff !important;
    background-color: #3A241B !important;
    border-color: #3A241B !important;
}

.btn-brown i {
    color: #ffffff;
}
</style>

<script type="text/javascript">
	 $(function(){ 
		$("#edit").on("click",function(){
			//수정,삭제 버튼 비활성화
			$("#normalBtns").hide();
			$("#listBtn").hide();
			
			//확인,취소 버튼 활성화
			$("#editBtns").show();
			$("#cancelBtn").show();
			
			//readonly 비활성화
			$(".form-control").not("#userNm, #boardRegDate").attr("readonly",false);
			
			//작성자,작성일은 수정 불가처리
			$("#userNm").attr("readonly",true);
			$("#boardRegDate").attr("readonly",true);
			
		}); //수정 버튼 끝
		
		$("#delete").on("click",function(){
			 $("#frm").attr("action","/notice/delete");
			
			let result = confirm("삭제하시겠습니까?");
			console.log("result: ",result)
			//result값이 true면 삭제
			if(result > 0){
				$("#frm").submit();
			}else{
				alert("삭제가 취소되었습니다.");
			} 
		});//삭제 버튼 끝 
	});
</script>


<%@ include file="../include/footer.jsp"%>