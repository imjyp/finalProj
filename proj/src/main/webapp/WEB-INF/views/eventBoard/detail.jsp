<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="/css/common2.css">
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

	<div class="card">
		<div class="card-header">
			<div class="container-fluid">
				<div class="page-heading row"
					style="margin-top: 100px; margin-bottom: 0px">
					<div class="col-6 d-flex align-items-center">
						<nav aria-label="breadcrumb" class="ms-3">
							<ol class="breadcrumb mb-0">
								<li class="breadcrumb-item"><a href="/main">Home</a></li>
								<li class="breadcrumb-item active"><a href="/eventBoard/list">이벤트 목록</a></li>
								<li class="breadcrumb-item active"><a href="/eventBoard/detail?calNm=${calendarVO.calNm }&currentPage=1">이벤트 상세</a></li>
							</ol>
						</nav>
					</div>
					<div class="col-6 d-flex justify-content-end"></div>
				</div>
			</div>
		</div>
	</div>

	<div class="page-heading">
		<section class="section">
			<div class="card">
				<form id="frm" action="/eventBoard/update" method="post">
					<div class="card-content">
						<div class="table-responsive">
							<table class="table mb-0 table-hover">
								<tr>
									<th class="text-center" style="width: 10%;">제목</th>
									<td colspan="5">
										<input type="text" class="form-control" id="calTitle" 
											   name="calTitle" value="${calendarVO.calTitle}" readonly>
									</td>
								</tr>
								<tr>
									<th class="text-center">등록일</th>
									<td style="width: 25%;">
										<input type="datetime-local" class="form-control" 
											   id="calRegDate" name="calRegDate" 
											   value="${calendarVO.calRegDate}" readonly>
									</td>
									<th class="text-center" style="width: 10%;">기간</th>
									<td colspan="3">
										${calendarVO.calStart} ~ ${calendarVO.calEnd}
									</td>
								</tr>
								<tr>
									<th class="text-center">이미지</th>
									<td colspan="5">
										<img src="/resources${calendarVO.fileGroupVO.fileDetailVOList[0].fileSaveLocate}"
											 style="max-width: 80%;" class="img-fluid" />
									</td>
								</tr>
								<tr>
									<th class="text-center">내용</th>
									<td colspan="5">
										<textarea rows="8" cols="30" class="form-control" 
												  id="calContent" name="calContent" 
												  readonly>${calendarVO.calContent}</textarea>
									</td>
								</tr>
								<tr>
									<th class="text-center">첨부파일</th>
									<td colspan="5">
										<c:forEach var="fileDetailVO" 
												 items="${calendarVO.fileGroupVO.fileDetailVOList}"
												 varStatus="status">
											<div class="form-group mb-2"
												 style="display: flex; align-items: center; gap: 10px;">
												<button type="button" id="fileName"
														class="btn btn-outline-dark btn-sm download" 
														name="fileName"
														data-file="${fileDetailVO.fileSaveLocate}">
													<svg xmlns="http://www.w3.org/2000/svg" width="16"
														 height="16" fill="currentColor" 
														 class="bi bi-download"
														 viewBox="0 0 16 16">
															<path d="M.5 9.9a.5.5 0 0 1 .5.5v2.5a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1v-2.5a.5.5 0 0 1 1 0v2.5a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2v-2.5a.5.5 0 0 1 .5-.5"></path>
															<path d="M7.646 11.854a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 10.293V1.5a.5.5 0 0 0-1 0v8.793L5.354 8.146a.5.5 0 1 0-.708.708z"></path>
													</svg>
													다운로드
												</button>
												<small>${fileDetailVO.fileOriginalName}</small>
											</div>
										</c:forEach>
									</td>
								</tr>
							</table>
						</div>
					</div>

					<!-- 버튼 영역 -->
					<div class="card-footer">
						<span class="d-flex justify-content-between">
							<div>
								<button type="button" id="delete"
										class="btn btn-secondary btn-user">삭제</button>
							</div>
							<div>
								<a href="/eventBoard/list?currentPage=${param.currentPage}&keyword=${param.keyword}"
								   class="btn btn-dark btn-user">목록</a>
							</div>
						</span>
					</div>
				</form>
			</div>
		</section>
	</div>

</div>
<script type="text/javascript">

	$(function () {
		$("#edit").on("click", function () {
			//수정,삭제 버튼 비활성화
			$("#spn1").css("display", "none");
			//등록,취소 버튼 활성화
			$("#spn2").css("display", "block");
			//readonly 비활성화
			$(".form-control").attr("readonly", false);

			//작성자,작성일은 수정 불가처리
			$("#userNm").attr("readonly", true);
			$("#calRegDate").attr("readonly", true);
			//$("#calStart").attr("readonly", false);
			//$("#calEnd").attr("readonly", false);
		}); //수정 버튼 끝
		
		
		$("#cancel").on("click", function () {
			//수정,삭제 버튼 활성화
			$("#spn1").css("display", "block");
			//등록,취소 버튼 비활성화
			$("#spn2").css("display", "none");
			//readonly 비활성화
			$(".form-control").attr("readonly", true);

			//작성자,작성일은 수정 불가처리
			$("#userNm").attr("readonly", true);
			$("#calRegDate").attr("readonly", true);
			//$("#calStart").attr("readonly", true);
			//$("#calEnd").attr("readonly", true);
		}); //취소 버튼 끝

		
		$("#delete").on("click", function () {
			$("#frm").attr("action", "/eventBoard/delete");

			let result = confirm("삭제하시겠습니까?");
			console.log("result: ", result)
			//result값이 true면 삭제
			if (result > 0) {
				$("#frm").submit();
			} else {
				alert("삭제가 취소되었습니다.");
			}
		});//삭제 버튼 끝 
	});

	//다운로드 클릭 처리 ->동적요소
	$(document).on("click", ".download", function () {
		//해당 파일 경로 가져오기
		let filePath = $(this).data("file");
		//console.log("다운로드파일경로: ",filePath);
		if (filePath != null || filePath != "") {
			//다운로드 url 생성
			const downloadUrl = `/download?fileName=\${filePath}`;
			//console.log("downloadUrl : ", downloadUrl);
			//a 태크를 동적으로 생성하여 다운로드 트리거
			const $a = $('<a></a>');
			$a.attr("href", downloadUrl);
			$a.attr("download", ""); //서버에서 지정한 파일명으로 다운로드
			$a[0].click(); //a태그 클릭 트리거
		}//end if
	});

	//파일 이미지 미리보기
	$(function () {
		$("#fileName").on("change", handleImg);     // 파일 선택 시 이미지 미리보기 트리거
	});

</script>

<style>
.btn-dark{
	color: white !important;
}
</style>
<%@ include file="../include/footer.jsp"%>