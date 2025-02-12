<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>
<!DOCTYPE html>

  <!-- summernote api 시작 -->
   <script src="/summernote/summernote-lite.js"></script>
  <script src="/summernote/lang/summernote-ko-KR.js"></script>
  <link rel="stylesheet" href="/summernote/summernote-lite.css">
  <!-- summernote api 끝 -->


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
				<form id="frm" action="/resource/createPost" method="post" enctype="multipart/form-data">
					<div class="card-body">
						<div class="row">
							<div >
								<!-- 공지사항 상세내역 시작 -->
								<div class="form-group">
									<label for="boardTitle">제목</label> <input type="text"
										class="form-control" id="boardTitle" name="boardTitle"
										placeholder="제목을 입력하세요" required >
								</div>

								<div class="form-group col-md-3">
									<!-- 로그인 시 사용자 정보가 자동으로 입력되도록 설정 -->
									<label for="userNm">작성자</label> <input type="text"
										class="form-control" id="userNm" 
										value="${tbUserVO.userNm}" readonly>
										<input type="hidden" name="userNo" value="${tbUserVO.userNo}">
								</div>
							</div>
							<div class="col-12">
								<div class="form-group">
									<label for="boardCn">내용</label>
									<textarea rows="10" cols="30" class="form-control" id="summernote" name="boardCn"
										placeholder="내용을 입력하세요" required>  </textarea>
										<div id="editor">	</div>
								</div>
								<div class ="form-group">
								<label for="uploadFiles">첨부파일</label>
								<div class="input-group">
									<div class="custom-file">
									  <input type="file" class="custom-file-input" id="uploadFiles"
									  name="uploadFiles" class="uploadFiles" multiple />
									  
									</div>
								</div>
							    </div>								
							<!-- 공지사항 상세내역 끝 -->

							</div>
						</div>
					</div>
					
					<!-- 수정모드 시작 -->
					<span id="spn2" class="justify-between">
						<span style="float: left">
							<button type="submit" class="btn btn-primary btn-user">등록
							</button>
					</span> <span style="float: right"> 
							<a href="/resource/list"	class="btn btn-success btn-user"> 취소 </a>
					</span>
					</span>
					<!-- 수정모드 끝 -->
				</form>
			</div>
		</section>
	</div>

</div>
<script>
function handleImg(e){
	
	console.log("응애 됨")
	
	// 이미지 오브젝트
	let files = e.target.files;
	
	let fileArr = Array.prototype.slice.call(files);
	
	$("#divIamge").html("");
	
	fileArr.forEach(function(f){
		let reader = new FileReader();
		
		reader.onload = function(e){
			let img = "<img src='" + e.target.result+"' style = 'width:20%' />";
			$("#divImage").append(img);
		}
		reader.readAsDataURL(f);
	})
	
	
}

$(function(){
	$("#uploadFiles").on("change",handleImg);
})
  

  </script>
	

<%@ include file="../include/footer.jsp" %>