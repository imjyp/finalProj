<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<%@ include file="../include/header.jsp"%>

<script src="/dist/assets/static/js/components/dark.js"></script>
<script src="/dist/assets/extensions/perfect-scrollbar/perfect-scrollbar.min.js"></script>
<script src="/dist/assets/compiled/js/app.js"></script>
<script src="/dist/assets/extensions/apexcharts/apexcharts.min.js"></script>
<script src="/dist/assets/static/js/pages/dashboard.js"></script>
<link rel="stylesheet" href="/css/common2.css">
<link rel="stylesheet" href="/dist/assets/compiled/css/app-dark.css">
<link rel="stylesheet" href="/dist/assets/compiled/css/iconly.css">

<style>
  /* 페이지네이션 위에 여백 추가 */
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
								<li class="breadcrumb-item active"><a href="/gmj/gmj${storeNo }/budget/type=2">예산 사용내역</a></li>
							</ol>
						</nav>
					</div>
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
					                <option value="${year.storeBudgetYear}">${year.storeBudgetYear}</option>
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
											<th class="sorting sorting_asc" tabindex="0"
													aria-controls="table1" rowspan="1" colspan="1"
													aria-sort="ascending"
													aria-label="price: activate to sort column descending"
													style="width: 7%;">번호</th>
												<th class="sorting" tabindex="0" aria-controls="table1"
														rowspan="1" colspan="1"
														aria-label="date: activate to sort column ascending"
														style="width: 15%;">사용 날짜</th>
												<th class="sorting" tabindex="0" aria-controls="table1"
													rowspan="1" colspan="1"
													aria-label="year: activate to sort column ascending"
													style="width: 15%;">지출액</th>
												<th class="sorting sorting_asc" tabindex="0"
													aria-controls="table1" rowspan="1" colspan="1"
													aria-sort="ascending"
													aria-label="price: activate to sort column descending"
													style="width: 15%;">예산 잔액</th>
												<th class="sorting" tabindex="0" aria-controls="table1"
													rowspan="1" colspan="1"
													aria-label="content: activate to sort column ascending"
													style="width: 7%">입/출금</th>
												<th class="sorting" tabindex="0" aria-controls="table1"
													rowspan="1" colspan="1"
													aria-label="content: activate to sort column ascending"
													style="width: 20%">내용</th>
											</tr>
										</thead>
										<tbody id="tby">
											<c:forEach var="budget" items="${bgList2 }" >
												<tr>
													<td style="text-align:center" class="sorting_1">${budget.rnum }</td>
													<td style="text-align:center" class="storeBudgetDate">${budget.storeBudgetDate}</td>
<%-- 													<td><fmt:formatDate value="${budget.storeBudgetDate }" pattern="yyyy-MM-dd"/> </td> --%>
													<td style="text-align:right" ><fmt:formatNumber value="${budget.storeBudget}" type="number" pattern="#,###" /></td>
													<td style="text-align:right"><fmt:formatNumber value="${budget.restBG}" type="number" pattern="#,###" /></td>
													<td style="text-align:center">
														<c:if test="${budget.storeBudgetTy  eq 1}"><span class="badge bg-success">입금</span></c:if>
														<c:if test="${budget.storeBudgetTy  eq 2}"><span class="badge bg-warning">출금</span></c:if>
													</td>
													<td style="text-align:left">${budget.storeBudgetContent }</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
							<div class="card-footer">
							<nav aria-label="Page navigation example">
		                    	<ul class="pagination pagination-warning  justify-content-center">
		                        	<li id="divPagingArea"class="page-item">
		                        		${articlePage2.pagingArea} 
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
	

<!-- 모달 시작 -->
 <div class="modal fade text-left show" id="modal" tabindex="-1" style="display:none"aria-labelledby="myModalLabel33" aria-modal="true" role="dialog">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel33">예산 등록 </h4>
                <button type="button" class="close" onclick="mclose()" data-bs-dismiss="modal" aria-label="Close">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-x"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>
                </button>
            </div>
            <form >
            
                <div class="modal-body">
                    <label for="storeBudgetYear">예산 연도</label>
                    <div class="form-group">
                        <input id="storeBudgetYear" name="storeBudgetYear" type="number" placeholder="예산 연도" class="form-control">
                    </div>
                    <label for="storeBudget">총 예산액 </label>
                    <div class="form-group">
                        <input id="storeBudget" name="storeBudget" type="number" placeholder="총예산액" class="form-control">
                    </div>
                    <label for="storeBudgetContent">내용</label>
                    <div class="form-group">
                        <input id="storeBudgetContent" name="storeBudgetContent" type="text" placeholder="내용" class="form-control">
                    </div>
                    
                </div>
                <div class="modal-footer" id="reg">
                    <button type="button" class="btn btn-light-secondary" onclick="mclose()"  data-bs-dismiss="modal">
                        <i class="bx bx-x d-block d-sm-none"></i>
                        <span class="d-none d-sm-block">취소</span>
                    </button>
                    <button type="button" class="btn btn-primary ms-1" data-bs-dismiss="modal" onclick="register()">
                        <i class="bx bx-check d-block d-sm-none"></i>
                        <span class="d-none d-sm-block">등록</span>
                    </button>
                  </div>  
                  
                  <div class="modal-footer" id="ed">
                    <button type="button" class="btn btn-light-secondary" onclick="mclose()"  data-bs-dismiss="modal">
                        <i class="bx bx-x d-block d-sm-none"></i>
                        <span class="d-none d-sm-block">취소</span>
                    </button>
                    <button id="editbtn" type="button" class="btn btn-primary ms-1" data-bs-dismiss="modal" onclick="edit2()">
                        <i class="bx bx-check d-block d-sm-none"></i>
                        <span class="d-none d-sm-block">수정</span>
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>




<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>

//날짜 형식
const storeBudgetDate = document.querySelectorAll('.storeBudgetDate');

storeBudgetDate.forEach(storeBudgetDate => {
const fullDate = storeBudgetDate.innerText.trim();
storeBudgetDate.innerText = fullDate.substring(0, 10); 
});

let storeNo = ${storeNo};
$("#ysgr").on('click',function(){
	location.href="/gmj/gmj"+storeNo+"/budget";
})
		
$("#reset").on('click',function(){
	data={};
	console.log("초기화됐낭?",data);
	$("#search").click();
	 $("#yearSelect").val("년도선택"); // 년도 선택 초기화
    $("#typeSelect").val("입출금 선택"); 
	
})	
let data={};
	    
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

		
$("#search").on('click',function(){
	data.currentPage="1";
	data.keyword="";
	console.log("Data",data);
	
	
	$.ajax({
		url:"/gmj"+storeNo+"/budgetList",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(data),
		type:"post",
		dataType:"json",
		success:function(articlePage){	
			console.log("articlePage.content : ", articlePage.content);
			let str = "";
			$.each(articlePage.content, function(idx,budget){
				const formattedDate = formatDate(budget.storeBudgetDate);
                const formattedstoreBudget = formatNumber(budget.storeBudget);
                const formattedRestBG = formatNumber(budget.restBG);
                const transactionType = (budget.storeBudgetTy === 1) ? "입금" : (budget.storeBudgetTy === 2) ? "출금" : "";

                str += `<tr>
                    <td style="text-align:center">\${budget.rnum}</td>
                    <td style="text-align:center">\${formattedDate}</td>
                    <td style="text-align:right">\${formattedstoreBudget}</td>
                    <td style="text-align:right">\${formattedRestBG}</td>
                    <td style="text-align:center"><span class="badge \${budget.storeBudgetTy === 1 ? 'bg-success' : 'bg-warning'}">\${transactionType}</span></td>
                    <td style="text-align:left"> \${budget.storeBudgetContent}</td>
                </tr>`;

			});		
			
			$("#tby").html(str);
			$("#divPagingArea").html(articlePage.pagingArea);
		}
	})
})
function formatDate(date) { 
    const d = new Date(date);
	return d.toLocaleDateString();
}

function formatNumber(num) { //천단위
    return num.toLocaleString(); 
}


	
</script>



