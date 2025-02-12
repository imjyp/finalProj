<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<link rel="stylesheet" href="/css/common2.css">
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

<div id="main" >
<%@ include file="../include/top.jsp" %>

<div class="card">
	  <div class="card-header">
	    <div class="container-fluid">

	<header class="mb-3">
		<a href="#" class="burger-btn d-block d-xl-none"> <i
			class="bi bi-justify fs-3"></i>
		</a>
	</header>
	<div class="page-heading row" style="margin-top:130px; margin-bottom:0px">
	
		<div class="col-6 d-flex align-items-center">
	          <nav aria-label="breadcrumb" class="ms-3">
	            <ol class="breadcrumb mb-0">
	              <li class="breadcrumb-item"><a href="/main">Home</a></li>
	              <li class="breadcrumb-item active"><a href="/bonsa/salary">급여 지급 관리</a></li>
	            </ol>
	          </nav>
	        </div>
	        <div class="col-6 d-flex justify-content-end">
	        
	          <div class="d-flex flex-nowrap" style="overflow-x: auto; width: 100%; margin-left:90px"">
	            <div class="card text-center me-2" style="width: 150px;">
	              <div class="card-header bg-secondary text-black py-1 px-2 fw-bold">
	                사원
	              </div>
	              <div class="card-body py-1">
	                <h6 id="approvalCnt" class="mb-0">3,000,000</h6>
	              </div>
	            </div>
	            
	            <div class="card text-center me-2" style="width: 150px;">
	              <div class="card-header bg-secondary text-black py-1 px-2 fw-bold">
	                과장
	              </div>
	              <div class="card-body py-1">
	                <h6 id="pendingCnt" class="mb-0">4,000,000</h6>
	              </div>
	            </div>
	            
	            <div class="card text-center me-2" style="width: 150px;">
	              <div class="card-header bg-secondary text-black py-1 px-2 fw-bold">
	                부장
	              </div>
	              <div class="card-body py-1">
	                <h6 id="nomalMem" class="mb-0">5,000,000</h6>
	              </div>
	            </div>
	            
	          </div> <!-- /.d-flex.flex-nowrap -->
	        </div> <!-- /.col-md-6.d-flex.justify-content-end -->
</div>
</div>
</div>
	
				
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
								<div class="col-4">
										<div class="dropdown" style="display:flex;">
											<button class="btn btn-outline-secondary dropdown-toggle me-1 "
												type="button" id="sel" 
												data-bs-toggle="dropdown" aria-haspopup="true"
												aria-expanded="false">선택</button>
											<div class="dropdown-menu"
												aria-labelledby="sel"
												style="position: absolute; inset: 0px auto auto 0px; margin: 0px; transform: translate(0px, 40px);"
												data-popper-placement="bottom-start">
												<a class="dropdown-item sel-item"
													data-value="부서선택" href="#">부서선택</a>
												<a class="dropdown-item sel-item"
													data-value="직책선택" href="#">직책선택</a>
											</div>
											
											<button class="btn btn-secondary dropdown-toggle me-1 "
												type="button" id="dropdownMenuButton1"
												data-bs-toggle="dropdown" aria-haspopup="true"
												aria-expanded="false" style="display:none">부서선택</button>
											<div class="dropdown-menu"
												aria-labelledby="dropdownMenuButton1"
												style="position: absolute; inset: 0px auto auto 0px; margin: 0px; transform: translate(0px, 40px);"
												data-popper-placement="bottom-start">
												<c:forEach var="dept" items="${deptList }">
													<a class="dropdown-item dept-item"
														data-value="${dept.deptNo  }" href="#">${dept.deptNm}</a>
												</c:forEach>
											</div>
											
											
											<button class="btn btn-secondary dropdown-toggle me-1 "
												type="button" id="dropdownMenuButton2"
												data-bs-toggle="dropdown" aria-haspopup="true"
												aria-expanded="false" style="display:none">직책선택</button>
											 <div class="dropdown-menu"
												aria-labelledby="dropdownMenuButton2"
												style="position: absolute; inset: 0px auto auto 0px; margin: 0px; transform: translate(0px, 40px);"
												data-popper-placement="bottom-start">
												 <c:forEach var="position" items="${positionList }">
													<a class="dropdown-item position-item"
														data-value="${position.positionNo  }" href="#">${position.positionNm}</a>
												</c:forEach> 
											</div> 
											
											
											<label> <input type="search" id="search"
												value="${param.keyword }"
												class="form-control form-control-sm" placeholder="Search.."
												aria-controls="table2"></label> 
											<a href="#" id="searchBtn" class="btn btn-warning rounded-pill">조회</a>
									</div>
								</div>

							</div>
							<div class="row dt-row">
								<div class="col-sm-12 table-responsive tableType01">
									<table class="table table-hover mb-0 board" id="table1"
										aria-describedby="table1_info">
										<thead style="text-align:center">
											<tr id="ex">
												<th class="sorting sorting_asc" tabindex="0"
													aria-controls="table2" rowspan="1" colspan="1"
													aria-sort="ascending"
													aria-label="Name: activate to sort column descending"
													style="width: 5%">번호</th>
												<th class="sorting sorting_asc" tabindex="0"
													aria-controls="table2" rowspan="1" colspan="1"
													aria-sort="ascending"
													aria-label="Name: activate to sort column descending"
													style="width: 7%">사진</th>
												<th class="sorting" tabindex="0" aria-controls="table2"
													rowspan="1" colspan="1"
													aria-label="City: activate to sort column ascending"
													style="width: 10%">부서</th>
												<th class="sorting" tabindex="0" aria-controls="table2"
													rowspan="1" colspan="1"
													aria-label="City: activate to sort column ascending"
													style="width: 10%">직책</th>
												<th class="sorting" tabindex="0" aria-controls="table2"
													rowspan="1" colspan="1"
													aria-label="City: activate to sort column ascending"
													style="width: 10%">회원명</th>
												<th class="sorting" tabindex="0" aria-controls="table2"
													rowspan="1" colspan="1"
													aria-label="Phone: activate to sort column ascending"
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
													aria-label="Email: activate to sort column ascending"
													style="width: 18%">지급 날짜</th>
											</tr>
										</thead>
										<tbody id="tby">

										</tbody>
									</table>
								</div>
							</div>
							<div style="float:right;">
								<a href="#" class="btn btn-dark rounded-pill" id="send" >급여 지급</a> 
								<!-- <a href="#" class="btn btn-secondary rounded-pill" id="edit">급여금 수정</a> -->
							</div>
							<!-- <div class="pagination pagination-primary justify-content-center" id="divPagingArea"></div> -->
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
		</section>
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
                 <button type="button" class="btn btn-secondary" onclick="mclose()"data-bs-dismiss="modal">
                     <i class="bx bx-x d-block d-sm-none"></i>
                     <span class="d-none d-sm-block">닫기</span>
                 </button>
             </div>
         </div>
     </div>
 </div>



<div class="swal2-container swal2-center swal2-backdrop-show" id="show" style="overflow-y: auto; display:none" >
	<div aria-labelledby="swal2-title" aria-describedby="swal2-html-container" class="swal2-popup swal2-modal swal2-show" tabindex="-1" role="dialog"
		aria-live="assertive" aria-modal="true" style="display: grid;">
		<h2 class="swal2-title" id="swal2-title" style="display: block;">급여금 입력</h2>
		<label for="swal2-input" class="swal2-input-label">${dept }금액</label>
		<input id="swal2-input" class="swal2-input form-control" placeholder="" type="text" style="display: flex;" >
		<div class="swal2-actions" style="display: flex;">
			<button type="button" class="swal2-confirm swal2-styled" aria-label="" style="display: inline-block;" id="ok">OK</button>
			<button type="button" class="swal2-cancel swal2-styled" aria-label="" style="display: inline-block;" onclick="sclose()">Cancel</button>
		</div>
	</div>
</div>


<style>
.avatar{
	width:40px;
	height:40px;
}

/* .modal-content{
	border: solid rgb(107, 255, 107) !important;
} */


</style>


<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>
<%@ include file="../include/footer.jsp"%>
<script>

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
	$.ajax({
		url:"/payAll",
		type:"post",
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
		}
	})
}

function sclose(){
	$("#show").css('display','none');
}

$("#send").on('click',function(){
	mopen();
	$("#myModalLabel33").html("급여 지급");
	//$(".r").html("등록");
	
	let m=`<div class="col-12">
        <div class="card widget-todo">
        <div class="card-header border-bottom d-flex justify-content-between align-items-center">
            <h4 class="card-title d-flex">
                <i class="bx bx-check font-medium-5 pl-25 pr-75"></i>회원목록
            </h4>
            <ul class="list-inline d-flex mb-0">
                <li class="d-flex align-items-center">
                    <i class="bx bx-check-circle font-medium-3 me-50"></i>
                    <div class="dropdown">
                        <fieldset class="form-group">
	                        <select class="form-select" id="basicSelect">
	                        <option class="dept"  value="none">부서</option>
	                        <c:forEach var="dept" items="${deptList }">
                        		<option class="dept" value="${dept.deptNo }">${dept.deptNm}</option>
            				</c:forEach>
                        </select>
                    </fieldset>
                    </div>
                </li>
                <li class="d-flex align-items-center" >
                    <i class="bx bx-sort me-50 font-medium-3"></i>
                    <div class="dropdown" id="position">
                    </div>
                </li>
            </ul>
        </div>
        <div class="table-responsive" >
        <table class="table table-hover mb-0">
            <thead style="text-align:center">
                <tr>
                    <th>부서</th>
                    <th>이름</th>
                    <th>전화번호</th>
                    <th>직책</th>
                    <th>사진</th>
                </tr>
            </thead>
            <tbody id="bdy">
            <c:forEach var="emp" items="${people }">
                <tr  style="cursor:pointer;" class="trEmp" >
                	<input id="userNo" type="hidden" value="${emp.userNo}">
                    <td class="text-bold-500" style="text-align:center">${emp.deptNm}</td>
                    <td class="text-bold-500" style="text-align:center">${emp.userNm}</td>
                    <td style="text-align:center">\${formatphone('${emp.userPhone}')}</td>
                    <td style="text-align:center">${emp.positionNm}</td>
                    <td><img class="avatar" src="/resources${emp.profile}" alt="" srcset=""></td>
                </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    </div>
</div>`;
    $(".modal-body").html(m);
	
    // 부서 선택 시 직책 선택 박스 표시
    $("#basicSelect").on('change', function() {
        // 부서가 선택된 경우
        if ($(this).val() != 'none') {
            $("#position").css('display', 'block'); 
            if($(this).val()=='1' || $(this).val()=='3'|| $(this).val()=='4'||$(this).val()=='5'){
            	let str=`
                <fieldset class="form-group">
                    <select class="form-select" id="basicSelect2" >
	                    <option class="position"  value="none">직책</option>
						<option class="position" value="1">사원</option>
						<option class="position" value="2">과장</option>
                    </select>
                </fieldset>`;
                
            	$("#position").html(str);
            }
            if($(this).val()=='2'){
            	let str=`
                    <fieldset class="form-group">
                        <select class="form-select" id="basicSelect2" >
    	                    <option class="position"  value="none">직책</option>
    						<option class="position" value="1">사원</option>
    						<option class="position" value="3">부장</option>
                        </select>
                    </fieldset>`;
                    
                	$("#position").html(str);
            }
            console.log("부서 선택 값:",$("#basicSelect").val());
            data.deptNo=$(this).val();
           
        } else {
            $("#position").css('display', 'none'); 
        }
    });
    
    $("#position").on('change', '#basicSelect2', function() {
        console.log("직책 선택 값:", $(this).val());
        data.positionNo=$(this).val();
        console.log("data",data);
        
        $.ajax({
    		url:"/filter",
    		type:"post",
    		contentType: "application/json", 
            dataType: "json",  
            data: JSON.stringify(data), 
            success: function (resp) {
            	console.log("필터 resp:", resp);
            	if(resp==null || resp==''){
            		alert("선택한 부서, 직책에 해당하는 회원이 없습니다.");
            	}
            	else{
            		//회원 조회
                	let str = "";
        			$.each(resp, function(idx,member){

        			  str += `<tr style="cursor:pointer;" class="trEmp">
        				  	<input type="hidden" id="userNo" value="\${member.userNo}">
   			                    <td style="text-align:center" class="text-bold-500">\${member.deptNm}</td>
   			                    <td style="text-align:center" class="text-bold-500">\${member.userNm}</td>
   			                    <td style="text-align:center">\${member.userPhone}</td>
   			                    <td style="text-align:center">\${member.positionNm}</td>
   			                    <td><img class="avatar" src="/resources\${member.profile}" ></td>
   			                </tr>`;
        			});		
        			
        			$("#bdy").html(str);
            	}
            }
        })
    });
})


//전역 변수
let data = {
	"currentPage":"1",
	"keyword":"",
	"deptNo":"",
	"positionNo":"",
	"year":"",
	"month":""
};


$(document).ready(function() {

    $("#year").on('change', function() {
        let yearValue = $(this).val();
        if (yearValue != 'none') {
            console.log("년도 선택 값:", yearValue);
            data.year = yearValue;
            console.log("data", data);
            $.ajax({
            	url:"/bonsa/salarylist",
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
                    	const fdate = nvl(map.salModifyDate,"-");
                    	
                        tbl += `<tr class="tr" style="cursor:pointer;" >
                                    <td style="text-align:center">\${map.rnum}</td>
                                    <td style="text-align:center"><img class='avatar avatar-sm'src="/resources\${map.profile}"></td>
                                    <td style="text-align:center">\${map.deptNm}</td>
                                    <td style="text-align:center">\${map.positionNm}</td>
                                    <td style="text-align:center">\${map.userNm}</td>
                                    <td style="text-align:right">\${fsalAmount}</td>
                                    <td style="text-align:center">\${fDty}</td>
                                    <td style="text-align:right">\${fsalTax}</td>
                                    <td style="text-align:center">\${map.salPymntDate}</td>
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
            	url:"/bonsa/salarylist",
        		type:"post",
        		contentType: "application/json", 
                dataType: "json",  
                data: JSON.stringify(data), 
                success: function (resp) {
                	console.log("resp:", resp);

                	let tbl = "";
                    $.each(resp.content, function (idx, map) {
                    	const fsalTax = formatNumber(map.afterTax);
                    	const fDty = map.duty+"%";
                    	const fsalAmount = formatNumber(map.salAmount);
                    	const fdate = nvl(map.salModifyDate,"-")
                        tbl += `<tr class="tr" style="cursor:pointer;" >
                                    <td style="text-align:center">\${map.rnum}</td>
                                    <td style="text-align:center"><img class='avatar avatar-sm'src="/resources\${map.profile}"></td>
                                    <td style="text-align:center">\${map.deptNm}</td>
                                    <td style="text-align:center">\${map.positionNm}</td>
                                    <td style="text-align:center">\${map.userNm}</td>
                                    <td style="text-align:right">\${fsalAmount}</td>
                                    <td style="text-align:center">\${fDty}</td>
                                    <td style="text-align:right">\${fsalTax}</td>
                                    <td style="text-align:center">\${map.salPymntDate}</td>
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


ajax($("#search").val(),1);


function nvl(exp1, exp2){
	if(exp1 === undefined || exp1 == null || exp1 == ""){
		exp1 = exp2;
	}
	return exp1;
}

function formatNumber(num) { //천단위
    return num.toLocaleString(); 
}

const fTrClick = () =>{
	   let trs = document.querySelectorAll(".tr");
	 	for(let i=0;i<trs.length;i++){
	 		console.log("trs: ", trs[i]);
	 		
	 		trs[i].addEventListener("mouseover", ()=>{
	 			trs[i].style.backgroundColor="rgb(24, 31, 61)";
	 			trs[i].style.color="black";
	 		});

	 		<!--function은 this를 쓸 수 있고 화살표함수는 this 사용 불가-->
	       trs[i].addEventListener("mouseout",function(){
		         /*this.style.backgroundColor="white";
		         this.style.color="black";
		         this.style.fontWeight="normal";*/
		         this.setAttribute("style",false);
	       })
	 	}
}

function mclose(){
	$("#large").css("display","none");
}

function mopen(){
	//$("#large").css("display","block");
	let myModal = new bootstrap.Modal(document.getElementById('large'), {
	    backdrop: true 
		});
		myModal.show();
}

		//    진찬      1
function ajax(keyword, currentPage) {
	//전역변수 사용
	//후 : data = {"currentPage":"1","keyword":"","deptNo":"2"};
    data.keyword = nvl(keyword, "");
	data.currentPage = nvl(currentPage, "1");
	//검색어 후 : data = {"currentPage":"1","keyword":"진찬","deptNo":"2"};
    
    $.ajax({
        url: "/bonsa/salarylist",
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
            	const fdate = nvl(map.salModifyDate,"-")
                tbl += `<tr class="tr" style="cursor:pointer;" >
                            <td style="text-align:center">\${map.rnum}</td>
                            <td style="text-align:center"><img class='avatar avatar-sm'src="/resources\${map.profile}"></td>
                            <td style="text-align:center">\${map.deptNm}</td>
                            <td style="text-align:center">\${map.positionNm}</td>
                            <td style="text-align:center">\${map.userNm}</td>
                            <td style="text-align:right">\${fsalAmount}</td>
                            <td style="text-align:center">\${fDty}</td>
                            <td style="text-align:right">\${fsalTax}</td>
                            <td style="text-align:center">\${map.salPymntDate}</td>
                         </tr>`;
            });
            $("#tby").html(tbl);
            $("#divPagingArea").html(resp.pagingArea);
        }
    });
}//end ajax함수



$(function(){
	
	//행 선택 시 데이터 가져오기
	$(document).on("click",".trEmp",function(){
		$("#show").css('display','block');
		console.log("this : ",$(this));
		
		let tds = $(this).children();
		
		let dept;
		let name;
		let phone;
		let position;
		let profile;
		let userNo;
		
		$.each(tds,function(idx,td){
			console.log("td : ", $(this).html());
			
			if(idx==0){
				userNo=$(this).val();
			}else if(idx==1){
				dept = $(this).html();
			}else if(idx==2){
				name = $(this).html();
			}else if(idx==3){
				phone = $(this).html();
			}else if(idx==4){
				position = $(this).html();
			}else if(idx==5){
				profile = $(this).children("img").eq(0).attr("src");
			}
		});
		
		let data2 = {
			"dept":dept,
			"name":name,
			"phone":phone,	
			"position":position,
			"profile":profile,
			"userNo":userNo
		};
		
		
		$("#ok").on('click',function(){
			let salAmount = $("#swal2-input").val();	
			console.log("금액: ",salAmount);
			data2.salAmount=salAmount;
			if(salAmount){
			$.ajax({
				url: "/bonsa/insertSalary",
		        type: "POST",
		        contentType: "application/json", 
		        dataType: "json",  
		        data: JSON.stringify(data2), 
		        success: function (resp) {
		        	console.log("지급됐어?",resp);
		        	if(resp==1){
		        		$("#swal2-input").val("");
		        		var Toast = Swal.mixin({
						      toast: true,
						      position: 'top-end',
						      showConfirmButton: false,
						      timer: 1000
						    });
						
						Toast.fire({
							icon:'success',
							title:'등록성공.'
						});
						setTimeout(()=>location.reload(),1000);
		        	}
		        }
			})
			}
			else{
				alert("입력해!");
			}
			
			
			sclose();
		})
		console.log("data2 : ", data2);
	});
	

	mclose();
	//선 부서 클릭 -> 후 부서 선택
	$(".dept-item").on("click", function() {
	    const dept = $(this).text();
	    console.log("선택된 부서: " + dept);
	    $("#dropdownMenuButton1").text(dept);
	    //data.dept=dept;
	    
	    let deptNo = $(this).data("value");
	    console.log("선택된 부서번호: ",deptNo); 
	    
	    //전역 변수 사용.
	    //전 : data = {"currentPage":"1","keyword":"","deptNo":""};
	    //후 : data = {"currentPage":"1","keyword":"","deptNo":"2"};
	    data.deptNo=deptNo;
	    
	 	console.log("ajax에 왔다, data : ", data);
	 	
	 	ajax($("#search").val(),1);
	});//조회 클릭 이벤트 끝
	
	
	$(".position-item").on("click", function() {
		
	    const position = $(this).text();
	    console.log("선택된 직책: " + position);
	    $("#dropdownMenuButton2").text(position);
	    
	    let positionNo = $(this).data("value");
	    console.log("선택된 직책번호: ",positionNo); 
	    
	    data.positionNo=positionNo;
	    
	 	console.log("ajax에 왔다, data : ", data);
	 
	 	ajax($("#search").val(),1);
	});//조회 클릭 이벤트 끝
	
	
$(".sel-item").on("click", function() {
		
	    const sel = $(this).text();
	    console.log("선택!!: " + sel);
	    $("#sel").text(sel.split("선택")[0]);
	 	if(sel=="부서선택") {
	 		data.positionNo="";
	 		$("#dropdownMenuButton2").css("display","none");
	 		$("#dropdownMenuButton1").css("display","block");
	 	}
	 	if(sel=="직책선택") {
	 		data.deptNo="";
	 		$("#dropdownMenuButton1").css("display","none");
	 		$("#dropdownMenuButton2").css("display","block");
	 	}
	});
	
	
	
	//페이징
	$(document).on("click",".clsPagingArea",function(){
		let currentPage = $(this).data("currentPage");//1
		let keyword = $(this).data("keyword");
		
		console.log("currentPage : " + currentPage);
		console.log("keyword : " + keyword);
		
		ajax(keyword,currentPage);
	});
	
	//엔터를 통한 조회
	$("#search").on("keydown", function(event) {
	   if (event.keyCode == 13) { 
	       var keyword = $("#search").val();  
	       ajax(keyword, 1);
	   }
	});
	
	//조회
	$("#searchBtn").on('click',function(){
		var keyword = $("#search").val();
		
        ajax(keyword, 1);
	})
	
});//end 달러function


</script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>