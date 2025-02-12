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
		<div class="row mb-2 align-items-center">
	         <ol class="breadcrumb float-sm-end">
	            <li class="breadcrumb-item" style="font-size:2rem"><a href="/main">Home</a></li>
	            <li class="breadcrumb-item active" style="font-size:2rem"><a href="/eventBoard/test">이벤트 게시판</a></li>
	         </ol>
		</div>
		<section class="section">
			<div class="card col-md-10">
				<form id="frm" action="/eventBoard/createPost" method="post" enctype="multipart/form-data">
					<div class="card-body">
						<div class="row">
							<div >
								<!-- 이벤트 상세내역 시작 -->
								<div class="form-group">
									<label for="calTitle">제목</label> <input type="text"
										class="form-control" id="calTitle" name="calTitle"
										placeholder="제목을 입력하세요" required >
								</div>

								<div class="form-group col-md-3">
									<!-- 로그인 시 사용자 정보가 자동으로 입력되도록 설정 -->
									<label for="userNm">작성자</label> <input type="text"
										class="form-control" id="userNm" name="userNm"
										value="${eventBoardVO.userNm}" readonly>
								</div>
							</div>
							<div class="col-12">
								<div class="form-group">
									<label for="calContent">내용</label>
									<textarea rows="10" cols="30" class="form-control" id="summernote" name="calContent"
										placeholder="내용을 입력하세요" required>  </textarea>
										<div id="editor">	</div>
								</div>
								<div class="form-group col-md-5">
									<label for="calStart">게시 시작</label>
									<input type="datetime-local" class="form-control" id="calStart"
										name="calStart" required onchange="validateDate()">
								</div>
								<div class="form-group col-md-5">
									<label for="calEnd">게시 종료</label>
									<input type="datetime-local" class="form-control" id="calEnd"
										 name="calEnd" required onchange="validateDate()">
								</div>
								
								<div class="form-group col-md-4">
									<label for="textColorInput">글자색</label>
				                   	<input type="color" class="textColor" id="textColor" disabled>
				                   	<!-- this 선택이 바뀌면 나 자신을 함수의 파라미터로 던짐 -->
									<select class="form-select" onchange="fnTextColor(this)">
<!-- 				                        <option value="#000000" >검정</option> -->
				                        <option value="#FFFFFF" selected>하얀(기본값)</option>                      
				                    </select>
								</div>
								
								<div class="form-group col-md-4">
									<label for="bgColorInput">배경색</label>
				                   	<input type="color" class="bgColor" id="bgColor" disabled>
				                   	<!-- this 선택이 바뀌면 나 자신을 함수의 파라미터로 던짐 -->
									<select class="form-select" onchange="fnBgColor(this)">
				                        <option value="" disabled>선택해주세요</option>
				                        <option value="#FF6B6B" >빨간색</option>
				                        <option value="#4ECDC4" >민트색</option>
				                        <option value="#FFD93D" >노란색</option>
										<option value="#5E60CE" >보라색</option>
										<option value="#FF924C" >오렌지색</option>                        
				                    </select>
								</div>
																
								<div class="form-group col-md-3">
									<label for="uploadFiles">첨부파일</label>
									<input type="file" id="uploadFiles" name="uploadFiles" class="uploadFiles"
									 accept=".png, .jpg, .jpeg, .gif" onchange="setThumbnail(event)" multiple/>
								</div>
								<div id="divImage" class="mt-3"></div>
								
							</div>
							<!-- 이벤트 상세내역 끝 -->
							
							</div>
						</div>

					<!-- 수정모드 시작 -->
					<span id="spn2" class="justify-between">
						<span style="float: left">
							<button type="submit" class="btn btn-primary btn-user" id="submitBT" disabled>등록</button>
						</span> 
						<span style="float: right"> 
							<a href="/eventBoard/list"	class="btn btn-success btn-user">취소</a>
						</span>
					</span>
					<!-- 수정모드 끝 -->
				</form>
			</div>
		</section>
	</div>
</div>

<script>

function fnTextColor(obj){
	console.log("선택한 색, value : ",obj.value);
	document.getElementById('textColor').value = obj.value;
}
function fnBgColor(obj){
	console.log("선택한 색, value : ",obj.value);
	document.getElementById('bgColor').value = obj.value;
}
//validateDate() 호출
// document.getElementById('calStart').addEventListener('change', validateDate);
// document.getElementById('calEnd').addEventListener('change', validateDate);
	
//파일들 미리보기 원본
// $(function(){
	//이미지 미리보기 콜백함수
// 	$("#uploadFiles").on("change", function(event){
// 	    console.log("이미지 미리보기 체크 구간"); // 콘솔 디버깅용 로그 추가

// 		const file = event.target.files;// 업로드된 파일 배열 가져오기
// 		console.log("여기부터 : ", file) //로그체크
		
// 		var image = new Image(); // 새로운 이미지 객체 생성
// 		var ImageTempUrl = window.URL.createObjectURL(file[0]);  // 파일 URL 생성
// 		image.src = ImageTempUrl; // 이미지 객체에 URL 설정
// 		$("#divImage").append(image); // 미리보기 영역(divImage)에 추가
// 	});
// });

// 이미지 미리보기 TEST
  function setThumbnail(event) {
	    const divImage = document.querySelector("div#divImage");
	    divImage.innerHTML = ""; // div 초기화

	    for (const image of event.target.files) {
	        // 파일 타입 확인
	        if (!image.type.startsWith("image/")) {
	            alert("이미지 파일만 업로드 가능합니다.");
	            continue;
	        }

	        const reader = new FileReader();
	        reader.onload = function(event) {
	            const img = document.createElement("img");
	            img.setAttribute("src", event.target.result);
	            img.style.width = "150px"; // 이미지 너비 설정
	            img.style.height = "150px"; // 이미지 높이 설정
	            img.style.margin = "5px"; // 이미지 간격 설정
	            img.style.objectFit = "cover"; // 이미지 비율 유지
	            divImage.appendChild(img);
	        };
	        console.log(image);
	        reader.readAsDataURL(image);
	    }
	}


//텍스트 에디터 태그
// $('#summernote').summernote({
// 	  height: 150,
// 	  lang: "ko-KR"
// });

//날짜 유효성
function validateDate() {
  let boardStart = document.getElementById('calStart').value;
  let boardEnd = document.getElementById('calEnd').value;
  const submitBT = document.getElementById('submitBT');
  
  console.log("날짜 유효성 검사 시작일",boardStart);
  console.log("날짜 유효성 검사 종료일",boardEnd);
  
// 날짜가 유효한지 확인
  if (boardStart && boardEnd) {
	if (boardStart > boardEnd) {
		alert("시작 날짜가 종료 날짜보다 클 수 없습니다.");
		submitBT.disabled = true; // 등록 버튼 비활성화
		return;
	}else if(boardStart <= boardEnd){
		alert("등록 가능");
		submitBT.disabled = false; // 등록 버튼 활성화
	}
	if(boardStart === boardEnd) {
		let offset = 9 * 60 * 60 * 1000; // +9시간 (KST) 시간 더하기
	    let endDate = new Date(new Date(boardStart).getTime() + offset); // 시작일 + 9시간
	    endDate.setMinutes(endDate.getMinutes() + 1); // Minutes 으로 1분추가
	    // 자동으로 수정된 종료일을 입력 필드에 반영
	    boardEnd = endDate.toISOString().slice(0, 16); // ISO 형식 변환
	    document.getElementById("calEnd").value = boardEnd;	    
	    console.log("자동 수정된 종료일:", boardEnd);
	}
  }
}
</script>
	

<%@ include file="../include/footer.jsp" %>