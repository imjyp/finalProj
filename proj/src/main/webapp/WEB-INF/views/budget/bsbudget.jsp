<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<%@ include file="../include/header.jsp"%>
<link rel="stylesheet" href="/css/common2.css">
<script src="/dist/assets/static/js/components/dark.js"></script>
<script
	src="/dist/assets/extensions/perfect-scrollbar/perfect-scrollbar.min.js"></script>
<script src="/dist/assets/compiled/js/app.js"></script>
<script src="/dist/assets/extensions/apexcharts/apexcharts.min.js"></script>
<script src="/dist/assets/static/js/pages/dashboard.js"></script>
<style>
/* 페이지네이션 위에 여백 추가 */
.card-footer {
	margin-top: 30px; /* 필요에 따라 값 조정 */
}

.btn-dark{
	color: white !important;
}
</style>

<div id="main">
	<%@ include file="../include/top.jsp"%>

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
								<li class="breadcrumb-item active"><a href="/bonsa/budget">예산관리</a></li>
							</ol>
						</nav>
					</div>
				</div>
			</div>
		</div>
		<div>
		<a href="#" id="ysgr" class="btn btn-light">예산 관리</a> <a href="#"
			id="yssy" class="btn btn-outline-light">예산 사용 내역</a>
	</div>
	<br>
	<!-- 예산 관리 시작 -->
	<div class="page-content ">
		<div class="col-sm-12 col-md-10" style="margin-left: 50px;">

			<div class="card-body ">
				<div>
					<div id="table1_wrapper"
						class="dataTables_wrapper dt-bootstrap5 no-footer">

						<div class="row dt-row">
							<div class="col-sm-12 table-responsive">
								<table class="table table-hover mb-0" id="table1"
									aria-describedby="table1_info">
									<thead style="text-align: center">
										<tr>
											<th class="sorting sorting_asc" tabindex="0"
												aria-controls="table1" rowspan="1" colspan="1"
												aria-sort="ascending"
												aria-label="price: activate to sort column descending"
												style="width: 5%;">선택</th>
											<th class="sorting sorting_asc" tabindex="0"
												aria-controls="table1" rowspan="1" colspan="1"
												aria-sort="ascending"
												aria-label="price: activate to sort column descending"
												style="width: 5%;">번호</th>

											<th class="sorting" tabindex="0" aria-controls="table1"
												rowspan="1" colspan="1"
												aria-label="year: activate to sort column ascending"
												style="width: 7%;">예산 연도</th>
											<th class="sorting sorting_asc" tabindex="0"
												aria-controls="table1" rowspan="1" colspan="1"
												aria-sort="ascending"
												aria-label="price: activate to sort column descending"
												style="width: 13%;">예산 등록액</th>
											<!--<th class="sorting sorting_asc" tabindex="0"
											aria-controls="table1" rowspan="1" colspan="1"
											aria-sort="ascending"
											aria-label="price: activate to sort column descending"
											style="width: 15%;">총 예산액</th>-->
											<th class="sorting" tabindex="0" aria-controls="table1"
												rowspan="1" colspan="1"
												aria-label="content: activate to sort column ascending"
												style="width: 10%">총 지출액</th>
											<th class="sorting" tabindex="0" aria-controls="table1"
												rowspan="1" colspan="1"
												aria-label="content: activate to sort column ascending"
												style="width: 15%">예산 잔액</th>

											<th class="sorting" tabindex="0" aria-controls="table1"
												rowspan="1" colspan="1"
												aria-label="content: activate to sort column ascending"
												style="width: 20%">내용</th>
											<th class="sorting" tabindex="0" aria-controls="table1"
												rowspan="1" colspan="1"
												aria-label="date: activate to sort column ascending"
												style="width: 10%;">예산 등록 날짜</th>

										</tr>
									</thead>
									<tbody id="tby">
										<c:forEach var="budget" items="${bgList }" varStatus="">
											<tr>
												<td style="text-align: center"><input id="no"
													value="${ budget.deptBudgetNo}" type="hidden" /> <input
													class="form-check-input" type="radio"
													name="flexRadioDefault" id="flexRadioDefault2"
													value="${budget.deptBudgetNo}"></td>
												<td style="text-align: center" class="sorting_1">${budget.rnum }</td>
												<td style="text-align: center">${budget.headBudgetYear }</td>
												<td style="text-align: right"><fmt:formatNumber
														value="${budget.headBudget}" type="number" pattern="#,###" /></td>
												<%-- <td><fmt:formatNumber value="${budget.sum}" type="number" pattern="#,###" /></td> --%>
												<td style="text-align: right"><fmt:formatNumber
														value="${budget.useTotal}" type="number" pattern="#,###" /></td>
												<td style="text-align: right"><fmt:formatNumber
														value="${budget.restBG}" type="number" pattern="#,###" /></td>
												<td style="text-align: left">${budget.headBudgetContent }</td>
												<td style="text-align: center" class="headBudgetDate">${budget.headBudgetDate}</td>
												<%-- 												<td><fmt:formatDate value="${budget.headBudgetDate }" pattern="yyyy-MM-dd"/> </td> --%>


											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
						<div class="card-footer">
							<nav aria-label="Page navigation example">
								<ul
									class="pagination pagination-warning  justify-content-center">
									<li id="divPagingArea" class="page-item">
										${articlePage.pagingArea}</li>
								</ul>
							</nav>
						</div>
						<a href="#" onclick="reg()" class="btn btn-warning rounded-pill">등록</a>
						<a href="#" onclick="edit()" class="btn btn-dark rounded-pill">수정</a>
						<a href="#" onclick="del()" class="btn btn-secondary rounded-pill">삭제</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>

	


	<!-- 모달 시작 -->
	<div class="modal fade text-left" id="modal" tabindex="-1"
		aria-labelledby="myModalLabel33" aria-modal="true" role="dialog">
		<div
			class="modal-dialog modal-dialog-centered modal-dialog-scrollable"
			role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="myModalLabel33">예산 등록</h4>
					<button type="button" class="close" onclick="mclose()"
						data-bs-dismiss="modal" aria-label="Close">
						<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
							viewBox="0 0 24 24" fill="none" stroke="currentColor"
							stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
							class="feather feather-x">
							<line x1="18" y1="6" x2="6" y2="18"></line>
							<line x1="6" y1="6" x2="18" y2="18"></line></svg>
					</button>
				</div>
				<form>
					<div class="modal-body">
						<label for="headBudgetYear">예산 연도</label>
						<div class="form-group">
							<input id="headBudgetYear" name="headBudgetYear" type="number"
								placeholder="예산 연도" class="form-control">
						</div>
						<label for="headBudget">총 예산액 </label>
						<div class="form-group">
							<input id="headBudget" name="headBudget" type="number"
								placeholder="총예산액" class="form-control">
						</div>
						<label for="headBudgetContent">내용</label>
						<div class="form-group">
							<input id="headBudgetContent" name="headBudgetContent"
								type="text" placeholder="내용" class="form-control">
						</div>

					</div>
					<div class="modal-footer" id="reg">
						<button type="button" class="btn btn-light-secondary"
							onclick="mclose()" data-bs-dismiss="modal">
							<i class="bx bx-x d-block d-sm-none"></i> <span
								class="d-none d-sm-block">취소</span>
						</button>
						<button type="button" class="btn btn-primary ms-1"
							data-bs-dismiss="modal" onclick="register()">
							<i class="bx bx-check d-block d-sm-none"></i> <span
								class="d-none d-sm-block">등록</span>
						</button>
					</div>

					<div class="modal-footer" id="ed">
						<button type="button" class="btn btn-light-secondary"
							onclick="mclose()" data-bs-dismiss="modal">
							<i class="bx bx-x d-block d-sm-none"></i> <span
								class="d-none d-sm-block">취소</span>
						</button>
						<button id="editbtn" type="button" class="btn btn-primary ms-1"
							data-bs-dismiss="modal" onclick="edit2()">
							<i class="bx bx-check d-block d-sm-none"></i> <span
								class="d-none d-sm-block">수정</span>
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
const headBudgetDate = document.querySelectorAll('.headBudgetDate');

headBudgetDate.forEach(headBudgetDate => {
const fullDate = headBudgetDate.innerText.trim();
headBudgetDate.innerText = fullDate.substring(0, 10); 
});

function del(){
	
	
	
	let selectedRow = $("input:radio[name=flexRadioDefault]:checked").closest("tr")
	console.log("체킁: ",selectedRow.find("td"));
	
	if(selectedRow.length>0){
		
		
	 	var rnum = selectedRow.find("td").eq(1).text(); 
        var headBudgetYear = selectedRow.find("td").eq(2).text(); 
      
        
//     	let deptBudgetNo = $("#no").val();
        //let headBudgetYear = $("#headBudgetYear").val();
        //기본키 구하기(jquery방법)
		let deptBudgetNo = $("input[name='flexRadioDefault']:checked").val();
		console.log("deptBudgetNo : ", deptBudgetNo);
		
    	let data={
    			deptBudgetNo:deptBudgetNo,
    			headBudgetYear:headBudgetYear
    	}
    	console.log("data:",data);
    	
    	$.ajax({
    		url:"/bonsa/delete",
    		contentType:"application/json;charset=utf-8",
    		data:JSON.stringify(data),
    		type:"post",
    		dataType:"json",
    		success:function(result){
    			if(result==1){
    				var Toast = Swal.mixin({
    				      toast: true,
    				      position: 'top-end',
    				      showConfirmButton: false,
    				      timer: 1000
    				    });
    				
    				Toast.fire({
    					icon:'success',
    					title:'삭제성공.'
    				});
    				setTimeout(()=>location.reload(),1000);
    			}
    			else{
    				alert("예산 사용내역이 있어 삭제할 수 없습니다.");
    			}
    		}
    	})
    	
	}
	else{
		var Toast = Swal.mixin({
		      toast: true,
		      position: 'top-end',
		      showConfirmButton: false,
		      timer: 1000
		    });
		
		Toast.fire({
			icon:'warning',
			title:'삭제할 항목을 선택하세요.'
		});
	}
	
	
	
	
}
	function mopen(){
		$("#modal").modal("show");
	}
	
	
	/* function mclose(){
		$("#modal").css("display","none");
	} */
	
	function reg(){
			
		mopen();
		$("#ed").css("display","none");
		$("#reg").css("display","block");
		resetModalForm(); 
	}
	
	
	$("#yssy").on('click',function(){
		location.href="/bonsa/budget/type=2";
	})


	function resetModalForm() {
	    $("#headBudgetYear").val("");
	    $("#headBudget").val("");
	    $("#headBudgetContent").val("");
	    $("input:radio[name=flexRadioDefault]").prop("checked", false); 
	}
	
	function register(){
		let headBudgetYear = $("#headBudgetYear").val();
		let headBudget = $("#headBudget").val();
		let headBudgetContent = $("#headBudgetContent").val();
		let data={
				headBudgetYear:headBudgetYear,
				headBudget:headBudget,
				headBudgetContent:headBudgetContent
		}
		console.log("data:",data);
		
		$.ajax({
			url:"/bonsa/insertBudget",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"json",
			success:function(result){
				if(result==1){
					var Toast = Swal.mixin({
					      toast: true,
					      position: 'top-end',
					      showConfirmButton: false,
					      timer: 3000
					    });
					
					Toast.fire({
						icon:'success',
						title:'등록성공.'
					});
					setTimeout(()=>location.reload(),3000);
				}
			}
		})
		
	}
	
	function edit(){
		
		let selectedRow = $("input:radio[name=flexRadioDefault]:checked").closest("tr")
		console.log("체킁: ",selectedRow.find("td"));
		
		if(selectedRow.length>0){
			mopen();
			$("#modal").css("display","block");
			$("#reg").css("display","none");
			$("#ed").css("display","block");
			
			var rnum = selectedRow.find("td").eq(1).text(); 
	        var headBudgetYear = selectedRow.find("td").eq(2).text(); 
	        var headBudget = selectedRow.find("td").eq(3).text();
	        var headBudgetDate = selectedRow.find("td").eq(4).text(); 
	        var headBudgetContent = selectedRow.find("td").eq(5).text(); 
	        var restBG = selectedRow.find("td").eq(6).text();
	        console.log("선택된 예산 번호: " + rnum);
	        console.log("선택된 예산 연도: " + headBudgetYear);
	        console.log("선택된 총 예산액: " + headBudget);
	        console.log("선택된 예산 등록 날짜: " + headBudgetDate);
	        console.log("선택된 예산 내용: " + headBudgetContent);
	        console.log("선택된 예산 잔액: " + restBG);
	        $("#headBudgetYear").val(headBudgetYear);
	        $("#headBudget").val(headBudget.replace(/,/g, ''));  
	        $("#headBudgetContent").val(headBudgetContent); 
		}
		else{
			var Toast = Swal.mixin({
			      toast: true,
			      position: 'top-end',
			      showConfirmButton: false,
			      timer: 3000
			    });
			
			Toast.fire({
				icon:'warning',
				title:'수정할 항목을 선택하세요.'
			});
		}
		
	}
	
	
function edit2(){
	let headBudgetYear = $("#headBudgetYear").val();
	let headBudget = $("#headBudget").val();
	let headBudgetContent = $("#headBudgetContent").val();
	let deptBudgetNo = $("#no").val();
	let data={
			headBudgetYear:headBudgetYear,
			headBudget:headBudget,
			headBudgetContent:headBudgetContent,
			deptBudgetNo:deptBudgetNo
	}
	console.log("data:",data);
	
	$.ajax({
		url:"/bonsa/updateBudget",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(data),
		type:"post",
		dataType:"json",
		success:function(result){
			if(result==1){
				var Toast = Swal.mixin({
				      toast: true,
				      position: 'top-end',
				      showConfirmButton: false,
				      timer: 3000
				    });
				
				Toast.fire({
					icon:'success',
					title:'수정성공.'
				});
				setTimeout(()=>location.reload(),3000);
			}
		}
	})
	
}
	
</script>