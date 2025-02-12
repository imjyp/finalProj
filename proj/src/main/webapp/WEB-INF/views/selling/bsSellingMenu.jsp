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

	<%@ include file="../include/top.jsp"%>
	<header class="mb-3">
		<a href="#" class="burger-btn d-block d-xl-none"><i
			class="bi bi-justify fs-3"></i></a>
	</header>
	
	   <div class="row mb-2 align-items-center">
         <ol class="breadcrumb float-sm-end">
            <li class="breadcrumb-item" style="font-size:2rem"><a href="/main">Home</a></li>
            <li class="breadcrumb-item active" style="font-size:2rem"><a href="/bonsa/sellingMenu">메뉴별 판매현황</a></li>
         </ol>
   </div>
				
				
				
	<div class="col-12">
		<div class="card">
			<div class="card-header"></div>
			<div class="card-body">
				<input type="month" id="startDate"/> 
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
							<h4 class="card-title">메뉴 베스트셀러 TOP5</h4>
						</div>
						<div class="card-content">
							<!-- table hover -->
							<div class="table-responsive">
								<table class="table table-hover mb-0" style="text-align: center">
									<thead>
										<tr>
											<th style="width: 15%" id="tbldate"></th>
											<th style="width: 15%">순위</th>
											<th style="width: 30%">메뉴</th>
											<th style="width: 30%">판매량</th>
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
let data={};
let barChart;
let pieChart;

function updateBarChart(labels, dataset) {
	console.log("차트 업데이트 - 라벨:", labels, "데이터셋:", dataset);
	const ctx = document.getElementById('myChart').getContext('2d');
    if (barChart) {
        barChart.data.labels = labels;
        barChart.data.datasets[0].data = dataset;
        barChart.update(); 
    } else {
        barChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                    label: '메뉴별 판매량',
                    data: dataset,
                    borderWidth: 1,
                    backgroundColor: 'rgba(75, 192, 192, 0.2)', 
                    borderColor: 'rgba(75, 192, 192, 1)', 
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
                        position: 'top',
                    },
                }
            }
        });
    }
}

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
                    label: '베스트셀러 메뉴',
                    data: dataset,
                    backgroundColor: [
                        'rgba(255, 99, 132)',  // Red
                        'rgba(54, 162, 235)',  // Blue
                        'rgba(255, 206, 86)',  // Yellow
                        'rgba(75, 192, 192)',  // Green
                        'rgba(153, 102, 255)', // Purple
                        'rgba(255, 159, 64)'   // Orange
                    ],
                    
                    borderWidth: 1
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

//updateBarChart();
//updatePieChart();


$(document).ready(function () {
	 let defaultDate = today.toISOString().substring(0,7);
	console.log(today.toISOString().substring(0,7));
	console.log("타입",typeof defaultDate);
	$('#startDate').val(defaultDate);
	let year = defaultDate.substring(0,4);
	let month = defaultDate.substr(5,2);
	data.month=month;
	data.year=year;
	console.log("데이터:",data);
	menu();
	bestseller();
	$("#tbldate").html(defaultDate);
	
	$(document).on('change', '#startDate', function() {
		console.log("하잉",$("#startDate")[0]);
		let start = $("#startDate").val();
		console.log("선택된 시작 날짜:", start);
		$("#tbldate").html(start);
		
		year = start.substring(0,4);
		month = start.substr(5,2);
		console.log("년도:",year);
		console.log("월:",month);
		data.month=month;
		data.year=year;
		console.log("데이터:",data);
		menu();
		bestseller();
	});
});

function menu(){
	axios.post('/bonsa/getMenu', data)
	.then(function (resp) {
		console.log("메뉴별 판매량 응답: ", resp);

		const labels = resp.data.labels;
		const dataset  = resp.data.data;
		console.log("차트 데이터 확인:", labels );
		console.log("차트 데이터 확인:", dataset );
		updateBarChart(labels, dataset);
	})
	.catch(function (error) {
		console.log("에러발생", error);
	});
}

function bestseller(){
	$.ajax({
		url: "/bonsa/bestsellerMenu",
		contentType: "application/json;charset=utf-8",
		data: JSON.stringify(data),
		type: "post",
		dataType: "json",
		success: function (resp) {
			console.log("응답: ", resp);
			const labels = resp.map(item => item.menuNm);
            const dataset = resp.map(item => item.total);
            console.log("베스트셀러 차트 데이터:", labels, dataset);
            updatePieChart(labels, dataset);
            
			let str = ``;
			$.each(resp, function (idx, item) {
				str += `<tr>
				             <td></td>
				             <td>\${item.rank}</td>
				             <td>\${item.menuNm }</td>
				             <td>\${item.total}</td>
				         </tr>`;
			});

			$("#tby").html(str);
		},
		error: function (error) {
			console.log("에러발생", error);
		}
	});

	
}
</script>

