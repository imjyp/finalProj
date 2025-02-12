<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="/css/common2.css">
<!DOCTYPE html>
<sec:authorize access="isAuthenticated()">
	<%-- <p>개똥이 : <sec:authentication property="principal"/></p> --%>
	<%@ include file="../include/header.jsp"%>



	<header class="mb-3">
		<a href="#" class="burger-btn d-block d-xl-none"> <i
			class="bi bi-justify fs-3"></i>
		</a>
	</header>
</sec:authorize>
<%@ include file="../include/top.jsp"%>

<div id="main">
	<div class="card">
		<div class="card-header">
			<div class="container-fluid">

				<header class="mb-3">
					<a href="#" class="burger-btn d-block d-xl-none"> <i
						class="bi bi-justify fs-3"></i>
					</a>
				</header>
				<div class="page-heading row" >

					<div class="col-6 d-flex align-items-center">
						<nav aria-label="breadcrumb" class="ms-3">
							<ol class="breadcrumb mb-0">
								<li class="breadcrumb-item"><a href="/main">Home</a></li>
								<li class="breadcrumb-item active"><a
									href="/eventBoard/test">이벤트 게시판</a></li>
							</ol>
						</nav>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="page-heading">
		<div class="row">
			<input type="date" style=" width:130px; margin-left:40px">
			<input type="date" style="width:130px">
			<fieldset class="col-1 form-group"  style="margin-left:40px">
				<select class="form-select" id="menu">
					<option>상태</option>
					<option value="1">진행중</option>
					<option value="2">종료</option>
					<option value="3">진행예정</option>
				</select>
			</fieldset>

		</div>
		<section class="section">
			<div class="card">
				<div class="card-content">
					<div class="event-grid" id="tby"></div>
				</div>
			</div>
		</section>
	</div>
</div>


<style>
.event-grid {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
	gap: 20px;
	padding: 20px;
}

.form-select {
	height: 40px !important;
}

#main {
	margin-top: 141px;
}

.event-card {
	border: 1px solid #ddd;
	border-radius: 8px;
	overflow: hidden;
	background: white;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.event-card img {
	width: 100%;
	height: 200px;
	object-fit: cover;
}

.event-card .card-content {
	padding: 15px;
}

.event-card .card-title {
	font-size: 1.2rem;
	font-weight: bold;
	margin-bottom: 10px;
}

.event-card .card-info {
	display: flex;
	justify-content: space-between;
	margin-top: 10px;
}
</style>
<script type="text/javascript">
const today2 = new Date().toISOString().slice(0, 10);


	function formatDate(dateStr) { //formatDate인 함수를 정의
		console.log("안녕",dateStr);
	    const date = new Date(dateStr); //문자열을 날짜 객체로 변환
	    const year = date.getFullYear(); //연도 추출
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

				let str = "";
				$.each(result.content, function(idx, calendarVO) {
				    const calStart = formatDate(calendarVO.calStart);
				    const calEnd = formatDate(calendarVO.calEnd);
				    let status = (calStart <= today2 && calEnd >= today2) ? "진행중" : 
				                 (calStart > today2) ? "진행예정" : "종료";
				    
				    str += `
				    <a href ="/eventBoard/detail?calNm=\${calendarVO.calNm}&currentPage=\${currentPage}">
				    <div class="event-card">
				        <img src="/resources\${calendarVO.fileGroupVO.fileDetailVOList[0].fileSaveLocate}" alt="Event Image"/>
				        <div class="card-content">
				            <div class="card-title">\${calendarVO.calTitle}</div>
				            <div class="card-text">\${calendarVO.calContent}</div>
				            <div class="card-info">
				                <div>상태: \${status}</div>
				                
				            </div>
				            <div class="card-info">
				            <div>기간: \${calStart} ~ \${calEnd}</div>
				                
				            </div>
				        </div>
				    </div></a>`;
				});

				$("#tby").html(str);
				
				 $("#divPagingArea").html(result.pagingArea); 
			}//end success
				
		});//end ajax
	}//end getList함수
	
	
	$(function(){
		
		getList("${param.currentPage}","");
		
		
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
		$(document).on("click",".clsPagingArea",function(){
			
			let currentPage = $(this).data("currentPage");
			let keyword = $(this).data("keyword");
			
			getList(currentPage,keyword);// 해당 페이지와 검색어로 getList 호출
		});
		
	});//end 달러function
</script>

<%@ include file="../include/footer.jsp"%>

<style>
img {
	width: 300px;
}
</style>