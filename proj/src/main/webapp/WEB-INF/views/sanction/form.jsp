<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>



<sec:authorize access="isAuthenticated()">
	<!-- 로그인 시 사이드바 시작-->
	<%@ include file="../include/header.jsp"%>
</sec:authorize> 
<!-- 비회원 메인 페이지(사이드바 없음) 시작 -->
<%@ include file="../include/top.jsp"%>
<!-- 비회원 메인 페이지(사이드바 없음) 끝 -->
<!-- Bootstrap JS 한 번만 포함 -->
<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script> -->
 <!-- jstree CSS (기본 스타일) -->
 <link rel="stylesheet" href="/dist/themes/default/style.min.css" />
<!-- jstree JS (jQuery 이후에 로드) -->
 <script type="text/javascript" src="/dist/jstree.min.js"></script>
<!-- sweetAlert -->
<link rel="stylesheet" href="/css/sweetalert2.min.css">

<script type="text/javascript" src="/js/sweetalert2.min.js"></script>
			<style>
			   			
			    td {
			    	border: 1px solid #ddd !important;
			        text-align: center;
			        vertical-align: middle;
			        width: 120px;
			        
			    }
			    #main {
				  margin-top: 141px !important;
				}
			</style>
<!-- 로그인 시 사이드바 끝-->



	
	<div id="main">
	<div class="card">
	  <div class="card-header">
	    <div class="container-fluid">
	      <div class="row align-items-center">
	<!-- 제목과 브레드크럼 -->
		<div class="row mb-2 align-items-center">
	         <ol class="breadcrumb float-sm-end">
	            <li class="breadcrumb-item" style="font-size:2rem"><a href="/main">Home</a></li>
	            <li class="breadcrumb-item active" style="font-size:2rem"><a href="/sanction/form">기안서작성</a></li>
	         </ol>
	   </div>
	  </div>
	 </div>
	</div>   
<div class="card-content">
	<form id="frm" action="/sanction/createPost" method="post" enctype="multipart/form-data">
	 <!-- 결재선 상단 시작-->
	  <div class="card-body" style="display: flex; justify-content: space-between; align-items: flex-start; gap: 30px;">
	    <!-- 버튼 그룹 시작 -->
        <div style="display: flex; gap: 10px; align-items: center;">
		    <!-- 결재선 버튼 -->
		    <button type="button" class="btn btn-dark" id="sanctionLineBtn" >결재선</button>
		</div> 
	    <!-- 버튼 그룹 끝 -->
		   
		<!-- 결재란 시작 -->   
	    <div id="sign">
	      
	      <table style="border-collapse: collapse;">
	      
	        <tbody >
	            <tr id="approver-names">
	                <td id="approver-name" style="height: 30px;">기안자</td>
	                <input type="hidden" name="sanctionUsers" value="${userId}">
	                <input type="hidden" name="userId" value="${userId}">
   	 			    <input type="hidden" name="sanctionLines" value="draft">
   	 			    <input type="hidden" name="sanctionTypes" value="1">
	            </tr>
	            <tr id="approver-signs">
	                <td id="approver-sign" style="height: 90px;">기안자 서명</td>
	            </tr>
	            <tr id="approver-dates">
	                <td id="approver-date" style="height: 30px;">기안날짜</td>
	            </tr>
	        </tbody>
	       </table>
	    
		</div>
		<!-- 결재란 끝 -->   
	  </div>	
	<!-- 결재선 상단 끝-->
		<div class="card-body">
			<div class="row">
				   <div style="font-weight: bold; margin-bottom: 10px;">
				   	<!-- 수신 부서 버튼 -->
		    		<button type="button" class="btn btn-dark" id="receiveBtn" >수신 부서</button>
				   </div>
			    <div id="receive" style="display: flex; flex-wrap: wrap; gap: 10px;">
			    </div>  
			     <!-- 문서 양식 버튼 -->
			     <div class="form-group">
				    <label for="docNm">결제 유형</label><span class="text-danger" style="vertical-align: super;">*</span>
				    <select id="docTypeSelect" class="form-control"  name="docTypeNo" >
						        <option value="select">결재 유형</option>
						        <option value="1">발주</option>
						        <option value="2">견적</option>
						        <option value="3">계산</option>
						        <option value="4">업무보고</option>
						        <option value="5">기타</option>
					</select>
				</div>  
				<div class="form-group">
					<label for="docNm">제목</label><span class="text-danger" style="vertical-align: super;">*</span> <input type="text" class="form-control" id="docTitle" name="docTitle" placeholder="문서 제목 입력"  required>
				</div>
				<!-- <div class="row">
				    <div class="col-md-3">
				        <div class="form-group">
				            <label for="helperText">기안자</label>
				            <input type="text" id="userNo" name="userNo" class="form-control" placeholder="기안자 이름 자동 입력" readonly>
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
				</div> -->
					<div class="form-group">
					    <label for="readonlyInput">내용</label> <span class="text-danger" style="vertical-align: super;">*</span>
					    <textarea class="form-control" id="docContent" name="docContent" style="height: 200px;"  required></textarea>
					</div>
					
					<div class="form-group">
						<label for="autoFillCheck" class="form-check-label">자동 입력</label>
          				<input type="checkbox" id="autoFillCheck" class="form-check-input">
					
					</div>
					
					
					<div class="form-group mb-3">
                <label for="uploadFiles" class="fw-bold">첨부파일</label>
                <input type="file" class="form-control" id="uploadFiles" name="uploadFiles" multiple>
            </div>
					
			</div>
		</div>
		<!-- 등록 시작 -->
		<div id="spn2" class="card-body" style="display: flex; justify-content: space-between; align-items: center;">
			<span style="float: left">
				<button type="submit" class="btn btn-primary btn-user">상신
				</button>
			</span> 
			<span style="float: right"> 
					<a href="/sanction/temp" class="btn btn-success btn-user"> 임시저장 </a>
			</span>
			
		</div>
		<!-- 등록 끝 -->
	</form>
</div>
</div>
</div>
<!-- 결재선 모달 시작 -->
<div class="modal fade text-left w-100" id="modalLine" tabindex="-1" aria-labelledby="myModalLabel16"  aria-modal="true" role="dialog">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-xl" role="document">
        <div class="modal-content">
            <div class="modal-header">
            		<h4>결재선</h4>
	                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
	            </div>
	            <div class="d-flex" >
                  <div id="jstree-container" style="flex: 1;">
				    	<div id="jstree" style="border: 1px solid #ddd; height: 100%;  overflow: auto;"></div>
				  </div>
                  
                  <!-- 결재자 선택 시 중간, 최종 결재자 여부 선택 시작-->
                <div style=" flex: 3; border: 1px solid #ddd; ">
                    <div class="clsRole" id="role-selection" style="display: flex; align-items: center; padding: 10px; gap: 10px;">
                    <label for="role-select" id="role-nm" data-user-no="" >결재단계: </label>
				    <select id="role-select" class="form-control" style="width: 120px;"">
				        <option value="select">결재 선택</option>
				        <option value="middle">중간 결재</option>
				        <option value="final">최종 결재</option>
				    </select>
					<!-- 결재 방식을 선택 -->
					
                    <label for="approval-type" id="approval-how" >결재 선택: </label>
				    <select id="approval-type" class="form-control" style="width: 120px;">
				        <option value="1">정상</option>
				        <option value="2">대결</option>
				        <option value="3">전결</option>
				    </select>
					
                    <button type="button" class="btn btn-primary ms-1" id="setRole">설정</button>
           
					<button type="button" class="btn btn-secondary" id="reset" style="float:right" title="초기화">
	                  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-counterclockwise" viewBox="0 0 16 16">
						 <path fill-rule="evenodd" d="M8 3a5 5 0 1 1-4.546 2.914.5.5 0 0 0-.908-.417A6 6 0 1 0 8 2z"></path>
						 <path d="M8 4.466V.534a.25.25 0 0 0-.41-.192L5.23 2.308a.25.25 0 0 0 0 .384l2.36 1.966A.25.25 0 0 0 8 4.466"></path>
					  </svg>
	                 
	                </button>
	                </div>
                	<div id="addNewRole"></div>    
                  </div>
                  <!-- 결재자 선택 시 중간, 최종 결재자 여부 선택 끝-->
                    
               </div> <hr>  
                <div id="spn" style=" float:left;" >
                    <button type="button" id="commit" class="btn btn-primary" >
                        <i class="bx bx-x d-block d-sm-none"></i>
                        <span class="d-none d-sm-block">등록</span>
                    </button>
                </div>
        </div>
    </div>
  </div>  
<!-- 결재선 모달 끝 -->
<!-- 수신 부서 모달 시작 -->
<div class="modal fade text-left w-100" id="modalReceive" tabindex="-1" aria-labelledby="myModalLabel16"  aria-modal="true" role="dialog">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" role="document">
        <div class="modal-content">
            <div class="modal-header">
            		<h4>수신 부서</h4>
	                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
	            </div>
	            
                  <div id="jstree2" style="border: 1px solid #ddd;"> </div>
                    
                <div id="spn" style=" float:left;" >
                    <button type="button" id="receiveCommit" class="btn btn-primary" >
                        <i class="bx bx-x d-block d-sm-none"></i>
                        <span class="d-none d-sm-block">등록</span>
                    </button>
                </div>
        </div>
    </div>
  </div>
    
<!-- 수신 부서 모달 끝 -->
<!-- Summernote CSS & JS -->
<!-- <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script> -->
<!-- Summernote CSS & JS -->
<!-- <script>
    CKEDITOR.replace('docContent');
</script> -->
<script type="text/javascript">
	  
	//결재선 관련 정보 가져오기 시작
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
					
					console.log("테스트 : ",$("#jstree").html());
					
					//jstree에 데이터 넣는 방식
					$('#jstree').jstree({
						
								'core':{
								  'data' : department
								}
								/* , "plugins" : ["search"],
								"search" : {
								    "show_only_matches" : true,
								    "show_only_matches_children" : true
								} */
					});
					  
		        }, //success 끝
		        
		        error: function(xhr, status, error) {
		            console.error("AJAX 요청 실패: ", status, error);
		        }//error end
					
					
			});
			
		}	//결재선 관련 정보 가져오기 끝
		
	//수신 부서 관련 정보 가져오기 시작
	 function receiveDept(){
				
			$.ajax({
				url:"/sanction/receiveDept"
				,contentType:"application/json;charset=utf-8"
				,type:"get"
				,success:function(result){
					
					console.log("detail result: ",result);
					
					let department = new Array();
					
					$.each(result,function(idx,value){//부서별 반복 시작
						
						// 상위 부서가 없는 값은 string으로 변환 후 #으로 변환
						if(value.deptSuprr == 0){
							value.deptSuprr.toString();
							value.deptSuprr = "#";
						}
						
						department[idx] = {id : value.deptNo, parent:value.deptSuprr, text:value.deptNm
											, 'state' : {
										         'opened' : true
										         
										       }
											}
					})//부서별 반복 끝
					  console.log("department: ",department);
					
					//jstree에 데이터 넣는 방식
					$('#jstree2').jstree({
						
								'core':{
								  'data' : department
								},
								'plugins': ['checkbox'],
								'checkbox': {
								    'keep_selected_style': false,  // 선택 스타일 유지 여부
								    'three_state': false,           // 부모-자식 노드 선택 연동 여부
								    'cascade': 'down',
								    'tie_selection': false          // 선택된 노드만 체크 (true로 유지)
								  }
					});
					
		        }, //success 끝
		        
		        error: function(xhr, status, error) {
		            console.error("AJAX 요청 실패: ", status, error);
		        }//error end
					
					
			});
			
		}	//수신 부서 관련 정보 가져오기 끝
	  
	  $(function(){
		  
		  //결재선 버튼 클릭 시 이벤트 시작
		  $("#sanctionLineBtn").on("click",function(){
				//모달 활성화
				$("#modalLine").modal("show");
				
				  jstreeDept();
				
			
			});//결재선 버튼 클릭 시 이벤트 끝
			
		  //수신 부서 버튼 클릭 시 이벤트 시작
		  $("#receiveBtn").on("click",function(){
				//모달 활성화
				$("#modalReceive").modal("show");
				
				receiveDept();
				
			
			});//수신 부서 버튼 클릭 시 이벤트 끝
			
			

		  //초기화 버튼 클릭 시 이벤트 시작
		  $("#reset").on("click",function(){
			  // #role-select 선택값 초기화
		      $("#role-select").val("select");

		      // #approval-type 선택값 초기화
		      $("#approval-type").val("1");
		      
		      $().remove();
			  
		  });//초기화 버튼 클릭 시 이벤트 끝
		  
		  
		// 결재자 클릭 시 이벤트
		  $(document).on("click","#jstree a",function(e){
			  
			  e.preventDefault();
			  
			  // 결재선 , 결재 처리 활성
			  //$("#role-selection").css("display", "flex");
			
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
				  var roleSelectCk = $("#addNewRole").find("[id^='role-select']"); //결새 선택 select id
				  var roleNm = $("#addNewRole").find("[id^='role-nm']");
				  
				  console.log("결재자:", userNm, "ID:", userNo, "선택된 역할:", roleSelect, "결재 방식:", approvalType);
				  
				  var chk = false;
				  // 결재자 중복체크
				  roleNm.each(function(){
					
					  var roleNmEach = $(this).text();
					  console.log("roleNmEach: ",roleNmEach)
					 
					  if(roleNmEach === userNm){
						  Swal.fire({
					            icon: "warning",
					            title: "이미 결재선에 지정했습니다"
					        });
// 					        return;
					        chk = true;//중복된 결재자가 있으면 true 반환
					  }
					  
				  });
				   
				  if(chk) return; //true로 반환되면 결재방식 선택 종료
				  
				// 선택 값 검증
				    if (roleSelect === "select") {
				        Swal.fire({
				            icon: "warning",
				            title: "결재 역할을 선택하세요."
				        });
				        return;
				    }
				  
				  
				  
				  
				  //중간 결재자로 지정되고 설정을 눌렀을 때 결재자 칸 추가
				  if(roleSelect === "middle"){
					  
					
				    // 기존 중간 결재자의 개수 확인
				        var middleCount = roleSelectCk.filter(function(){ return $(this).val() === "middle"}).length;
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
				        var finalCount = roleSelectCk.filter(function(){ return $(this).val() === "final"}).length;
					
				    // 중간 결재자는 총 3명까지 지정 가능하게
				        if (finalCount >= 1) {
					        	Swal.fire({
									  icon: "warning",
									  title: "최종 결재자는 1명만 지정 가능합니다."
				            })
				            return; // 복제 중단
				        }
				  }
					  
				  	  //*********** 시작 ************************
					  //기존 결재선 선택 div 복제
					  var newRoleSelection = $("#role-selection").clone();
					  
				  	  //console.log("clsRoleLen : " + $(".clsRole").length);
				  	  
					  //복제된 결재선에 고유 id 부여(id 식별 카운터 증가)
					  newRoleSelection.attr("id","role-selection-"+$(".clsRole").length);
					  
					  //복제된 div 설정 및 초기화 버튼 제거
					  newRoleSelection.find("#setRole").remove();
					  newRoleSelection.find("#reset").remove();
					  
				      // 복제된 결재선에 결재 데이터 저장, 행 별 id 구분
				      newRoleSelection.find("#role-nm").text(`\${userNm}`);
				      newRoleSelection.find("#role-nm").attr("id","role-nm-"+$(".clsRole").length);
				      newRoleSelection.find("#role-select").attr("id","role-select-"+$(".clsRole").length);
				      newRoleSelection.find("#approval-type").attr("id","approval-type-"+$(".clsRole").length);
				      
				      //console.log("userNo!! : " + userNo);
				      newRoleSelection.find("#role-nm-"+$(".clsRole").length).attr("data-user-no",userNo);// label은 name속성을 사용할 수 없어서 data-형식으로 해야함
				     
				      newRoleSelection.find("#role-select-"+$(".clsRole").length).val(roleSelect);
				      newRoleSelection.find("#approval-type-"+$(".clsRole").length).val(approvalType);
				        
				      // 삭제 버튼, 이벤트 추가
				      const deleteButton = $("<button>")
				          .addClass("btn-close")
				          .on("click", function () {
				              newRoleSelection.remove(); // 해당 행 삭제
				          });
				      newRoleSelection.append(deleteButton);  
					  
				        
				      //addNewRole에 선택한 결재선 추가								  
					  $("#addNewRole").append(newRoleSelection); 
				      
				      //*************************** 끝 ******************
				      
					// #role-select 선택값 초기화
				      $("#role-select").val("select");

				      // #approval-type 선택값 초기화
				      $("#approval-type").val("1");
					  
				      
				      
				      
				      
				  
			  }); //결재방식 선택 끝
			  
			  
		  });//결재자 클릭 시 이벤트 끝
		  
		  
		// 결재선 등록버튼 클릭 이벤트 시작
	      $("#commit").on("click",function(e){
	    	  
	    	  e.preventDefault();
	    	  
	    	  var roleSelectCk = $("#addNewRole").find("[id^='role-select']"); //결재 선택 select id
	    	  
	    	  // 결재 선택 
	    	  var roleSelect = $("#addNewRole").find("[id^='role-selection-']");
	    	  
	    	  
	    	  // 선택한 중간 결재자의 개수 확인
		        var middleCount = roleSelectCk.filter(function(){ return $(this).val() === "middle"}).length;
		      // 선택한 최종 결재자의 개수 확인
		        var finalCount = roleSelectCk.filter(function(){ return $(this).val() === "final"}).length;
	    	 
		     if(middleCount > 3){
	    		 Swal.fire({
					  icon: "warning",
					  title: "중간 결재자는 최대 3명까지 지정 가능합니다."
	              });
	              return;
	    	 }
		     
		     if(finalCount != 1){
	    		 Swal.fire({
					  icon: "warning",
					  title: "최종 결재자는 반드시 1명이어야 합니다."
	              });
	              return;
	    	 } 
		     
		  // 기존 결재자 데이터 초기화 (기본 양식 유지)
	         $('#approver-names').find('td:not(#approver-name)').remove();
	         $('#approver-signs').find('td:not(#approver-sign)').remove();
	         $('#approver-dates').find('td:not(#approver-date)').remove();
		     
		     //결재자 정보 결재란에 넣기
		     roleSelect.each(function(){
		    	 // 결재자 이름, 결재선택, 결재유형 저장
		    	 var userNm = $(this).find("[id^='role-nm']").text();
		    	 var sanctionLine = $(this).find("[id^='role-select']").val();
		    	 var sanctionType = $(this).find("[id^='approval-type']").val();
		    	 
		    	 //결재자 pk 저장
		    	 var userNo = $(this).find("[id^='role-nm']").attr("data-user-no")
		    	 
		    	 console.log("userNo: ", userNo);
		    	 console.log("sanctionLine: ", sanctionLine);
		    	 console.log("sanctionType: ", sanctionType);
		    	 
		    	 //결재란에 추가할 결재자 정보와 userNo, sanctionLine, sanctionType 저장
		    	 const name = `<td>\${userNm}</td>
		    	 			   <input type="hidden" name="sanctionUsers" value="\${userNo}">
		    	 			   <input type="hidden" name="sanctionLines" value="\${sanctionLine}">
		    	 			   <input type="hidden" name="sanctionTypes" value="\${sanctionType}">
		    	 			   
		    	 			   `;
		    	 const sign = `<td>결재자 서명</td>`;
		    	 const date = `<td>결재 날짜</td>`;
		    	 
		    	 // 기존 결재란 양식에 결재칸 추가
		    	 $("#approver-names").append(name);
		    	 $("#approver-signs").append(sign);
		    	 $("#approver-dates").append(date);
		     });
		     
		     
		     
			 Swal.fire({
				  icon: "success",
				  title: '결재란이 업데이트되었습니다.',
				  showConfirmButton: false,
				  timer: 1500
     		}).then((result) => {
     		
		      // 모달 닫기
		      $('#modalLine').modal('hide'); 
           	
           })
           
		     //최종 결재자 찾기
			/*  var finalApprover = null;
		     roleSelect.each(function(){
		    	 
		    	 var selectElement = $(this).find('select[name="sanctionlineNo"]'); 
		    	 
			     if(selectElement.val() == "final"){
			    	 finalApprover = $(this).closest(".clsRole").find("[id^='role-nm']").text();
			     }
		     })
			 console.log("finalApprover: ",finalApprover); */
		    
		     
	      });// 결재선 등록버튼 클릭 이벤트 끝

	   // 수신부서 등록 시작
	      $("#receiveCommit").on("click",function(){
	    	  
	    	  $('#receive').empty();
	    	  
	    	  var jstree2 = $("#jstree2").find("[aria-selected='true']")
	    	
			  //지정한 부서 수신 부서란에 등록 시작
			  jstree2.each(function(){
				  
				  
				  
	    	      var deptNo = $(this).attr("id").split('_')[0]; //클릭한 노드의 id 
			      var deptNm = $(this).text(); //클릭한 노드의 이름 
				  console.log("deptNo: ", deptNo);
				  console.log("deptNm: ", deptNm);
				  
				//수신 부서에 추가할 부서 정보와 deptNo 저장
		    	 const name = ` <div style="position: relative;">
			    	 				<input type="text" id="\${deptNo}" style="padding-right: 30px;"  class="form-control" value="\${deptNm}" readonly>
			    	 				<input type="hidden" name="receive" type="text" value="\${deptNo}" readonly>
			    	 				<i class="bi bi-x-circle" style="position: absolute; right: 10px; top: 50%; transform: translateY(-50%); cursor: pointer;"></i>
		    	 				</div>`;
		    	 
		    	 
		    	
		    	 // 기존 결재란 양식에 결재칸 추가
		    	 $("#receive").append(name);
				  
		    	 Swal.fire({
					  icon: "success",
					  title: '수신 부서가 업데이트되었습니다.',
					  showConfirmButton: false,
					  timer: 1500
	     		}).then((result) => {
	     		
			      // 모달 닫기
			      $('#modalReceive').modal('hide');
	     		});
			  
			  
	    	  
	     	  });//지정한 부서 수신 부서란에 등록 끝
		  
		  
		 
	  }); // 수신부서 등록 끝
	  
	  // 수신부서 설정 취소 버튼
	  $(document).on("click",".bi-x-circle",function(){
		
		  $(this).closest("div").remove();
	  });
	  
	  $("#frm").on("submit", function (event) {
          var docTypeValue = $("#docTypeSelect").val(); // 선택된 값 가져오기

          // 값이 "select"라면 폼 제출을 막고 경고 메시지 표시
          if (docTypeValue === "select") {
              event.preventDefault(); // 폼 제출 막기
              Swal.fire({
				  icon: "warning",
				  title: '결재 유형을 선택해주세요!',
				  showConfirmButton: false,
				  timer: 1500
     		  }).then((result) => {
     		
     			 $("#docTypeSelect").focus(); // select로 포커스 이동
     		});
              
          }
      });
	
 });  
	  
		
		
		
		
</script>
<footer>
    <!-- Toast Notification -->
	<div class="toast-container position-fixed top-0 end-0 p-4" style="z-index: 1055;">
	    <div id="liveToast" class="toast align-items-center text-white bg-warning border-0" role="alert" aria-live="assertive" aria-atomic="true" data-bs-delay="5000">
	        <div class="d-flex">
	            <div class="toast-body">
	                <strong class="me-auto">알림</strong>
	                <p class="mb-0">새로운 알림이 도착했습니다.</p>
	                <small id="toast-timestamp">방금</small>
	            </div>
	            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
	        </div>
	    </div>
	</div>


    <!-- 기존 푸터 내용 -->
    <div class="footer clearfix mb-0 text-muted">
        <div class="float-start">
            <p>2024 &copy; CAFE@BEAN</p>
        </div>
    </div>
</footer>

<!-- 커스텀 스크립트 포함 -->
<script src="/dist/assets/compiled/js/app.js"></script>
<script>
  document.getElementById('autoFillCheck').addEventListener('change', function() {
    if (this.checked) {
    	document.getElementById('docTypeSelect').value = '4';
      document.getElementById('docTitle').value = "2025_02_05_업무보고";
      document.getElementById('docContent').value = "업무보고 올립니다.";
    } else {
    	document.getElementById('docTypeSelect').value = 'select';
      document.getElementById('docTitle').value = "";
      document.getElementById('docContent').value = "";
    }
  });
</script>
