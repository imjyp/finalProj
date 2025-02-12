<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<link rel="stylesheet" href="/css/common2.css">
<!DOCTYPE html>
<%@ include file="../include/header.jsp"%>
	

<style>
#main {
  margin-top: 141px; 
}

.cc{

}

</style>
<div id="main">

<%@ include file="../include/top.jsp" %>
	<header class="mb-3">
		<a href="#" class="burger-btn d-block d-xl-none"><i
			class="bi bi-justify fs-3"></i></a>
	</header>
	<div class="row mb-2 align-items-center">
         <ol class="breadcrumb float-sm-end">
            <li class="breadcrumb-item" style="font-size:2rem"><a href="/main">Home</a></li>
            <li class="breadcrumb-item active" style="font-size:2rem"><a href="/gmj/gmj${storeNo }/sellingDate">기간별 매출</a></li>
         </ol>
   </div>
   
				
	<div class="col-12">
		<div class="card">
			<div class="card-header">
				<h4 class="card-title" id="title"></h4>
			</div>
			<div class="card-body col-3">
				<fieldset class="form-group">
	                <select class="form-select" id="startDate">
						<c:forEach var="y" items="${year}">
							<option class="year" value="${y.year}">${y.year}</option>
						</c:forEach>
					</select>
	            </fieldset>
			</div>
			
			<div class="row" id="table-hover-row" >
				<div class="col-7" >
			 		<canvas id="myChart" ></canvas>
		 		</div>
		 		<div class="col-5"  >
		 		<div class="row" style="margin-left:30px;" >
			 		<div class="card col-5 cc" style="border:solid 1px black;box-shadow: 5px 5px 3px #afafaf">
		                    <div class="card-content">
		                        <div class="card-body" style="text-align:center;" >
		                            <h5 class="card-title">매출 현황</h5>
		                            <p class="card-text" id="margin">
		                                
		                            </p>
		                        </div>
		                    </div>
		                </div>
		                <div class="card col-5 cc" style="border:solid 1px black; margin-left:50px;box-shadow: 5px 5px 3px #afafaf">
		                    <div class="card-content">
		                        <div class="card-body" style="text-align:center">
		                            <h5 class="card-title">전년 대비 매출 현황</h5>
		                            <p class="card-text" id="lastyear">
		                                
		                            </p>
		                        </div>
		                    </div>
		                </div>
			 		</div>
			 		<div class="row"style="margin-left:30px;">
			 			<div class="card col-5 cc" style="border:solid 1px black;box-shadow: 5px 5px 3px #afafaf">
		                    <div class="card-content">
		                        <div class="card-body" style="text-align:center">
		                            <h5 class="card-title">지출액</h5>
		                            <p class="card-text" id="budget">
		                                
		                            </p>
		                        </div>
		                    </div>
		                </div>
		                <div class="card col-5 cc" style="border:solid 1px black;margin-left:50px;box-shadow: 5px 5px 3px #afafaf">
		                    <div class="card-content">
		                        <div class="card-body" style="text-align:center">
		                            <h5 class="card-title">총수익</h5>
		                            <p class="card-text" id="profit">
		                               
		                            </p>
		                        </div>
		                    </div>
		                </div>
			 		</div>
			 		
		 		</div>
			 </div>
			 <hr> 
	 <section class="section">
        <div class="row" id="table-hover-row">
            <div class="col-12">
                <div class="card">
                    <div class="card-header">
                        <h4 class="card-title col">매출표</h4>
                        <div class="col text-end">
                        <form action="/margin/download" method="get">
                        	<input type="hidden" name="year" id="selectedYear">
                        	<input type="hidden" name="type" value="2">
                        	<input type="hidden" name="storeNo" value="${storeNo }">
                        	<button type="submit" class="btn btn-warning">매출표 출력</button>
                        </form>
                        </div>
                    </div>
                    <div class="card-content">
                        <!-- table hover -->
                        <div class="table-responsive">
                            <table class="table table-hover mb-0 " style="text-align:center">
                                <thead style="text-align:center">
                                    <tr>
                                        <th id="tblDate" style="width:7%"></th>
                                        <th style="width:13%">날짜</th>
                                        <th style="width:20%">매출</th>
                                        <th style="width:20%">지출액</th>
                                        <th style="width:20%">총수익</th>
                                        <th style="width:20%">전년 대비 매출 분석</th>
                                    </tr>
                                </thead>
                                <tbody id="tby">
                                   
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
		</div>
	</div>
</div>


<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>
<%@ include file="../include/footer.jsp"%>

<script>
let chartjs;
let data={storeNo:${storeNo}};


function getMargin(){
	$.ajax({
        url: "/getmargin",
        type: "get",
        data: data,
        success: function(response) {
            console.log("마진", response);
            updateChart(response.data,response.data2,response.labels,response.profit);
            card(response.data,response.data2,response.profit);
        }
    });
	
	
}

	
function updateChart(data, data2, labels, profit) {
    const ctx = document.getElementById('myChart').getContext('2d');

    if (chartjs) {
        chartjs.data.labels = labels;
        chartjs.data.datasets[0].data = data;
        chartjs.data.datasets[1].data = data2;
        chartjs.data.datasets[2].data = profit;
        chartjs.update();
    } else {
		chartjs =  new Chart(ctx, {
        	  type: 'bar',
        	  data: {
        	    labels: labels,
        	    datasets: [
        	      {
        	        label: '매출현황',
        	        data: data,
        	      },
        	      {
          	        label: '지출액',
          	        data: data2,
          	      },
        	      {
          	        label: '총수익',
          	        data: profit,
          	      }
        	    ]
        	  },
        	});
		
    }
}

$(document).ready(function () {
	let defaultDate = today.toISOString().substring(0,7);
	console.log(today.toISOString().substring(0,7));
	let year = defaultDate.substring(0,4);
	data.year=year;
	$('#startDate').val(year);
	$("#tblDate").html(year);
	console.log("데이터:",data);
	getMargin();
	updateChart3();
	updateTable();
	$('#selectedYear').val(year);
	
	$(document).on('change', '#startDate', function() {
		console.log("하잉",$("#startDate")[0]);
		let start = $("#startDate").val();
		console.log("선택된 시작 날짜:", start);
		$("#startDate").val(start);
		$("#tblDate").html(start);
		
		year = start.substring(0,4);
		console.log("년도:",year);
		data.year=year;
		console.log("데이터:",data);
		getMargin();
		updateChart3();
		updateTable();
		$('#selectedYear').val(year);
	});
});


function card(margin, budget, profit){
	let marginSum=0;
	for(let i=0;i<margin.length;i++){
		marginSum+=margin[i];
	}
	
	let profitSum=0;
	for(let i=0;i<profit.length;i++){
		profitSum+=profit[i];
	}
	
	let budgetSum=0;
	for(let i=0;i<budget.length;i++){
		budgetSum+=budget[i];
	}
	
	$("#margin").html("₩"+marginSum.toLocaleString());
	$("#profit").html("₩"+profitSum.toLocaleString());
	$("#budget").html("₩"+budgetSum.toLocaleString());
}


function updateChart3(){
	 $.ajax({
        url: "/compareWithLastyear",
        type: "post",
        data: JSON.stringify(data),
        contentType:"application/json;charset=utf-8",
        dataType:"json",
        success: function(response) {		
			console.log("전년대비 판매량 응답: ", response);
			console.log("화긴: ", response[0].growthRate);
			if(response[0].growthRate>0){
				$("#lastyear").html("▲"+response[0].growthRate +"%");
				$("#lastyear").css("color","red");
			}
			else{
				$("#lastyear").html("▼"+response[0].growthRate+"%");
				$("#lastyear").css("color","blue");
			}
        }
			
	})
}


function updateTable() {
        axios.post('/getTable2', data) 
    .then(function (resp) {
        console.log("updateTable 응답:",resp.data);
        let str="";
        $.each(resp.data, function(idx,item){
			
        	str+=`<tr>
        			<td></td>
        			<td>\${item.monthS}</td>
        			<td style="text-align:right">\${item.monthlySales.toLocaleString()}</td>
        			<td style="text-align:right">\${item.monthlyYSales.toLocaleString()}</td>
        			<td style="text-align:right">\${item.profit.toLocaleString()}</td>`;
        			if (item.growthRate > 0) {
                    str += `<td style="color:red">▲\${item.growthRate}%</td>`;
                } 
        			else if(item.growthRate==0){
        				str += `<td> - </td>`;
        			}
        			else {
                    str += `<td style="color:blue">▼\${item.growthRate}%</td>`;
                }

        	
       			str+=`</tr>`;
        })
        
        $("#tby").html(str);
    })
    .catch(error => {
        console.error("테이블 업데이트 중 에러 발생:", error);
    });
}


</script>