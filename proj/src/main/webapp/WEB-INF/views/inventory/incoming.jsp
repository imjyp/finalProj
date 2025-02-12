<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<!-- 로그인 권한 -->
<sec:authorize access="isAuthenticated()">
 <!-- 로그인 시 사이드바 시작-->
<%@ include file="../include/header.jsp" %>
        <div id="main">
            <header class="mb-3">
                <a href="#" class="burger-btn d-block d-xl-none">
                    <i class="bi bi-justify fs-3"></i>
                </a>
            </header>
</sec:authorize>
 <!-- 로그인 시 사이드바 끝-->
 
 <!-- 비회원 메인 페이지(사이드바 없음) 시작 -->
<%@ include file="../include/top.jsp" %>
 <!-- 비회원 메인 페이지(사이드바 없음) 끝 -->

<div class="page-heading" style="margin:10 10 10 10px;">
	<div class="page-title">
		<div class="row">
			<div class="col-12 col-md-6 order-md-1 order-last">
				<h3>입고조회</h3>
			</div>
		</div>
	</div>
	<section class="section">
		<div class="card">
			<div class="card-body">
				<div
					class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
					<div class="dataTable-top">
						<div class="input-group" style="width: 200px; display: flex; justify-content: flex-end;">
							<input type="text" id="keyword" name="keyword" class="form-control"
								placeholder="검색어 입력" value="${param.keyword}">
							<div>
								<button type="button" id="search" class="btn btn-outline-primary">검색</button>
							</div>
						</div>
						<div  style="display: flex; justify-content: flex-end;width: 100%;">
								<button type="button" id="create" class="btn btn-primary ms-3">등록</button>
						</div>
						
					</div>
					<div class="table-responsive">
						<table class="table table-hover mb-0" id="table1">
							<thead>
								<tr>
									<th class="sorting sorting_asc" tabindex="0"
										aria-controls="table1" rowspan="1" colspan="1"
										aria-sort="ascending"
										aria-label="price: activate to sort column descending"
										style="width: 7%;">선택</th>
									<th>순번</th>
									<th>담당자</th>
									<th>발주번호</th>
									<th>품목명</th>
									<th>수량</th>
									<th>입고단가(원)</th>
									<th>입고일</th>
								</tr>
							</thead>
							<tbody id="tby">
							</tbody>
						</table>
					</div>
				</div>
				<div class="row">
					<div class="card-footer" id="divPagingArea">
					${articlePage.pagingArea} 
					</div>
				</div>
	</section>
</div>
<div class="row" id="divPagingArea"></div>
<div class="col-12" style="justify-content: left; display: flex;">
	<a href="#" id="delete" class="btn btn-danger ms-3">삭제</a>
</div>
<!-- 입고 등록 모달 시작 -->
<div class="modal fade text-left" id="modalCreate" tabindex="-1" aria-labelledby="myModalLabel33"  aria-modal="true" role="dialog">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" role="document">
        <div class="modal-content">
            <form action="/resource/create" method="post" enctype="multipart/form-data" >
	            <div class="modal-header">
	                <h4 class="modal-title" class="boardTitle">입고등록</h4>
	                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
	                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-x"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>
	                </button>
	            </div>
            	<input type="hidden" id="boardNo" name="boardNo">
                <div class="modal-body">
                    <label for="text">발주번호 </label>
                    <div class="form-group">
                        <input id="headOrderNo" type="text" value="headOrderNo" name="headOrderNo" class="form-control" required>
                    </div>
                    <label for="text">품목명(dropbox나 트리 형식으로) </label>
                    <div class="form-group">
                        <input id="itemNo" type="text" value="itemNo" name="itemNo" class="form-control" required>
                    </div>
                    <label for="text">수량</label>
                    <div class="form-group">
                        <input id="recordAmount" type="text" value="recordAmount" name="recordAmount" class="form-control" required>
                    </div>
                    <label for="text">입고단가(원)</label>
                    <div class="form-group">
                        <input id="recordItemPrice" type="text" value="recordItemPrice" name="recordItemPrice" class="form-control" required>
                    </div>
                    
                    
				  </div>
                <div id="spn" class="modal-footer" style=" flex-start;" >
                    <button type="submit" id="commit" class="btn btn-light-secondary" >
                        <i class="bx bx-x d-block d-sm-none"></i>
                        <span class="d-none d-sm-block">등록</span>
                    </button>
                    <button type="button" id="cancel" class="btn btn-primary ms-1" data-bs-dismiss="modal">
                        <i class="bx bx-check d-block d-sm-none"></i>
                        <span class="d-none d-sm-block">취소</span>
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>	
<!-- 입고 등록 모달 끝 -->
<!-- 입고 상세 모달 시작 -->
<div class="modal fade text-left" id="modalDetail" tabindex="-1" aria-labelledby="myModalLabel33"  aria-modal="true" role="dialog">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" role="document">
        <div class="modal-content">
            <form action="/resource/update" method="post" enctype="multipart/form-data" >
	            <div class="modal-header">
	                <h4 class="modal-title" id="boardTitle" class="boardTitle" name="boardTitle"></h4>
	                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
	                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-x"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>
	                </button>
	            </div>
            	<input type="hidden" id="boardNo" name="boardNo">
                <div class="modal-body">
                    <label for="text">작성자 </label>
                    <div class="form-group">
                        <input id="userNm" type="text" value="userNm" name="userNm" class="form-control" readonly>
                    </div>
                    <label for="text">부서</label>
                    <div class="form-group">
                        <input id="deptNm" type="text" value="deptNm" name="deptNm" class="form-control" readonly>
                    </div>
                    <label for="text">내용</label>
                    <div class="form-group">
                        <textarea id="boardCn" type="text" name="boardCn" class="form-control" readonly></textarea>
                    </div>
                    
				  </div>
                <div id="spn1" class="modal-footer" style="justify-content: flex-start;">
                    <button type="button" id="edit" class="btn btn-light-secondary" >
                        <i class="bx bx-x d-block d-sm-none"></i>
                        <span class="d-none d-sm-block">수정</span>
                    </button>
                    <button type="button" id="close" class="btn btn-primary ms-1"  data-bs-dismiss="modal">
                        <i class="bx bx-check d-block d-sm-none"></i>
                        <span class="d-none d-sm-block">닫기</span>
                    </button>
                </div>
                <div id="spn2" class="modal-footer" style="display: none; flex-start;" >
                    <button type="submit" id="commit" class="btn btn-light-secondary" >
                        <i class="bx bx-x d-block d-sm-none"></i>
                        <span class="d-none d-sm-block">저장</span>
                    </button>
                    <button type="button" id="cancel" class="btn btn-primary ms-1" data-bs-dismiss="modal">
                        <i class="bx bx-check d-block d-sm-none"></i>
                        <span class="d-none d-sm-block">취소</span>
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>	
<!-- 입고 상세 모달 끝 -->
<script>
$(function(){
	
	//페이지 로딩 시 초기값으로 getList 호출
	//getList("${param.currentPage}","");
	
	//console.log("개똥이");
	
	$("#search").on("click",function(){
		let keyword = $("input[name='keyword']").val();
		//console.log("keyword: ",keyword);
		getList(1,keyword);
	})
	$("#keyword").on("keydown",function(event){
		if(event.key == "Enter"){
		let keyword = $("input[name='keyword']").val();
		//console.log("keyword: ",keyword);
		getList(1,keyword);
			
		}
	})
	
	//페이지 클릭 처리 -> 동적요소
	$(document).on("click",".clsPagingArea",function(){
		
		let currentPage = $(this).data("currentPage");
		let keyword = $(this).data("keyword");
		
		getList(currentPage,keyword);// 해당 페이지와 검색어로 getList 호출
	});
	
	//다운로드 클릭 처리 ->동적요소
	$(document).on("click",".download",function(){
		//해당 파일 경로 가져오기
		let filePath = $(this).data("file");
		//console.log("다운로드파일경로: ",filePath);
		
		if(filePath != null || filePath != ""){
			//다운로드 url 생성
			const downloadUrl = `/download?fileName=\${filePath}`;
			//console.log("downloadUrl : ", downloadUrl);
			//a 태크를 동적으로 생성하여 다운로드 트리거
			const $a = $('<a></a>');
			$a.attr("href",downloadUrl);
			$a.attr("download",""); //서버에서 지정한 파일명으로 다운로드
			$a[0].click(); //a태그 클릭 트리거
			
			
		}//end if
	});
	
	
	// 등록 모달
	$(document).on("click","#create",function(){
		//모달 활성화
		$("#modalCreate").modal("show");
		//data-board-no="달러{resourceVO.boardNo}
		//boardNo값을 기준으로 비동기식 데이터 송수신
		
	
	});
	
	//수정 버튼 클릭 시 이벤트
	$(document).on("click","#edit",function(){
		//수정,취소 버튼 숨김
		$("#spn1").css("display","none");
		//저장,취소 버튼 활성
		$("#spn2").css("display","block");
		
		//내용 영역 입력 활성
		$("#boardCn").attr("readonly",false);
		//다운로드 버튼 숨김
		$("#fileName").css("display","none");
		
		//첨부파일 버튼 활성화
		$("#up").css("display","block");
		
		
	});
	
	// 모달이 닫힐 때 원래 상태로 초기화
	$('#inlineForm').on('hide.bs.modal', function () {
	    // 초기 상태로 되돌리기
	    $("#spn1").css("display", "block"); // 첫 번째 푸터 보이기
	    $("#spn2").css("display", "none");  // 두 번째 푸터 숨기기
	    
	    $("#boardCn").attr("readonly", true); // 텍스트 영역을 읽기 전용으로 설정
	    $("#fileName").css("display", "block");  // 파일 이름 보이기
	    
	    $("#up").css("display","none");// 첨부파일 버튼 숨기기
	});
	
	
	
	$("#delete").on("click",function(){
		// 선택된 radio 버튼 찾기
		//<input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault2">
	    var selectedRadio = $("input[type='radio']:checked");
		
		
		if(selectedRadio.length > 0){//체크됐다면.. 1 > 0
			 // 해당 radio의 부모 td에서 boardNo 값 가져오기
	        var boardNo = selectedRadio.closest("td").find('input[name="boardNo"]').val();
			//delete->boardNo :  48
			console.log("delete->boardNo : ", boardNo);
			
	        // 확인 메시지 (선택적으로 추가)
	        var confirmDelete = confirm("정말로 삭제하시겠습니까?");
	        if (confirmDelete) {
	            // AJAX로 boardNo를 서버에 전송하여 삭제 요청
	            del(boardNo)
	        }else{
	        	alert("삭제가 취소되었습니다.");
	        	return;
	        }
		}else{
			alert("삭제가 취소되었습니다.");
			return;
		} 
	});//삭제 버튼 끝 
});//end 달러function
</script>
<%@ include file="../include/footer.jsp" %>