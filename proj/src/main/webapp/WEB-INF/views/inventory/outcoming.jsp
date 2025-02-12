<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- 로그인 권한 -->
<%-- <sec:authorize access="isAuthenticated()"> --%>
<%@ include file="../include/header.jsp" %>


<link rel="stylesheet" href="/resources/css/styles.css">


<!-- sweetAlert -->
<link rel="stylesheet" href="/css/sweetalert2.min.css">
<script type="text/javascript" src="/js/sweetalert2.min.js"></script>

<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <div id="main">
    <%@ include file="../include/top.jsp" %>
     <header class="mb-3">
         <a href="#" class="burger-btn d-block d-xl-none">
             <i class="bi bi-justify fs-3"></i>
         </a>
     </header>
 <div class="card">
   <div class="card-header">
   </div>
   <div class="card-content">
       <div class="card-body">
           
           
           <!-- 탭 콘텐츠 -->
		   <div class="tab-content">
           <%-- 발주/주문 (품목리스트)--%>
		   <div class="tab-pane fade " id="outItem" role="tabpanel" aria-labelledby="order-tab">
           <div>
           	<h4 class="card-title">재고수불 리스트(출고)</h4>
           </div>
           <div class="table-responsive">
               <table class="table table-lg">
                   <thead>
                       <tr>
                           <!--  
                           <th>
                           <div class="form-check">
                               <div class="custom-control custom-checkbox">
<!--                                    <input type="checkbox" class="form-check-input form-check-secondary form-check-glow" name="customCheck" id="checkboxGlow2"> 
       								<input type="checkbox" class="form-check-input form-check-secondary form-check-glow" 
       									name="customCheck_${itemVO.itemNo}" id="checkboxGlow_${stat.index}">
                               </div>
                           </div>
                           </th>
                           -->
                           <th>재고수불번호</th>
                           <th>품목 번호</th>
                           <th>재고 수량</th>
                           <th>유통기한</th>
                           <th>거래날짜</th>
                           <th>거래가격</th>
                           <th>가맹점 발주번호</th>
                       </tr>
                   </thead>
                   <tbody id="tby">

                   </tbody>
               </table>
                <div class="card-footer" id="divPagingArea">
                <!--
	            <nav aria-label="Page navigation example">
	               <ul class="pagination pagination-primary  justify-content-center">
	                   <li class="page-item">
					  </li>
	               </ul>
	            </nav>
	              -->
	           </div>
           </div>
           </div>
		    <%-- 가맹점별 출고 --%>
		    <div class="tab-pane fade ${tab == 'oStore' ? 'active' : ''}" id="oStore" role="tabpanel" aria-labelledby="oStore-tab">
		        <h4 class="card-title">가맹점별 출고 리스트</h4>
			<!-- 발주/주문 관리 -->
		    <div class="tab-pane fade ${tab == 'outDate' ? 'active' : '' }" id="outDate" role="tabpanel" aria-labelledby="outDate-tab">
		        <h4 class="card-title">날짜별 출고 리스트</h4>
		    </div>
		    
        </div>
    </div>
</div>
</div>
<%@ include file="../include/footer.jsp" %>

<script>


function nvl(expr1, expr2) {
	   if (expr1 === undefined || expr1 == null || expr1 == "") {
	      expr1 = expr2;
	   }
	 return expr1;
	 }  


// 재고수불 리스트
function getList(currentPage, keyword){
	let data = {
		"currentPage":nvl(currentPage, "1"),
		"keyword":nvl(keyword, "1"),
	};
	
	console.log("data : ", data);
// 	const storeNo = 1;
	
	$.ajax({
		url:"/outcomingList",
		contentType:"application/json;charset=utf-8",
		dataType : "json",
		data:JSON.stringify(data),
		type:"post",
		success:function(articlePage){
			
			console.log("articlePage : ", articlePage);
			console.log("articlePage.content : ", articlePage.content);
			
			let str = "";
			
			$.each(articlePage.content, function(idx,itemVO){
				str += `<tr>
						<td>\${inventoryRecordVO.invntryRecordNo}</td>
						<td>\${inventoryRecordVO.itemNo}</td>
						<td>\${inventoryRecordVO.recordAmount}</td>
						<td>\${inventoryRecordVO.expDate}</td>
						<td>\${inventoryRecordVO.recordRegDate}</td>
						<td>\${inventoryRecordVO.recordItemPrice}</td>
						<td>\${inventoryRecordVO.storeOrderNo}</td>
						</tr>`
			});
			
			$("#tby").html(str);
			
			$("#divPagingArea").html(articlePage.pagingArea);
			
			getList();
		}
	});
}

// $(function(){
// 	getItemList("1","", storeNo);

// })


</script>
	

