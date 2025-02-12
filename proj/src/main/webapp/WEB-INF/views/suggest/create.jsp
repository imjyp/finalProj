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
					<h3>건의사항</h3>
				</div>
			</div>
		</div>
		<section class="section">
			<div class="card col-md-10">
				<form id="frm" action="/suggest/createPost" method="post">
					<div class="card-body">
						<div class="row">
							<div >
								<!-- 건의사항 상세내역 시작 -->
								<div class="form-group">
									<label for="suggestTitle">제목</label> <input type="text"
										class="form-control" id="suggestTitle" name="suggestTitle"
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
									<label for="suggestContent">내용</label>
									<textarea rows="10" cols="30" class="form-control" id="suggestContent" name="suggestContent"
										placeholder="내용을 입력하세요" required>  </textarea>
										
								</div>
								
								<!-- 건의사항 상세내역 끝 -->

							</div>
						</div>
					</div>
					
					<!-- 등록 시작 -->
					<div class="form-check">
					    <input class="form-check-input" type="checkbox" id="autoFillCheck">
					    <label class="form-check-label" for="autoFillCheck">
					        자동 채우기
					    </label>
					</div>
										
										
					<span id="spn2" class="justify-between">
						<span style="float: left">
							<button type="submit" class="btn btn-primary btn-user">등록
							</button>
					</span> <span style="float: right"> 
							<a href="/suggest/list"	class="btn btn-success btn-user"> 취소 </a>
					</span>
					</span>
					<!-- 등록 끝 -->
				</form>
			</div>
		</section>
	</div>

</div>
<script>
$('.summernote').summernote({
	  height: 150,
	  lang: "ko-KR"
	});
  

  </script>
	
<script>
    document.getElementById("autoFillCheck").addEventListener("change", function() {
        if (this.checked) {
            document.getElementById("suggestTitle").value = "업무 환경 개선 제안";  
            document.getElementById("suggestContent").value = "최근 사무실 내 공간 활용에 대한 불편을 느끼는 직원들이 많습니다. 업무 집중도가 높아질 수 있도록 더 효율적인 공간 배치와 휴식 공간의 확장이 필요하다고 생각합니다. 또한, 편안한 근무 환경을 위해 공기 청정기나 실내 식물 배치 등도 고려해볼 수 있을 것입니다. 이를 통해 직원들의 생산성과 만족도를 높일 수 있을 것으로 기대됩니다.";  
        } else {
            document.getElementById("suggestTitle").value = "";
            document.getElementById("suggestContent").value = "";
        }
    });
</script>

<%@ include file="../include/footer.jsp" %>