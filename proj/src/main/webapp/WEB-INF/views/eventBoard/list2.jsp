<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>

<!DOCTYPE html>
<sec:authorize access="isAuthenticated()">
	<%-- <p>개똥이 : <sec:authentication property="principal"/></p> --%>
	<%@ include file="../include/header.jsp"%>
	 <div id="main">
	<header class="mb-3">
		<a href="#" class="burger-btn d-block d-xl-none"> <i
			class="bi bi-justify fs-3"></i>
		</a>
	</header>
</sec:authorize>
<%@ include file="../include/top.jsp"%>
<div class="page-heading" style="margin:10 10 10 10px;">
<!-- 	<div class="page-title"> -->
<!-- 		<div class="row"> -->
<!-- 			<div class="col-12 col-md-6 order-md-1 order-last"> -->
<!-- 				<h3>이벤트 게시판</h3> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->
	<div class="row mb-2 align-items-center">
         <ol class="breadcrumb float-sm-end">
            <li class="breadcrumb-item" style="font-size:2rem"><a href="/main">Home</a></li>
            <li class="breadcrumb-item active" style="font-size:2rem"><a href="/eventBoard/test">이벤트 게시판</a></li>
         </ol>
   	</div>
	
	<section class="section">
		<div class="card">
			<div class="card-body">
				<div
					class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
					<div class="dataTable-top">
						<div class="input-group"
							style="width: 200px; display: flex; justify-content: flex-end;">
							<input type="text" id="keyword" name="keyword" class="form-control"
								placeholder="검색어 입력" value="${param.keyword}">
							<div>
								<button type="button" id="search"
									class="btn btn-outline-primary">검색</button>
							</div>
						</div>
						<div class="col-12" style="justify-content: right; display: flex;">
							<a href="/eventBoard/create" class="btn btn-primary">등록</a>
						</div>
					</div>
					<div class="table-responsive">
						<table class="table table-hover mb-0" id="table1">
							<thead style="text-align:center">
								<tr>
									<th class="text-bold-500 text-center">순번</th>
									<th class="text-bold-500 text-center">부서</th>
									<th class="text-bold-500 text-center">제목</th>
									<th class="text-bold-500 text-center">작성자</th>
									<th class="text-bold-500 text-center">게시일</th>
									<th class="text-bold-500 text-center">게시 기간</th>
								</tr>
							</thead>
							<tbody id="tby">
							</tbody>
						</table>
					</div>
				</div>
			<div class="row" id="divPagingArea"  style="display: flex; 
			justify-content: center; align-items: center;  margin-top: 20px;"></div>
			</div>
		</div>
	</section>
</div>

			<%-- <tbody id="tby">
				<c:forEach var="calendarVO" items="${articlePage.content}" varStatus="stat" >
              <tr>
                  <td>${calendarVO.boardNo}</td>
                  <td>${calendarVO.deptNm}</td>
                  <td>${calendarVO.boardTitle}</td>
                  <td>${calendarVO.boardCn}</td>
                  <td>${calendarVO.userNo}</td>
                  <td>${calendarVO.boardGegDate}</td>
              </tr>
            </c:forEach> 
			</tbody>
		</table>  --%>

<!-- javaScript 시작 -->
<script type="text/javascript">

	//날짜 형식 변환 함수 정의
	function formatDate(dateStr) { //formatDate인 함수를 정의
		console.log("안녕",dateStr);
	    const date = new Date(dateStr); //문자열을 날짜 객체로 변환
	    const year = date.getFullYear(); //연도 추출
		//const year = String(date.getFullYear()).slice(-2); //연도 뒤에 두 자리만 추출
	    const month = String(date.getMonth() + 1).padStart(2, "0"); //월 추출 및 0 채우기
	    const day = String(date.getDate()).padStart(2, "0");
	    const hours = String(date.getHours()).padStart(2, "0");
	    const minutes = String(date.getMinutes()).padStart(2, "0");
	    console.log("체로롱",`\${year}-\${month}-\${day} \${hours}:\${minutes}`)
	    return `\${year}-\${month}-\${day}`;
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
			url:"/eventBoard/listAjax",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"json",
			success:function(result){
				console.log("result: ",result);

				let str="";
				$.each(result.content,function(idx,calendarVO){
					console.log("calendarVO: ",calendarVO);
					const calRegDate = new Date(calendarVO.calRegDate).toISOString().slice(0, 10);
			        const calStart = formatDate(calendarVO.calStart);
					//const calStart = new Date(calendarVO.calStart).toISOString().slice(0, 16);
        			const calEnd = formatDate(calendarVO.calEnd);
			        //const calEnd = new Date(calendarVO.calEnd).toISOString().slice(0, 16);
					
			        // 목록 문자열 생성
					str+=`<tr>
						 <td style="text-align:center"class="text-bold-500 text-center">\${calendarVO.rnum}</td>
		                  <td style="text-align:center"class="text-bold-500 text-center">\${calendarVO.deptNm}</td>
		                  <td style="text-align:left"class="text-bold-500 "><a href ="/eventBoard/detail?calNm=\${calendarVO.calNm}&currentPage=\${currentPage}">\${calendarVO.calTitle}</a></td>
		                  <td style="text-align:center"class="text-bold-500 text-center">\${calendarVO.userNm}</td>
		                  <td style="text-align:center"class="text-bold-500 text-center">\${calRegDate}</td>
						  <td style="text-align:center"class="text-bold-500 text-center">\${calStart} ~ \${calEnd}</td>
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