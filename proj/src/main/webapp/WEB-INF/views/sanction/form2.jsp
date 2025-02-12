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
		<h4 class="card-title">결재문서작성</h4>
	</div>
	<form id="frm" action="/sanction/createPost" method="post" enctype="multipart/form-data">
	 <!-- 결재선 버튼 -->
        <div class="mb-3 d-flex gap-3">
		    <!-- 결재선 버튼 -->
		    <button type="button" class="btn btn-primary" id="sanctionLineBtn" >결재선</button>
		
		    <!-- 문서 양식 버튼 -->
		    <button type="button" class="btn btn-secondary" id="docTypeBtn" >문서 유형(dropdown으로 바꾸자)</button>
		
		    <!-- 수신자 버튼 -->
		    <button type="button" class="btn btn-info" id="receiveBtn" >수신자</button>
		    
		    
		</div>
		
		
		<div class="card-body">
			<div class="row">
				<div class="form-group">
					<label for="docNm">제목</label> <input type="text" class="form-control" id="docNm" placeholder="문서 제목 입력">
				</div>
				<div class="row">
				    <div class="col-md-3">
				        <div class="form-group">
				            <label for="helperText">기안자</label>
				            <input type="text" id="userNm" name="userNm" class="form-control" placeholder="기안자 이름 자동 입력" readonly>
				        </div>
				    </div>
				    <div class="col-md-3">
				        <div class="form-group">
				            <label for="helperText">부서</label>
				            <input type="text" id="deptNm" name="deptNm" class="form-control" placeholder="기안자 부서 자동 입력" readonly>
				        </div>
				    </div>
				    <div class="col-md-6">
				        <div class="form-group">
				            <label for="readonlyInput">작성일</label>
				            <input type="text" id=docCreate  name="docCreate" class="form-control" value="작성일자 자동 입력" readonly>
				        </div>
				    </div>
				</div>
					<div class="form-group">
					    <label for="readonlyInput">내용</label> 
					    <textarea class="form-control" id="docContent" name="docContent" style="height: 200px;">"summernote 추가하기"</textarea>
					</div>
					<div class ="form-group">
					  <label for="uploadFiles">첨부파일(다중선택 가능하게)</label>
					   <div class="input-group">
						<div class="custom-file">
						  <input type="file" class="custom-file-input" id="uploadFiles"
						  name="uploadFiles" class="uploadFiles" multiple />
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 등록 시작 -->
		<span id="spn2" class="justify-between">
			<span style="float: left">
				<button type="submit" class="btn btn-primary btn-user">상신
				</button>
			</span> 
			<span style="float: right"> 
					<a href="/sanction/temp" class="btn btn-success btn-user"> 임시저장 </a>
			</span>
			<span style="float: right"> 
					<a href="/sanction/list" class="btn btn-warning btn-user"> 취소 </a>
			</span>
		</span>
		<!-- 등록 끝 -->
	</form>
</div>

</div>
<!-- 결재선 모달 시작 -->
<div class="modal fade text-left w-100" id="modalLine" tabindex="-1" aria-labelledby="myModalLabel16"  aria-modal="true" role="dialog">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-xl" role="document">
        <div class="modal-content">
            <form action="#" method="post" enctype="multipart/form-data" >
            <div class="modal-header">
            		<h4>결재선</h4>
	                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
	            </div>
                  <div>
				    	<div id="jstree"> </div>
				  </div>
                  
                  <!-- 결재자 선택 시 중간, 최종 결재자 여부 선택 시작-->
                <div id="role-selection" class="modal-footer" style="display: none; justify-content: space-between;align-items: center;" >
                  
                    <label for="role-select" id="role-nm" >결재자: </label>
				    <select id="role-select" class="form-control" style="width: 120px;" name="sanctionlineNo">
				        <option value="select">결재 선택</option>
				        <option value="middle">중간 결재</option>
				        <option value="final">최종 결재</option>
				    </select>

					<!-- 결재 방식을 선택 -->
                    <label for="approval-type" id="approval-how" >결재 방식: </label>
				    <select id="approval-type" class="form-control" style="width: 120px;" name="sanctionTypeNo">
				        <option value="normal">정상</option>
				        <option value="delegated">대결</option>
				        <option value="final">전결</option>
				    </select>

                    <button type="button" class="btn btn-primary ms-1" id="setRole">설정</button>
           
					<button type="button" class="btn btn-secondary" id="reset" style="float:right" title="초기화">
	                  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-counterclockwise" viewBox="0 0 16 16">
						 <path fill-rule="evenodd" d="M8 3a5 5 0 1 1-4.546 2.914.5.5 0 0 0-.908-.417A6 6 0 1 0 8 2z"></path>
						 <path d="M8 4.466V.534a.25.25 0 0 0-.41-.192L5.23 2.308a.25.25 0 0 0 0 .384l2.36 1.966A.25.25 0 0 0 8 4.466"></path>
					  </svg>
	                 
	                </button><br>
                </div> 
                  <!-- 결재자 선택 시 중간, 최종 결재자 여부 선택 끝-->
                    
                <div id="addNewRole"></div>    
                    
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
<!-- 결재선 모달 끝 -->
<!-- Summernote CSS & JS -->
<!-- <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script> -->
<!-- Summernote CSS & JS -->
<script type="text/javascript">

	  
	
	  
	  
	//조직도 관련 정보 가져오기 시작
	 function jstreeDept(){
				
			$.ajax({
				url:"/sanction/deptTree"
				,contentType:"application/json;charset=utf-8"
				,type:"get"
				,success:function(result){
					
					console.log("detail result: ",result);
					
					let department = [];
					
					//result : List<JstreeDeptVO> jstreeDeptVO
					//value : JstreeDeptVO
					$.each(result,function(key,value){//부서별 반복
						let tbUserVOs = [];
						//children만들기
							//JstreeDeptVO.tbUserVOList : List<TBUserVO>
							$.each(value.tbUserVOList,function(idx,tbUserVO){//그 부서 내의 사원으로 반복
								
							
								tbUserVOs.push({
									/* "id" : tbUserVO.userNo, */
									"text" : tbUserVO.positionNm + " " + tbUserVO.userNm,
									"a_attr" : {id : tbUserVO.userNo}
								})
							});
							
							department.push({
								'text' : value.deptNm,
							       'state' : {
							         'opened' : false,
							         'selected' : false
							       },
							       'children' : tbUserVOs
							});
						
						
					});// each end
						console.log("department: ", department);
					
					
					$('#jstree').jstree({
						
								'core':{
								  'data' : department
								}
					});
					
					// 결재자 클릭 시 이벤트
					  $(document).on("click","#jstree a",function(e){
						  
						  e.preventDefault();
						  
						  // 결재선 , 결재 처리 활성
						  $("#role-selection").css("display", "flex");
						
						  var userNo = $(this).attr("id"); //클릭한 노드의 id 
						  var userNm = $(this).text(); //클릭한 노드의 이름 
						  console.log("userNo: ", userNo);
						  console.log("userNm: ", userNm);
						  


						  //.off() 메서드는 이전에 바인딩된 이벤트 핸들러를 제거하는 메서드
						  //.on() 메서드는 특정 이벤트(여기서는 클릭)에 대해 이벤트 핸들러를 설정
						  //.on()을 여러 번 호출하면 이벤트 핸들러가 여러 번 바인딩될 수 있다
						  //.off()를 사용하여 이전에 바인딩된 핸들러를 제거하고, 새로 등록된 핸들러만 실행되도록 할 수 있다
						  //결재방식 선택 시작
						  $("#setRole").off("click").on("click",function(){
							  
							
							  var roleSelect = $("#role-select").val();  // 중간, 최종결재
							  var approvalType = $("#approval-type").val();  //선택된 결재방식
							  
							// 선택 값 검증
							    if (roleSelect === "select") {
							        Swal.fire({
							            icon: "warning",
							            title: "결재 역할을 선택하세요."
							        });
							        return;
							    }
							  console.log("결재자:", userNm, "ID:", userNo, "선택된 역할:", roleSelect, "결재 방식:", approvalType);
							  
							  
							  
							  let roleId = 1; //복제되는 role-selection구분 id
							  //중간 결재자로 지정되고 설정을 눌렀을 때 결재자 칸 추가
							  if(roleSelect === "middle"){
								  
								
							    // 기존 중간 결재자의 개수 확인
							        var middleCount = $("#addNewRole").find("#role-select")
							        					.filter(function(){ return $(this).val() === "middle"}).length;
							    // 중간 결재자는 총 3명까지 지정 가능하게
							        if (middleCount >= 3) {
								        	Swal.fire({
												  icon: "warning",
												  title: "중간 결재자는 최대 3명까지 지정 가능합니다."
							            })
							            return; // 복제 중단
							        }
							  }
							  if(roleSelect === "final"){
								  
								
							    // 기존 중간 결재자의 개수 확인
							        var finalCount = $("#addNewRole").find("#role-select")
							        				.filter(function(){ return $(this).val() === "final"}).length;
								
							    // 중간 결재자는 총 3명까지 지정 가능하게
							        if (finalCount >= 1) {
								        	Swal.fire({
												  icon: "warning",
												  title: "최종 결재자는 1명만 지정 가능합니다."
							            })
							            return; // 복제 중단
							        }
							  }
								  
								  //기존 결재선 선택 div 복제
								  var newRoleSelection = $("#role-selection").clone();
								  newRoleSelection.css("display","flex");
								  
								  //복제된 결재선에 고유 id 부여
								  newRoleSelection.attr("id",`role-selection-\${roleId}`);
								  
								  //복제된 div 설정 및 초기화 버튼 제거
								  newRoleSelection.find("#setRole").remove();
								  newRoleSelection.find("#reset").remove();
								  
							      // 복제된 결재선에 결재 데이터 저장
							      newRoleSelection.find("#role-nm").text(`결재자: \${userNm}`);
							      newRoleSelection.data("userNo", userNo);
							      newRoleSelection.data("userNm", userNm);
							      newRoleSelection.find("#role-select").val(roleSelect);
							      newRoleSelection.find("#approval-type").val(approvalType);
							      
							      
							        
							      // 삭제 버튼, 이벤트 추가
							      const deleteButton = $("<button>")
							          .addClass("btn-close")
							          .on("click", function () {
							              newRoleSelection.remove(); // 해당 행 삭제
							          });
							      newRoleSelection.append(deleteButton);  
								  
							        
							      //addNewRole에 선택한 결재선 추가								  
								  $("#addNewRole").append(newRoleSelection); 
							      
								// #role-select 선택값 초기화
							      $("#role-select").val("select");

							      // #approval-type 선택값 초기화
							      $("#approval-type").val("normal");

							      
							      // id 식별 카운터 증가
							      roleId++;
								  
							  
						  }); //결재방식 선택 끝
						  
						  
						  //결재선 빼고 싶을 때 취소버튼 이벤트 시작
						  $(".approveCancel").on("click",function(){
							
							// 'role-selection' div 숨기기
						    $("#role-selection").hide();
							
							// 폼 필드 초기화
					        $("#role-select").val("select");  // '결재자' select를 '중간 결재'로 초기화
					        $("input[name='approvalType']").prop("checked", false);  // 모든 radio 버튼 선택 해제
							  
							  
							  
						  });//결재선 빼고 싶을 때 취소버튼 이벤트 끝
						  
						  
					  });//결재자 클릭 시 이벤트 끝
					
		        },
		        
		        error: function(xhr, status, error) {
		            console.error("AJAX 요청 실패: ", status, error);
		        }//error end
					
					
			});
			
		}	//조직도 관련 정보 가져오기 끝
	  
	  $(function(){
		  
		  //결재선 버튼 클릭 시 이벤트 시작
		  $("#sanctionLineBtn").on("click",function(){
				//모달 활성화
				$("#modalLine").modal("show");
				
				  jstreeDept();
				
			
			});//결재선 버튼 클릭 시 이벤트 끝

		  //초기화 버튼 클릭 시 이벤트 시작
		  $("#reset").on("click",function(){
			  // #role-select 선택값 초기화
		      $("#role-select").val("select");

		      // #approval-type 선택값 초기화
		      $("#approval-type").val("normal");
			  
		  });//초기화 버튼 클릭 시 이벤트 끝
		  

		  
		  
		 
	  })
	  
	  
	  
</script>


<%@ include file="../include/footer.jsp"%>