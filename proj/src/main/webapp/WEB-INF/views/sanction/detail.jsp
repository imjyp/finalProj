<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>
   
<!-- sweetAlert -->
<link rel="stylesheet" href="/css/sweetalert2.min.css">
<script type="text/javascript" src="/js/sweetalert2.min.js"></script>

<!DOCTYPE html>


<%-- <sec:authorize access="isAuthenticated()"> --%>
	<!-- 로그인 시 사이드바 시작-->
	<%@ include file="../include/header.jsp"%>
	<div id="main">
		<header class="mb-3">
			<a href="#" class="burger-btn d-block d-xl-none"> <i
				class="bi bi-justify fs-3"></i>
			</a>
			<style>
			   			
			    td {
			    	border: 1px solid #ddd !important;
			        text-align: center;
			        vertical-align: middle;
			        width: 120px;
			        
			    }
			</style>
		</header>
<%-- </sec:authorize> --%>
<!-- 로그인 시 사이드바 끝-->

<!-- 비회원 메인 페이지(사이드바 없음) 시작 -->
<%@ include file="../include/top.jsp"%>
<!-- 비회원 메인 페이지(사이드바 없음) 끝 -->

 <!-- jstree CSS (기본 스타일) -->
 <link rel="stylesheet" href="/dist/themes/default/style.min.css" />
<!-- jstree JS (jQuery 이후에 로드) -->
 <script src="/dist/jstree.min.js"></script>
    
<div class="card">
	<div class="card-header">
		<h4 class="card-title">결재문서 상세페이지</h4>
	</div>
	<%-- <p>
		<h2>결재관련데이터</h2>
		${sanctionDocVO}
		${receiveVO}
		${fileGroupVO}
	</p> --%> 
	<form id="frm" action="/sanction/createPost" method="post" enctype="multipart/form-data">
	 <!-- 결재선 상단 시작-->
	  <div class="card-body" style="display: flex; justify-content: space-between; align-items: flex-start; gap: 30px;">
	    <!-- 버튼 그룹 시작 -->
        <div style=" gap: 10px; align-items: center;">
		    <!-- 결재선 버튼 -->
		    <!-- <button type="button" class="btn btn-primary" id="sanctionLineBtn" >결재선</button> -->
		
		    <!-- 문서 양식 버튼 -->
		    <div class="form-group">
				    <label for="docNm">결제 유형</label>
		    <select id="docTypeSelect" class="form-control" style="width: 120px;" name="docTypeNo" disabled>
				        <option value="select">결재 유형</option>
				        <option value="1" <c:if test="${sanctionDocVO.docTypeNo == 1}">selected</c:if>>발주</option>
				        <option value="2" <c:if test="${sanctionDocVO.docTypeNo == 2}">selected</c:if>>견적</option>
				        <option value="3" <c:if test="${sanctionDocVO.docTypeNo == 3}">selected</c:if>>계산</option>
				        <option value="4" <c:if test="${sanctionDocVO.docTypeNo == 4}">selected</c:if>>업무보고</option>
				        <option value="5" <c:if test="${sanctionDocVO.docTypeNo == 5}">selected</c:if>>기타</option>
			</select>
			</div>
		    <!-- 수신 부서 버튼 -->
		    <!-- <button type="button" class="btn btn-info" id="receiveBtn" >수신 부서</button> -->
		</div> 
	    <!-- 버튼 그룹 끝 -->
		   
		<!-- 결재란 시작 -->   
	    <div id="sign">
	      
	      <table style="border-collapse: collapse;">
	      
	        <tbody >
	             <tr>
			        <c:forEach var="sanctionVO" items="${sanctionDocVO.sanctionVOList}" varStatus="status">
			            <c:if test="${!stopLoop}">
			                <td style="height: 30px;">
			                    ${sanctionVO.sanctionUserPosition} ${sanctionVO.sanctionUserNm}
			                    <input type="hidden" name="sanctionUsers" value="${sanctionVO.sanctionUser}">
			                    <input type="hidden" name="sanctionLines" value="${sanctionVO.sanctionLineType}">
			                    <input type="hidden" name="sanctionTypes" value="${sanctionVO.sanctionNo}">
			                </td>
			            </c:if>
			        </c:forEach>
			    </tr>
			
			    <!-- 결재 상태(도장/반려) 행 -->
			    <tr>
			        <c:forEach var="sanctionVO" items="${sanctionDocVO.sanctionVOList}" varStatus="status">
			            <c:if test="${!stopLoop}">
			                <td style=" height: 90px;">
			                    <c:choose>
			                        <c:when test="${sanctionVO.sanctionStatusNo eq 1}">
			                            ${sanctionVO.sanctionLineNm}
			                        </c:when>
			                        <c:when test="${sanctionVO.sanctionStatusNo eq 2}">
			                            <img src="/download?fileName=${sanctionVO.sanctionUserSign}" alt="결재 도장"
			                                 style="width: 100%; height: auto; max-width: 100px; max-height: 100px;">
			                        </c:when>
			                        <c:when test="${sanctionVO.sanctionStatusNo eq 3}">
			                            반려
			                            <c:set var="stopLoop" value="true"></c:set>
			                        </c:when>
			                    </c:choose>
			                </td>
			            </c:if>
			        </c:forEach>
			    </tr>

			    <!-- 결재 날짜 행 -->
			    <tr>
			        <c:forEach var="sanctionVO" items="${sanctionDocVO.sanctionVOList}" varStatus="status">
			            <c:if test="${!stopLoop}">
			                <td style=" height: 30px;">
			                    ${sanctionVO.sanctionDate}
			                </td>
			            </c:if>
			        </c:forEach>
			    </tr>
	        </tbody>
	       </table>
	    
		</div>
		<!-- 결재란 끝 -->   
	  </div>	
	<!-- 결재선 상단 끝-->
		<div class="card-body">
			<div class="row">
				   <div style="font-weight: bold; margin-bottom: 10px;">수신 부서</div>
				    <div id="receive" style="display: flex; flex-wrap: wrap; gap: 10px;">
					   <c:forEach var="receiveVO" items="${receiveVO.receiveVOList}" varStatus="status">
		        			<div style="position: relative;">
		    	 				<input type="text" id="${receiveVO.deptNo}" style="padding-right: 30px;"  class="form-control" value="${receiveVO.receiveDeptNm}" readonly>
	    	 				</div>
				       </c:forEach>	
				    </div>    
				<div class="form-group">
					<label for="docNm">제목</label> 
					<input type="text" class="form-control" id="docTitle" name="docTitle" value="${sanctionDocVO.docTitle}" readonly>
				</div>
				<div class="row">
				    <div class="col-md-3">
				        <div class="form-group">
				            <label for="helperText">기안자</label>
				            <input type="text" id="userNo" name="userNo" class="form-control" value="${sanctionDocVO.userNm}" readonly>
				        </div>
				    </div>
				    <div class="col-md-3">
				        <div class="form-group">
				            <label for="helperText">부서</label>
				            <input type="text" id="deptNm" name="deptNm" class="form-control" value="${sanctionDocVO.employeeVO.deptNm}" readonly>
				        </div>
				    </div>
				    <div class="col-md-6">
				        <div class="form-group">
				            <label for="readonlyInput">작성일</label>
				            <input type="text" id=docCreate  name="docCreate" class="form-control" 
				             value="<fmt:formatDate value='${sanctionDocVO.docCreateDate}' pattern='yyyy-MM-dd HH:mm:ss'/>" readonly>
				        </div>
				    </div>
				</div>
					<div class="form-group">
					    <label for="readonlyInput">내용</label> 
					    <textarea class="form-control" id="docContent" name="docContent" style="height: 200px;"  readonly>${sanctionDocVO.docContent}</textarea>
					</div>
					
					<c:forEach var="fileDetailVO" items="${fileGroupVO.fileGroupVO.fileDetailVOList}" varStatus="status">
					<div class ="form-group" style="display:flex; align-items: center; gap: 10px; ">
					  <button type="button" id="fileName"  class="btn btn-dark btn-sm download" name="fileName" data-file="${fileDetailVO.fileSaveLocate}">
	                  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-download" viewBox="0 0 16 16">
	                  <path d="M.5 9.9a.5.5 0 0 1 .5.5v2.5a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1v-2.5a.5.5 0 0 1 1 0v2.5a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2v-2.5a.5.5 0 0 1 .5-.5"></path>
	                  <path d="M7.646 11.854a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 10.293V1.5a.5.5 0 0 0-1 0v8.793L5.354 8.146a.5.5 0 1 0-.708.708z"></path>
	                  </svg>
                      다운로드
                     </button>
                     
                       <p style="margin-bottom: 0rem;">${fileDetailVO.fileOriginalName}</p>
				   </div>
				   </c:forEach> 
				   <c:forEach var="sanctionVO" items="${sanctionDocVO.sanctionVOList}" varStatus="status" >
				    <c:if test="${ sanctionVO.sanctionUser eq userId}"> 
						<div class="form-group">
						    <label for="docReject">반려사유</label> 
						    <textarea class="form-control" id="docReject" name="docReject" style="height: 100px;"
						    			<c:if test="${sanctionVO.sanctionStatusNo == 2}">readonly</c:if>></textarea>
						</div>
					</c:if>
				  </c:forEach>
			</div>
		</div>
		<!-- 버튼 시작 -->
		<div id="spn2" class="card-body" style="display: flex; justify-content: space-between; align-items: center;">
		  <div style="display: flex; gap: 10px;">
			<c:forEach var="sanctionVO" items="${sanctionDocVO.sanctionVOList}" varStatus="status" >
		    	<c:if test="${sanctionVO.sanctionStatusNo eq 1 && sanctionVO.sanctionUser eq userId}"> 
					<span style="float: left">
						<button id="approve" type="button" class="btn btn-primary btn-user">결재
						</button>
					</span> 
					<span style="float: left">
						<button id="reject" type="button" class="btn btn-warning btn-user">반려
						</button>
					</span> 
				</c:if>
			</c:forEach>
			</div>
			<span style="float: right"> 
					<a href="javascript:history.back();" class="btn btn-warning btn-user">목록 </a>
			</span>
			
		</div>
		<!-- 버튼 끝 -->
	</form>
</div>

</div>

<script type="text/javascript">
	  
	  $(function(){
		  
	  
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
	
	//결재버튼 처리 시작
	$("#approve").on("click",function(){
		
		
		
		var app = confirm("기안을 승인하시겠습니까?");
		if(!app){
			alert("승인을 취소합니다.")
			return;
		}
		
		let data = {"docNo" : "${sanctionDocVO.docNo}"
					,"sanctionUser" : "${userId}" }
		
		console.log("data: ",data);
		$.ajax({
			
			
			url: "/sanction/approveAjax"
			, contentType:"application/json;charset=utf-8"
			, data: JSON.stringify(data)
			, type: "post"
			, dataType: "json"
			, success: function(result){
				console.log("result: ", result);
				
				alert("결재가 완료되었습니다.");
				
				location.reload();
			},
            error: function(xhr, status, error) {
                alert("결재를 실패했습니다.");
            }
			
		});
		
		
		
		
		
	})//결재버튼 처리 끝
	
	//반려버튼 처리 시작
	$("#reject").on("click",function(){
		
		
		
		var app = confirm("반려처리 하시겠습니까?");
		if(!app){
			alert("반려를 취소합니다.")
			return;
		}
		
		
		let data = {"docNo" : "${sanctionDocVO.docNo}"
					,"sanctionUser" : "${userId}"
					, "docReject" : $("#docReject").val()
					}
		
		console.log("data: ",data);
		$.ajax({
			
			
			url: "/sanction/rejectAjax"
			, contentType:"application/json;charset=utf-8"
			, data: JSON.stringify(data)
			, type: "post"
			, dataType: "json"
			, success: function(result){
				console.log("result: ", result);
				
				alert("반려가 완료되었습니다.");
				
				location.reload();
			},
            error: function(xhr, status, error) {
                alert("반려를 실패했습니다.");
            }
			
		});
		
		
		
		
		
	})//반려버튼 처리 끝
	  
	  
	
 });  
	  
</script>


<%@ include file="../include/footer.jsp"%>