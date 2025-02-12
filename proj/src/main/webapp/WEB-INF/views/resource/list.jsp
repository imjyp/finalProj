<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>


<sec:authorize access="isAuthenticated()">
	<%-- <p>개똥이 : <sec:authentication property="principal"/></p> --%>
	<%@ include file="../include/header.jsp"%>
</sec:authorize>
	<style>
    #table1 th, #table1 td {
        text-align: center;
        vertical-align: middle; /* 세로 정렬도 가운데로 */
	    }
	 /* 모달 크기 조정 */
  #udModal .modal-dialog {
	    max-width: 900px; /* 모달의 너비를 키움 */
	  }
	  
	  /* 글씨 크기 조정 */
	  #udModal .form-label,
	  #udModal input,
	  #udModal p,
	  #udModal h5 {
	    font-size: 15px; /* 글씨 크기 키움 */
	  }
	
	  #udModal h3 {
	    font-size: 20px; /* 사용자 이름 글씨 크기 */
	  }
	
	  #udModal p.text-small {
	    font-size: 14px; /* 소형 글씨 크기 */
	  }
	  
	  /* 검색 폼 아래에 여백 추가 */
	  .dataTable-top{
	    margin-bottom: 50px !important; /* 필요에 따라 값 조정 */
	  }
	  
	  /* 페이지네이션 위에 여백 추가 */
	  .card-footer {
	    margin-top: 50px; /* 필요에 따라 값 조정 */
	  }
	  
	  /* 뱃지만 개별적으로 가운데 정렬 (만약 필요하면) */
	.tableType01 td .badge {
	    display: inline-block !important;
	    text-align: center;
	    width: 100%; /* 뱃지가 전체 영역에서 중앙에 오도록 설정 */
	}
	
	.swal-body{
		font-family : 'NotoSansKR' ; 
		font-size :500 !important;
	}
	#main {
				  margin-top: 140px !important;
				}
	</style>
<link rel="stylesheet" href="/css/common2.css">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<%@ include file="../include/top.jsp"%>
<div id="main">
<div class="card">
	<div class="card-header">
	    <div class="container-fluid">
	      <div class="row align-items-center">
		<!-- 제목과 브레드크럼 -->
		<div class="col-md-6 d-flex align-items-center">
	          <nav aria-label="breadcrumb" class="ms-3">
	            <ol class="breadcrumb mb-0">
	            <li class="breadcrumb-item"><a href="/main">Home</a></li>
	            <li class="breadcrumb-item active"><a href="/resource/list">자료실</a></li>
	         </ol>
          </nav>
        </div>
	</div>
  </div>	
</div>
	<section class="section">
		<div class="card-content">
			<div class="card-body align-items-center justify-content-between" style="display: flex; margin-bottom: 20px;">
            <div class="dataTable-top" style="justify-content: right; width: 100%; ">
				<div class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
					<div class="dataTable-top">
						<div class="dataTable-search" style=" flex: 1;">
							<input type="text" id="keyword" name="keyword" class="dataTable-input" 
							placeholder="검색어 입력" value="${param.keyword}" aria-controls="tby">
								<button type="button" id="search"
									class="btn btn-warning rounded-pill">검색</button>
						<sec:authorize access="isAuthenticated()"><!-- 로그인 했다면 보여라 -->
							<sec:authorize access="hasAnyRole('CEO','SYS','IS','JJ','GH','GY','MR')">
									<button onclick="location.href='/resource/create'" class="btn btn-dark rounded-pill" style="float: right;">등록</button>
							</sec:authorize>
						</sec:authorize>
						</div>
					</div>
					<div class="tableType01" style="width:100% !important">
						<table class="board" id="table1">
							<thead>
								<tr>
									<th class="sorting sorting_asc" tabindex="0"
										aria-controls="table1" rowspan="1" colspan="1"
										aria-sort="ascending"
										aria-label="price: activate to sort column descending"
										style="width: 7%;">선택</th>
									<th>순번</th>
									<th>부서</th>
									<th>제목</th>
									<th>작성자</th>
									<th>게시일</th>
									<th>첨부파일</th>
								</tr>
							</thead>
							<tbody id="tby">
							</tbody>
						</table>
					</div>
						<div class="card-footer">
       			 <nav aria-label="Page navigation example">
					<div class="pagination pagination-warning justify-content-center" id="divPagingArea"></div>
				 </nav>
				</div>
				</div>
			</div>
		</div>
<sec:authorize access="isAuthenticated()"><!-- 로그인 했다면 보여라 -->
	<sec:authorize access="hasAnyRole('CEO','SYS','IS','JJ','GH','GY','MR')">
		<div class="col-12" style="justify-content: left; display: flex;">
			<button type="button" id="delete" class="btn btn-danger rounded-pill">삭제</button>
		</div>
	</sec:authorize>
</sec:authorize>
	  </div>			
	</section>
<div>
</div>
</div>
			<%-- <tbody id="tby">
				<c:forEach var="resourceVO" items="${articlePage.content}" varStatus="stat" >
              <tr>
                  <td>${resourceVO.boardNo}</td>
                  <td>${resourceVO.boardNo}</td>
                  <td>${resourceVO.boardTitle}</td>
                  <td>${resourceVO.boardCn}</td>
                  <td>${resourceVO.userNo}</td>
                  <td>${resourceVO.boardGegDate}</td>
              </tr>
            </c:forEach> 
			</tbody>
		</table>  --%>

</div>
<!-- 모달 시작 -->
<div class="modal fade text-left" id="inlineForm" tabindex="-1" aria-labelledby="myModalLabel33"  aria-modal="true" role="dialog">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" role="document">
        <div class="modal-content">
            <form action="/resource/update" method="post" enctype="multipart/form-data" >
	            <div class="modal-header">
	                <h4 class="modal-title" id="boardTitle" class="boardTitle" name="boardTitle"></h4>
	                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
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
                    <button type="button" id="fileName"  class="btn btn-outline-dark download" name="fileName" data-file="">
	                  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-download" viewBox="0 0 16 16">
	                  <path d="M.5 9.9a.5.5 0 0 1 .5.5v2.5a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1v-2.5a.5.5 0 0 1 1 0v2.5a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2v-2.5a.5.5 0 0 1 .5-.5"></path>
	                  <path d="M7.646 11.854a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 10.293V1.5a.5.5 0 0 0-1 0v8.793L5.354 8.146a.5.5 0 1 0-.708.708z"></path>
	                  </svg>
                      다운로드
                     </button>
                     <div id="up" class ="form-group" style="display: none;">
						<label for="uploadFiles">첨부파일</label>
						<div class="input-group">
							<div class="custom-file">
							  <input type="file" class="custom-file-input" id="uploadFiles"
							  name="uploadFiles" class="uploadFiles" multiple />
							  
							</div>
						</div>
					 </div>
				  </div>
				  <sec:authorize access="isAuthenticated()"><!-- 로그인 했다면 보여라 -->
					<sec:authorize access="hasAnyRole('CEO','SYS','IS','JJ','GH','GY','MR')"> 
		                <div id="spn1" class="modal-footer" style="justify-content: flex-start;"></div>
	                </sec:authorize>
                </sec:authorize>
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
<!-- 모달 끝 -->
<script type="text/javascript">

	
	
	function nvl(expr1, expr2) {
	    if (expr1 === undefined || expr1 == null || expr1 == "") {
	       expr1 = expr2;
	    }
	  	return expr1;
	 } 
	
    //삭제처리 
	function del(boardNo){
		 let data = { "boardNo":boardNo}
		 //48
	     console.log("boardNo: ",data);
		 
		 $.ajax({
             url: "/resource/delete", 
             contentType:"application/json;charset=utf-8",
             data:JSON.stringify(data),
             type: "POST",
             dataType: "text",
             success: function(response) {
            	 console.log("response : ", response);//1 또는 0
                 alert("삭제가 완료되었습니다.");
            	 
            	 //삭제 후 1페이지가 보이게
                 getList(1,"");
             },
             error: function(xhr, status, error) {
                 alert("삭제에 실패했습니다.");
             }
         });
	}
	
	//모달 창에 값 부여하는 함수
	function detail(boardNo){
		let data = {"boardNo":boardNo};
		//console.log("data: ", data);
		
		$.ajax({
			url:"/resource/detailAjax"
			,contentType:"application/json;charset=utf-8"
			,data:JSON.stringify(data)
			,type:"post"
			,dataType:"json"
			,success:function(result){
				console.log("detail result: ",result);
				
				$('#boardNo').val(result.boardNo);
				$('#boardTitle').text(result.boardTitle);
				$("#userNm").val(result.userNm);
				$("#deptNm").val(result.deptNm);
				$("#boardCn").val(result.boardCn);
				$("#fileName").attr("data-file",result.fileGroupVO.fileDetailVOList[0].fileSaveLocate);
				console.log("result.fileGroupVO.fileDetailVOList[0].fileSaveLocate: ",result.fileGroupVO.fileDetailVOList[0].fileSaveLocate);
				
			}	
		})
		
	}

	//자료실 목록
	function getList(currentPage, keyword){
		
		currentPage = nvl(currentPage,"1");
		
		let data = {
			"currentPage":currentPage,
			"keyword":nvl(keyword,"")
		};
	
		//console.log("data: ",data);
		
		$.ajax({
			url:"/resource/listAjax",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"json",
			success:function(result){
				//console.log("result: ",result);
				
				let str="";
				$.each(result.content,function(idx,resourceVO){
					
				//console.log("체킁: ",idx,resourceVO);
					str+=`<tr>
						  <td><input name="boardNo" id="boardNo" value="\${resourceVO.boardNo}" type="hidden"/>
						  		<input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault2" value="\${resourceVO.userNo}" ></td>
						  <td>\${resourceVO.rnum}</td>
		                  <td>\${resourceVO.deptNm}</td>													
		                  <td style="text-align: left;"><a href="#" data-bs-toggle="modal" data-bs-target="#inlineForm" class="exam" 
		                  		data-board-no="\${resourceVO.boardNo}" data-user-no="\${resourceVO.userNo}">
		                  		\${resourceVO.boardTitle}
		                  	  </a>
		                  </td>
		                  <td>\${resourceVO.userNm}</td>
		                  <td>\${resourceVO.boardRegDate}</td>
		                  <td >`;
		                  /* 첨부파일이 있을 때 첨부파일의 저장경로 불러오기 */
		                  if(resourceVO.fileGroupVO!=null){
		                  	//console.log("resourceVO.fileGroupVO.fileDetailVOList : ", resourceVO.fileGroupVO.fileDetailVOList);
				             $.each(resourceVO.fileGroupVO.fileDetailVOList,function(idx,fileDetailVO){ 
				                  str += `
				                  			  <button type="button" title="\${fileDetailVO.fileOriginalName}" class="btn btn-outline-dark download" name="fileName" data-file="\${fileDetailVO.fileSaveLocate}">
							                  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-download" viewBox="0 0 16 16">
							                  <path d="M.5 9.9a.5.5 0 0 1 .5.5v2.5a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1v-2.5a.5.5 0 0 1 1 0v2.5a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2v-2.5a.5.5 0 0 1 .5-.5"></path>
							                  <path d="M7.646 11.854a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 10.293V1.5a.5.5 0 0 0-1 0v8.793L5.354 8.146a.5.5 0 1 0-.708.708z"></path>
							                  </svg>
						                      다운로드
					                      </button>
					                     `
				             });
		                  }//end if
		                  str += `</td>
		                  </tr>`;
				});
				// <tbody id="tby">에 목록 추가
				$("#tby").html(str);
				
				//페이징처리
				 $("#divPagingArea").html(result.pagingArea); 
			}//end success
				
		});//end ajax
	}//end getList함수
	
	
	$(function(){
		
		var userId = "${userId}" // 로그인한 회원의 userNo
		
		//페이지 로딩 시 초기값으로 getList 호출
		getList("${param.currentPage}","");
		
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
		
		$(document).on("click",".exam",function(){
			//모달 활성화
			$("#inlineForm").modal("show");
			//data-board-no="달러{resourceVO.boardNo}
			//boardNo값을 기준으로 비동기식 데이터 송수신
			let boardNo = $(this).data("boardNo");
			//console.log("exam->boardNo : ", boardNo);
			var userNo = $(this).data("userNo");
			console.log("userNo: ",userNo);
			console.log("userId: ",userId);
			if(userNo === userId){
				
			 const edit = `<button type="button" id="edit" class="btn btn-light-secondary" >
			                <i class="bx bx-x d-block d-sm-none"></i>
			                <span class="d-none d-sm-block">수정</span>
		            	   </button>`
		      $("#spn1").append(edit);      	
			}
			detail(boardNo);
			
			
		
		});
		// 모달 닫힘 이벤트 처리
		$("#inlineForm").on("hidden.bs.modal", function () {
		    $("#spn1").empty(); // 동적으로 추가된 수정 버튼 제거
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
			
		    var listUser = $("input[type='radio']:checked").val();
		    console.log("userId: ",userId);
		    console.log("listUser: ",listUser);
			if(userId != listUser){
				alert("게시물을 등록한 사용자가 아닙니다.");
				// 체크된 radio 체크 해제
				$("input[type='radio']:checked").prop("checked", false);
				return;
			}
			
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
				alert("삭제할 목록을 선택하세요.");
				return;
			} 
		});//삭제 버튼 끝 
	});//end 달러function
</script>

<%@ include file="../include/footer.jsp"%>