<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<%@ include file="../include/header.jsp"%>

<style>
#main {
  margin-top: 141px; 
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
            <li class="breadcrumb-item active" style="font-size:2rem"><a href="/bonsa/sellingGMJ">가맹점별 매출</a></li>
         </ol>
   </div>
   
	<div class="col-12">
		<div class="card">
			<div class="card-header"></div>
				<div class="card-body col-3">
				<fieldset class="form-group">
	                <select class="form-select" id="startDate">
						<c:forEach var="y" items="${year}">
							<option class="year" value="${y.year}">${y.year}</option>
						</c:forEach>
					</select>
	            </fieldset>
			</div>
			<div class="row"  style="height:400px">
				<canvas id="myChart"  style="height:100%"></canvas>
			</div>
			<hr>
				<div class="card" style="border:1px solid black">
				<div class="row" id="table-hover-row">
					<div class="col-3" style="margin-right:30px; margin-left:10px">
						<canvas id="bestSeller"></canvas>
					</div>
					<div class="col-8" style="margin-left:30px">
						<div class="card-header">
							<h4 class="card-title">우수가맹점 TOP5</h4>
						</div>
						<div class="card-content">
							<!-- table hover -->
							<div class="table-responsive">
								<table class="table table-hover mb-0" style="text-align: center">
									<thead style="text-align:center">
										<tr>
											<th style="width: 15%" id="tbldate"></th>
											<th style="width: 15%">순위</th>
											<th style="width: 30%">가맹점</th>
											<th style="width: 30%">매출</th>
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
		</div>
	</div>
</div>



<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>
<%@ include file="../include/footer.jsp"%>

<script>
let lineChart;
let pieChart;
let data={};
updateChart();

function updateChart(labels,datas){
	const ctx = document.getElementById('myChart').getContext('2d');
	console.log("라인",lineChart);
	if (lineChart) {
		lineChart.data.labels = labels;
        lineChart.data.datasets[0].data = datas;
		lineChart.update(); 
    } 
	else {
        lineChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                    label: '가맹점 매출',
                    data: datas,
                    borderColor: 'rgba(75, 192, 192, 1)',
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    borderWidth: 1,
                }]
            },
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true
                    }
                },
                plugins: {
                    legend: {
                        display: true,
                        position: 'top'
                    }
                }
            }
        });
    }
}



$(document).ready(function () {
	let defaultDate = today.toISOString().substring(0,7);
	console.log(today.toISOString().substring(0,7));
	console.log("타입",typeof defaultDate);
	let year = defaultDate.substring(0,4);
	$('#startDate').val(year);
	data.year=year;
	console.log("데이터:",data);
	gmj();
	bestseller();
	$("#tbldate").html(year);
	
	$(document).on('change', '#startDate', function() {
		console.log("하잉",$("#startDate")[0]);
		let start = $("#startDate").val();
		console.log("선택된 시작 날짜:", start);
		$("#tbldate").html(start);
		
		year = start.substring(0,4);
		console.log("년도:",year);
		data.year=year;
		gmj();
		bestseller();
		console.log("데이터:",data);
	});
});

function updatePieChart(labels, dataset) {
	const ctx = document.getElementById('bestSeller').getContext('2d');
    if (pieChart) {
        pieChart.data.labels = labels;
        pieChart.data.datasets[0].data = dataset;
        pieChart.update();
    } else {
        pieChart = new Chart(ctx, {
            type: 'pie',
            data: {
                labels: labels,
                datasets: [{
                    data: dataset
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                }
            }
        });
    }
}

function bestseller(){
	console.log("데이터 요청",data);
	$.ajax({
		url: "/bonsa/rankgmj",
		contentType: "application/json;charset=utf-8",
		data: JSON.stringify(data),
		type: "post",
		dataType: "json",
		success: function (resp) {
			console.log("우수가맹점응답: ", resp);
			const labels = resp.map(item => item.storeNm);
            const dataset = resp.map(item => item.yearlySales);
            console.log("베스트셀러 차트 데이터:", labels, dataset);
            updatePieChart(labels, dataset);
            
			let str = ``;
			$.each(resp, function (idx, item) {
				str += `<tr>
				             <td></td>
				             <td>\${item.rank}</td>
				             <td>\${item.storeNm }</td>
				             <td style="text-align:right">\${item.yearlySales.toLocaleString()}</td>
				         </tr>`;
			});

			$("#tby").html(str);
		},
		error: function (error) {
			console.log("에러발생", error);
		}
	});

	
}

function gmj(){
	console.log("데이터 요청",data);
	  $.ajax({
        url: "/bonsa/bsGMJMargin",
        type: "get",
        data: data,  
        success: function (response) {
            console.log("가맹점 매출 응답: ", response);
            let labels = response.map(store => store.storeNm); 
            let datas = response.map(store => store.yearlySales);
            updateChart(labels,datas);
        }
	  })
}


</script>