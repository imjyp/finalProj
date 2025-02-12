<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>

<!-- sweetAlert -->
<link rel="stylesheet" href="/css/sweetalert2.min.css">
<script type="text/javascript" src="/js/sweetalert2.min.js"></script>

<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>

<script src="/dist/assets/static/js/components/dark.js"></script>
<script src="/dist/assets/extensions/perfect-scrollbar/perfect-scrollbar.min.js"></script>
<script src="/dist/assets/compiled/js/app.js"></script>
<script src="/dist/assets/static/js/pages/dashboard.js"></script>
<!DOCTYPE html>

<style>
#main {
  margin-top: 70px; 
}

.btn-dark{
color:white !important;
}

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

/* 제목 입력 필드 */
#suggestTitle {
    width: 100%;
}

/* 작성자, 작성일 필드 */
.col-md-6 .form-control {
    width: 100%;
}

/* 내용 텍스트영역 */
#suggestContent {
    min-height: 200px;
    resize: vertical;
}

/* 댓글 영역 스타일 */
.comment-thread {
    padding: 1rem 0;
}

.comment {
    background-color: #f8f9fa;
    padding: 1rem;
    border-radius: 0.375rem;
    margin-bottom: 1rem;
}

/* 댓글 입력 폼 */
.input-group {
    margin-bottom: 1rem;
}

.input-group .form-control {
    border-top-right-radius: 0;
    border-bottom-right-radius: 0;
}

.input-group .btn {
    border-top-left-radius: 0;
    border-bottom-left-radius: 0;
}

/* 버튼 영역 */
.card-footer {
    padding: 1rem 2rem;
    background-color: transparent;
    border-top: 1px solid #dee2e6;
}

.btn {
    padding: 0.5rem 1rem;
    font-size: 0.95rem;
}

/* 모달 스타일 */
.modal-content {
    border: none;
    border-radius: 0.5rem;
}

.modal-header {
    padding: 1.5rem;
    border-bottom: 1px solid #dee2e6;
}

.modal-body {
    padding: 1.5rem;
}

.modal-footer {
    padding: 1rem 1.5rem;
    border-top: 1px solid #dee2e6;
}

/* Breadcrumb 스타일 수정 */
.breadcrumb {
    display: flex;
    padding: 1.5rem 0;
    margin: 1.5rem 0;
    list-style: none;
}

.breadcrumb-item {
    font-size: 2rem !important;  /* 텍스트 크기 대폭 증가 */
    color: #6c757d;
}

.breadcrumb-item a {
    color: #6c757d;
    text-decoration: none;
    font-size: 2rem;  /* 링크 텍스트 크기도 동일하게 증가 */
}

.breadcrumb-item a:hover {
    color: #4B2F24;
}

.breadcrumb-item + .breadcrumb-item::before {
    content: ">";
    padding: 0 1.5rem;  /* 구분자 간격 증가 */
    font-size: 2rem;  /* 구분자 크기도 증가 */
}

.breadcrumb-item.active {
    color: #495057;
    font-size: 2rem;  /* active 상태 텍스트 크기도 증가 */
}

/* 페이지 헤더 여백 조정 */
.page-title {
    margin-bottom: 2rem;
}

.page-heading h3 {
    margin-bottom: 0.5rem;
}
</style>
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
						<ol class="breadcrumb mb-0">
							<li class="breadcrumb-item"><a href="/main">Home</a></li>
							<li class="breadcrumb-item"><a href="/suggest/list">건의게시판</a></li>
						</ol>
					</nav>
				</div>
			</div>
		</div>
		<section class="section" style="margin-top:50px;">
			<div class="card">
				<div class="card-body">
					<form id="frm" action="/suggest/update" method="post">
						<input type="hidden" name="suggestBoardNo" value="${suggestVO.suggestBoardNo}">
						<div class="row">
							<div class="col-md-12 mb-3">
								<div class="form-group">
									<label for="suggestTitle" class="form-label">제목</label>
									<input type="text" class="form-control" id="suggestTitle" name="suggestTitle"
										value="${suggestVO.suggestTitle}" readonly>
								</div>
							</div>
							<div class="col-md-6 mb-3">
								<div class="form-group">
									<label for="userNm" class="form-label">작성자</label>
									<input type="text" class="form-control" id="userNm" name="userNm"
										value="${suggestVO.userNm}" readonly>
								</div>
							</div>
							<div class="col-md-6 mb-3">
								<div class="form-group">
									<label for="suggestDate" class="form-label">작성일</label>
									<input type="date" class="form-control" id="suggestDate" name="suggestDate"
										value="${suggestVO.suggestDate}" readonly>
								</div>
							</div>
							<div class="col-md-12">
								<div class="form-group">
									<label for="suggestContent" class="form-label">내용</label>
									<textarea class="form-control" id="suggestContent" name="suggestContent"
										rows="10" readonly>${suggestVO.suggestContent}</textarea>
								</div>
							</div>
						</div>

						<!-- 버튼 영역 -->
						<div class="card-footer" style="background-color: transparent; border-top: 1px solid #eee; padding-top: 1rem;">
							<!-- 일반모드 -->
							<span id="spn1" class="d-flex justify-content-between">
								<div>
									<c:if test="${userId eq suggestVO.userNo}">
										<button type="button" id="edit" class="btn btn-warning">
											<i class="bi bi-pencil"></i> 수정
										</button>
										<button type="button" id="delete" class="btn btn-danger">
											<i class="bi bi-trash"></i> 삭제
										</button>
									</c:if>
								</div>
								<div>
									<a href="/suggest/list?currentPage=${param.currentPage}&keyword=${param.keyword}"
										class="btn btn-dark">
										<i class="bi bi-list"></i> 목록
									</a>
								</div>
							</span>
							<!-- 수정모드 -->
							<c:if test="${userId eq suggestVO.userNo}">
								<span id="spn2" class="d-flex justify-content-between" style="display: none !important;">
									<button type="button" id="confirm" class="btn btn-warning">
										<i class="bi bi-check"></i> 확인
									</button>
									<a href="/suggest/detail?suggestBoardNo=${param.suggestBoardNo}"
										class="btn btn-secondary">
										<i class="bi bi-x"></i> 취소
									</a>
								</span>
							</c:if>
						</div>
					</form>
<hr>
					<div class="card mt-4">
						<div class="card-body">
							<!-- 댓글 입력 폼 -->
							<sec:authorize access="isAuthenticated()">
								<sec:authorize access="hasAnyRole('CEO','SYS','IS','JJ','GH','GY','MR','GMJ')">
									<form id="frm" class="mb-4" action="/suggest/createReply" method="post">
										<input type="hidden" name="suggestBoardNo" value="${suggestVO.suggestBoardNo}"/>
										<input type="hidden" name="repUser" value="${userId}"/>
										<div class="input-group">
											<input type="text" name="repContent" id="repContent" class="form-control" 
												placeholder="댓글을 입력하세요">
											<button type="button" class="btn btn-warning reply">
												<i class="bi bi-chat"></i> 등록
											</button>
										</div>
									</form>
								</sec:authorize>
							</sec:authorize>

							<!-- 댓글 목록 -->
							<c:forEach var="replyVO" items="${replyVO}">
								<div class="comment-thread" style="margin-left:${replyVO.lvl*50}px;">
									<div class="comment border-bottom py-3">
										<div class="d-flex justify-content-between">
											<div>
												<strong>${replyVO.userNm}</strong>
												<small class="text-muted">
													<fmt:formatDate value="${replyVO.repRegDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
												</small>
											</div>
											<div>
												<c:if test="${userId eq replyVO.repUser}">
													<button class="btn btn-sm btn-link replyUpdate" 
														data-rep-content="${replyVO.repContent}"
														data-no="${replyVO.repNo}">
														<i class="bi bi-pencil"></i>
													</button>
													<button class="btn btn-sm btn-link text-danger replyDelete" 
														data-no="${replyVO.repNo}">
														<i class="bi bi-trash"></i>
													</button>
												</c:if>
											</div>
										</div>
										<p class="mb-1" id="spanReplyContent${replyVO.repNo}">${replyVO.repContent}</p>
										
										<!-- 대댓글 입력 폼 -->
										<sec:authorize access="isAuthenticated()">
											<sec:authorize access="hasAnyRole('CEO','SYS','IS','JJ','GH','GY','MR','GMJ')">
												<div class="input-group input-group-sm mt-2">
													<input type="text" id="txt${replyVO.repNo}" class="form-control" 
														placeholder="대댓글을 입력하세요">
													<button type="button" class="btn btn-outline-warning clsReplyBtn"
														data-rep-user="${userId}" 
														data-parent-no="${replyVO.repNo}"
														data-board-no="${replyVO.suggestBoardNo}">
														<i class="bi bi-reply"></i> 답글
													</button>
												</div>
											</sec:authorize>
										</sec:authorize>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>
	 <!-- 댓글수정 모달창 시작-->
	 <div class="modal fade" id="modalReplyUpdate">
	        <div class="modal-dialog">
	          <div class="modal-content">
	            <div class="modal-header">
	              <h4 class="modal-title">댓글 수정</h4>
	              <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
	                <span aria-hidden="true">&times;</span>
	              </button>
	            </div>
            <div class="modal-body">
              <p id="modalReplyBody">
              	<input type="hidden" id="modalNo">
              	<input type="text" class="form-control form-control-sm" id="modalRepContent">
              </p>
            </div>
            <div class="modal-footer justify-content-between">
              <button type="button" class="btn btn-default" data-bs-dismiss="modal">Close</button>
              <button type="button" id="btnModalUpdate" class="btn btn-warning">댓글 변경</button>
            </div>
          </div>
          <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
      </div>
 <!-- 댓글수정 모달창 끝-->
</div>

</div>
<script type="text/javascript">
	 $(function(){ 
		 //건의사항 수정
		$("#edit").on("click",function(){
			// 수정,삭제 버튼 비활성화
			$("#spn1").css("display", "none");
			//확인,취소 버튼 활성화
			$("#spn2").css("display", "block");
			//readonly 비활성화
			$(".form-control").attr("readonly",false);
			
			//작성자,작성일은 수정 불가처리
			$("#userNm").attr("readonly",true);
			$("#boardRegDate").attr("readonly",true);
			
		}); //수정 버튼 끝
		
		//건의사항 수정 확인(sweetalert 적용)
		$("#confirm").on("click",function(){
			
			let suggestContent = $("#suggestContent").val();
			
			if(suggestContent.trim() === ""){
				Swal.fire({
					  icon: "warning",
					  title: "내용을 입력하세요."
				});
				return;
			}
			
			Swal.fire({
				  icon: "success",
				  title: "수정이 완료되었습니다."
    		}).then((result) => {
    			$(this).closest("form").submit();  // 폼을 제출
          	
          });
			
		})
		 //건의사항 삭제(sweetalert 적용)
		$("#delete").on("click",function(){
			
			Swal.fire({
		        title: '삭제하시겠습니까?',
		        icon: 'warning',
		        showCancelButton: true,  // 취소 버튼
		        confirmButtonText: '삭제',
		        cancelButtonText: '취소'
		    }).then((result) => {
		        // 사용자가 확인을 클릭한 경우
		        if (result.isConfirmed) {
		            // 폼 액션을 삭제로 설정
				   $("#frm").attr("action","/suggest/delete");
				
					// 폼 제출
					$("#frm").submit();
		        }else{
					Swal.fire({
						  icon: "info",
						  title: "삭제가 취소되었습니다."
	         		 })
				
				}
		    });
		});//삭제 버튼 끝 
		
		//댓글 등록 (sweetalert 적용)
		$(document).on("click",".reply",function(){
			let replyContent = $(this).closest("form").find("#repContent").val();  // 댓글 입력값 가져오기
		    console.log("replyContent: ",replyContent);
		    // 댓글이 공백이면 알림창 표시
		    if (replyContent.trim() === "") {
			    	Swal.fire({
						  icon: "warning",
						  title: "내용을 입력하세요."
	            })
					return;
		    }
		    
		    
		    Swal.fire({
				  icon: "success",
				  title: "댓글이 등록되었습니다."
      		}).then((result) => {
      			$(this).closest("form").submit();  // 폼을 제출
            	
            });
		})
		
		//댓글 수정버튼 클릭
		$(document).on("click",".replyUpdate",function(){
			let repContent = $(this).data("rep-content");
			let repNo= $(this).data("no");
			
			let data ={
					repContent,
					repNo
			}
			//console.log("data: ",data);
			$("#modalNo").val(repNo);
			$("#modalRepContent").val(repContent);
			
			//모달 보이기
			$('#modalReplyUpdate').modal('show');
		});
		
		//댓글 수정 실행(sweetalert 적용)
		$("#btnModalUpdate").on("click",function(){
			let repNo = $("#modalNo").val();
			let repContent = $("#modalRepContent").val();
			
			let data = {
					"repContent":repContent,
					"repNo":repNo
			}
			//console.log("data :",data);
			
			 // 댓글이 공백이면 알림창 표시
		    if (repContent.trim() === "") {
			    	Swal.fire({
						  icon: "warning",
						  title: "내용을 입력하세요."
	            })
					return;
		    }
		    
		    
		    ;
			
			
			//1.JSON.stringify(data)-> @RequestBody
			$.ajax({
				url:"/suggest/updateReply",
				contentType: "application/json;charset=utf-8",
				data:JSON.stringify(data),
				type:"post",
				dataType:"json",
				success:function(result){
					//console.log("result: ",result);
					
					Swal.fire({
						  icon: "success",
						  title: "댓글이 변경되었습니다."
		      		}).then((result) => {
		      		//수정된 내용으로 처리
						$("#spanReplyContent"+repNo).html(result.repContent);
						//모달 닫기
						$("#modalReplyUpdate").modal("hide");
						
						location.reload();
		            	
		            })
					
					
					
				}
			});//end ajax
		});//end btnModalUpdate
		
		//댓글 삭제(sweetalert 적용)
		$(document).on("click",".replyDelete",function(){
			
			let repNo = $(this).data("no");
			//console.log("repNo: ",repNo);
			
			Swal.fire({
		        title: '삭제하시겠습니까?',
		        icon: 'warning',
		        showCancelButton: true,  // 취소 버튼
		        confirmButtonText: '삭제',
		        cancelButtonText: '취소'
		    }).then((result) => {
		        // 사용자가 확인을 클릭한 경우
		        if (result.isConfirmed) {
		        	$.ajax({
						url:"/suggest/deleteReply"
						/* , contentType:"application/json;charset=utf-8" */
						, data:{repNo:repNo}
						, type:"post"
						, dataType:"text"
						, success:function(result){
							//console.log("result: ", result);
							Swal.fire({
								  icon: "success",
								  title: "댓글이 삭제되었습니다.",
								  showConfirmButton: false,
								  timer: 1500
			                }).then((result) => {
								location.reload();
			                	
			                });
						},error: function(xhr, status, error) {
				            console.error("삭제 실패: ", error);
							Swal.fire({
		                         icon: 'error',
		                         title: '댓글 삭제가 실패했습니다.',
		                         showConfirmButton: false,
								  timer: 1500
		                     });
						}
		        	});	
		        }else{
					Swal.fire({
						  icon: "info",
						  title: "삭제가 취소되었습니다."
	         		 })
				
				}
		    });
			
			//let confirmDel = confirm("댓글을 삭제하시겠습니까?");
			//console.log("confirmDel: ",confirmDel); 
			
		});//댓글 삭제 끝
		
		// 대댓글 저장(sweetalert 적용)
		$(document).on("click",".clsReplyBtn",function(){
			
			let repContent = $(this).closest(".input-group").find("input").val();
			let repUser = $(this).data("rep-user");
			let parentNo = $(this).data("parent-no");
			let suggestBoardNo = $(this).data("board-no");
			
			
			if(repContent.trim() === ""){
				Swal.fire({
					  icon: "warning",
					  title: "내용을 입력하세요."
              })
				return;
			}
			
			let data ={
					"repContent":repContent,
					"repUser":repUser,
					"parentNo":parentNo,
					"suggestBoardNo":suggestBoardNo
			}
			console.log("data: ",data);
			
			$.ajax({
				url:"/suggest/createRereply"
				, contentType: "application/json;charset=utf-8"
				, data:JSON.stringify(data)
				, type:"post"
				, dataType:"json"
				, success:function(result){
					if (result) {
						Swal.fire({
							  icon: "success",
							  title: "대댓글이 성공적으로 등록되었습니다.",
							  showConfirmButton: false,
							  timer: 1500
		                }).then((result) => {
						location.reload();
		                	
		                });
	                  
	                } else {
	                	 Swal.fire({
	                         icon: 'error',
	                         title: '대댓글 등록에 실패하였습니다.',
	                         showConfirmButton: false,
							  timer: 1500
	                     });
	                }
				}
			})
		});// 대댓글 끝 
		
		
	});//end 달러function
</script>


<%@ include file="../include/footer.jsp"%>