<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>

<link rel="stylesheet" href="/css/common2.css">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
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
<sec:authorize access="isAuthenticated()">
	<%-- <p>개똥이 : <sec:authentication property="principal"/></p> --%>
	<%@ include file="../include/header.jsp"%>
	
</sec:authorize>
<%@ include file="../include/top.jsp"%>
	 <div id="main" class="mt-5">
<div class="card">
	  <div class="card-header">
	    <div class="container-fluid">
	      <div class="row align-items-center">
		<!-- 제목과 브레드크럼 -->
		<div class="col-md-6 d-flex align-items-center">
	          <nav aria-label="breadcrumb" class="ms-3">
	            <ol class="breadcrumb mb-0">
	            <li class="breadcrumb-item"><a href="/main">Home</a></li>
	            <li class="breadcrumb-item active"><a href="/notice/list">공지사항</a></li>
	         </ol>
          </nav>
        </div>
	</div>
  </div>	
	
	<div class="card-content">
		<div class="card-body align-items-center justify-content-between" style="display: flex; margin-bottom: 20px;">
            <div class="dataTable-top" style="justify-content: right; display: flex; width: 100%; ">
				<div
					class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
					<div class="dataTable-top">
						<div class="dataTable-search" style=" flex: 1;">
							<input type="date" style=" width:130px">
							<input type="date" style="width:130px">
						
							<input type="text" id="keyword" name="keyword" class="dataTable-input" style="margin-left:40px"
								placeholder="검색어 입력" value="${param.keyword}" aria-controls="tby">
								
							<button type="button" id="search"
								class="btn btn-warning rounded-pill">검색</button>
						<sec:authorize access="isAuthenticated()"><!-- 로그인 했다면 보여라 -->
							<sec:authorize access="hasAnyRole('CEO','SYS','IS','JJ','GH','GY','MR')">
									<button onclick="location.href='/notice/create'" class="btn btn-dark rounded-pill" style="float: right;">등록</button>
							</sec:authorize>
						</sec:authorize>
						</div>
					</div>
					<div class="tableType01" style="width:100% !important">
						<table class="board" id="table1">
							<thead>
								<tr>
									<th style="width:80px">순번</th>
									<th>부서</th>
									<th>제목</th>
									<th>작성자</th>
									<th>게시일</th>
									<th>게시 기간</th>
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
	  </div>
	</div>	
</div>
</div>


			<%-- <tbody id="tby">
				<c:forEach var="noticeVO" items="${articlePage.content}" varStatus="stat" >
              <tr>
                  <td>${noticeVO.boardNo}</td>
                  <td>${noticeVO.boardNo}</td>
                  <td>${noticeVO.boardTitle}</td>
                  <td>${noticeVO.boardCn}</td>
                  <td>${noticeVO.userNo}</td>
                  <td>${noticeVO.boardGegDate}</td>
              </tr>
            </c:forEach> 
			</tbody>
		</table>  --%>



<script type="text/javascript">
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
			url:"/notice/listAjax",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"json",
			success:function(result){
				console.log("result: ",result);
				
				let str="";
				$.each(result.content,function(idx,noticeVO){
					str+=`<tr>
						 <td>\${noticeVO.rnum}</td>
		                  <td>\${noticeVO.deptNm}</td>
		                  <td  style="text-align: left;"><a href ="/notice/detail?boardNo=\${noticeVO.boardNo}&currentPage=\${currentPage}">\${noticeVO.boardTitle}</a></td>
		                  <td>\${noticeVO.userNm}</td>
		                  <td>\${noticeVO.boardRegDate}</td>
		                  <td>\${noticeVO.boardStart} ~ \${noticeVO.boardEnd}</td>
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