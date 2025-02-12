<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/common2.css">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<%@ include file="../include/header.jsp"%>
    <style>
        .search-container {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }
        
        .table th, .table td {
        	text-align: center;
            vertical-align: middle;
            white-space: nowrap;  
            padding: 8px;         
        }
        .table {
            min-width: 100%;     
            margin-left: 10px;    
        }
        .pagination {
            margin-bottom: 0;
        }
        .main-content {
            padding: 50px;
            margin-left: 300px;  
        }
        .page-heading {
            margin-bottom: 20px;
        }
        .modal-dialog {
            max-width: 600px;
        }
        .table-responsive {
               
            padding-left: 15px;  
        }
        .checkbox-column {
            width: 40px;        
            min-width: 40px;    
            text-align: center; 
        }
        .action-column {
            width: 120px;       
            min-width: 120px;   
        }
        
        .search-container {
    display: flex;
    gap: 10px;
    margin-bottom: 20px;
    align-items: center;  /* 수직 정렬 추가 */
}

.search-container input,
.search-container button {
    height: 38px;        /* 버튼과 입력창 높이 통일 */
    line-height: 1.5;    /* 텍스트 수직 정렬 */
    padding: 0.375rem 0.75rem;  /* 패딩 조정 */
}

.search-container .btn {
    display: inline-flex;
    align-items: center;
    justify-content: center;
}

/* 기존 input 스타일 수정 */
.search-container input {
    width: 300px;
    height: 38px;
}


#best{
	width: 200px;
}
#tby tr {
  cursor: pointer;
}        
 /* 검색 폼 아래에 여백 추가 */
	  .dataTable-top{
	    margin-bottom: 50px !important; /* 필요에 따라 값 조정 */
	  }
	  
	  /* 페이지네이션 위에 여백 추가 */
	  .card-footer {
	    margin-top: 50px; /* 필요에 따라 값 조정 */
	  }
	  .container-fluid {
				  margin-top: 70px !important;
				}
    </style>


<div class="container-fluid" >
    <div class="main-content">
    <%@ include file="../include/top.jsp" %>
    	<div class="card-header">
	    <div class="container-fluid">
	      <div class="row align-items-center">
		<!-- 제목과 브레드크럼 -->
		<div class="col-md-6 d-flex align-items-center">
	          <nav aria-label="breadcrumb" class="ms-3">
	            <ol class="breadcrumb mb-0">
	            <li class="breadcrumb-item"><a href="/main">Home</a></li>
	            <li class="breadcrumb-item active"><a href="/inventory/gmjGR">가맹점 출고</a></li>
	         </ol>
          </nav>
        </div>
	</div>
  </div>	
</div>	
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-header">
                        <div class="input-group" style="width: 400px; display: width: 100%; display: flex; align-items: center; gap: 10px;">
							<div class="dataTable-top">
						<div class="dataTable-search" style=" flex: 1;">
							<input type="text" id="keyword" name="keyword" class="dataTable-input" 
							placeholder="검색어 입력" value="${param.keyword}" aria-controls="tby">
								<button type="button" id="search"
									class="btn btn-warning rounded-pill">검색</button>
						</div>
					</div>
						</div>
                    </div>
                    <div class="card-body">
                        <div class="tableType01" style="width:100% !important">
                            <table class="board" id="table1">
                                <thead  style="text-align:center">
                                    <tr>
                                        <th style="width: 10%;">순번  </th>
                                        <th style="width: 10%;">가맹점 이름</th>
                                        <th style="width: 30%;">가맹점 주소</th>
                                        <th style="width: 10%;">우편번호</th>
                                        <th style="width: 10%;">가맹 일자</th>
                                        <th style="width: 10%;">가맹 상태</th>
                                    </tr>
                                </thead>
                                <tbody id="tby">
                                </tbody>
                            </table>
                        </div>
                        
                       <div class="card-footer">
       			 <nav aria-label="Page navigation example">
					<div class="pagination pagination-warning justify-content-center" id="divPagingArea"></div>
				 </nav>
				</div>
                        
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
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
									<th>출고품목</th>
									<th>수량</th>
				                    <th>출고날짜</th>
				                    <th>유통기한</th>
				                    
								</tr>
							</thead>
							<tbody id="tby3">
    <tr>
        <td>1</td>
        <td>301</td>
        <td>디카페인 원두 (1kg)</td>
        <td>10</td>
        <td>2024-01-02</td>
        <td>2025-01-02</td>
    </tr>
    <tr>
        <td>2</td>
        <td>302</td>
        <td>에스프레소 원두 (1kg)</td>
        <td>15</td>
        <td>2024-01-05</td>
        <td>2025-01-05</td>
    </tr>
    <tr>
        <td>3</td>
        <td>303</td>
        <td>콜드브루 농축액 (1kg)</td>
        <td>8</td>
        <td>2024-01-08</td>
        <td>2024-07-08</td>
    </tr>
    <tr>
        <td>4</td>
        <td>304</td>
        <td>빨대 (100개)</td>
        <td>30</td>
        <td>2024-01-10</td>
        <td>2026-01-10</td>
    </tr>
    <tr>
        <td>5</td>
        <td>305</td>
        <td>페트컵 (50개)</td>
        <td>50</td>
        <td>2024-01-12</td>
        <td>2026-01-12</td>
    </tr>
    <tr>
        <td>6</td>
        <td>306</td>
        <td>디카페인 원두 (1kg)</td>
        <td>12</td>
        <td>2024-01-15</td>
        <td>2025-01-15</td>
    </tr>
    <tr>
        <td>7</td>
        <td>307</td>
        <td>에스프레소 원두 (1kg)</td>
        <td>18</td>
        <td>2024-01-18</td>
        <td>2025-01-18</td>
    </tr>
    <tr>
        <td>8</td>
        <td>308</td>
        <td>콜드브루 농축액 (1kg)</td>
        <td>6</td>
        <td>2024-01-21</td>
        <td>2024-07-21</td>
    </tr>
    <tr>
        <td>9</td>
        <td>309</td>
        <td>빨대 (100개)</td>
        <td>40</td>
        <td>2024-01-25</td>
        <td>2026-01-25</td>
    </tr>
    <tr>
        <td>10</td>
        <td>310</td>
        <td>페트컵 (50개)</td>
        <td>60</td>
        <td>2024-01-28</td>
        <td>2026-01-28</td>
    </tr>
</tbody>


		</table>
						<ul class="pagination pagination-warning justify-content-center" >
                            <li class="page-item"><a class="page-link" href="#">Prev</a></li>
                            <li class="page-item active"><a class="page-link" href="#">1</a></li>
                            <li class="page-item"><a class="page-link" href="#">2</a></li>
                            <li class="page-item"><a class="page-link" href="#">Next</a></li>
                        </ul>
				  </div>
				</div>	
				 
            </form>
        </div>
    </div>
</div>
<!-- 출고내역 모달 끝 -->









<%@ include file="../include/footer.jsp"%>
<script type="text/javascript" src="/js/signup.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=86230698ce774a3d05d0780b53b5009b"></script>


<script>

let data={	"currentPage":"1",
		"keyword":"",};

let keyword= $("#keyword").val();
data.keyword=keyword;
data.currentPage="1";


$("#best").on('click',function(){
	//순위, 월평균 실적
	$(".modal2").modal("show");
	
})

list();

function list(){
$.ajax({
	url:"/gmjAjax",
	contentType:"application/json;charset=utf-8",
	data:JSON.stringify(data),
	type:"post",
	dataType:"json",
	success:function(result){
		console.log("아작스 응답:",result);
		
		let str = "";
		let num = 1;
		$.each(result.content, function(idx, map){
			let statusText = map.storeStatus === 'Y' ? '가맹중' : '폐업';
			str+=`<tr  style="text-align:center">
				
                <td>\${num}</td>
                <td>\${map.storeNm}</td>
                <td class="text-bold-500">\${map.storeAddr1} \${map.storeAddr2}</td>
                <td>\${map.storeZip}</td>
                <td>\${map.storeOpenDate}</td>
                <td>\${statusText}</td>
            </tr>`;
            num++;
		})
		$("#tby").html(str);
		$("#divPagingArea").html(result.pagingArea);
		
	}
})
}
//품목별 출고
function getOutgoing(currentPage, itemNo){
	
	currentPage = nvl(currentPage,"1");
	
	let data = {
		"currentPage":currentPage,
		"itemNo":itemNo
	};

	console.log("data: ",data);
	
	$.ajax({
		url:"/inventory/storeItemAjax",
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
			 $("#divPagingArea2").html(result.pagingArea); 
		}//end success
			
	});//end ajax
}//end getDetail함수
$(document).ready(function() {
	
	 $(document).on('click', '.gmj-check', function(e) {
	        e.stopPropagation();
	    });

	    $('#selectAll').on('click', function(e) {
	        e.stopPropagation();
	    });
	//가맹점 클릭 시 이벤트    
	$(document).on('click', 'tr', function() {
		$("#inlineForm2").modal("show");
		
		/* 클릭한 항목의 sanctionDocVO 데이터를 가져옴 */
		/* let itemNo = $(this).data("itemNo");
		let itemNm = $(this).data("itemNm");
		
			console.log("itemNo: ",itemNo);
			console.log("itemNm: ",itemNm);
			
			getOutgoing(1,itemNo);
			$("#modalItemNo2").val(itemNo);
			$("#modalItemNm2").text(itemNm); */
	    });
	});
	
   

   



$('#keyword').keypress(function(e) {
    if (e.which == 13) {
   	 var keyword = $('#keyword').val().trim();
  	     data.keyword=keyword;
  	     console.log("검색:",keyword);
      	 searchGmj();
    }
});












</script>

<style>

.table-responsive {
    overflow: hidden !important;
}

.table {
    width: 100%;
    table-layout: fixed;
    margin: 0;
    padding: 0;
}

/* 모달 스크롤 제거 */
.modal-dialog {
    
    margin: 1.75rem auto;
}

.modal-dialog-scrollable {
    overflow: hidden;
}

.modal-body {
    overflow: hidden;
    padding: 1rem;
}

/* 전체 페이지 스크롤 방지 */
.modal-open {
    overflow: hidden;
}

/* 테이블 셀 내용 처리 */
.table td, .table th {
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}




</style>


