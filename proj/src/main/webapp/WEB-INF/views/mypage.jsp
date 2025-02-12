<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>  
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>출퇴근 조회</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/common2.css">
</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp"%>

<style>
.tableType01 tr:hover {
	transform: translateY(-3px); 
	box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1); 
	cursor: pointer !important;
}

#main {
  margin-top: 141px; 
}
</style>
<div id="main">
<%@ include file="./include/top.jsp" %>
<sec:authorize access="isAuthenticated()">
<sec:authentication property="principal.userVO" var="userVO"/>
        <div class="col-12">
                <div class="card">
                    <div class="card-header">
                    
                    <div class="row mb-2 align-items-center">
         <ol class="breadcrumb float-sm-end">
            <li class="breadcrumb-item" style="font-size:2rem"><a href="/main">Home</a></li>
            <li class="breadcrumb-item active" style="font-size:2rem"><a href="/mypage">마이페이지</a></li>
         </ol>
   </div>
   
						
                    </div>
                    <div class="card-body">
                        <ul class="nav nav-tabs" id="myTab" role="tablist">
                            <li class="nav-item" role="presentation">
                                <a class="nav-link active" id="home-tab" data-bs-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">근태기록</a>
                            </li>
                            <li class="nav-item" role="presentation">
                                <a class="nav-link" id="profile-tab" data-bs-toggle="tab" href="#profile" role="tab" aria-controls="profile" aria-selected="false" tabindex="-1">프로필</a>
                            </li>
                            <li class="nav-item" role="presentation">
                                <a class="nav-link" id="salary-tab" data-bs-toggle="tab" href="#salary" role="tab" aria-controls="salary" aria-selected="false" tabindex="-1">급여내역조회</a>
                            </li>
                        </ul>
                        <div class="tab-content" id="myTabContent">
                            <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
                            <section class="section">
							        <div class="row" id="table-hover-row">
							            <div class="col-12">
							                <div class="card">
							                    <div class="card-content">
							                        <div class="card-body row">
							                        <div class="filter-section col-6" >
										                 <!--<select class="filter-input">
										                    <option value="all">전체 상태</option>
										                    <option value="ontime">정상출근</option>
										                    <option value="late">지각</option>
										                    <option value="early">조기퇴근</option>
										                </select>
										                 -->
										                 <form action="/excel/download" method="get">
    														<input type="month" name="searchDate"  class="workingdate" value=""/>
										                	<button type="submit" class="btn btn-warning">근태 기록 출력</button>
									                	</form>
										            </div>
										            
											        
										            <div class="col-6">
											            <div class="table-responsive">
								                            <table class="table ">
								                                <thead class="thead-dark" style="text-align:center">
								                                    <tr>
								                                        <th>월평균 근무시간</th>
								                                        <th>정상</th>
								                                        <th>지각</th>
								                                        <th>조기퇴근</th>
								                                    </tr>
								                                </thead>
								                                <tbody id="worktb" >
								                                    
								                                </tbody>
								                            </table>
											            </div>
							                        
							                        </div>
							                        <div class="table-responsive tableType01" style="margin-top:30px">
							                            <table class="table table-hover mb-0 board"  id="table1">
							                                <thead style="text-align:center">
							                                    <tr >
							                                        <th>근무일</th>
											                        <th>출근시각</th>
											                        <th>퇴근시각</th>
											                        <th>근무시간</th>
											                        <th>비고</th>
							                                    </tr>
							                                </thead>
							                                <tbody id="tbd">
							                                   
							                                </tbody>
							                            </table>
							                        </div>
							                    </div>
							                </div>
							            </div>
							        </div>
							    </section>
							    <div class="pagination"> </div>
                            </div>
                            <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                                <section class="section">
                                <br>
        <div class="row">
            <div class="col-12 col-lg-4">
                <div class="card">
                    <div class="card-body">
                        <div class="d-flex justify-content-center align-items-center flex-column">
							<div class="avatar avatar-2xl" id="pic">
								<c:forEach var="fileDetailVO" items="${userVO.fileGroupVO.fileDetailVOList}" >
										
									    <img src="/resources${fileDetailVO.fileSaveLocate}" 
									         alt="프로필 이미지" 
									         id="profilepic"
									         style="cursor: pointer;">
								</c:forEach>
							          <input type="file" id="profilePicUpload" style="display: none;" accept="image/*">
							</div>
                            <h3 class="mt-3">${userVO.userNm }</h3>
                            <p class="text-small"><c:if test="${userVO.deptNm !=null}">${userVO.deptNm}</c:if>
                            					<c:if test="${userVO.storeNm !=null}">${userVO.storeNm}</c:if> / ${userVO.positionNm }</p>
                     <%--  <c:if test="${userVO.userCode == '4'}">    --%>   					
                    <hr>
                    <div id="signplace">
				        <p>전자서명</p>
				        <c:forEach var="fileDetailVO" items="${userVO.fileGroupSignVO.fileDetailVOList}" >
				                <img src="/resources${fileDetailVO.fileSaveLocate}" 
				                     alt="전자서명" 
				                     id="sign" 
				                     style="cursor: pointer;">
		                     
				        </c:forEach>
				        <c:if test="${empty userVO.fileGroupSignVO.fileDetailVOList }">
					        	<button id="signreg">등록</button>
					        	 <img src="/resources${fileDetailVO.fileSaveLocate}" 
					                     alt="전자서명" 
					                     id="sign" 
					                     style="cursor: pointer;"> 
					        </c:if>
				        <input type="file" id="signUpload" style="display: none;" accept="image/*">
				    </div>
				   <%--  </c:if> --%>
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
	                                <input type="text" name="name" id="name" class="form-control able" placeholder="이름" value="${userVO.userNm }" readonly>
	                            </div>
	                            <div class="form-group">
	                                <label for="userNo" class="form-label">아이디</label>
	                                <input type="text" name="userNo" id="userNo" class="form-control" placeholder="아이디" value="${userVO.userNo }" readonly>
	                            </div>
	                             <div class="form-group">
	                                <label for="dept" class="form-label">부서</label>
	                                <input type="text" name="dept" id="dept" class="form-control" placeholder="부서" value="${userVO.deptNm }" readonly>
	                            </div>
	                             <div class="form-group">
	                                <label for="position" class="form-label">직책</label>
	                                <input type="text" name="position" id="position" class="form-control" placeholder="직책" value="${userVO.positionNm }" readonly>
	                            </div>
	                             <div class="form-group">
	                                <label for="email" class="form-label">이메일</label>
	                                <input type="text" name="email" id="email" class="form-control able" placeholder="이메일" value="${userVO.userMail }" readonly>
	                            </div>
                            </div>
                            <div class="col-12 col-lg-6">
	                           
	                            <div class="form-group">
	                                <label for="phone" class="form-label">연락처</label>
	                                <input type="text" name="phone" id="phone" class="form-control able" placeholder="연락처" value="${userVO.userPhone }" readonly>
	                            </div>
	                            <div class="form-group">
	                                <label for="birthday" class="form-label">생일 </label>
	                                <input type="date" name="birthday" id="birthday" class="form-control able" placeholder="생일" value="<fmt:formatDate value="${userVO.userBirth }" pattern="yyyy-MM-dd" />" readonly>
	                            </div>
	                            <div class="form-group">
	                                <label for="zip" class="form-label">우편번호</label>
	                                <button type="button" id="btnPost" style="display:none">우편번호 검색</button>
	                                <input type="text" name="userZip" id="userZip" class="form-control able" placeholder="우편번호" value="${userVO.userZip }" readonly>
	                            </div>
	                            <div class="form-group">
	                                <label for="addr1" class="form-label">주소</label>
	                                <input type="text" name="userAddr1" id="userAddr1" class="form-control" placeholder="주소" value="${userVO.userAddr1 }" readonly>
	                            </div> 
	                            <div class="form-group">
	                                <label for="addr2" class="form-label">상세주소</label>
	                                <input type="text" name="userAddr2" id="userAddr2" class="form-control able" placeholder="상세주소" value="${userVO.userAddr2 }"readonly>
	                            </div>
	                            <div class="form-group" style="display:flex">
	                                <button type="button" class="btn btn-warning" style="display:none" id="ok">저장</button>
	                                <button type="button" class="btn btn-warning" id="edit">수정</button>
	                                <button type="button" class="btn btn-secondary" id="exit" style="display:none" >취소</button>
	                                <button type="button" class="btn btn-dark" id="out">탈퇴</button>
	                            </div>
	                            <a href="/updatePW" class="font-bold">비밀번호 변경</a>
                           </div>
                           </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>
                            </div>
                            <div class="tab-pane fade" id="salary" role="tabpanel" aria-labelledby="home-tab">
                            	<section class="section">
							        <div class="row" id="table-hover-row">
							            <div class="col-12">
							                <div class="card">
							                    <div class="card-header">
							                    <div class="filter-section col-6" >
   														<input type="month"value=""/>
									            </div>
							                    </div>
							                    <div class="card-content">
							                        <div class="table-responsive tableType01">
							                            <table class="table table-hover mb-0 board">
							                                <thead style="text-align:center">
							                                    <tr style="text-align:center">
							                                        <th style="width:20%">지급날짜</th>
							                                        <th style="width:25%">지급액</th>
							                                        <th style="width:20%">세율</th>
							                                        <th style="width:25%">실수령액</th>
							                                    </tr>
							                                </thead>
							                                <tbody>
							                                <c:forEach var="salary" items="${salaryList }">
							                                    <tr >
							                                        <td style="text-align:center">${salary.salPymntDate }</td>
							                                           <td class="salamount" style="text-align:right">
																            <fmt:formatNumber value="${salary.salAmount}" pattern="#,###" />
																        </td>
																        <td style="text-align:center" class="salamount"> ${salary.duty}% </td>
																        <td style="text-align:right" class="salamount">
																            <fmt:formatNumber value="${salary.afterTax}" pattern="#,###" />
																        </td>
							                                    </tr>
							                                   </c:forEach>
							                                </tbody>
							                            </table>
							                        </div>
							                    </div>
							                </div>
							            </div>
							        </div>
							    </section>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</div>
</sec:authorize>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="/js/signup.js"></script>
<style>
#pic img{
width:200px;
height:200px;
}

</style>
<script>
let editMode = false;
let dateString = year + '/' + month + '/' + date;
console.log("마이페이지 날짜",dateString);
    
let data={
		schdulDate:dateString
}; 


/* list();
tb(); */

/*
 $(document).on("change",".workingdate", function () {
    let selectedDate = $(this).val();
    console.log("선택한 날짜:", selectedDate);

    //let replaceDate = selectedDate.replace("-","/");
    data.searchDate = selectedDate;
    console.log("데이터 객체:", data);

    list();
    tb();
});
 */
 
function tb(data){
	    console.log("🔄 tb() 함수 실행됨");
	    console.log("📤 [tb] 요청 데이터:", data);
	    
	$.ajax({
		url:"/workingtable",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(data),
		type:"post",
		dataType:"json",
		success:function(result){
			console.log("테이블",result);
			
			let str = `<tr style="text-align:center">
							<td >\${result.avgWorkingTime}</td>
							<td >\${result.js}</td>
							<td >\${result.jg}</td>
							<td >\${result.jgtg}</td>
			</tr>`;
			
			$("#worktb").html(str);
		}
	})
} 


    

function list(data){
    console.log("🔄 list() 함수 실행됨");
    console.log("📤 [list] 요청 데이터:", data);
	$.ajax({
		url:"/list",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(data),
		type:"post",
		dataType:"json",
		success:function(result){
			console.log("응답",result);
			let str="";
			$.each(result, function(idx, map){
				str+=` <tr style="text-align:center">
	                <td  class="text-bold-500">\${map.schdulDate}</td>
	                <td >\${map.attend}</td>
	                <td class="text-bold-500">\${map.leave}</td>
	                <td >\${map.workingTime}</td>
	                <td >\${map.status}</td>
	            </tr>`;
			})
			$("#tbd").html(str);
		}
	})
}

$("#edit").on('click',function(){
	editMode = true;
	$("#ok").css('display','block');
	$("#edit").css('display','none');
	$("#exit").css('display','block');
	$("#out").css('display','none');
	$("#btnPost").css('display','block'); 
	$(".able").attr("readonly",false);
	$("#name").focus();
})

 $("#exit").on('click',function(){
	 editMode = false;
	 $("#edit").css('display','block');
	 $("#out").css('display','block'); 
	 $("#exit").css('display','none');
	 $("#ok").css('display','none');
	 $("#btnPost").css('display','none'); 
	 $("input").attr("readonly",true);
 }) 
 
 $("#sign").on('click',function(){
	 if(!editMode) {
         alert("전자서명은 수정모드에서만 변경 가능합니다");
         return;
     }
	 else{
		 //alert("전자서명 등록할꾸얌");
		 $("#signUpload").click();
	 }
 })
 
 $("#signUpload").on('change',function(){
	 $("#signreg").css('display','none');
	 const file = this.files[0];
	    if (file) {
	        const reader = new FileReader();
	        reader.onload = function (e) {
	            $("#sign").attr("src", e.target.result); // 미리 보기
	        };
	        reader.readAsDataURL(file);
	    }
	  
 })

 
$("#signreg").on('click',function(){
		 $("#signreg").css('display','none');
		 $("#edit").click();
		 $("#signUpload").click();
})


$("#profilepic").on('click',function(){
  if(!editMode) {
         alert("프로필 사진은 수정모드에서만 변경 가능합니다");
         return;
     }
	 else{
 		//alert("프로필사진 등록할꾸얌");
 		$("#profilePicUpload").click();
	 }
})

$("#profilePicUpload").on('change', function () {
    const file = this.files[0];
    if (file) {
        const reader = new FileReader();
        reader.onload = function (e) {
            $("#profilepic").attr("src", e.target.result); // 미리 보기
        };
        reader.readAsDataURL(file);
    }
});

function formatphone(phone) {
    const number = phone.replace(/[^0-9]/g, "");
    
    return number.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
}

 //프로필 수정내역 저장
 $("#ok").on('click',function(){
	const formData = new FormData();
    const profile = $("#profilePicUpload")[0].files[0];
    const sign = $("#signUpload")[0].files[0];
    
    if (profile) {
        formData.append("userProfile", profile); 
    }
    if (sign) {
        formData.append("userSign", sign);
    }
   
	 let data={ 
			userNm: $("#name").val(),
	 		userMail:$("#email").val(),
	 		userPhone:$("#phone").val(),
	 		userBirth:$("#birthday").val(),
	 		userZip:$("#userZip").val(),
	 		userAddr1: $("#userAddr1").val(),
	 		userAddr2:$("#userAddr2").val(),
	 }
	 console.log("data",data);
	 formData.append("userData", JSON.stringify(data));
	 
	 $.ajax({
		 	url:"/udpateProfile",
			type: "POST",
		    data: formData,
		    contentType: false,
		    processData: false,
			success:function(result){
				console.log("수정잘됐엉?",result);
				alert("수정됐습니다.");
				location.reload();
			},
			 error: function () {
		         alert("수정 중 문제가 발생했습니다.");
		     },
	 });
 })
  
    
$("#out").on("click", function() {
    let r = confirm("진짜 탈퇴할꾸얌?");
    if(r){
    	$.ajax({
    		url:"/deleteUser",
    		contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"json",
			success:function(result){
				if(result>0){
					alert("탈퇴완");
					location.href = "/logout";
				}
				
			}
    	})
    }
});
 
$(document).ready(function() {
    let phoneInput = $("#phone");
    let phoneNumber = phoneInput.val();
    phoneInput.val(formatphone(phoneNumber));
    let year = today.getFullYear();
    let month = String(today.getMonth() + 1).padStart(2, '0');
    let formattedDate = `\${year}-\${month}`;
    console.log("하잉",year, month);
    console.log("하잉",formattedDate);
    $(".workingdate").val(formattedDate);
    data.searchDate = formattedDate;
    list(data);
    tb(data);

    $(document).on("change", ".workingdate", function() {
        let selectedDate = $(this).val();
        console.log("선택한 날짜:", selectedDate);
        
        if (!selectedDate) {
            console.error("🚨 선택한 날짜 값이 비어 있음!");
            return;
        }

        data.searchDate = selectedDate;
        
        console.log("📢 최종 요청 데이터:", data);
        console.log("⚡ list(data) 실행!");
        list(data);
        console.log("⚡ tb(data) 실행!");
        tb(data);
    });
});

    
</script>
</body>
</html>

<style>
#sign{
	width:100px;
	height:100px;
	
}

#signplace{
text-align:center;
	margin-top:30px;
}
hr {
    border: 1px solid #ccc; 
    margin: 20px 0;       
    width: 100%;          
}
</style>