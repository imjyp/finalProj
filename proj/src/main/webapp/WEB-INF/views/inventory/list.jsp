<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>

<link rel="stylesheet" href="/css/common2.css">
<!-- sweetAlert -->
<link rel="stylesheet" href="/css/sweetalert2.min.css">

<script type="text/javascript" src="/js/sweetalert2.min.js"></script>
<sec:authorize access="isAuthenticated()">
	<%-- <p>개똥이 : <sec:authentication property="principal"/></p> --%>
	<%@ include file="../include/header.jsp"%>
</sec:authorize> 
		<style>
	    #table1 th, #table1 td {
	        text-align: center;
	        vertical-align: middle; /* 세로 정렬도 가운데로 */
		    }
		 
		 .modal-body .table-responsive {
			    display: grid;
			    overflow-y: auto;
			    max-height: 500px; /* 테이블의 최대 높이 설정 */
			}
	
	  
	  /* 검색 폼 아래에 여백 추가 */
	  .dataTable-top{
	    margin-bottom: 50px !important; /* 필요에 따라 값 조정 */
	  }
	  
	  /* 페이지네이션 위에 여백 추가 */
	  .card-footer {
	    margin-top: 50px; /* 필요에 따라 값 조정 */
	  }
	  
	 
	
	.swal-body{
		font-family : 'NotoSansKR' ; 
		font-size :500 !important;
	}
	#main {
				  margin-top: 140px !important;
				}
		</style>
<%@ include file="../include/top.jsp"%>
	<div id="main"> 
<div class="card">
	<div class="card-header">
	    <div class="container-fluid">
	      <div class="row align-items-center">
		<!-- 제목과 브레드크럼 -->
		<div class="col-md-6 d-flex align-items-center">
	          <nav aria-label="breadcrumb" class="ms-3">
	            <ol class="breadcrumb mb-0">
	            <li class="breadcrumb-item"><a href="/main">Home</a></li>
	            <li class="breadcrumb-item active"><a href="/inventory/list">재고현황</a></li>
	         </ol>
          </nav>
        </div>
	</div>
  </div>	
</div>	
	<section class="section">
		<div class="card-content">
			<div class="card-body align-items-center justify-content-between" style="margin-bottom: 20px;">
            <div class="dataTable-top" style="justify-content: right; width: 100%; ">
            <div class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
					<div class="dataTable-top">
						<div class="dataTable-search" style="display:flex; flex: 1;">
							<input type="text" id="keyword" name="keyword" class="dataTable-input" 
							placeholder="검색어 입력" value="${param.keyword}" aria-controls="tby">
								<button type="button" id="search" style="margin-left:10px;"
									class="btn btn-warning rounded-pill">검색</button>
						
					
						<div style="margin-left: auto; display: flex; gap: 10px; justify-content: flex-end">
							<button type="button" id="create" class="btn btn-outline-dark rounded-pill">재고 등록</button>
							<div id="spn3" class="modal-footer" style=" flex-start; display:block" >
								<button type="button" id="safetyAmount" class="btn btn-outline-dark rounded-pill">안전재고 변경</button>
							</div>
							<div id="spn2" class="modal-footer" style=" flex-start; display:none" >
			                    <button type="button" id="safetyCommit" class="btn btn-primary" >
			                        <i class="bx bx-x d-block d-sm-none"></i>
			                        <span class="d-none d-sm-block rounded-pill">저장</span>
			                    </button>
			                    <button type="button" id="safetyCancel" class="btn btn-danger" data-bs-dismiss="modal">
			                        <i class="bx bx-check d-block d-sm-none"></i>
			                        <span class="d-none d-sm-block rounded-pill">취소</span>
			                    </button>
			                </div>
						</div>
					</div>	
					</div>
					</div>
					<div class="tableType01" style="width:100% !important">
						<table class="board" id="table1">
							<thead>
								<tr>
									<th style="width:80px">순번</th>
									<th>품목 이름</th>
				                    <th>재고수량</th>
				                    <th>안전재고 수량</th>
				                    <th>유통기한</th>
				                    <th>평균매입가(원)</th>
				                    <th>판매가(원)</th>
				                    <th>판매여부</th>
				                    <th>입/출고</th>
								</tr>
							</thead>
							<tbody id="tby">
							</tbody>
						</table>
						</div>
						</div>
					  <div class="card-footer">
       			 <nav aria-label="Page navigation example">
					<div class="pagination pagination-warning justify-content-center" id="divPagingArea"></div>
				 </nav>
				</div>
				</div>
				</div>
	</section>
</div>
<!-- 입고내역 모달 시작 -->
<div class="modal fade text-left" id="inlineForm" tabindex="-1" aria-labelledby="myModalLabel33"  aria-modal="true" role="dialog">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-xl" role="document">
        <div class="modal-content">
            <form action="/resource/update" method="post" enctype="multipart/form-data" >
	            <div class="modal-header">
	                <h4 class="modal-title" id="modalItemNm" class="boardTitle"></h4>
	                
	                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
	            </div>
                <div class="modal-body">
                    <div class="table-responsive">
                    	<input type="hidden" id="modalItemNo" />
						<table class="table table-hover mb-0" id="table1">
							<thead>
								<tr>
									<th>순번</th>
									<th>발주번호</th>
									<!-- <th>담당자(임시)</th> -->
									<th>발주 수량</th>
				                    <th>남은 수량</th>
				                    <th>입고날짜</th>
				                    <th>유통기한</th>
				                    <th>매입가</th>
								</tr>
							</thead>
							<tbody id="tby2">
							</tbody>
						</table>
				  </div>
						<div class="pagination pagination-warning justify-content-center" id="divPagingArea2" style="display: flex; 
					justify-content: center; align-items: center;  margin-top: 20px;"></div>
						</div>
				 
            </form>
        </div>
    </div>
</div>
</div>
<!-- 입고내역 모달 끝 -->
<!-- 출고내역 모달 시작 -->
<div class="modal fade text-left" id="inlineForm2" tabindex="-1" aria-labelledby="myModalLabel33"  aria-modal="true" role="dialog">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-xl" role="document">
        <div class="modal-content">
            <form action="/resource/update" method="post" enctype="multipart/form-data" >
	            <div class="modal-header">
	                <h4 class="modal-title" id="modalItemNm2" class="boardTitle"></h4>
	                
	                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
	            </div>
                <div class="modal-body">
                    <div class="table-responsive">
                    	<input type="hidden" id="modalItemNo2" />
						<table class="table table-hover mb-0" id="table2">
							<thead>
								<tr>
									<th>순번</th>
									<th>출고번호</th>
									<th>가맹점명</th>
									<th>출고수량</th>
				                    <th>출고날짜</th>
				                    <th>유통기한</th>
				                    
								</tr>
							</thead>
							<tbody id="tby3">
							</tbody>
						</table>
				  </div>
						<div class="pagination pagination-warning justify-content-center" id="divPagingArea3" style="display: flex; 
					justify-content: center; align-items: center;  margin-top: 20px;"></div>
						</div>
				 
            </form>
        </div>
    </div>
</div>
<!-- 출고내역 모달 끝 -->
<!-- 입고 등록 모달 시작 -->
<div class="modal fade text-left" id="modalCreate" tabindex="-1" aria-labelledby="myModalLabel33"  aria-modal="true" role="dialog">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-xl" role="document">
        <div class="modal-content">
            <form action="/inventory/create" method="post" >
	            <div class="modal-header">
	                <h4 class="modal-title" class="boardTitle">재고 등록</h4>
	                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
	                
	            </div>
                <div class="modal-body">
                    <div class="table-responsive">
						<table class="table table-hover mb-0" id="table2">
							<thead>
								<tr>
									<th style="width: 120px;">발주번호</th>
									<th>품목명</th>
									<th style="width: 100px;">발주 수량</th>
				                    <th >유통기한</th>
				                    <th style="width: 120px;">매입가</th>
								</tr>
							</thead>
							<tbody id="tby3">
								<tr class="inventory-row">
									<td><input type="text" name="headOrderNo" class="form-control"></td>
									<td><select name="itemNo" class="form-control itemDropdown" style = "overflow-y: auto;">
			                                <option value="">품목 선택</option>
			                            </select></td>
									<td><input type="number" name="recordAmount" class="form-control"></td>
				                    <td><input type="date" name="expDate" class="form-control"></td>
				                    <td><input type="text" name="recordItemPrice" class="form-control"></td>
								</tr>
							</tbody>
						</table>
						<button type="button" id="addRow" class="btn btn-success mt-2">+ 추가</button>
						</div>
				  </div>
                <div id="spn" class="modal-footer" style=" flex-start;" >
                    <button type="button" id="commit" class="btn btn-light-secondary" >
                        <i class="bx bx-x d-block d-sm-none"></i>
                        <span class="d-none d-sm-block">등록</span>
                    </button>
                    <button type="button" id="cancel" class="btn btn-primary ms-1" data-bs-dismiss="modal">
                        <i class="bx bx-check d-block d-sm-none"></i>
                        <span class="d-none d-sm-block">취소</span>
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>	
<!-- 입고 등록 모달 끝 -->

<script type="text/javascript">


	
	

	function formatNumber(value) {
	    return value.toLocaleString(); // 숫자를 천 단위로 ',' 추가
	}
	
	// itemDel 값 변환 함수
    function formatItemDel(value) {
        return value == 1 ? "판매중" :"품절" ;
    }
	//
    function formatRemainAmount(value) {
        return value < 0 ? "0" : value;
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
			url:"/inventory/inventoryListAjax",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"json",
			success:function(result){
				console.log("result: ",result);
				
				let str="";
				
				
				$.each(result.content,function(idx,itemVO){
					
					
				//console.log("체킁: ",idx,sanctionDocVO);
					str+=`<tr class="item-row">
						 <td>\${itemVO.rnum}</td>
						 <td>\${itemVO.itemNm}</td>
		                  <td>\${itemVO.remainAmount}</td>
		                  <td>
		                  	<input type="number" name="safetyAmount" style="width:100px; margin-left:30px" class="form-control text-center" value="\${itemVO.safetyAmount}" disabled>
		                  </td>
		                  <td>\${itemVO.expDate}</td>													
		                  <td style="text-align: right; width:80px;">\${formatNumber(itemVO.avgPurchasePrice)}</td>													
		                  <td style="text-align: right; width:80px;">\${formatNumber(itemVO.salePrice)}</td>													
		                  <td>\${formatItemDel(itemVO.itemDel)}</td>													
		                  <td><button data-bs-toggle="modal" data-bs-target="#inlineForm" 
		                  		data-item-no = \${itemVO.itemNo} data-item-nm= \${itemVO.itemNm} class="btn btn-primary exam">
			                  입고</button>
		                  	  <button data-bs-toggle="modal" data-bs-target="#inlineForm2" 
		                  		data-item-no = \${itemVO.itemNo} data-item-nm= \${itemVO.itemNm} class="btn btn-danger exam2">
			                  출고</button>
			              </td>													
		                  </tr>`;
				});
				// <tbody id="tby">에 목록 추가
				$("#tby").html(str);
				
				
				
				//페이징처리
				 $("#divPagingArea").html(result.pagingArea); 
			}//end success
				
		});//end ajax
	}//end getList함수
	
	function getDetail(currentPage, itemNo){
		
		currentPage = nvl(currentPage,"1");
		
		let data = {
			"currentPage":currentPage,
			"itemNo":itemNo
		};
	
		console.log("data: ",data);
		
		$.ajax({
			url:"/inventory/inventoryDetailAjax",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"json",
			success:function(result){
				console.log("result: ",result);
				
				let str="";
				$.each(result.content,function(idx,inventoryVO){
					
				//console.log("체킁: ",idx,sanctionDocVO);
					str+=`<tr>
						 <td>\${inventoryVO.rnum}</td>
						 <td>\${inventoryVO.headOrderNo}</td>
		                  <td>\${inventoryVO.recordAmount}</td>													
		                  <td>\${formatRemainAmount(inventoryVO.remainAmount)}</td>													
		                  <td>\${inventoryVO.recordRegDate}</td>													
		                  <td>\${inventoryVO.expDate}</td>													
		                  <td  style="text-align: right;">\${formatNumber(inventoryVO.recordItemPrice)}</td>													
		                  </tr>`;
				});
				// <tbody id="tby">에 목록 추가
				$("#tby2").html(str);
				
				
				//페이징처리
				 $("#divPagingArea2").html(result.pagingArea); 
			}//end success
				
		});//end ajax
	}//end getDetail함수
	//품목별 출고
	function getOutgoing(currentPage, itemNo){
		
		currentPage = nvl(currentPage,"1");
		
		let data = {
			"currentPage":currentPage,
			"itemNo":itemNo
		};
	
		console.log("data: ",data);
		
		$.ajax({
			url:"/inventory/inventoryOutgoingAjax",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"json",
			success:function(result){
				console.log("result: ",result);
				
				let str="";
				$.each(result.content,function(idx,inventoryVO){
					
				//console.log("체킁: ",idx,sanctionDocVO);
					str+=`<tr>
						 <td>\${inventoryVO.rnum}</td>
						 <td>\${inventoryVO.storeOrderNo}</td>
						 <td>\${inventoryVO.storeNm}</td>
		                  <td>\${inventoryVO.recordAmount}</td>													
		                  <td>\${inventoryVO.recordRegDate}</td>													
		                  <td>\${inventoryVO.expDate}</td>													
		                  </tr>`;
				});
				// <tbody id="tby">에 목록 추가
				$("#tby3").html(str);
				
				
				//페이징처리
				 $("#divPagingArea3").html(result.pagingArea); 
			}//end success
				
		});//end ajax
	}//end getDetail함수
	
	function getInventory(){
		
		$.ajax({
			url:"/inventory/getItemAjax",
			contentType:"application/json;charset=utf-8",
			type:"get",
			success:function(result){
				console.log("result: ",result);
				
				let dropdown = $(".itemDropdown");
				
				$.each(result,function(idx,itemVO){
					dropdown.append(`<option value="\${itemVO.itemNo}">\${itemVO.itemNm}</option>`);
				
				});
				
			}//end success
				
		});//end ajax
	}//end getInventory함수
	
	function safetyCheck(){
		$("tr").each(function () {
			let remainAmountTd = $(this).find("td:nth-child(3)");
	        let safetyAmount = parseInt($(this).find("input[name='safetyAmount']").val());
	        let remainAmount = parseInt(remainAmountTd.text().trim());

	        if (remainAmount < safetyAmount) {
	            remainAmountTd.css("color", "red");
	        }
	    });
	}
	
	$(function(){
		
		
		//페이지 로딩 시 초기값으로 getList 호출
		getList("${param.currentPage}","");
		
		//console.log("개똥이");
		//안전재고 위험 시 이벤트
		safetyCheck();
		
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
		
		//페이지 클릭 처리(Modal 전용) -> 동적요소
		$(document).on("click",".clsPagingAreaModal",function(){
			
			let currentPage = $(this).data("currentPage");
			let keyword = "";
			
			/* 클릭한 항목의 모달에 임시 저장해놓은 itemNo 데이터를 가져옴 */
			let itemNo = $("#modalItemNo").val();
			
				console.log("itemNo: ",itemNo);
			
			getDetail(currentPage,itemNo);
		});
		
			
		//입고내역 모달 활성화 시작
		 $(document).on("click",".exam",function(){
			$("#inlineForm").modal("show");
			
			/* 클릭한 항목의 sanctionDocVO 데이터를 가져옴 */
			let itemNo = $(this).data("itemNo");
			let itemNm = $(this).data("itemNm");
			
				console.log("itemNo: ",itemNo);
				console.log("itemNm: ",itemNm);
				
				getDetail(1,itemNo);
				$("#modalItemNo").val(itemNo);
				$("#modalItemNm").text(itemNm);
		}); //입고내역 모달 활성화 끝
		
		//출고내역 모달 활성화 시작
		 $(document).on("click",".exam2",function(){
			$("#inlineForm2").modal("show");
			
			/* 클릭한 항목의 sanctionDocVO 데이터를 가져옴 */
			let itemNo = $(this).data("itemNo");
			let itemNm = $(this).data("itemNm");
			
				console.log("itemNo: ",itemNo);
				console.log("itemNm: ",itemNm);
				
				getOutgoing(1,itemNo);
				$("#modalItemNo2").val(itemNo);
				$("#modalItemNm2").text(itemNm);
		}); //입고내역 모달 활성화 끝

		//재고등록 모달 활성화 시작
		 $("#create").on("click",function(){
			$("#modalCreate").modal("show");
			getInventory();
			
			/* 클릭한 항목의 sanctionDocVO 데이터를 가져옴 */
			
		}); //재고등록 모달 활성화 끝
		
		 $(document).on("input","input[name='recordItemPrice']", function () {
			 let value = $(this).val().replace(/[^0-9]/g, ""); // 숫자 이외 문자 제거
			    if (value !== "") {
			        $(this).val(formatNumber(Number(value)));
			    }
		    });

		  // 폼 제출 시 ',' 제거 후 숫자만 전송
		  $("#commit").on("click", function () {
		    	event.preventDefault();
		    	
		       
		        let formData = [];
		        
		        $(".inventory-row").each(function(){
		        	let headOrderNo = $(this).find("input[name='headOrderNo']").val();	
		        	let itemNo = $(this).find("select[name='itemNo']").val();	
		        	let recordAmount = $(this).find("input[name='recordAmount']").val();	
		        	let expDate = $(this).find("input[name='expDate']").val();	
		        	let recordItemPrice = $(this).find("input[name='recordItemPrice']").val().replace(/,/g,"");	
		        
		        
		        	let data = {
		        			"headOrderNo":headOrderNo,
		        			"itemNo":itemNo,
		        			"recordAmount":recordAmount,
		        			"expDate":expDate,
		        			"recordItemPrice":recordItemPrice
		        			
		        	}
		        	formData.push(data);
		        })
		        
		        console.log("formData: ",formData);
		        
		        $.ajax({
		            url: "/inventory/create",
		            contentType:"application/json;charset=utf-8",
		            type: "post",
		            data: JSON.stringify(formData),
		            success: function (response) {
		                //alert("등록이 완료되었습니다!"); // 성공 메시지
		                Swal.fire({
		  				  icon: "success",
		  				  title: '등록이 완료되었습니다!',
		  				  showConfirmButton: false,
		  				  timer: 1500
		       		}).then((result) => {
		       		
		       			location.reload(); // 페이지 새로고침 
		             	
		             })
		            },
		            error: function (xhr, status, error) {
		            	Swal.fire({
							  icon: "warning",
							  title: "오류가 발생했습니다."
			              });
		            }
		        });
		    });
		
		    $("#addRow").on("click", function () {
		        let newRow = `
		            <tr class="inventory-row">
		                <td><input type="text" name="headOrderNo" class="form-control"></td>
		                <td>
		                    <select name="itemNo" class="form-control itemDropdown">
		                        <option value="">품목 선택</option>
		                    </select>
		                </td>
		                <td><input type="number" name="recordAmount" class="form-control"></td>
		                <td><input type="date" name="expDate" class="form-control"></td>
		                <td><input type="text" name="recordItemPrice" class="form-control purchasePrice"></td>
		                <td><button type="button" class="btn btn-danger removeRow">삭제</button></td>
		            </tr>`;
		        $("#tby3").append(newRow);
		        getInventory(); // 추가된 행의 품목 목록 업데이트
		    });
		    
		 // 삭제 버튼 클릭 시 해당 행 삭제
		    $(document).on("click", ".removeRow", function () {
		        $(this).closest(".inventory-row").remove();
		    });
		 
		 //안전재고 수량 등록 버튼 시작
		 	$("#safetyAmount").on("click",function(){
		 		
		 		
		 	
		 		$("#spn3").css("display", "none");
		 		$("#spn2").css("display", "block");
			 	$("input[name='safetyAmount']").removeAttr("disabled");
			 	//기존 안전재고 수량 저장
			 	$("input[name='safetyAmount']").each(function(){
			 		$(this).attr("data-original",$(this).val());
			 		
			 	})//기존 안전재고 수량 저장 끝
		 	})
		 //안전재고 수량 등록 버튼 끝
		 	$("#safetyCancel").on("click", function() {
		       location.reload();
		    });
		 
		 //안전재고 저장 버튼 시작
		 $("#safetyCommit").on("click",function(){
			 
			 let formData = [];
			 
			 $(".item-row").each(function(){
				 
				 let originalAmount = parseInt($(this).find("input[name='safetyAmount']").data("original"));
				 let modifiedAmount = parseInt($(this).find("input[name='safetyAmount']").val());
				 let itemNo = $(this).find(".exam").data("itemNo");
				 console.log("originalAmount: ",originalAmount);
				 console.log("modifiedAmount: ",modifiedAmount);
				 console.log("itemNo: ",itemNo);
				 
				 if(originalAmount !== modifiedAmount){
					 let data = { "itemNo":itemNo,
							 	  "safetyAmount":modifiedAmount
					 			}
					 formData.push(data);
					 
				 }
			 })
			 
			 console.log(formData);
			 
			 if (formData.length === 0) {
		            Swal.fire({
						  icon: "warning",
						  title: "변경된 데이터가 없습니다."
		              });
		            return;
		        }
			 $.ajax({
				
				 url:"/inventory/updateSafetyAmount",
				 contentType:"application/json;charset=utf-8",
				 data:JSON.stringify(formData),
				 type:"post",
				 success:function(result){
					 
					 console.log("result: ", result);
					 Swal.fire({
		  				  icon: "success",
		  				  title: '안전재고가 성공적으로 변경되었습니다!',
		  				  showConfirmButton: false,
		  				  timer: 1500
		       		}).then((result) => {
		       		
		       			location.reload(); // 페이지 새로고침 
		             	
		             })
					
				 },
		            error: function (xhr, status, error) {
		                Swal.fire({
							  icon: "warning",
							  title: "오류가 발생했습니다."
			              });
		            }
				 
			 })
			 
			 
		 })
		 
	});//end 달러function
</script>

<%@ include file="../include/footer.jsp"%>