<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<%@ include file="../include/header.jsp"%>
<link rel="stylesheet" href="/css/common2.css">
<script src="/dist/assets/static/js/components/dark.js"></script>
<script src="/dist/assets/extensions/perfect-scrollbar/perfect-scrollbar.min.js"></script>
<script src="/dist/assets/compiled/js/app.js"></script>
<script src="/dist/assets/extensions/apexcharts/apexcharts.min.js"></script>
<script src="/dist/assets/static/js/pages/dashboard.js"></script>

<style>
  .card-footer {
    margin-top: 30px; /* 필요에 따라 값 조정 */
  }
  </style>
<div id="main">
<%@ include file="../include/top.jsp" %>

	<div class="card">
		<div class="card-header">
			<div class="container-fluid">

				<header class="mb-3">
					<a href="#" class="burger-btn d-block d-xl-none"> <i
						class="bi bi-justify fs-3"></i>
					</a>
				</header>
				<div class="page-heading row"
					style="margin-top: 130px; margin-bottom: 0px">

					<div class="col-6 d-flex align-items-center">
						<nav aria-label="breadcrumb" class="ms-3">
							<ol class="breadcrumb mb-0">
								<li class="breadcrumb-item"><a href="/main">Home</a></li>
								<li class="breadcrumb-item active"><a href="/bonsa/budget/type=2">예산사용내역</a></li>
							</ol>
						</nav>
					</div>
				</div>
			</div>
		</div>
		<div>
		<a href="#" id="ysgr" class="btn btn-outline-light">예산 관리</a>
		<a href="#" id="yssy" class="btn btn-light">예산 사용 내역</a>
	</div>
	<br>
	<!-- 예산 관리 시작 -->
	<div class="page-content">
	<div class="col-sm-12 col-md-10" style="margin-left:50px;">
				<div class="card-body">
				<div class="row">
					    <fieldset class="col-2 form-group">
					        <select class="form-select" id="yearSelect">
					            <option>년도선택</option>
					            <c:forEach var="year" items="${yearList}">
					                <option value="${year.headBudgetYear}">${year.headBudgetYear}</option>
					            </c:forEach>
					        </select>
					    </fieldset>
					
					    <fieldset class="col-2 form-group">
					        <select class="form-select" id="typeSelect">
					            <option>입출금 선택</option>
					            <option value="1">입금</option>
					            <option value="2">출금</option>
					        </select>
					    </fieldset>
					    <a href="#" class="btn btn-outline-light" style="height:35px; width:100px" id="search">조회</a>
	                    <a href="#" class="btn btn-outline-light "  style="height:35px;width:150px"id="reset">선택초기화</a>
					</div>
					
	                
						<div id="table1_wrapper"
							class="dataTables_wrapper dt-bootstrap5 no-footer">
							<div class="row dt-row">
								<div class="col-sm-12 table-responsive">
									<table class="table table-hover mb-0" id="table1"
										aria-describedby="table1_info">
										<thead style="text-align:center">
											<tr>
											<th  tabindex="0"
													aria-controls="table1" rowspan="1" colspan="1"
													aria-sort="ascending"
													aria-label="price: activate to sort column descending"
													style="width: 7%;">번호</th>
												<th tabindex="0" aria-controls="table1"
														rowspan="1" colspan="1"
														aria-label="date: activate to sort column ascending"
														style="width: 15%;">사용 날짜</th>
												<th tabindex="0" aria-controls="table1"
													rowspan="1" colspan="1"
													aria-label="year: activate to sort column ascending"
													style="width: 15%;">지출액</th>
												<th tabindex="0"
													aria-controls="table1" rowspan="1" colspan="1"
													aria-sort="ascending"
													aria-label="price: activate to sort column descending"
													style="width: 15%;">예산 잔액</th>
												<th tabindex="0" aria-controls="table1"
													rowspan="1" colspan="1"
													aria-label="content: activate to sort column ascending"
													style="width: 7%">입/출금</th>
												<th  tabindex="0" aria-controls="table1"
													rowspan="1" colspan="1"
													aria-label="content: activate to sort column ascending"
													style="width: 20%">내용</th>
											</tr>
										</thead>
										<tbody id="tby">
										<!-- 
											<c:forEach var="budget" items="${bgList2 }" >
												<tr>
													<td class="sorting_1">${budget.rnum }</td>
													<td class="headBudgetDate">${budget.headBudgetDate}</td>
<%-- 													<td><fmt:formatDate value="${budget.headBudgetDate }" pattern="yyyy-MM-dd"/> </td> --%>
													<td ><fmt:formatNumber value="${budget.headBudget}" type="number" pattern="#,###" /></td>
													<td><fmt:formatNumber value="${budget.restBG}" type="number" pattern="#,###" /></td>
													<td>
														<c:if test="${budget.headBudgetTy  eq 1}">입금</c:if>
														<c:if test="${budget.headBudgetTy  eq 2}">출금</c:if>
													</td>
													<td>${budget.headBudgetContent }</td>
												</tr>
											</c:forEach>
											 -->
										</tbody>
									</table>
								</div>
							</div>
							<div class="card-footer">
							<nav aria-label="Page navigation example">
		                    	<ul class="pagination pagination-warning  justify-content-center">
		                        	<li id="divPagingArea"class="page-item">
		                        		<%-- ${articlePage2.pagingArea}  --%>
									</li>
		                    	</ul>
		                	</nav>
		                	</div>
						</div>
					</div>
				</div>
		</div>
	</div>
	</div>
	
</body>
</html>


<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>

// 날짜 형식
const headBudgetDate = document.querySelectorAll('.headBudgetDate');

headBudgetDate.forEach(headBudgetDate => {
const fullDate = headBudgetDate.innerText.trim();
headBudgetDate.innerText = fullDate.substring(0, 10); 
});

$("#dropdownMenuButton1").on('click',function(){
	alert("gd");
})
	
	

$("#reset").on('click',function(){
	data={};
	console.log("초기화됐낭?",data);
	$("#search").click();
	 $("#yearSelect").val("년도선택"); // 년도 선택 초기화
    $("#typeSelect").val("입출금 선택"); 
	
})	
	
$("#ysgr").on('click',function(){
	location.href="/bonsa/budget";
})
	
let data={keyword:"",
	currentPage:"1"};
	
$(document).ready(function() {

	$("#yearSelect").on("change", function() {
	    const year = $(this).val(); // 선택된 년도
	    console.log("선택된 년도: " + year);
	    data.year = year;
	});

	$("#typeSelect").on("change", function() {
	    const type = $(this).val(); // 선택된 입출금
	    console.log("선택된 입출금: " + type);
	    data.type = type;
	});

});
	 
list();

function list(){
	$.ajax({
		url:"/bonsa/budgetList",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(data),
		type:"post",
		dataType:"json",
		success:function(articlePage){	
			console.log("articlePage.content : ", articlePage.content);
			let str = "";
			$.each(articlePage.content, function(idx,budget){
				const formattedDate = formatDate(budget.headBudgetDate);
                // 금액 천 단위 콤마 처리
                const formattedHeadBudget = formatNumber(budget.headBudget);
                const formattedRestBG = formatNumber(budget.restBG);
                // 입출금 처리
                const transactionType = (budget.headBudgetTy === 1) ? "입금" : (budget.headBudgetTy === 2) ? "출금" : "";

                str += `<tr>
                    <td style="text-align:center">\${budget.rnum }</td>
                    <td style="text-align:center">\${formattedDate}</td>
                    <td style="text-align:right">\${formattedHeadBudget}</td>
                    <td style="text-align:right">\${formattedRestBG}</td>
                    <td style="text-align:center">
                        <span class="badge \${budget.headBudgetTy === 1 ? 'bg-success' : 'bg-warning'}">\${transactionType}</span>
                    </td>
                    <td style="text-align:left">\${budget.headBudgetContent}</td>
                </tr>`;

			});		
			
			$("#tby").html(str);
			$("#divPagingArea").html(articlePage.pagingArea);
		}
	})
}
		
$("#search").on('click',function(){
	data.currentPage="1";
	data.keyword="";
	console.log("Data",data);
	list();
	
})
function formatDate(date) {
    const d = new Date(date);
    const year = d.getFullYear();
    const month = String(d.getMonth() + 1).padStart(2, '0');
    const day = String(d.getDate()).padStart(2, '0');
    return `\${year}-\${month}-\${day}`;
}
	
function formatNumber(num) { //천단위
    return num.toLocaleString(); 
}
	
</script>



