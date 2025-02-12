<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>

<link rel="stylesheet" href="/css/common2.css">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
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
	            <li class="breadcrumb-item active"><a href="/sanction/mysanc">내문서함</a></li>
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
								<button onclick="location.href='sanction/form'" class="btn btn-dark rounded-pill" style="float: right;">기안서작성</button>
						</div>
					</div>
					<div class="tableType01" style="width:100% !important">
						<table class="board" id="table1">
							<thead>
								<tr>
									<th style="width:80px">순번</th>
									<th>문서유형</th>
									<th>제목</th>
									<th>결재자</th>
									<th>결재상태</th>
									<th>결재일</th>
									<th>작성일</th>
								</tr>
							</thead>
							<tbody id="tby">
							</tbody>
						</table>
						</div>
						</div>
					  <div class="card-footer">
       			 <nav aria-label="Page navigation example">
					<div class="pagination pagination-warning justify-content-center" id="divPagingArea"></div>
				 </nav>
				</div>
				</div>
				</div>
				</div>
	</section>
</div>
</div>

			<%-- <tbody id="tby">
				<c:forEach var="sanctionDocVO" items="${articlePage.content}" varStatus="stat" >
              <tr>
                  <td>${sanctionDocVO.boardNo}</td>
                  <td>${sanctionDocVO.boardNo}</td>
                  <td>${sanctionDocVO.boardTitle}</td>
                  <td>${sanctionDocVO.boardCn}</td>
                  <td>${sanctionDocVO.userNo}</td>
                  <td>${sanctionDocVO.boardGegDate}</td>
              </tr>
            </c:forEach> 
			</tbody>
		</table>  --%>




<script type="text/javascript">

	//결재처리 상태 보여주기
	function formDate(value){
		return value == null ? "미처리":value;
	}
	
	
	function nvl(expr1, expr2) {
	    if (expr1 === undefined || expr1 == null || expr1 == "") {
	       expr1 = expr2;
	    }
	  	return expr1;
	 } 

	//getList(1,keyword);
	function getList(currentPage, keyword){
		
		currentPage = nvl(currentPage,"1");
		
		let data = {
			"currentPage":currentPage,
			"keyword":nvl(keyword,"")
		};
	
		console.log("data: ",data);
		
		$.ajax({
			url:"/sanction/mysancListAjax",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"json",
			success:function(result){
				console.log("result: ",result);
				
				let str="";
				$.each(result.content,function(idx,sanctionDocVO){
					
				//console.log("체킁: ",idx,sanctionDocVO);
					str+=`<tr>
						 <td>\${sanctionDocVO.rnum}</td>
		                  <td>\${sanctionDocVO.docTypeNm}</td>
		                  <td style="text-align: left;"><a href="/sanction/detail?docNo=\${sanctionDocVO.docNo}&currentPage=\${currentPage}">\${sanctionDocVO.docTitle}</a></td>
		                  <td>\${sanctionDocVO.sanctionUserNm}</td>
		                  <td>\${sanctionDocVO.sanctionStatusNm}</td>													
		                  <td>\${formDate(sanctionDocVO.sanctionDate)}</td>													
		                  <td>\${sanctionDocVO.docCreateDate}</td>
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
		
		//페이지 로딩 시 초기값으로 getList 호출
		getList("${param.currentPage}","");
		
		//console.log("개똥이");
		
		$("#search").on("click",function(){
			let keyword = $("input[name='keyword']").val();
			console.log("keyword: ",keyword);
			getList(1,keyword);
		})
		$("#keyword").on("keydown",function(event){
			if(event.key == "Enter"){
			let keyword = $("input[name='keyword']").val();
			console.log("keyword: ",keyword);
			getList(1,keyword);
				
			}
		})
		
		//페이지 클릭 처리 -> 동적요소
		$(document).on("click",".clsPagingArea",function(){
			
			let currentPage = $(this).data("currentPage");
			let keyword = $(this).data("keyword");
			
			getList(currentPage,keyword);// 해당 페이지와 검색어로 getList 호출
		});
		
		
		
		
	});//end 달러function
</script>

<%@ include file="../include/footer.jsp"%>