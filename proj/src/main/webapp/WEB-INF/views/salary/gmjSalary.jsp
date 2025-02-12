<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<script src="/dist/assets/static/js/components/dark.js"></script>
<script src="/dist/assets/extensions/perfect-scrollbar/perfect-scrollbar.min.js"></script>
<script src="/dist/assets/compiled/js/app.js"></script>
<script src="/dist/assets/extensions/apexcharts/apexcharts.min.js"></script>
<script src="/dist/assets/static/js/pages/dashboard.js"></script>
<link rel="stylesheet" href="/css/common2.css">
<link rel="stylesheet" href="/dist/assets/compiled/css/app-dark.css">
<link rel="stylesheet" href="/dist/assets/compiled/css/iconly.css">
<%@ include file="../include/header.jsp"%>

<style>
.tableType01 tr:hover {
	transform: translateY(-3px); 
	box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1); 
	cursor: pointer !important;
}

 /* 모달 크기 조정 */
  #large .modal-dialog {
    max-width: 900px; /* 모달의 너비를 키움 */
  }
  
  /* 글씨 크기 조정 */
  #large .form-label,
  #large input,
  #large p,
  #large h5 {
    font-size: 15px; /* 글씨 크기 키움 
  }
*/
  #large h3 {
    font-size: 20px; /* 사용자 이름 글씨 크기 */
  }
  

  #large p.text-small {
    font-size: 14px; /* 소형 글씨 크기 */
  }
  
  /* 검색 폼 아래에 여백 추가 */
  .dataTable-top {
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
	<div class="page-heading row"style="margin-top:130px; margin-bottom:0px">
	
	<div class="col-6 d-flex align-items-center">
	          <nav aria-label="breadcrumb" class="ms-3">
	            <ol class="breadcrumb mb-0">
	              <li class="breadcrumb-item"><a href="/main">Home</a></li>
	              <li class="breadcrumb-item active"><a href="/gmj/gmj${storeNo }/salary">급여 지급 관리</a></li>
	            </ol>
	          </nav>
	        </div>
	<div class="col-6 d-flex justify-content-end" style="float:right">
	        
	          <div class="d-flex flex-nowrap" style="overflow-x: auto; width: 100%; margin-left:90px"">
	            <div class="card text-center me-2" style="width: 150px;">
	              <div class="card-header bg-secondary text-black py-1 px-2 fw-bold">
	                시급
	              </div>
	              <div class="card-body py-1">
	                <h6 id="approvalCnt" class="mb-0">10,000</h6>
	              </div>
	            </div>
	            
	            <div class="card text-center me-2" style="width: 150px;">
	              <div class="card-header bg-secondary text-black py-1 px-2 fw-bold">
	                매니저
	              </div>
	              <div class="card-body py-1">
	                <h6 id="pendingCnt" class="mb-0">2,000,000</h6>
	              </div>
	            </div>
	          </div> <!-- /.d-flex.flex-nowrap -->
	        </div> <!-- /.col-md-6.d-flex.justify-content-end -->
				
	</div>
	<div class="card-content">

		<section class="section">
			<div class="card">
				<div class="card-body">
					<div class="table datatable-minimal">
						<div id="table2_wrapper"
							class="dataTables_wrapper dt-bootstrap5 no-footer">
							<div style="display: flex; align-items: center; gap: 10px; width: 100%;">
								<div >
									<fieldset class="form-group">
                                        <select class="form-select" id="year">
                                        <option value="none">== 년도 선택 ==</option>
                                        	<c:forEach var="y" items="${year }">
                                            	<option value="${y.year }">${y.year }</option>
                                           	</c:forEach>
                                        </select>
                                        </fieldset>
                                </div>
                                <div>
                                        <fieldset class="form-group">
                                        <select class="form-select" id="month">
                                        <option value="none">== 월 선택 ==</option>
                                        	<c:forEach var="m" items="${month }">
                                            	<option value="${m.month }">${m.month }</option>
                                           </c:forEach>
                                        </select>
                                    </fieldset>
								</div>
								<div >
									<div id="table2_filter" class="dataTables_filter">
										<label><input type="search" id="search" value="${param.keyword }"
											class="form-control form-control-sm" placeholder="Search.."
											aria-controls="table2"></label>
											<a href="#" id="searchBtn" class="btn btn-warning rounded-pill">조회</a>
									</div>
								</div>
							</div>
							<div class="row dt-row">
								<div class="col-sm-12 tableType01" >
									<table class="table dataTable no-footer board" id="table1"
										aria-describedby="table2_info">
										<thead  style="text-align:center">
											<tr>
												<th class="sorting sorting_asc" tabindex="0"
													aria-controls="table2" rowspan="1" colspan="1"
													aria-sort="ascending"
													aria-label="Name: activate to sort column descending"
													style="width: 7%">번호</th>
												<th class="sorting" tabindex="0" aria-controls="table2"
													rowspan="1" colspan="1"
													aria-label="Email: activate to sort column ascending"
													style="width: 10%">사진</th>
												<th class="sorting" tabindex="0" aria-controls="table2"
													rowspan="1" colspan="1"
													aria-label="Email: activate to sort column ascending"
													style="width: 12%">직책</th>
												<th class="sorting" tabindex="0" aria-controls="table2"
													rowspan="1" colspan="1"
													aria-label="Email: activate to sort column ascending"
													style="width: 12%">회원명</th>
												
												<th class="sorting" tabindex="0" aria-controls="table2"
													rowspan="1" colspan="1"
													aria-label="City: activate to sort column ascending"
													style="width: 15%">급여 금액</th>
												<th class="sorting" tabindex="0" aria-controls="table2"
													rowspan="1" colspan="1"
													aria-label="Phone: activate to sort column ascending"
													style="width: 10%">세율</th>
												<th class="sorting" tabindex="0" aria-controls="table2"
													rowspan="1" colspan="1"
													aria-label="Phone: activate to sort column ascending"
													style="width: 15%">실수령액</th>
												<th class="sorting" tabindex="0" aria-controls="table2"
													rowspan="1" colspan="1"
													aria-label="Phone: activate to sort column ascending"
													style="width: 20%">지급 날짜</th>
											</tr>
										</thead>
										<tbody id="tby">
											<%-- <c:forEach var="salary" items="${salaryList }">
												<tr class="odd">
													<td class="sorting_1">${salary.rnum }</td>
													<td>${salary.userNm }</td>
													<td>${salary.salPymntDate }</td>
													<td>${salary.salAmount }</td>
												</tr>
											</c:forEach> --%>
										</tbody>
									</table>
								</div>
							</div>
							<div style="float:right;">
								 <a href="#" class="btn btn-dark rounded-pill" id="send" >급여 지급</a>  
							</div>
							
							<div class="card-footer">
							<nav aria-label="Page navigation example">
		                        <ul class="pagination pagination-warning  justify-content-center">
		                            <li id="divPagingArea"class="page-item">
		                            </li>
		                        </ul>
		                    </nav>
		                   </div> 
		                    
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>
</div>
</div>

<div class="modal fade text-left show" id="large" tabindex="-1" role="dialog" aria-labelledby="myModalLabel17" aria-modal="true" style="display: none;">
     <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg" role="document">
         <div class="modal-content">
             <div class="modal-header">
                 <h4 class="modal-title" id="myModalLabel17">급여 지급</h4>
                 <button type="button" class="close" data-bs-dismiss="modal" onclick="mclose()"aria-label="Close">
                     <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-x"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>
                 </button>
             </div>
             <div class="modal-body">
                
             </div>
             <div class="modal-footer">
             	<button type="button" class="btn btn-warning" onclick="payAll()" data-bs-dismiss="modal">
                     <i class="bx bx-x d-block d-sm-none"></i>
                     <span class="d-none d-sm-block">일괄지급</span>
                 </button>
                 <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                     <i class="bx bx-x d-block d-sm-none"></i>
                     <span class="d-none d-sm-block">닫기</span>
                 </button>
             </div>
         </div>
     </div>
 </div>


<style>
.avatar{
	width:40px;
	height:40px;
}
</style>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>
<%@ include file="../include/footer.jsp"%>
<script>


let data = {
		"currentPage":"1",
		"keyword":"",
		"year":"",
		"month":"",
		"storeNo": ${storeNo}
};

ajax($("#search").val(),1);

function mopen(){
	//$("#large").css("display","block");
	let myModal = new bootstrap.Modal(document.getElementById('large'), {
	    backdrop: true 
		});
		myModal.show();
}

$("#send").on('click',function(){
	mopen();
	let m=`<div class="col-12">
        <div class="card widget-todo">
        <div class="card-header border-bottom d-flex justify-content-between align-items-center">
            <h4 class="card-title d-flex">
                <i class="bx bx-check font-medium-5 pl-25 pr-75"></i>회원목록
            </h4>
        </div>
        <div class="table-responsive" >
        <table class="table table-hover mb-0">
            <thead style="text-align:center">
                <tr>
                    <th>이름</th>
                    <th>전화번호</th>
                    <th>직책</th>
                    <th>사진</th>
                </tr>
            </thead>
            <tbody id="bdy">
            <c:forEach var="emp" items="${empList }">
                <tr  style="cursor:pointer;" class="trEmp">
                	<input id="userNo" type="hidden" value="${emp.userNo}">
                    <td style="text-align:center" class="text-bold-500">${emp.userNm}</td>
                    <td style="text-align:center" >\${formatphone('${emp.userPhone}')}</td>
                    <td style="text-align:center">${emp.positionNm}</td>
                    <td style="text-align:center"><img class="avatar" src="/resources${emp.profile}" alt="" srcset=""></td>
                </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    </div>
</div>`;
    $(".modal-body").html(m);
	
})

function formatphone(phone){
	const digits = phone.replace(/\D/g, '');
    
    if (digits.length === 11) {
        return digits.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
    } else if (digits.length === 10) {
        return digits.replace(/(\d{3})(\d{3})(\d{4})/, '$1-$2-$3');
    }
    return phone;
}

function payAll(){
	console.log("지급?",data);
	
	$.ajax({
		url:"/payAllGMJ",
		type:"post",
		contentType: "application/json",  // JSON 포맷으로 전송
        dataType: "json",
		data:JSON.stringify(data),
		success:function(resp){
			console.log("지급됐나용?",resp);
			if(resp){
        		$("#swal2-input").val("");
        		var Toast = Swal.mixin({
				      toast: true,
				      position: 'top-end',
				      showConfirmButton: false,
				      timer: 1000
				    });
				
				Toast.fire({
					icon:'success',
					title:'지급완'
				});
				setTimeout(()=>location.reload(),1000);
        	}
			else{
				$("#swal2-input").val("");
        		var Toast = Swal.mixin({
				      toast: true,
				      position: 'top-end',
				      showConfirmButton: false,
				      timer: 1000
				    });
				
				Toast.fire({
					icon:'warning',
					title:'이번달 근무한 직원이 없습니다.'
				});
				setTimeout(()=>location.reload(),1000);
			}
		}
	})
}

function nvl(exp1, exp2){
	if(exp1 === undefined || exp1 == null || exp1 == ""){
		exp1 = exp2;
	}
	return exp1;
}


function formatNumber(num) { //천단위
    return num.toLocaleString(); 
}

function ajax(keyword, currentPage) {
   data = {
        "keyword": nvl(keyword, ""),
        "currentPage": nvl(currentPage, "1"),
        "storeNo": ${storeNo}
    };

    console.log("ajax에 왔다, data : ", data);

    $.ajax({
        url: "/salarylist",
        type: "POST",
        contentType: "application/json",  // JSON 포맷으로 전송
        dataType: "json",  // 응답으로 JSON을 기대
        data: JSON.stringify(data),  // data를 JSON 문자열로 변환
        success: function (resp) {
            console.log("resp:", resp);

            let tbl = "";
            $.each(resp.content, function (idx, map) {
            	const fsalAmount = formatNumber(map.salAmount);
            	const fsalTax = formatNumber(map.afterTax);
            	const fDty = map.duty+"%";
            	
                tbl += `<tr>
                            <td class="noline" style="text-align:center">\${map.rnum}</td>
                            <td class="noline" style="text-align:center"><img class="avatar" src="/resources\${map.profile}"></td>
                            <td class="noline" style="text-align:center">\${map.positionNm}</td>
                            <td class="noline" style="text-align:center">\${map.userNm}</td>
                            <td class="noline" style="text-align:right">\${fsalAmount}</td>
                            <td class="noline" style="text-align:center">\${fDty}</td>
                            <td class="noline" style="text-align:right">\${fsalTax}</td>
                            <td class="noline" style="text-align:center">\${map.salPymntDate}</td>
                         </tr>`;
            });
            $("#tby").html(tbl);
            $("#divPagingArea").html(resp.pagingArea);
        }
    });
}


$(document).ready(function() {

    $("#year").on('change', function() {
        let yearValue = $(this).val();
        if (yearValue != 'none') {
            console.log("년도 선택 값:", yearValue);
            data.year = yearValue;
            console.log("data", data);
            $.ajax({
            	url:"/salarylist",
        		type:"post",
        		contentType: "application/json", 
                dataType: "json",  
                data: JSON.stringify(data), 
                success: function (resp) {
                	console.log("resp:", resp);

                	let tbl = "";
                    $.each(resp.content, function (idx, map) {
                    	const fsalAmount = formatNumber(map.salAmount);
                    	const fdate = nvl(map.salModifyDate,"-");
                    	const fsalTax = formatNumber(map.afterTax);
                    	const fDty = map.duty+"%";
                        tbl += `<tr class="tr" style="cursor:pointer;" >
                        	<td>\${map.rnum}</td>
                            <td><img class="avatar" src="/resources\${map.profile}"></td>
                            <td>\${map.positionNm}</td>
                            <td>\${map.userNm}</td>
                            <td>\${fsalAmount}</td>
                            <td>\${fDty}</td>
                            <td>\${fsalTax}</td>
                            <td>\${map.salPymntDate}</td>
                                 </tr>`;
                   	});
                    $("#tby").html(tbl);
                    $("#divPagingArea").html(resp.pagingArea);
            	}
            })
        } else {
            data.year = null; 
        }
    });

    $("#month").on('change', function() {
        let monthValue = $(this).val();
        if (monthValue != 'none') {
            console.log("월 선택 값:", monthValue);
            data.month = monthValue;
            console.log("data", data);
            
            $.ajax({
            	url:"/salarylist",
        		type:"post",
        		contentType: "application/json", 
                dataType: "json",  
                data: JSON.stringify(data), 
                success: function (resp) {
                	console.log("resp:", resp);

                	let tbl = "";
                    $.each(resp.content, function (idx, map) {
                    	const fsalAmount = formatNumber(map.salAmount);
                    	const fsalTax = formatNumber(map.afterTax);
                    	const fDty = map.duty+"%";
                    	const fdate = nvl(map.salModifyDate,"-")
                        tbl += `<tr class="tr" style="cursor:pointer;" >
                        	<td>\${map.rnum}</td>
                            <td><img class="avatar" src="/resources\${map.profile}"></td>
                            <td>\${map.positionNm}</td>
                            <td>\${map.userNm}</td>
                            <td>\${fsalAmount}</td>
                            <td>\${fDty}</td>
                            <td>\${fsalTax}</td>
                            <td>\${map.salPymntDate}</td>
                                 </tr>`;
                   	});
                    $("#tby").html(tbl);
                    $("#divPagingArea").html(resp.pagingArea);
            	}
            })
        } else {
            data.month = null;
        }
    });
});

$(function(){
	$(document).on("click",".clsPagingArea",function(){
		let currentPage = $(this).data("currentPage");//1
		let keyword = $(this).data("keyword");
		
		console.log("currentPage : " + currentPage);
		console.log("keyword : " + keyword);
		
		ajax(keyword,currentPage);
	});
	
	$("#search").on("keydown", function(event) {
	   if (event.keyCode == 13) { 
	       var keyword = $("#search").val();  
	       ajax(keyword, 1);
	   }
	});
	
	$("#searchBtn").on('click',function(){
		var keyword = $("#search").val();  
        ajax(keyword, 1);
	})
	
})


</script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>