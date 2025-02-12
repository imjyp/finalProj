<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<head>


	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>가맹점 발주</title>
	<link rel="stylesheet" href="/dist/assets/compiled/css/app.css">
	<link rel="stylesheet" href="/css/common2.css">
	<link rel="shortcut icon" type="image/x-icon" href="/kor/images/favicon.ico">
<!-- 	<link rel="stylesheet" href="/dist/assets/compiled/css/app-dark.css"> -->
	<link rel="stylesheet" href="/dist/assets/compiled/css/iconly.css">
<!-- 	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"> -->
	
	
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/top.jsp"%>
	
</head>
<style>
/* 체크박스 */
.narrow-column {
    padding: 0;
    width: 5px;
    text-align: center;
}

#btnCheckboxInit {
	margin: 0;
    padding: 0;
    border: none;
    background: none;
    color: grey;
}

.item-checkbox, .btnCheckboxInit {
    width: 20px;
    height: 20px;
}

/* 컬럼 간의 간격 조정 */
.order-status-tab .row > .col-md-6,
.order-status-tab .row > .col-md-3 {
    margin-bottom: 20px; /* 개별 컬럼 간의 간격 */
}


/* 카드 내부 여백 및 차트 컨테이너 높이 조정 */
.order-status-tab .card-body {
    padding: 15px;
    position: relative;
    height: 300px; /* 원하는 높이로 설정 */
}

canvas {
    width: 100% ;
    height: 100% ;
}

/* 아코디언 버튼 크기 조정을 위한 클래스 */
.accordion-button-sm {
    padding: 0.25rem 0.5rem; /* 패딩 축소 */
    font-size: 0.875rem;      /* 폰트 크기 축소 */
}

/* 배지 스타일링 (선택 사항) */
.accordion-body .badge {
    font-size: 0.9em;
    margin-left: 5px;
}

/* 단계별 간격 조정 */
.accordion-body ol li {
    margin-bottom: 15px;
}

/* 단계 제목 강조 */
.accordion-body ol li strong {
    display: block;
    margin-bottom: 5px;
}

 
/* 뱃지만 개별적으로 가운데 정렬 */
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
  margin-top: 141px; 
}


</style>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<title>가맹점 발주</title>
<div id="main">
	<div class="card">
	    <div class="card-header">
	        <div class="container-fluid">
	            <!-- 제목과 브레드크럼 -->
	            <div class="row align-items-center">
	                <div class="col-md-6 d-flex align-items-center">
	                    <nav aria-label="breadcrumb" class="ms-3">
	                        <ol class="breadcrumb mb-0">
	                            <li class="breadcrumb-item"><a href="/main">Home</a></li>
	                            <li class="breadcrumb-item active"><a href="/gmj/order">발주</a></li>
	                        </ol>
	                    </nav>
	                </div>
	            </div>
	            <!--아코디언 -->
	            <div class="row mt-3">
	                <div class="col-12 d-flex justify-content-end">
	                    <div class="accordion" id="accordionExample">
	                        <!-- 도움말 아코디언 항목 -->
	                        <div class="accordion-item">
	                            <h2 class="accordion-header" id="headingOne">
	                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
	                                    도움말
	                                </button>
	                            </h2>
	                            <div id="collapseOne" class="accordion-collapse collapse" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
	                                <div class="accordion-body">
	                                    <strong>발주 처리 단계</strong> <br><br>
	                                    <ol>
	                                        <li class="mb-3">
	                                            <div class="d-flex align-items-center mb-1">
	                                                <span class="badge bg-primary me-2">발주</span>
	                                            </div>
	                                            <p>
	                                                품목 리스트에서 발주할 품목을 선택한 후, "발주" 버튼을 클릭하여 상세 정보를 입력합니다.<br>
	                                                이 과정에서 발주할 품목의 수량, 가격 등을 확인하고 필요한 추가 정보를 기입할 수 있습니다.<br>
	                                            </p>
	                                            <br>
	                                        </li>
	                                        <li class="mb-3">
	                                            <div class="d-flex align-items-center mb-1">
	                                                <span class="badge bg-secondary me-2">미승인</span>
	                                                <span class="badge bg-warning me-2">회수</span>
	                                            </div>
	                                            <p>
	                                                발주가 접수되면 본사에서 계산서를 발행하기 전까지 발주 상태는 "미승인" 상태로 유지됩니다.<br>
	                                                이 상태에서는 발주를 "회수"할 수 있으며, 필요 시 발주 내용을 수정하거나 취소할 수 있습니다.<br>
	                                            </p>
	                                            <br>
	                                        </li>
	                                        <li class="mb-3">
	                                            <div class="d-flex align-items-center mb-1">
	                                                <span class="badge bg-success me-2">견적 완료</span>
	                                                <span class="badge bg-danger me-2">반려</span>
	                                            </div>
	                                            <p>
	                                                본사에서 계산서를 발행하는 단계에서는 발주를 "반려"하거나 계산서를 발행할 수 있습니다.<br>
	                                                계산서가 성공적으로 발행되면 발주 상태는 "견적 완료"로 변경됩니다.<br>
	                                                견적 완료 상태에서는 추가적인 수정이 불가능하며, 최종적인 발주 내역으로 확정됩니다.
	                                            </p>
	                                            <br>
	                                        </li>
	                                    </ol>
	                                    <br>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>

		<div class="card-body">
			<!-- 발주 / 계산 / 발주 관리 탭 -->
			<div class="tab-list">
				<ul class="nav nav-tabs">
					<li>
						<a class="nav-link active" data-id="status" id="status-tab" href="#status" role="tab" class="status" aria-selected="true" 
							onclick="getStatusList()">발주 현황</a>
					</li>
					<li>
						<a class="nav-link" data-id="order" id="order-tab" href="#order" role="tab" class="order" aria-selected="false"
							onclick="getItemList()">발주</a> 
					</li>
					<li>
						<a class="nav-link" data-id="orderList" id="orderList-tab" href="#orderList" role="tab" class="orderList" aria-selected="false"
							onclick="getOrderList()">발주 내역</a>
					</li>
					<li>
					<li>
						<a class="nav-link" data-id="bill" id="bill-tab" href="#bill" role="tab" class="bill" aria-selected="false"
							onclick="getBList()">계산서 발행 내역</a>
					</li>
					
				</ul>
			</div>

			<!-- 발주 현황 -->
			<div class="tab-content">
				<div class="tab-pane active order-status-tab" id="status" role="tabpanel">
			    <section class="section">
			        <div class="row"> 
			            <!-- 테이블 컬럼 (6칸) -->
			            <div class="col-md-6">
			                <div class="card">
			                    <div class="card-header">
			                        <h4 class="card-title text-center">발주 현황</h4>
			                    </div>
			                    <div class="card-body">
			                        <div class="table-responsive">
			                            <table class="table table-bordered mb-0">
			                                <thead>
			                                    <tr>
			                                        <th class="text-center">발주 상태</th>
			                                        <th class="text-center">건수</th>
			                                        <th class="text-center">총 금액</th>
			                                    </tr>
			                                </thead>
			                                <tbody id="statustby">
			                                </tbody>
			                                <tfoot>
			                                    <tr>
			                                        <th class="text-center" style="font-weight: bold; font-size: 1em;">총 건수</th>
			                                        <td class="text-center" id="totalOrders" style="font-weight: bold; font-size: 1em;">0</td>
			                                        <td class="text-end" id="totalAmount" style="font-weight: bold; font-size: 1em;"> </td>
			                                    </tr>
			                                </tfoot>
			                            </table>
			                        </div>
			                    </div>
			                </div>
			            </div>
			            
			            <!-- 막대 차트 컬럼 (3칸) -->
			            <div class="col-md-3"> 
			                <div class="card">
			                    <div class="card-header">
			                        <!-- <h4 class="card-title">발주 상태 막대 그래프</h4> -->
			                    </div>
			                    <div class="card-body">
			                        <canvas id="statusChart"></canvas>
			                    </div>
			                </div>
			            </div>
			            
			            <!-- 도넛 차트 컬럼 (3칸) -->
			            <div class="col-md-3"> 
			                <div class="card">
			                    <div class="card-header">
			                        <!-- <h4 class="card-title">발주 상태 도넛 차트</h4> -->
			                    </div>
			                    <div class="card-body">
			                        <canvas id="statusPieChart"></canvas>
			                    </div>
			                </div>
			            </div>
			        </div> <!-- .row 닫기 -->
			    </section>
			</div>

              
				<%-- 발주/주문 (품목리스트)--%>
				<div class="tab-pane fade" id="order">
					<section class="section">
						<div class="row" id="table-hover-row">
							<div class="col-12">
								<div class="card">
									<div class="card-header">
										<h4 class="card-title">품목리스트</h4>
										
									</div>
									<div class="card-content">
										<div
											class="card-body align-items-center justify-content-between"
											style="display: flex;">
											<form>
												<!-- 검색  -->
												<div class="dataTable-search">
													<input type="text" name="keyword" value="${param.keyword}" class="krd dataTable-input" placeholder="" >
													<button type="button" class="btnSearch btn btn-warning rounded-pill">검색</button>
												</div>
											</form>
											<div class="d-flex">
												<button type="button" class="btn btn-dark  ms-2"  id="orderButton">발주</button>
											</div>
										</div>
										<!-- table hover -->
										<div class="tableType01">
											<table class="board">
											<colgroup>
								       			<col width="3%">
								       			  <col>
								       			<col width="8%">
								       		</colgroup>
												<thead>
													<tr>
														<th class="narrow-column" style="text-align: right;">
															<button type="button" class="btnCheckboxInit ms-3" id="btnCheckboxInit">
																<span class="fa-fw select-all fas"></span>
															</button>
														</th>
														<th class="checkbox-column text-center">
															<input type="checkbox" data-cbox-id="order" class="form-check-input checkAll" />
														</th>
														<th class="text-center">번호</th>
														<th class="text-center">품목 이름</th>
														<th class="text-center">원가</th>
														<th class="text-center">판매가</th>
													</tr>
												</thead>
												<tbody id="itemtby">
												</tbody>
											</table>
										</div>
											<div class="card-footer ">
												<div class="pagination pagination-warning justify-content-center divPagingArea"></div>
											</div>
									</div>
								</div>
							</div>
						</div>
					</section>
				</div>

				<!-- 발주내역 -->
				<div class="tab-pane fade" id="orderList">
					<section class="section">
						<div class="row" id="table-hover-row">
							<div class="col-12">
								<div class="card">
									<div class="card-header">
										<h4 class="card-title">발주 목록</h4>
									</div>
									<div class="card-content">
										<div class="card-body align-items-center justify-content-between" style="display: flex;">
											<form>
												<!-- 검색  -->
												<div class="dataTable-search">
													<input type="text" name="keyword" value="${param.keyword}" class="krd dataTable-input" placeholder="" >
													<button type="button" class="btnSearch btn btn-warning rounded-pill">검색</button>
												</div>
											</form>
											<div class="d-flex">
												<button type="button" class="btn btn-dark"  id="cancelOrder1Btn" onclick="cancelOrder(selectedOrders)">회수</button>
											</div>
										</div>
										<!-- table hover -->
										<div class="tableType01">
											<table class="board">
												<colgroup>
									       			<col width="3%">
				       			        			<col>
									       			<col width="8%">
									       		</colgroup>
												<thead>
													<tr>
														<th class="checkbox-column text-center">
															<input type="checkbox" data-cbox-id="orderList" class="form-check-input checkAll" />
														</th>
														<th class="text-center">순번</th>
														<th class="text-center">발주 번호</th>
														<th class="text-center">제목</th>
														<th class="text-center">가맹점 번호</th>
														<th class="text-center">가맹점 이름</th>
														<th class="text-center">발주 금액</th>
														<th class="text-center">발주 상태</th>
														<th class="text-center">발주일</th>
														<th class="text-center">발주서</th>
													</tr>
												</thead>
												<tbody id="orderListtby">
												</tbody>
											</table>
										</div>
											<div class="card-footer ">
												<div class="pagination pagination-warning justify-content-center divPagingArea"></div>
											</div>
									</div>
								</div>
							</div>
						</div>
					</section>
				</div>
				<!-- 계산 -->
				<div class="tab-pane fade" id="bill">
					<section class="section">
						<div class="row" id="table-hover-row">
							<div class="col-12">
								<div class="card">
									<div class="card-header">
										<h4 class="card-title">계산서 발행 내역</h4>
									</div>
									<div class="card-content">
										<div class="card-body"
											style="justify-content: left; display: flex;">
											<form>
												<!-- 검색  -->
												<div class="dataTable-search">
													<input type="text" name="keyword" value="${param.keyword}" class="krd dataTable-input" placeholder="" >
                                                        <button type="button" class="btnSearch btn btn-warning rounded-pill">검색</button>
												</div>
											</form>
										</div>
										<!-- table hover -->
										<div class="tableType01">
											<table class="board" style="width:100% !important">
												<thead>
													<tr>
														<!-- 
														<th class="checkbox-column text-center">
															<input type="checkbox" data-cbox-id="bill" class="form-check-input checkAll" />
														</th>
														 -->
														<th class="text-center">번호</th>
														<th class="text-center">계산 번호</th>
														<th class="text-center">제목</th>
														<th class="text-center">계산일</th>
														<th class="text-center">계산 상태</th>
														<th class="text-center">계산서</th>
													</tr>
												</thead>
												<tbody id="billtby">
												</tbody>
											</table>
									</div>
											<div class="card-footer ">
												<div class="pagination pagination-warning justify-content-center divPagingArea"></div>
											</div>
								</div>
							</div>
						  </div>
						</div>
					</section>
				</div>
				
			</div>
		</div>
		<!-- 	</div> -->
	</div>
	<%@ include file="../include/footer.jsp"%>
</div>


<!-- 발주 모달  -->
<div class="modal fade show" id="orderModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalCenterTitle" aria-modal="true"
	style="display: none; padding-left: 0px;">
	<div
		class="modal-dialog modal-dialog-centered modal-dialog-centered modal-dialog-scrollable modal-xl"
		role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h1 class="modal-title">발주서 작성</h1>
				<button type="button" class="btn-close" onclick="mClose()"
					data-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body text-center" id="modalContent"></div>
			<div class="modal-footer">
				<button type="button" class="btn btn-warning ms-1" id="excelBtn" >
					<i class="bx bx-check d-block d-sm-none"></i> 
					<span class="d-none d-sm-block">내보내기</span>
				</button>
				<button type="button" class="btn btn-dark" id="updateBtn" onclick="update()">
					<i class="bx bx-x d-block d-sm-none"></i> 
					<span class="d-none d-sm-block">기안</span>
				</button>
				
			</div>
		</div>
	</div>
</div>

<!-- 발주서 상세 모달  -->
<div class="modal fade show" id="odModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalCenterTitle" aria-modal="true"
	style="display: none; padding-left: 0px;">
	<div
		class="modal-dialog modal-dialog-centered modal-dialog-centered modal-dialog-scrollable modal-xl"
		role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h1 class="modal-title">발주서 상세</h1>
				<button type="button" class="btn-close" onclick="mClose()"
					data-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body text-center" id="modalContent"></div>
			<div class="modal-footer" style="display: flex; justify-content: right;">
				<button type="button" class="btn btn-warning" id="cancelOrder2Btn" onclick="">
					<i class="bx bx-x d-block d-sm-none"></i> 
					<span class="d-none d-sm-block">회수</span>
				</button>
				<!--  
				<button type="button" class="btn btn-secondary ms-1" id="reorderBtn" >
					<i class="bx bx-check d-block d-sm-none"></i> 
					<span class="d-none d-sm-block">재발주</span>
				</button>
				-->
				
			</div>
		</div>
	</div>
</div>
<!-- 계산서 상세 모달  -->
<div class="modal fade" id="bdModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-modal="true">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-xl" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">계산서 상세보기</h5>
                <button type="button" class="btn-close" onclick="mClose()"
                    data-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id="modalContent">
                
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">
var keyword = ""; 

//******************1) 체크박스 자동 체크 시작 **********************
//체크박스 체크된 값 저장
let checkboxArr = [];
//******************1) 체크박스 자동 체크 끝 **********************

//****** 클릭한 탭 정보 관련 시작 *******
//어떤 tabId에 checkAll이 되어있는가?
let tabId = "";

let orderCheckAll = ""; //Y->""
let orderListCheckAll = ""; //Y->""
let billCheckAll = ""; //Y->""
let statusCheckAll = ""; //Y->""
//****** 클릭한 탭 정보 관련 끝 *******

var storeNo = `${user.userVO.storeNo}`;
console.log("storeNo : ", storeNo);

var storeNm = `${user.userVO.storeNm}`;
console.log("storeNm : ", storeNm);


$(document).ready(function() {

	// 초기 페이지
	$("#status-tab").addClass("active");
	getStatusList("1", "");
	$("#status-tab").trigger("click");
	
	$("#status").css("display","block").removeClass("fade");
	$("#order").css("display","none").removeClass("fade");
	$("#orderList").css("display","none").addClass("fade");
	$("#bill").css("display","none").addClass("fade");
	
	
	// 탭 컨트롤 (발주 현황)
    $("#status-tab").on("click", function(){
        removeActive();
        switchTab($(this), "#status");
        updKrdTabId(); 
        getStatusList();
    });
        
	// 탭 컨트롤 (발주)
    $("#order-tab").on("click", function(){
        removeActive();
        switchTab($(this), "#order");
        updKrdTabId(); 
        getItemList(1, $("input[name='keyword']").val());
    });
    
  	// 텝 컨트롤 (견적)
	$("#orderList-tab").on("click",function(){
		removeActive();
		$(this).addClass("active");
		switchTab($(this), "#orderList");
        updKrdTabId();
        getOrderList(1, $("input[name='keyword']").val());
	});
 
    // 탭 컨트롤 (계산)
    $("#bill-tab").on("click", function(){
        removeActive();
        switchTab($(this), "#bill");
        getBList(1, $("input[name='keyword']").val());
        updKrdTabId(); 
//         console.log("bill-tab 클릭 후 tabId :", tabId); 
    });
    
    
    // 검색
    $(".btnSearch").on("click", function () {
        updKrdTabId();
        
        if (tabId === "order") {
        	getItemList(1, $("input[name='keyword']").val());
        }else  if (tabId === "orderList") {
            getOrderList(1, $("input[name='keyword']").val());
        }else if (tabId === "bill") {
            getBList(1, $("input[name='keyword']").val());
        } else {
            getStatusList();
        }
    });
    
    // 페이지네이션
    $(document).on("click", ".clsPagingArea", function () {
        const currentPage = $(this).data("currentPage");
        updKrdTabId();
        
        console.log("페이지 클릭 -> tabId : ", tabId, ", currentPage :", currentPage, "검색어 -> keyword :", keyword);
        console.log("tabId : ", tabId);
        
        if (tabId === "order") {
        	getItemList(currentPage, $("input[name='keyword']").val());
        	
        	//발주/주문의 전체 체크박스가 체크되어있는지?
        	console.log("orderCheckAll : " + orderCheckAll);
        } else if (tabId === "orderList") {
            getOrderList(currentPage, $("input[name='keyword']").val());
            
          	//발주 내역의 전체 체크박스가 체크되어있는지?
        	console.log("orderListCheckAll : " + orderListCheckAll);
        } else if (tabId === "bill") {
            getBList(currentPage, $("input[name='keyword']").val());
            
          	//계산서 발행 내역의 전체 체크박스가 체크되어있는지?
        	console.log("billCheckAll : " + billCheckAll);
        } else {
            getStatusList(currentPage, $("input[name='keyword']").val());
            
          	//발주/주문 현황의 전체 체크박스가 체크되어있는지?
        	console.log("statusCheckAll : " + statusCheckAll);
        }
    });
    
        
      const selectedItems = JSON.parse(localStorage.getItem('selectedItems')) || [];
        
      //체크박스 선택 정보 저장
    	$(document).on("change", ".item-checkbox", function() {
    		console.log($(this).prop('checked'));
    		
    		if(checkboxArr==null){
    			checkboxArr = [];
    		}
    		
    		if($(this).prop('checked')){//체크 시
    			// 체크된 값을 전역 배열에 넣음
    			checkboxArr.push($(this).val());
    			// 세션 스토리지에 넣음
    			sessionStorage.setItem("checkboxArr",JSON.stringify(checkboxArr));
    		}else{//체크 풀리면
    			//배열에서 값 삭제
    			removeArr($(this).val());
    			sessionStorage.setItem("checkboxArr",JSON.stringify(checkboxArr));
    		}
    		
    		//현재 저장된 값들 확인
    		checkboxAll();
//    	 	 $(".item-checkbox:checked").each(function(idx){
//    	 		  console.log($(this).val());
//    	 	 });
    	});

    	//체크박스 전체 동시에 체크 처리
    	$(".checkAll").on("change",function(){
    		//어떤 tabId에서 전체 체크박스를 클릭했는가? 
    		console.log("checkAll->tabId : ", tabId);
    		
    		//체크가 되었는가? 아니면 체크가 풀렸는가?
    		console.log("idChecked : ",$(this).is(":checked"));
    		
    		if(tabId=="order"){//발주/주문
    			if($(this).is(":checked")){//전체 체크박스 체크 on
    				orderCheckAll = "Y";
    				fn_itemCheckboxOn();
    			}else{//전체 체크박스 체크 off
    				orderCheckAll = "";
    				fn_itemCheckboxOff()
    			}
    		}else if(tabId=="orderList"){//발주 내역
    			if($(this).is(":checked")){//전체 체크박스 체크 on
    				orderListCheckAll = "Y";
    				fn_itemCheckboxOn();
    			}else{//전체 체크박스 체크 off
    				orderListCheckAll = "";
    				fn_itemCheckboxOff();
    			}
    		}else if(tabId=="bill"){//계산서 발행 내역
    			if($(this).is(":checked")){//전체 체크박스 체크 on
    				billCheckAll = "Y";
    				fn_itemCheckboxOn();
    			}else{//전체 체크박스 체크 off
    				billCheckAll = "";
    				fn_itemCheckboxOff();
    			}
    		}else if(tabId=="status"){//발주/주문 현황
    			if($(this).is(":checked")){//전체 체크박스 체크 on
    				statusCheckAll = "Y";
    				fn_itemCheckboxOn();
    			}else{//전체 체크박스 체크 off
    				statusCheckAll = "";
    				fn_itemCheckboxOff();
    			}
    		}
    		
    		console.log("item-checkbox의 크기 : ",$(".item-checkbox").length);
    	});

    	// 전체 선택/해제 이벤트
        $(".check-all").on("change", function () {
            const isChecked = $(this).is(":checked"); 
            $(".item-checkbox").prop("checked", isChecked); 
        });

        // 개별 체크박스 선택/해제 시 전체 체크박스 상태 업데이트
        $(document).on("change", ".item-checkbox", function () {
            const total = $(".item-checkbox").length; 
            const checked = $(".item-checkbox:checked").length; 
            $(".check-all").prop("checked", total === checked); 
        });
    	
    	// 선택된 값 가져오기
        $(".get-selected").on("click", function () {
            const selectedValues = $(".item-checkbox:checked").map(function () {
                return $(this).val(); 
            }).get(); 

            console.log("선택된 값:", selectedValues); 
        });
    	
	// 발주 리스트의 회수 버튼 클릭 시
    $("#cancelOrder1Btn").on("click", function () {
        cancelOrderList();
    });

	
 
	$("#storeNo").val(storeNo);
	console.log($("#storeNo").val()); 
	
	$("#storeNm").val(storeNm);
	console.log($("#storeNm").val()); 
	

	
	
    /*
	//텝 컨트롤 (발주 / 주문)
	$("#order-tab").on("click",function(){
		removeActive();
		$(this).addClass("active");
		
		$("#order").css("display","block").removeClass("fade");
		$("#orderList").css("display","none").addClass("fade");
		$("#bill").css("display","none").addClass("fade");
		$("#status").css("display","none").addClass("fade");
	});
	
	// 텝 컨트롤 (견적)
	$("#orderList-tab").on("click",function(){
		removeActive();
		$(this).addClass("active");
		
		$("#order").css("display","none").addClass("fade");
		$("#orderList").css("display","block").removeClass("fade");
		$("#bill").css("display","none").addClass("fade");
		$("#status").css("display","none").addClass("fade");
	});
	
	//텝 컨트롤 (계산)
	$("#bill-tab").on("click",function(){
		removeActive();
		$(this).addClass("active");
		
		$("#order").css("display","none").addClass("fade");
		$("#orderList").css("display","none").addClass("fade");
		$("#bill").css("display","block").removeClass("fade");
		$("#status").css("display","none").addClass("fade");
	});
	
	//텝 컨트롤 (발주/주문 관리)
	$("#status-tab").on("click",function(){
		removeActive();
		$(this).addClass("active");
		
		$("#order").css("display","none").addClass("fade");
		$("#orderList").css("display","none").addClass("fade");
		$("#bill").css("display","none").addClass("fade");
		$("#status").css("display","block").removeClass("fade");
	});
	*/
	
	
    /* 견적 상세 모달 열기 */
    $(document).on("click", ".billDetail", function(event){
        event.preventDefault(); 
        
        $("#bdModal").modal("show");

        let billNo = $(this).data("bill-no"); 
        console.log("billDetail -> billNo: ", billNo);
        
        billDetail(billNo);
    });
    
    
    // 발주 상세 모달 열기
    $(document).on("click", ".orderDetail", function(event){
    	event.preventDefault();
    	
        $("#odModal").modal("show");
        
        let storeNo = $(this).data("storeNo");
        let storeOrderNo = $(this).data("store-order-no");
        console.log("orderDetail -> storeOrderNo : ", storeOrderNo);
        
        orderDetail(storeOrderNo, storeNo);
    });
	
	// 발주 버튼
    $("#orderButton").on("click", function () {
        const selectedItems = JSON.parse(sessionStorage.getItem("checkboxArr")) || [];
        if (selectedItems.length === 0) {
            alert("발주할 품목을 선택해주세요.");
            return;
        }

     	// 발주 데이터
        const data = {selectedItems};
        //selectedItems data : ["3","5","16", "28","13"]
        console.log("selectedItems data:", data);
     	
     	let formData = new FormData();
     	for(let i=0;i<selectedItems.length;i++){
     		formData.append("selectedItems["+i+"].itemNo",selectedItems[i]);
     	}
     	
     	//formData 값 확인
     	for (const [key, value] of formData.entries()) {
     		 console.log(key, value);
   		};

        // 서버에 데이터 전송
        axios.post("/gmj/insertOrder", formData)
            .then(resp => {
                const { storeOrderNo, storeNo, storeNm, storeOrderDate, selectedItems } = resp.data;
                console.log("storeNm:", storeNm);
                console.log("storeOrderNo:", storeOrderNo);

                // 모달 내용 생성
                let modalContent = `
                    <form class="form form-horizontal">
                    <h5 class="text-center my-4">품목 상세 정보</h5>
                    <table class="table table-bordered text-center align-middle">
                        <thead>
                            <tr>
                                <th class="text-center">품목 번호</th>
                                <th class="text-center">품목명</th>
                                <th class="text-center">원가</th>
                                <th class="text-center">판매가</th>
                                <th class="text-center">수량</th>
                                <th class="text-center">합계</th>
                            </tr>
                        </thead>
                        <tbody>`;
                selectedItems.forEach(item => {

                	const quantity = 1;  
                    const itemTotal = parseFloat(item.salePrice) * quantity;
                    
                	// 금액 천 단위 , 추가
    				const fmtItemPrice = item.itemPrice.toLocaleString();
    				const fmtSalePrice = item.salePrice.toLocaleString();
    				const fmtItemTotal = itemTotal.toLocaleString();
    				
   		            console.log("salePrice:", item.salePrice);
    				console.log("quantity:", quantity);
    				console.log("itemTotal :", itemTotal);

                    modalContent += `
                    	<tr>
	                        <td class="text-center">\${item.itemNo}</td>
	                        <td class="text-center">\${item.itemNm}</td>
	                        <td class="text-end">\${fmtItemPrice}</td>
	                        <td class="text-end">\${fmtSalePrice}</td>
	                        <td class="text-center">
		                        <div class="d-flex justify-content-center">
		                            <input type="number" class="form-control item-quantity " data-item-no="${item.itemNo}" value="1" min="1" style="width:100px;">
		                        </div>
		                    </td>
	                        <td class="text-end">
	                        	<div class="d-flex justify-content-center">
		                        	<span class="form-control item-total">\${fmtItemTotal}</span>
		                        </div>
	                        </td>
	                    </tr>`;
                });
                
                modalContent += `
                            </tbody>
                            <tfoot>
                            <tr style="border-top: 2px solid #ccc;">
	            	            <td colspan="2" class="text-center"><strong>총 수량</strong></td>
	            	            <td id="totalQuantity"><strong>0</strong></td>
	            	            <td colspan="2" class="text-center"><strong>총 금액</strong></td>
	            	            <td id="finalTotal" class="text-center"><strong>0원</strong></td>
	            	        </tr>
                            </tfoot>
                        </table>
                        <h5 class="text-center my-4">발주 기본 정보</h5>
                        <div class="row mb-3">
	                        <div class="col-md-6 d-flex align-items-center">
		                        <label for="storeOrderNo" class="col-sm-3 col-form-label text-left">발주 번호</label>
		                        <div class="col-sm-9">
		                        	<input type="text" class="form-control text-center" id="storeOrderNo" value="\${storeOrderNo}" readonly />
	                        	</div>	
	                        </div>
	                        <div class="col-md-6 d-flex align-items-center">
		                        <label for="storeOrderDate" class="col-sm-3 col-form-label text-left">발주일</label>
		                        <div class="col-sm-9">
		                        	<input type="date" class="form-control text-center" id="storeOrderDate" value="" />
	                        	</div>
	                        </div>
	                    </div>
	
	                    <div class="row mb-3">
		                    <div class="col-md-6 d-flex align-items-center">
		                        <label for="storeNo" class="col-sm-3 col-form-label text-left">가맹점 번호</label>
		                        <div class="col-sm-9">
		                        	<input type="text" class="form-control text-center" id="storeNo" value="\${storeNo}" readonly />
		                    	</div>	
		                    </div>
		                    <div class="col-md-6 d-flex align-items-center">
		                        <label for="storeNm" class="col-sm-3 col-form-label text-left">가맹점 이름</label>
		                        <div class="col-sm-9">
		                        	<input type="text" class="form-control text-center" id="storeNm" value="\${storeNm}" readonly />
		                    	</div>
		                    </div>
		                </div>
                        <div class="row mb-3">
	                        <div class="col-md-6 d-flex align-items-center">
		                        <label for="storeOrderTitle" class="col-sm-3 col-form-label text-left">제목</label>
		                        <div class="col-sm-9">
		                        	<input type="text" class="form-control text-center" id="storeOrderTitle" value="" />
	                        	</div>	
	                        </div>
	                        <div class="col-md-6 d-flex align-items-center">
		                        <label for="uploadFiles" class="col-sm-3 col-form-label text-left">첨부파일</label>
		                        <div class="col-sm-9">
		                        	<input type="file" class="form-control text-center" id="uploadFiles" value="" />
	                        	</div>
	                        </div>
	                        <input type="hidden" id="storeOrderSum" />
	                    </div>
                    </form>`;

                $("#modalContent").html(modalContent);
                $("#orderModal").modal("show");

             	// 총 수량과 최종 금액 계산 함수
                function updateTotals() {
                    let totalQuantity = 0;
                    let finalTotal = 0;

                    $(".item-quantity").each(function () {
                        const quantity = parseInt($(this).val()) || 0;
                        const row = $(this).closest("tr");
                        const salePrice = parseFloat(row.find("td:nth-child(4)").text().replace(/,/g, '')) || 0;

                        // console.log("체킁 salePrice : " + salePrice);
                        
                        // 개별 품목 금액 업데이트
                        const itemTotal = salePrice * quantity;
                        row.find(".item-total").text(itemTotal.toLocaleString());
                        // console.log("체킁 itemTotal : " + itemTotal);

                        // 총합 계산
                        totalQuantity += quantity;
                        finalTotal += itemTotal;
                    });

                    // 총 수량 및 금액 업데이트
                    $("#totalQuantity").html('<strong>' + totalQuantity + '</strong>');
                    $("#finalTotal").html('<strong>' + finalTotal.toLocaleString() + '</strong>');
                    
                    $("#storeOrderSum").val(finalTotal);
                }

                   // 수량 입력 시 실시간 업데이트
                   $(".item-quantity").on("input", updateTotals);

                   updateTotals();
            })
            .catch(error => {
                console.error("Error:", error);
                alert("updateTotals 오류");
            });
      });
	
	
    // 엑셀 내보내기
	$("#excelBtn").on("click", function(){
    const storeOrderNo = $("#storeOrderNo").val();
    if(!storeOrderNo){
        Swal.fire({
            icon: 'error',
            title: '발주 번호가 없습니다.'
        });
        return;
    }
    
    let formData = new FormData();

    const storeNo = $("#storeNo").val();
    const storeNm = $("#storeNm").val();
    const storeOrderTitle = $("#storeOrderTitle").val();
    const storeOrderSum = $("#storeOrderSum").val();
    const storeOrderDate = $("#storeOrderDate").val();

    formData.append("storeNo", storeNo);
    formData.append("storeNm", storeNm);
    formData.append("storeOrderNo", storeOrderNo);
    formData.append("storeOrderTitle", storeOrderTitle);
    formData.append("storeOrderSum", storeOrderSum);
    formData.append("storeOrderDate", storeOrderDate);

    // 발주 상세 정보 수집
    const storeOrderDetailList = [];
    $("#orderModal table tbody tr").each(function(index) {
        const itemNo = $(this).find('td:nth-child(1)').text().trim(); 
        const itemNm = $(this).find('td:nth-child(2)').text().trim(); 
        const storeOrderAmount = $(this).find('.item-quantity').val();
        const storeOrderPrice = $(this).find('td:nth-child(4)').text().replace(/,/g, '').trim(); 
        
        storeOrderDetailList.push({
            itemNo: itemNo,
            itemNm: itemNm,
            storeOrderAmount: parseInt(storeOrderAmount),
            storeOrderPrice: parseFloat(storeOrderPrice)
        });
    });
    
    formData.append("storeOrderDetailList", JSON.stringify(storeOrderDetailList));
    
    console.log("storeNo:", storeNo);
    console.log("storeNm:", storeNm);
    console.log("storeOrderNo:", storeOrderNo);
    console.log("storeOrderTitle:", storeOrderTitle);
    console.log("storeOrderSum:", storeOrderSum);
    console.log("storeOrderDate:", storeOrderDate);
    console.log("storeOrderDetailList:", storeOrderDetailList);

    axios.post("/exl/download", formData, {
        responseType: 'blob', 
        headers: { 'Content-Type': 'multipart/form-data' }
    })
    .then(response => {
        // 파일 다운로드 처리
        const url = window.URL.createObjectURL(new Blob([response.data]));
        const link = document.createElement('a');
        link.href = url;

        // 파일 이름 설정
        let fileName = `\${storeOrderDate} \${storeNm} 발주서.xlsx`;
     	// 응답 헤더에서 Content-Disposition 값 추출
        const disposition = response.headers['content-disposition'];
        if (disposition && disposition.indexOf('filename*=') !== -1) {
            // 예: filename*=UTF-8''2025-02-02_대전둔산점_발주서.xlsx
            fileName = decodeURIComponent(disposition.split("filename*=")[1].split("''")[1]).replace(/_/g, ' ');
        } else if (disposition && disposition.indexOf('filename=') !== -1) {
            // 예: filename="2025-02-02_대전둔산점_발주서.xlsx"
            fileName = decodeURIComponent(disposition.split('filename=')[1]).replace(/"/g, '').replace(/_/g, ' ');
        }
        
        link.setAttribute('download', fileName);
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
        window.URL.revokeObjectURL(url);
    })
    .catch(error => {
        console.error("Excel 다운로드 에러:", error);
        Swal.fire({
            icon: 'error',
            title: 'Excel 내보내기에 실패했습니다.'
        });
    });
});
 	
 	 
	// 다운로드 클릭 처리 -> 동적요소
    $(document).on("click", ".download", function(){
        // 해당 파일 경로 가져오기
        let filePath = $(this).data("file");
        
        if(filePath != null && filePath != ""){ 
            // 다운로드 url 생성
            const downloadUrl = `/download?fileName=\${filePath}`;
            console.log("downloadUrl : ", downloadUrl);
            
            const $a = $('<a></a>');
            $a.attr("href", downloadUrl);
            $a.attr("download", "");
            $a[0].click();
        }
    });
	
	
 	// 체크박스 초기화
 	$("#btnCheckboxInit").on("click",function(){
		//전역 배열 변수 초기화
		checkboxArr = [];
		//세션스토리지 초기화
		sessionStorage.setItem("checkboxArr",JSON.stringify(checkboxArr));
		//체크 비활성화
		$(".item-checkbox").each(function(){
			$(this).prop("checked",false);
		});
	});	
}); //end ready

//nav-tab의 active 클래스를 제거 함수 ->밑줄이 사라짐
function removeActive(){
	$("#order-tab").removeClass("active");
	$("#orderList-tab").removeClass("active");
	$("#bill-tab").removeClass("active");
	$("#status-tab").removeClass("active");
}

// 공백 처리 함수
function nvl(expr1, expr2) {
	   if (expr1 === undefined || expr1 == null || expr1 == "") {
	      expr1 = expr2;
	   }
	 return expr1;
}  

// 모달 닫기 함수
function mClose(){
	$("#orderModal").modal('hide');
	$("#odModal").modal('hide');
	$("#bdModal").modal('hide');
}

//선택된 품목 모달에 추가 함수
function insertSelectedItems() {
    const selectedItems = [];

    $(".item-checkbox:checked").each(function() {
        const item = {
        	itemNo: $(this).data("item-no"),
        	itemNm: $(this).data("item-nm"),
            itemPrice: $(this).data("item-price"),
            salePrice: $(this).data("sale-price")
       
        };
//         console.log("item.itemNo:", item.itemNo);
//         console.log("item.itemNm:", item.itemNm);
//         console.log("item.itemPrice:", item.itemPrice);
//         console.log("item.salePrice:", item.salePrice);
        
        console.log("선택된 품목:", item);
        
        selectedItems.push(item);
    });
    
}


/* 발주 update 함수 */
async function updateOrder() {
    try {
        const headers = { 'Content-Type': 'multipart/form-data' };
        const formData = new FormData();

        const storeNo         = $("#storeNo").val();
        const storeOrderNo    = $("#storeOrderNo").val();
        const storeOrderTitle = $("#storeOrderTitle").val();
        const storeOrderSum   = $("#storeOrderSum").val();
        const storeOrderDate  = $("#storeOrderDate").val();

        const files = $("#uploadFiles")[0]?.files; 
        if(files && files.length > 0) {
            Array.from(files).forEach(file => {
                formData.append("uploadFiles", file);
            });
        }

        formData.append("storeNo", storeNo);
        formData.append("storeOrderNo", storeOrderNo);
        formData.append("storeOrderTitle", storeOrderTitle);
        formData.append("storeOrderSum", storeOrderSum);
        formData.append("storeOrderDate", storeOrderDate);

        const response = await axios.put("/gmj/updateOrder", formData, { headers });
        console.log("updateOrder 체킁 :", response.data);

        Swal.fire({
            icon: 'success',
            title: '발주 업데이트 성공'
        });

        return response.data;  
    } catch (error) {
        console.error("updateOrder 에러:", error);
        Swal.fire({
            icon: 'error',
            title: '발주 업데이트 실패'
        });
        throw error;  
    }
}


 
// 발주 상세 update 함수
async function updateOD() {
    try {

    	const storeOrderNo = $("#storeOrderNo").val();
        const orderDetails = [];
        
        $(".item-quantity").each(function () {
            const row = $(this).closest("tr");
            const itemNo = row.find("td:nth-child(1)").text();
            const storeOrderAmount = parseInt($(this).val(), 10);
            const storeOrderPrice = parseInt(row.find(".item-total").text().replace(/,/g, ''), 10);
            
            
            orderDetails.push({
                storeOrderNo:storeOrderNo,
                itemNo:itemNo,
                storeOrderAmount:storeOrderAmount,
                storeOrderPrice:storeOrderPrice
            });
        });

        console.log("storeOrderDetail 업데이트 할 orderDetails: ", orderDetails);

        // 서버로 POST
        const response = await axios.post("/gmj/updateOD", orderDetails);
        console.log("updateOD 체킁 : ", response.data);

        // 예: response.data < 0 이면 성공이라면, 로직에 맞춰 처리
        if (response.data < 0) {
            Swal.fire({
                icon: 'success',
                title: '발주 상세 업데이트 성공!'
            });
        } else {
            Swal.fire({
                icon: 'error',
                title: '발주 상세 업데이트 오류!'
            });
        }
        return response.data;  
    } catch (error) {
        console.error("updateOD 에러 :", error);
        Swal.fire({
            icon: 'error',
            title: '발주 상세 업데이트 실패ㅠㅠ'
        });
        throw error;
    }
}

/* updateOrder, updateOD 실행 함수 */
async function update() {
    try {
        // 1) storeOrder UPDATE
        const resOrder = await updateOrder();

        // 2) storeOrderDetail UPDATE
        const resDetail = await updateOD();

        Swal.fire({
            icon: 'success',
            title: '발주 기안이 완료되었습니다.'
        });
        // 필요시 모달 닫기 or 페이지 새로고침
        $("#orderModal").modal("hide");
//         location.reload();

    } catch (err) {
        console.error("updateAll 에러 :", err);
    }
}



//******************2) 체크박스 자동 체크 시작 **********************
//배열에서 특정 값 삭제
function removeArr(val){
// 	let arr = ['a', 'b', 'b', 'c'];
	
	//원소 'b' 삭제
	for(let i = 0; i < checkboxArr.length; i++) {
		if(checkboxArr[i] === val)  {
			checkboxArr.splice(i, 1);
			 i--;
		}
	}
}

//체크박스가 체크된 값 모두 확인하기
function checkboxAll(){
	checkboxArr.forEach(function(val,idx){
		console.log("체크박스값 : ",val);
	});
}
//*****************2) 체크박스 자동 체크 시작 **********************


// 발주주문 - 품목 리스트
function getItemList(currentPage, keyword){
	let data = {
		"currentPage":nvl(currentPage, "1"),
		"keyword": $("input[name='keyword']").val()
	};
	
	console.log("data : ", data);
	
	axios.post('/gmj/orderAjax', data, {
		headers: {
	        'Content-Type': 'application/json;charset=utf-8'
	    }
	
	}).then(function (resp){
		const articlePage = resp.data;
		
		console.log("articlePage : ", articlePage);
		console.log("articlePage.content : ", articlePage.content);
		
		let str = "";
		
		articlePage.content.forEach(function(item, idx){
// 			console.log("item data: ", item);
		
			// 금액 천 단위 , 추가
			const fmtItemPrice = item.itemPrice.toLocaleString();
			const fmtSalePrice = item.salePrice.toLocaleString();
			
			str += `<tr>
					<td></td>
					<td class="text-center"><input type="checkbox" class="form-check-input item-checkbox" 
						data-item-no="\${item.itemNo}" 
						data-item-nm="\${item.itemNm}" 
						data-item-price="\${item.itemPrice}" 
						data-sale-price="\${item.salePrice}" value="\${item.itemNo}" />
					</td>
					<td class="text-center">\${item.itemNo}</td>
					<td class="text-center">\${item.itemNm}</td>
					<td class="text-end">\${fmtItemPrice}</td>
					<td class="text-end">\${fmtSalePrice}</td>
					</tr>`
					
// 			console.log("item.itemNo:", item.itemNo);
//          console.log("item.itemNm:", item.itemNm);
//          console.log("item.itemPrice:", item.itemPrice);
//          console.log("item.salePrice:", item.salePrice);
		});
	
		$("#itemtby").html(str);
		$(".divPagingArea").html(articlePage.pagingArea);
// 		$("#order .divPagingArea").html(articlePage.pagingArea);
		
		// 체크박스 선택 품목 발주 모달에 추가(동적)
        $("#itemtby").on("change", ".item-checkbox", function() {
			 insertSelectedItems();
        });
		
		
	  //******************3) 체크박스 자동 체크 시작 **********************
      //checkboxArr 값들을 통해 체크박스 자동 체크 처리
    	checkboxArr = JSON.parse(sessionStorage.getItem("checkboxArr"));
    	console.log("checkboxArr.length : " + checkboxArr.length);
    	for(let i=0;i<checkboxArr.length;i++){//배열에서 값을 꺼냄
    		console.log("checkboxArr : " + checkboxArr[i]);
    		$(".item-checkbox").each(function(){
    			console.log("개똥이2 : ",$(this).data("itemNo"));
    			if(checkboxArr[i]==$(this).data("itemNo")){
    				$(this).prop("checked",true);
    			}
    		});
    	}
    	
		//*******************3) 체크박스 자동 체크 시작 끝**********************
		
	}).catch(function (error){
		console.log("error :", error);
	});
		
}


//*******
//체크박스 전체 체크 ON
function fn_itemCheckboxOn(){
	$(".item-checkbox").prop("checked",true);
}

//체크박스 전체 체크 OFF
function fn_itemCheckboxOff(){
	$(".item-checkbox").prop("checked",false);
}


//탭 클릭 시 어떤 탭을 클릭했는지 기억해놓기
$(".nav-link").on("click",function(){		
	console.log("nav-link->tabId : ", tabId);
	tabId = $(this).data("id");
});
	
// keyword와 tabId 업데이트 함수***
function updKrdTabId() {
	var $currentTab = $(".tab-content > .tab-pane.active");
    keyword = $("input[name='keyword']").val();
//     tabId = $currentTab.attr("id"); 
}

//탭 전환 함수
function switchTab($tab, tabId) {

  tabId = $tab.attr("href");
	
  removeActive();
  $tab.addClass("active");
  $(".tab-pane").css("display", "none").addClass("fade");
  $(tabId).css("display", "block").removeClass("fade");
  updKrdTabId();
}	




/* 견적 리스트
function getEList(currentPage, keyword){
	let data = {
		"currentPage":nvl(currentPage, "1"),
		"keyword":nvl(keyword, "1"),
	};
	
	$.ajax({
		url:"/gmj/estimateAjax",
		contentType:"application/json;charset=utf-8",
		dataType : "json",
		data:JSON.stringify(data),
		type:"post",
		success:function(articlePage){
			
			console.log("articlePage : ", articlePage);
			console.log("articlePage.content : ", articlePage.content);
			
			let str = "";
			
			$.each(articlePage.content, function(idx,estimateVO){
				str += `<tr>
						<td>rnum</td>
						<td>\${estimateVO.estimateNo}</td>
						<td>\${estimateVO.storeOrderNo}</td>
						<td>\${estimateVO.estimateTitle}</td>
						<td>발주일</td>
						<td>발주 상태</td>
						</tr>`
			});
			
			$("#estimatetby").html(str);
			$("#divPagingArea").html(articlePage.pagingArea);
			
		}
	});
}
*/

//가맹점 발주/주문 리스트
function getOrderList(currentPage, keyword){

	let data = {
		"currentPage":nvl(currentPage, "1"),
		"keyword":$("input[name='keyword']").val()
	};
	
	$.ajax({
		url:"/gmj/orderList",
		contentType:"application/json;charset=utf-8",
		dataType : "json",
		data:JSON.stringify(data),
		type:"POST",
		success:function(articlePage){
			
			console.log("articlePage : ", articlePage);
			console.log("articlePage.content : ", articlePage.content);
			
			let str = "";
			
			$.each(articlePage.content, function(idx,storeOrderVO){

				let fmtstoreOrderDate = storeOrderVO.storeOrderDate ? storeOrderVO.storeOrderDate.split(" ")[0] : "-";
                let storeOrderStatus;
                let badgeClass;

                switch (storeOrderVO.storeOrderStatus) {
                    case 1:
                    	storeOrderStatus = "견적완료";
                        badgeClass = "badge bg-success"; 
                        break;
                    case 2:
                        storeOrderStatus = "미승인";
                        badgeClass = "badge bg-secondary"; 
                        break;
                    case 3:
                        storeOrderStatus = "회수";
                        badgeClass = "badge bg-warning"; 
                        break;
                    case 4:
                        storeOrderStatus = "반려";
                        badgeClass = "badge bg-danger"; 
                        break;
                }

// 			let storeOrderStatus = storeOrderVO.storeOrderStatus === 1 ? "견적완료" : "미승인";
			
				str += `<tr>
						   <td>
					   			<input type="checkbox" class="form-check-input item-checkbox" 
				   					data-store-no="\${storeOrderVO.storeNo}"
				   					data-store-order-no="\${storeOrderVO.storeOrderNo}"
				  			 		data-store-order-status="\${storeOrderVO.storeOrderStatus}" value="\${storeOrderVO.storeOrderNo}" />
		  			 		</td>
		                    <td class="noline" style="text-align:center;">\${storeOrderVO.rnum}</td>
						    <td class="noline" style="text-align:center;">\${storeOrderVO.storeOrderNo}</a></td>
						    <td class="noline" style="text-align:left;"><a href="#" data-bs-toggle="modal" data-bs-target="#odModal" class="orderDetail" data-store-order-no="\${storeOrderVO.storeOrderNo}" data-store-no="\${storeOrderVO.storeNo}">\${storeOrderVO.storeOrderTitle}</a></td>
		                    <td class="noline" style="text-align:center;">\${storeOrderVO.storeNo}호점</td>
		                    <td class="noline" style="text-align:center;">\${storeOrderVO.storeNm}</td>
		                    <td class="noline" style="text-align:right;">\${storeOrderVO.storeOrderSum.toLocaleString()}</td>
		                    <td class="noline" style="text-align:center;"><span class="\${badgeClass}">\${storeOrderStatus}</span></td>
		                    <td class="noline" style="text-align:center;">\${fmtstoreOrderDate}</td>
		                    <td class="noline" style="text-align:center;">`;
							/* 첨부파일이 있을 때 첨부파일의 저장경로 불러오기 */
			                if(storeOrderVO.fileGroupVO!=null){
			                	console.log("storeOrderVO.fileGroupVO.fileDetailVOList : ", storeOrderVO.fileGroupVO.fileDetailVOList);
					             $.each(storeOrderVO.fileGroupVO.fileDetailVOList,function(idx,fileDetailVO){ 
					                  str += `<button type="button" class="btn btn-outline-dark download" name="fileName" data-file="\${fileDetailVO.fileSaveLocate}" data-original-name="\${fileDetailVO.fileOriginalName}">
				                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-download" viewBox="0 0 16 16">
			                                        <path d="M.5 9.9a.5.5 0 0 1 .5.5v2.5a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1v-2.5a.5.5 0 0 1 1 0v2.5a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2v-2.5a.5.5 0 0 1 .5-.5"></path>
			                                        <path d="M7.646 11.854a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 10.293V1.5a.5.5 0 0 0-1 0v8.793L5.354 8.146a.5.5 0 1 0-.708.708z"></path>
			                                    </svg>
			                                     발주서
						                      </button>`;
					             });
			                }
               str += `</td>          
					   </tr>`;
			});
			
			$("#orderListtby").html(str);
			$("#orderList .divPagingArea").html(articlePage.pagingArea);
			
		}
	});
}

// 가맹점 발주 상세 조회 모달
function orderDetail(storeOrderNo) {
	console.log("체킁 storeOrderNo ");

	let data = {"storeOrderNo":storeOrderNo};
	console.log("data storeOrderNo : " + storeOrderNo);
	
	$.ajax({
		url:"/gmj/orderDetail",
		contentType:"application/json;charset=utf-8",
		data: JSON.stringify(data),
		type:"POST",
		dataType:"json",
		success: function(resp){
			const storeOrderVO = resp.storeOrderVO;
			const storeOrderDetailVO = resp.storeOrderDetailVO; 
			console.log("storeOrderVO : " + storeOrderVO);
			console.log("storeOrderDetailVO : " + storeOrderDetailVO);
			
            let totalQuantity = 0; 
            let totalPrice = 0;
            
            let fmtstoreOrderDate = storeOrderVO.storeOrderDate ? storeOrderVO.storeOrderDate.split(" ")[0] : "-";
            let storeOrderStatus;

            switch (storeOrderVO.storeOrderStatus) {
                case 1:
                	storeOrderStatus = "견적완료";
                    break;
                case 2:
                    storeOrderStatus = "미승인";
                    break;
                case 3:
                    storeOrderStatus = "회수";
                    break;
                case 4:
                    storeOrderStatus = "반려";
                    break;
            }

            
         	// 발주 상세 모달
			let modalContent = `
				<form class="form form-horizontal">
	            <h5 class="text-center my-4">발주 품목 정보</h5>
				<table class="table table-bordered text-center align-middle">
                <thead>
                    <tr>
                        <th class="text-center">발주 번호</th>
                        <th class="text-center">품목 번호</th>
                        <th class="text-center">품목 이름</th>
                        <th class="text-center">수량</th>
                        <th class="text-center">판매가</th>
                        <th class="text-center">총 금액</th>
                    </tr>
                </thead>
                <tbody>`;
              
                storeOrderDetailVO.forEach(detail => {    

                const quantity = detail.storeOrderAmount;  
                const itemTotal = parseFloat(detail.storeOrderPrice) * quantity;
                
                totalQuantity += quantity;
                totalPrice += itemTotal;
                
            	// 금액 천 단위 , 추가
				const fmtSOPrice = detail.storeOrderPrice.toLocaleString();
				const fmtItemTotal = itemTotal.toLocaleString();
				
                modalContent += `
                         <tr>
                             <td class="text-center">\${detail.storeOrderNo}</td>
                             <td class="text-center">\${detail.itemNo}</td>
                             <td class="text-center">\${detail.itemNm}</td>
                             <td class="text-center">\${detail.storeOrderAmount}</td>
                             <td class="text-end">\${fmtSOPrice}</td>
                             <td class="text-end">\${fmtItemTotal}</td>
                         </tr>`;
                         
                console.log("fmtSOPrice:", detail.storeOrderPrice);
                console.log("fmtSOPrice:", itemTotal);
             });

              modalContent += `
            	  		</tbody>
             	    		<tfoot>	
	                	        <tr style="border-top: 2px solid #ccc">
	                	            <td colspan="2" class="text-center"><strong>발주 총 수량</strong></td>
	                	            <td id="totalQuantity"><strong>\${totalQuantity}</strong></td>
	                	            <td colspan="2" class="text-center"><strong>발주 총 금액</strong></td>
	                	            <td id="totalPrice"><strong>\${totalPrice.toLocaleString()}</strong></td>
	                	        </tr>
	                	    </tfoot>
	                	</table>
	                	<input type="hidden" id="modalStoreNo" value="\${storeOrderVO.storeNo}">
	                    <input type="hidden" id="modalStoreOrderNo" value="\${storeOrderVO.storeOrderNo}">
	                    <input type="hidden" id="modalStoreOrderStatus" value="\${storeOrderVO.storeOrderStatus}">
	                	
	                	`;
	                	
	        // 발주서 기본 정보 추가
            modalContent += `
                <h5 class="text-center my-4">발주서 기본 정보</h5>
	                <div class="row mb-3">
					<div class="col-md-6 d-flex align-items-center">
						<label for="billNo" class="col-sm-3 col-form-label text-center">발주 번호</label>
						<div class="col-sm-9">
							<input type="text" class="form-control text-center" id="storeOrderNo" value="\${storeOrderVO.storeOrderNo}" readonly />
						</div>    
					</div>
					<div class="col-md-6 d-flex align-items-center">
						<label for="billDate" class="col-sm-3 col-form-label text-left">발주일</label>
						<div class="col-sm-9">
							<input type="text" class="form-control text-center" id="storeOrderDate" value="\${fmtstoreOrderDate}" readonly />
						</div>
					</div>
				</div>
	
				<div class="row mb-3">
					<div class="col-md-6 d-flex align-items-center">
						<label for="storeNo" class="col-sm-3 col-form-label text-left">가맹점 번호</label>
						<div class="col-sm-9">
							<input type="text" class="form-control text-center" id="storeNo" value="\${storeOrderVO.storeNo}" readonly />
						</div>    
					</div>
					<div class="col-md-6 d-flex align-items-center">
						<label for="storeNm" class="col-sm-3 col-form-label text-left">가맹점 이름</label>
						<div class="col-sm-9">
							<input type="text" class="form-control text-center" id="storeNm" value="\${storeOrderVO.storeNm}" readonly />
						</div>
					</div>
				</div>
				<div class="row mb-3">
					<div class="col-md-6 d-flex align-items-center">
						<label for="billTitle" class="col-sm-3 col-form-label text-left">제목</label>
						<div class="col-sm-9">
							<input type="text" class="form-control text-center" id="storeOrderTitle" value="\${storeOrderVO.storeOrderTitle}" readonly />
						</div>    
					</div>
					<div class="col-md-6 d-flex align-items-center">
						<label for="billStatus" class="col-sm-3 col-form-label text-left">발주 상태</label>
						<div class="col-sm-9">
							<input type="text" class="form-control text-center" id="storeOrderStatus" value="\${storeOrderStatus}" readonly />
						</div>
					</div>
				</div>
				</form>
                `;
	                	
				$('#odModal #modalContent').html(modalContent);
                $('#odModal').modal('show');
		},
		 error: function(xhr, status, error) {
	               console.error("발주 상세 오류 발생 : ", error);
	           }
		 });
  }
  
// 가맹점 발주 회수
function cancelOrder(selectedOrders){
    console.log("cancelOrder 체킁", selectedOrders);
   
    
    Swal.fire({
        title: '정말로 회수하시겠습니까?',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: '회수하기',
        cancelButtonText: '취소'
    }).then((result) => {
        if (result.isConfirmed) {
            $.ajax({
                url:"/gmj/cancelOrder",
                contentType:"application/json;charset=utf-8",
                data:JSON.stringify(selectedOrders),
                type:"PUT",
                dataType:"json",
                success:function(result){
                    console.log("result : ", result);
                    if (result > 0) { 
                        Swal.fire({
                            icon: 'success',
                            title: '발주 회수 성공',
                        }).then(() => {
                            location.reload(); 
                        });
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: '발주 회수 실패',
                            text: '처리된 항목이 없습니다.'
                        });
                    }
                },
                error: function (xhr, status, error) {
                    console.error("AJAX 요청 오류:", error);
                    Swal.fire({
                        icon: 'error',
                        title: '오류 발생',
                        text: '발주 회수 중 문제가 발생했습니다.'
                    });
                }
            });
        }
    });
}

// 발주 리스트에서 발주 다중 회수
function cancelOrderList(){
	 
    // 체크박스 선택
    let selectedOrders = [];
    $(".item-checkbox:checked").each(function() {
        const storeNo = $(this).data("store-no");
        const storeOrderNo = $(this).data("store-order-no");
        const storeOrderStatus = $("#storeOrderStatus").val(); 
        selectedOrders.push({
            storeNo: storeNo, 
            storeOrderNo: storeOrderNo,
            storeOrderStatus: storeOrderStatus
        });
    });
    
    if (selectedOrders.length === 0) {
        Swal.fire({
            icon: 'error',
            title: '선택된 항목이 없습니다.'
        });
        return;
    }

    console.log("selectedOrders:", selectedOrders);
    cancelOrder(selectedOrders);
}

// 발주 상세 모달 내 단일 발주 회수
$('#odModal').on('click', '#cancelOrder2Btn', function() {
	let storeOrderNo = $('#odModal #modalStoreOrderNo').val();
    let storeNo = $('#odModal #modalStoreNo').val();
    let storeOrderStatus = $('#odModal #modalStoreOrderStatus').val();
    
    console.log("발주 상세 모달 storeOrderNo:", storeOrderNo);
    console.log("발주 상세 모달 storeNo:", storeNo);
   
 	// 단일 발주 회수 요청
    let selectedOrders = [{
        storeNo: storeNo, 
        storeOrderNo: storeOrderNo,
        storeOrderStatus: storeOrderStatus
    }];
    
    cancelOrder(selectedOrders);
});

// 가맹점 계산서 발행 내역
function getBList(currentPage, keyword){
	//getList->keyword :
	console.log("getList->keyword : ", keyword);
	
	console.log("nav-link : " + $(".nav-link").length);
	
//         "keyword": nvl(keyword, "1"),
    let data = {
        "currentPage": nvl(currentPage, "1"),
     	"keyword": keyword,
    };
	console.log("getList->data : ", data);
	
    $.ajax({
        url:"/gmj/billAjax",
        contentType:"application/json;charset=utf-8",
        dataType : "json",
        data:JSON.stringify(data),
        type:"POST", 
        success:function(articlePage2){
            
            console.log("articlePage2 : ", articlePage2);
            console.log("articlePage2.content : ", articlePage2.content);
            
            let str = "";
            
            $.each(articlePage2.content, function(idx, billVO){

            	let billStatusClass = billVO.billStatus === "1" ? "badge bg-primary badge-style" : "badge bg-secondary badge-style";
            	let billStatus = billVO.billStatus === "1" ? "계산완료" : "미승인";

                let fmtBillDate = billVO.billDate ? billVO.billDate.split(" ")[0] : "-";
                console.log("fmtBillDate : " + fmtBillDate);
                
                str += `<tr>
                            <td class="text-center">\${billVO.rnum}</td>
                            <td class="text-center">\${billVO.billNo}</td>
                            <td class="text-start"><a href="#" class="billDetail" data-bill-no="\${billVO.billNo}" style="cursor: pointer;">\${billVO.billTitle || '-'}</a></td>
                            <td class="text-center">\${fmtBillDate}</td>
                            <td class="text-center" style="display: flex; justify-content: center; align-items: center;"><span class="\${billStatusClass}">\${billStatus}</span></td>
                            <td class="text-center">`;
                            /* 첨부파일이 있을 때 첨부파일의 저장경로 불러오기 */ 
                            if(billVO.fileGroupVO != null){
                                console.log("billVO.fileGroupVO.fileDetailVOList : ", billVO.fileGroupVO.fileDetailVOList);
                                $.each(billVO.fileGroupVO.fileDetailVOList, function(idx, fileDetailVO){ 
                                    str += `<button type="button" class="btn btn-outline-dark download" name="fileName" data-file="\${fileDetailVO.fileSaveLocate}">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-download" viewBox="0 0 16 16">
                                                    <path d="M.5 9.9a.5.5 0 0 1 .5.5v2.5a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1v-2.5a.5.5 0 0 1 1 0v2.5a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2v-2.5a.5.5 0 0 1 .5-.5"></path>
                                                    <path d="M7.646 11.854a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 10.293V1.5a.5.5 0 0 0-1 0v8.793L5.354 8.146a.5.5 0 1 0-.708.708z"></path>
                                                </svg>
                                                 계산서
                                            </button>`;
                                });
                            }
                           
                str += `</td>          
                        </tr>`;
            });
    
            $("#billtby").html(str);
            $("#bill .divPagingArea").html(articlePage2.pagingArea);
        }
    });
}

/* 계산 상세 조회 모달 */
function billDetail(billNo) {
    console.log("체킁 billDetail");

    let data = {"billNo": billNo};
    console.log("data : ", data);
    
    $.ajax({
        url: "/gmj/billDetail",
        contentType: "application/json;charset=utf-8",
        data: JSON.stringify(data),
        type: "POST",
        dataType: "json",
        success: function(resp){
            console.log("resp : ", resp);
            
            const billVO = resp.billVO;
            const storeOrderDetails = resp.storeOrderDetails;
            
            let storeNo = "";
            let storeNm = "";

            if (billVO && billVO.storeOrderVO) {
                storeNo = billVO.storeOrderVO.storeNo;
                storeNm = billVO.storeOrderVO.storeNm;
            }

            console.log("storeNo:", storeNo);
            console.log("storeNm:", storeNm);
            
            let totalQuantity = 0;
            let totalPrice = 0;
            
            let billStatus = billVO.billStatus === 1 ? "계산완료" : "반려";
            let fmtBillDate = billVO.billDate ? billVO.billDate.split(" ")[0] : "-";

            /*
            if (data.uploadFiles) {
                data.uploadFiles.forEach(file => {
                    $("#bdModal #uploadedFiles").append(`<li>\${file.originalName}</li>`);
                    $("#bdModal #uploadedFiles").append(`
                        <button type="button" class="btn btn-outline-dark download" name="fileName" data-file="\${file.fileSaveLocate}">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-download" viewBox="0 0 16 16">
                                <path d="M.5 9.9a.5.5 0 0 1 .5.5v2.5a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1v-2.5a.5.5 0 0 1 1 0v2.5a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2v-2.5a.5.5 0 0 1 .5-.5"></path>
                                <path d="M7.646 11.854a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 10.293V1.5a.5.5 0 0 0-1 0v8.793L5.354 8.146a.5.5 0 1 0-.708.708z"></path>
                            </svg>
                            \${file.originalName}
                        </button>`);
                });
            }
            */
            
            // 발주 품목 정보 생성
            let modalContent = `
            	<form class="form form-horizontal">
                <h5 class="text-center my-4">발주 품목 정보</h5>
                <table class="table table-bordered text-center align-middle">
                    <thead>
                        <tr>
                            <th class="text-center">발주 번호</th>
                            <th class="text-center">품목 번호</th>
                            <th class="text-center">품목 이름</th>
                            <th class="text-center">수량</th>
                            <th class="text-center">가격</th>
                            <th class="text-center">합계</th>
                        </tr>
                    </thead>
                    <tbody>`;

                storeOrderDetails.forEach(item => {
                const quantity = item.storeOrderAmount;
                const itemTotal = parseFloat(item.storeOrderPrice) * quantity;

                totalQuantity += quantity;
                totalPrice += itemTotal;

                modalContent += `
                    <tr>
                        <td>\${item.storeOrderNo}</td>
                        <td>\${item.itemNo}</td>
                        <td>\${item.itemNm}</td>
                        <td>\${quantity}</td>
                        <td>\${item.storeOrderPrice.toLocaleString()}</td>
                        <td>\${itemTotal.toLocaleString()}</td>
                    </tr>`;
            });

            modalContent += `
                    </tbody>
                    <tfoot>
                        <tr style="border-top: 2px solid #ccc;">
                            <td colspan="2" class="text-center"><strong>발주 총 수량</strong></td>
                            <td><strong>\${totalQuantity}</strong></td>
                            <td colspan="2" class="text-center"><strong>발주 총 금액</strong></td>
                            <td><strong>\${totalPrice.toLocaleString()}</strong></td>
                        </tr>
                    </tfoot>
                </table>`;

            // 계산서 기본 정보 추가
            modalContent += `
                <h5 class="text-center my-4">계산서 기본 정보</h5>
	                <div class="row mb-3">
					<div class="col-md-6 d-flex align-items-center">
						<label for="billNo" class="col-sm-3 col-form-label text-center">계산서 번호</label>
						<div class="col-sm-9">
							<input type="text" class="form-control text-center" id="billNo" value="\${billVO.billNo}" readonly />
						</div>    
					</div>
					<div class="col-md-6 d-flex align-items-center">
						<label for="billDate" class="col-sm-3 col-form-label text-center">계산일</label>
						<div class="col-sm-9">
							<input type="text" class="form-control text-center" id="billDate" value="\${fmtBillDate}" readonly />
						</div>
					</div>
				</div>
	
				<div class="row mb-3">
					<div class="col-md-6 d-flex align-items-center">
						<label for="storeNo" class="col-sm-3 col-form-label text-center">가맹점 번호</label>
						<div class="col-sm-9">
							<input type="text" class="form-control text-center" id="storeNo" value="\${storeNo}" readonly />
						</div>    
					</div>
					<div class="col-md-6 d-flex align-items-center">
						<label for="storeNm" class="col-sm-3 col-form-label text-center">가맹점 이름</label>
						<div class="col-sm-9">
							<input type="text" class="form-control text-center" id="storeNm" value="\${storeNm}" readonly />
						</div>
					</div>
				</div>
				<div class="row mb-3">
					<div class="col-md-6 d-flex align-items-center">
						<label for="billTitle" class="col-sm-3 col-form-label text-center">제목</label>
						<div class="col-sm-9">
							<input type="text" class="form-control text-center" id="billTitle" value="\${billVO.billTitle}" readonly />
						</div>    
					</div>
					<div class="col-md-6 d-flex align-items-center">
						<label for="billStatus" class="col-sm-3 col-form-label text-center">계산서 발행 상태</label>
						<div class="col-sm-9">
							<input type="text" class="form-control text-center" id="billStatus" value="\${billStatus}" readonly />
						</div>
					</div>
				</div>
				</form>
                `;

            $("#bdModal #modalContent").html(modalContent);
            $("#bdModal").modal("show");
        },
        error: function(xhr, status, error) {
            console.error("계산서 상세 에러 : ", error);
        }
    });
}	 

/* 가맹점 발주 현황 */
function getStatusList(){
    axios.post("/gmj/statusAjax", {
//         storeOrderDate: null, // 필요하면 필터 추가
        storeOrderStatus: null
    })
    .then(function (resp) {
        const data = resp.data;
        console.log("data:", data);

        // 테이블 업데이트
        updateTable(data);

        // 차트 업데이트
        updateCharts(data);
    })
    .catch(function (error) {
        console.error("status error :", error);
    });
}

// 테이블 업데이트 함수
function updateTable(data) {
    const tbody = document.querySelector("#statustby");
    tbody.innerHTML = ""; 

    let totalOrders = 0;
    let totalAmount = 0;

    data.forEach(item => {
        const statusText = getStatusText(item.storeOrderStatus);
        const orderCount = item.storeOrderCount || 0;
        const storeOrderSum = item.storeOrderSum || 0;

        totalOrders += orderCount;
        totalAmount += storeOrderSum;

        const row = `
            <tr>
                <td class="text-center">\${statusText}</td>
                <td class="text-center">\${orderCount}</td>
                <td class="text-end">\${storeOrderSum.toLocaleString()}</td>
            </tr>
        `;
        tbody.innerHTML += row;
    });

    // 총 건수 및 총 금액 업데이트
    document.getElementById("totalOrders").innerText = totalOrders;
//     document.getElementById("totalAmount").innerText = totalAmount.toLocaleString();
}

//차트 업데이트 함수 (막대 그래프와 원형 차트)
function updateCharts(data) {
    updateBarChart(data);
    updatePieChart(data);
}

// 막대 그래프 업데이트 함수
function updateBarChart(data) {
    const ctx = document.getElementById("statusChart").getContext("2d");

    const labels = data.map(item => getStatusText(item.storeOrderStatus));
    const counts = data.map(item => item.storeOrderCount);

    
    if (window.barChart instanceof Chart) {
        window.barChart.destroy();
    }

    window.barChart = new Chart(ctx, {
        type: "bar",
        data: {
            labels: labels,
            datasets: [{
                label: "발주 상태별 건수",
                data: counts,
                backgroundColor: ["#F38181", "#FCE38A", "#EAFFD0", "#95E1D3"],
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { position: 'bottom' }
            },
            scales: {
                y: { beginAtZero: true }
            }
        }
    });
}

// 원형 차트 업데이트 함수
function updatePieChart(data) {
    const ctx = document.getElementById("statusPieChart").getContext("2d");

    const labels = data.map(item => getStatusText(item.storeOrderStatus));
    const counts = data.map(item => item.storeOrderCount);

    
    if (window.pieChart instanceof Chart) {
        window.pieChart.destroy();
    }

    window.pieChart = new Chart(ctx, {
        type: "doughnut",
        data: {
            labels: labels,
            datasets: [{
                label: "발주 상태별 건수",
                data: counts,
                backgroundColor: ["#F38181", "#FCE38A", "#EAFFD0", "#95E1D3"], 
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { position: 'bottom' }
            }
        }
    });
}

// 상태 코드 -> 텍스트 변환 함수
function getStatusText(status) {
    switch (status) {
        case 1: return "견적완료";
        case 2: return "미승인";
        case 3: return "회수";
        case 4: return "반려";
    }
}

/* 엑셀 다운로드 함수 : html -> 엑셀로 변환
function exlDownload() {
  // 1) 엑셀용 HTML 기본 구조
  let tab_text = `
	<html xmlns:x="urn:schemas-microsoft-com:office:excel">
	<head>
	  <meta http-equiv="content-type" content="application/vnd.ms-excel; charset=UTF-8">
	  <xml>
	    <x:ExcelWorkbook>
	      <x:ExcelWorksheets>
	        <x:ExcelWorksheet>
	          <x:Name>Sheet</x:Name>
	          <x:WorksheetOptions>
	            <x:Panes></x:Panes>
	          </x:WorksheetOptions>
	        </x:ExcelWorksheet>
	      </x:ExcelWorksheets>
	    </x:ExcelWorkbook>
	  </xml>
	</head>
	<body>
	`;

  // 2) 모달 복제
  const clonedModal = $("#modalContent").clone();

  // 모달 input, span 값만 텍스트로 치환
  clonedModal.find("input").each(function() {
    const value = $(this).val();
    $(this).replaceWith(value);
  });
  clonedModal.find("span").each(function() {
    const text = $(this).text();
    $(this).replaceWith(text);
  });

  // 3) 발주 기본 정보 값 추출
  const storeOrderNo = clonedModal.find("#storeOrderNo").text() || clonedModal.find("#storeOrderNo").val();
  const storeOrderDate = clonedModal.find("#storeOrderDate").text() || clonedModal.find("#storeOrderDate").val();
  const storeNo = clonedModal.find("#storeNo").text() || clonedModal.find("#storeNo").val();
  const storeNm = clonedModal.find("#storeNm").text() || clonedModal.find("#storeNm").val();
  const storeOrderTitle = clonedModal.find("#storeOrderTitle").text() || clonedModal.find("#storeOrderTitle").val();

  // 4) 품목 상세 정보 테이블을 복제
  const detailTable = clonedModal.find("table").first().clone();
  const detailTableHtml = detailTable.prop("outerHTML");

  // 5) 최종 테이블 레이아웃
  tab_text += `
    <table border="1" style="border-collapse:collapse; width:80%;">
      <!-- 상단 제목 -->
      <tr>
        <td colspan="4" align="center" style="font-weight:bold; font-size:16px; height:40px;">
          발주서
        </td>
      </tr>

      <!-- 발주 기본 정보 제목 -->
      <tr>
        <td colspan="4" align="center" style="font-weight:bold; background:#f2f2f2;">
          발주 기본 정보
        </td>
      </tr>

      <!-- 발주 기본 정보: 2컬럼씩 -->
      <tr>
        <td style="width:20%; text-align:right;">발주 번호</td>
        <td style="width:30%;">\${storeOrderNo}</td>
        <td style="width:20%; text-align:right;">발주일</td>
        <td style="width:30%;">\${storeOrderDate}</td>
      </tr>
      <tr>
        <td style="text-align:right;">가맹점 번호</td>
        <td>\${storeNo}</td>
        <td style="text-align:right;">가맹점 이름</td>
        <td>\${storeNm}</td>
      </tr>
      <tr>
        <td style="text-align:right;">제목</td>
        <td>\${storeOrderTitle}</td>
      </tr>

      <!-- 품목 상세 정보 -->
      <tr>
        <td colspan="4" align="center" style="font-weight:bold; background:#f2f2f2;">
          품목 상세 정보
        </td>
      </tr>
      <tr>
        <td colspan="4">
          \${detailTableHtml}
        </td>
      </tr>
    </table>
  `;

  tab_text += `</body></html>`; 

  // 6) Blob으로 만들고 다운로드
 	const today = new Date();
    const formatDate = today.toISOString().slice(0, 10); 
    const fileName = `\${formatDate}_발주서.xls`;

  const blob = new Blob([tab_text], { type: "application/vnd.ms-excel;charset=utf-8;" });
  const link = document.createElement('a');
  link.href = URL.createObjectURL(blob);
  link.download = fileName;
  document.body.appendChild(link);
  link.click();
  document.body.removeChild(link);
}



	
 엑셀 다운로드 함수
function exlDownload() {
    let tab_text = '<html xmlns:x="urn:schemas-microsoft-com:office:excel">';
    tab_text += '<head><meta http-equiv="content-type" content="application/vnd.ms-excel; charset=UTF-8">';
    tab_text += '<xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet>';
    tab_text += '<x:Name>Sheet</x:Name>';
    tab_text += '<x:WorksheetOptions><x:Panes></x:Panes></x:WorksheetOptions></x:ExcelWorksheet>';
    tab_text += '</x:ExcelWorksheets></x:ExcelWorkbook></xml></head><body>';
    tab_text += "<table border='1px'>";

    // 모달 내부의 테이블 선택
    const modalTable = $('#modalContent table').first();
    if (modalTable.length === 0) {
        alert("내보낼 게 없는데용");
        return;
    }

    // 엑셀로 내보낼 데이터
    const clonedTable = modalTable.clone();
    clonedTable.find("input").each(function () {
        const value = $(this).val();
        $(this).replaceWith(value);
    });
    clonedTable.find("span").each(function () {
        const text = $(this).text();
        $(this).replaceWith(text);
    });

    // HTML에 추가
    tab_text += clonedTable.html();
    tab_text += '</table></body></html>';

    const data_type = 'data:application/vnd.ms-excel';
    const today = new Date();
    const formatDate = today.toISOString().slice(0, 10); 
    const fileName = `\${formatDate}_발주.xls`;

    // 파일 다운로드 처리
    const blob = new Blob([tab_text], { type: "application/vnd.ms-excel;charset=utf-8;" });
    const link = document.createElement('a');
    link.href = URL.createObjectURL(blob);
    link.download = fileName;
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
}
*/


</script>


