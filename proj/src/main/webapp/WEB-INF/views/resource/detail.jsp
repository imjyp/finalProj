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
	<!-- <div id="main"> -->
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
					<h3>자료실</h3>
				</div>
			</div>
		</div>
		<section class="section">
			<div class="card col-md-10">
				<form id="frm" action="/resource/update" method="post">
				<div class="card-header">
					<input type="hidden" name="boardNo" value="${resourceVO.boardNo}">
					<h4 class="card-title">${resourceVO.boardNo}</h4>
				</div>
					<div class="card-body">
						<div class="row">
							<div >
								<!-- 공지사항 상세내역 시작 -->
								<div class="form-group">
									<label for="boardTitle">제목</label> <input type="text"
										class="form-control" id="boardTitle" name="boardTitle"
										value="${resourceVO.boardTitle}" readonly>
								</div>

								<div class="form-group col-md-3">
									<label for="userNm">작성자</label> <input type="text"
										class="form-control" id="userNm" name="userNm"
										value="${resourceVO.userNm}" readonly>
								</div>

								<div class="form-group col-md-3">
									<label for="boardRegDate">작성일</label> <input type="date"
										class="form-control" id="boardRegDate" name="boardRegDate"
										value="${resourceVO.boardRegDate}" readonly>

								</div>
							</div>
							<div class="col-12">
								<div class="form-group">
									<label for="boardCn">내용</label>
									<textarea rows="10" cols="30" class="form-control" id="boardCn" name="boardCn"
										readonly> ${resourceVO.boardCn} </textarea>
								</div>
							
								
								<!-- 공지사항 상세내역 끝 -->

							</div>
						</div>
					</div>
					<!-- 일반모드 시작 -->
					<span id="spn1" class="justify-between">
						<sec:authorize access="isAuthenticated()"><!-- 로그인 했다면 보여라 -->
							<sec:authorize access="hasAnyRole('CEO','SYS','IS','JJ','GH','GY','MR')">
								<p style="float: left">
									<button type="button" id="edit" class="btn btn-primary btn-user"
										style="float: left;">수정</button>
									&nbsp;
									<button type="button" id="delete"
										class="btn btn-warning btn-user">삭제</button>
								</p>
							</sec:authorize>
						</sec:authorize>		
						<p style="float: right">
							<a
								href="/resource/list?currentPage=${param.currentPage}&keyword=${param.keyword}"
								class="btn btn-success btn-user"> 목록 </a>
						</p>
					</span>
					<!-- 일반모드 끝 -->
					<!-- 수정모드 시작 -->
					<span id="spn2" class="justify-between" style="display: none;">
						<span style="float: left">
							<button type="submit" class="btn btn-primary btn-user">확인
							</button>
					</span> <span style="float: right"> <a
							href="/resource/detail?boardNo=${param.boardNo}"
							class="btn btn-success btn-user"> 취소 </a>
					</span>
					</span>
					<!-- 수정모드 끝 -->
				</form>
			</div>
		</section>
	</div>

</div>

<script type="text/javascript">
	 $(function(){ 
		$("#edit").on("click",function(){
			//수정,삭제 버튼 비활성화
			$("#spn1").css("display", "none");
			//확인,취소 버튼 활성화
			$("#spn2").css("display", "block");
			//readonly 비활성화
			$(".form-control").attr("readonly",false);
			
			//작성자,작성일은 수정 불가처리
			$("#userNm").attr("readonly",true);
			$("#boardRegDate").attr("readonly",true);
			
		}); //수정 버튼 끝
		
		$("#delete").on("click",function(){
			 $("#frm").attr("action","/resource/delete");
			
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