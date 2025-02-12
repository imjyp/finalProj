<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<%@ include file="../include/header.jsp"%>
<link rel="stylesheet" href="/css/common2.css">
<link rel="stylesheet" href="/dist/assets/compiled/css/app-dark.css">
<link rel="stylesheet" href="/dist/assets/compiled/css/iconly.css">
<style>
    .form-control {
        box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
        border: 1px solid #ced4da;
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
	<div class="page-heading row" style="margin-top:130px; margin-bottom:0px">
	
		<div class="col-6 d-flex align-items-center">
	          <nav aria-label="breadcrumb" class="ms-3">
	            <ol class="breadcrumb mb-0">
	              <li class="breadcrumb-item"><a href="/main">Home</a></li>
	              <li class="breadcrumb-item active"><a href="/gmj/gmj${storeNo }/sellingInsert">보정계수 관리</a></li>
	            </ol>
	          </nav>
	        </div>
	        
	<div class="col-12">
		<div class="accordion col-3 ms-auto" id="accordionExample" style="margin-right: 3vw">
			<div class="accordion-item">
				<h2 class="accordion-header" id="headingOne">
					<button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
					도움말
					</button>
				</h2>
				<div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample" style="">
					<div class="accordion-body">
					현금 결제, 행사 상품, 서비스 등 재고량을 맞추기 위한 보정 계수를 관리할 수 있습니다!
					</div>
				</div>
			</div>
		</div>	
	</div>
		
	<div class="col-12">
		<div class="card">
	        <div class="card-header">
		    </div>
		    <div class="card-content">
		        <div class="card-body">
		                <div class="form-body">
		                    <div class="row">
		                        <div class="col-md-4" >
		                            <label for="first-name-horizontal">메뉴</label>
		                        </div>
		                        <fieldset class="col-md-5 form-group">
		                        	<select class="form-select" id="menu">
		    					</select>
				                    </fieldset>
				                    <div class="col-md-4">
		                            <label for="howmany">수량</label>
		                        </div>
		                        <div class="col-md-5 form-group">
		                            <input type="number" id="howmany" class="form-control count" name="email-id" placeholder="수량">
		                        </div>
		                        <div class="col-md-4" >
		                            <label for="howmuch">메뉴 가격</label>
		                        </div>
		                        <div class="col-md-5 form-group">
		                            <input type="number" id="howmuch" class="form-control unitprice money" name="contact" onkeyup="javascript:fn_totalMoney()"placeholder="가격">
		                        </div>
		                        <div class="col-md-4">
		                            <label for="total">총금액</label>
		                        </div>
		                        <div class="col-md-5 form-group">
		                            <input type="number" id="total" class="form-control total money" name="password" onkeyup="javascript:fn_totalMoney()"placeholder="총금액">
		                        </div>
		                        <div class="col-sm-12 d-flex justify-content-end">
		                            <button class="btn btn-warning me-1 mb-1" onclick="reg()">등록</button>
		                            <button type="reset" class="btn btn-light-secondary me-1 mb-1">취소</button>
		                        </div>
		                    </div>
		                </div>
		        </div>
		    </div>
		</div>
	</div>	    
			
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>
<%@ include file="../include/footer.jsp"%>

<script>
mchdr();
function mchdr(){
	$.ajax({
		url:"/menu",
		type: "get",
		success:function(resp){
			console.log("응답잘 왔니?",resp);
			let str=`<option>메뉴선택</option>`;
		                        
             $.each(resp, function(idx,m){
              str+=` <option value="\${m.menuNo}">\${m.menuNm}</option>`;
             })

		$("#menu").html(str);
		}
	})
	

	
}

fn_totalMoney=function(){
	$(".count, .unitprice").each(function(idx){
		$(".money").each(function(idx){
			$(this).val($(this).val().replace(/,/gi,''));
		});
		var unitprice=$(".unitprice").eq(idx).val();
		var count = $(".count").eq(idx).val();
		unitprice=unitprice*1;
		count=count*1;
		
		$(".total").eq(idx).val(unitprice*count);
		var total=$(".total").eq(idx).val();
		
		$(".money").each(function(idx){
			$(this).val($(this).val().toString().replace(/\B(?=(\d{8})+(?!\d))/g,","));
		})
		
	})
}	
function  reg(){
	let menuNo = $("#menu").val();
	let menuNm = $('#menu option:selected').text();
	let howmany = $("#howmany").val();
	let howmuch = $("#howmuch").val();
	let total = $("#total").val();
	let data2={
			menuNo:menuNo,
			sellingAmount:howmany,
			howmuch:howmuch,
			sellingTotal:total,
			storeNo:${storeNo},
			menuNm:menuNm
	}
	
	console.log("data2:",data2);
	
	
	$.ajax({
		url:"/gmj/mchdr",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(data2),
		type:"post",
		dataType:"json",
		success:function(resp){
			console.log("잘 들어왔엉?",resp);
			var answer = confirm(`\${resp.menuNm } \${resp.sellingAmount}개 총 \${resp.sellingTotal}원 잘 등록됐습니다.`);
			//옵션 순서를 알 경우 : 선택하고자 하는 옵션 순번을 명시하여 선택
			if(answer){
				$("#menu option:eq(0)").prop("selected",true);
				$("#howmany").val("");
				$("#howmuch").val("");
				$("#total").val("");
			}
			
			
		}
	})
	
}


</script>

