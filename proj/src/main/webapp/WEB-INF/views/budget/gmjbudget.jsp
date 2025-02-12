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
  
  
.btn-dark{
	color: white !important;
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
								<li class="breadcrumb-item active"><a href="/gmj/gmj${storeNo }/budget">예산 관리</a></li>
							</ol>
						</nav>
					</div>
				</div>
			</div>
		</div>
	</div>
   
				<div>
		<a href="#" id="ysgr" class="btn btn-light">예산 관리</a>
		<a href="#" id="yssy" class="btn btn-outline-light">예산 사용 내역</a>
	</div>
	<br>
	<!-- 예산 관리 시작 -->
	<div class="page-content">
	<div class="col-sm-12 col-md-10" style="margin-left:50px;">
			<div class="card-body">
				<div >
					<div id="table1_wrapper" class="dataTables_wrapper dt-bootstrap5 no-footer">
						<div class="row dt-row">
							<div class="col-sm-12 table-responsive">
								<table class="table table-hover mb-0" id="table1" aria-describedby="table1_info">
									<thead style="text-align:center">
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
												style="width: 10%;">예산 연도</th>
											<th class="sorting sorting_asc" tabindex="0"
												aria-controls="table1" rowspan="1" colspan="1"
												aria-sort="ascending"
												aria-label="price: activate to sort column descending"
												style="width: 15%;">총 예산액</th>
											<th class="sorting" tabindex="0" aria-controls="table1"
												rowspan="1" colspan="1"
												aria-label="content: activate to sort column ascending"
												style="width: 15%">총 지출액</th>
											
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
												style="width: 15%;">예산 등록 날짜</th>
										</tr>
									</thead>
									<tbody id="tby">
										<c:forEach var="budget" items="${bgList }" varStatus="">
											<tr>
												<td style="text-align:center"><input id="no" value="${ budget.storeBudgetNo}" type="hidden"/>
												<input class="form-check-input" type="radio" 
												name="flexRadioDefault" id="flexRadioDefault2" ></td>
												<td style="text-align:center" class="sorting_1">${budget.rnum }</td>
												<td style="text-align:center" >${budget.storeBudgetYear }</td>
												<td style="text-align:right"><fmt:formatNumber value="${budget.storeBudget}" type="number" pattern="#,###" /></td>
												<td style="text-align:right"><fmt:formatNumber value="${budget.useTotal}" type="number" pattern="#,###" /></td>
												 <td style="text-align:right"><fmt:formatNumber value="${budget.restBG}" type="number" pattern="#,###" /></td>
												<td style="text-align:left">${budget.storeBudgetContent }</td>
												<td style="text-align:center" class="storeBudgetDate">${budget.storeBudgetDate}</td>
<%-- 												<td><fmt:formatDate value="${budget.storeBudgetDate }" pattern="yyyy-MM-dd"/> </td> --%>
												
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
		                        		${articlePage.pagingArea} 
									</li>
		                    	</ul>
		                	</nav>
		                	</div>
						<a href="#" onclick="reg()" class="btn btn-warning ms-1">등록</a>
						<a href="#" onclick="edit()" class="btn btn-dark ms-1">수정</a>
					</div>
				</div>
			</div>
		</div>
	</div>
		<%-- <p>${storeNo }</p> --%>
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
	function mopen(){
		//모달창 띄워
		$("#modal").css("display","block");
	}
	function mclose(){
		$("#modal").css("display","none");
	}
	
	function reg(){
		mopen();
		$("#ed").css("display","none");
		$("#reg").css("display","block");
		resetModalForm(); 
	}
	
	$("#yssy").on('click',function(){
		location.href="/gmj/gmj"+storeNo+"/budget/type=2";
	})
	

	function resetModalForm() {
	    $("#storeBudgetYear").val("");
	    $("#storeBudget").val("");
	    $("#storeBudgetContent").val("");
	    $("input:radio[name=flexRadioDefault]").prop("checked", false); 
	}
	
	function register(){
		let storeBudgetYear = $("#storeBudgetYear").val();
		let storeBudget = $("#storeBudget").val();
		let storeBudgetContent = $("#storeBudgetContent").val();
		let data={
				storeBudgetYear:storeBudgetYear,
				storeBudget:storeBudget,
				storeBudgetContent:storeBudgetContent
		}
		console.log("data:",data);
		
		$.ajax({
			url:"/gmj"+storeNo+"/insertBudget",
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
			$("#modal").css("display","block");
			$("#reg").css("display","none");
			$("#ed").css("display","block");
			
			var rnum = selectedRow.find("td").eq(1).text(); 
	        var storeBudgetYear = selectedRow.find("td").eq(2).text(); 
	        var storeBudget = selectedRow.find("td").eq(3).text();
	        var storeBudgetDate = selectedRow.find("td").eq(4).text(); 
	        var storeBudgetContent = selectedRow.find("td").eq(5).text(); 
	        var restBG = selectedRow.find("td").eq(6).text();
	        console.log("선택된 예산 번호: " + rnum);
	        console.log("선택된 예산 연도: " + storeBudgetYear);
	        console.log("선택된 총 예산액: " + storeBudget);
	        console.log("선택된 예산 등록 날짜: " + storeBudgetDate);
	        console.log("선택된 예산 내용: " + storeBudgetContent);
	        console.log("선택된 예산 잔액: " + restBG);
	        $("#storeBudgetYear").val(storeBudgetYear);
	        $("#storeBudget").val(storeBudget.replace(/,/g, ''));  
	        $("#storeBudgetContent").val(storeBudgetContent); 
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
	
	let storeBudgetYear = $("#storeBudgetYear").val();
	let storeBudget = $("#storeBudget").val();
	let storeBudgetContent = $("#storeBudgetContent").val();
	let storeBudgetNo = $("#no").val();
	let data={
			storeBudgetYear:storeBudgetYear,
			storeBudget:storeBudget,
			storeBudgetContent:storeBudgetContent,
			storeBudgetNo:storeBudgetNo
	}
	console.log("data:",data);
	
	$.ajax({
		url:"/gmj"+storeNo+"/updateBudget",
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



