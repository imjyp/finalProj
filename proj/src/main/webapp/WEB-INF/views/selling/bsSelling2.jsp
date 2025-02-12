<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<%@ include file="../include/header.jsp"%>
<div id="main">

<%@ include file="../include/top.jsp" %>
	<header class="mb-3">
		<a href="#" class="burger-btn d-block d-xl-none"><i
			class="bi bi-justify fs-3"></i></a>
	</header>
	<h1>본사 매출</h1>
	<div class="col-12">
		<div class="card">
			<div class="card-header">
				<h4 class="card-title" id="title"></h4>
			</div>
			<div class="card-body">
					<ul class="nav nav-tabs" id="myTab" role="tablist">
                            <li class="nav-item" role="presentation">
                                <a class="nav-link active" id="home-tab" data-bs-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true" onclick="fbsMenu()">메뉴별 판매량</a>
                            </li>
                            <li class="nav-item" role="presentation">
                                <a class="nav-link" id="profile-tab" data-bs-toggle="tab" href="#profile" role="tab" aria-controls="profile" aria-selected="false" tabindex="-1" onclick="fbsItem()">품목별 판매량</a>
                            </li>
                            <li class="nav-item" role="presentation">
                                <a class="nav-link" id="contact-tab" data-bs-toggle="tab" href="#contact" role="tab" aria-controls="contact" aria-selected="false" tabindex="-1"onclick="fbsMargin()">기간별 매출</a>
                            </li>
                            <li class="nav-item" role="presentation">
                                <a class="nav-link" id="contact-tab" data-bs-toggle="tab" href="#contact" role="tab" aria-controls="contact" aria-selected="false" tabindex="-1"onclick="fgmjMargin()">가맹점별 매출</a>
                            </li>
                            <li class="nav-item" role="presentation">
                                <a class="nav-link" id="contact-tab" data-bs-toggle="tab" href="#contact" role="tab" aria-controls="contact" aria-selected="false" tabindex="-1"onclick="fbsLast()">
                                전년 대비 매출 트렌드 분석</a>
                            </li>
                        </ul><br><br>
                        
				<div class="row">
					<!-- <div class="col-3">

						<div class="nav flex-column nav-pills" id="v-pills-tab"
							role="tablist" aria-orientation="vertical">
							<a class="btn nav-link active" id="menuTab" data-bs-toggle="pill"
								role="tab" aria-selected="true" onclick="fbsMenu()">메뉴별 판매량</a>
							<a class="btn nav-link" id="itemTab" data-bs-toggle="pill"
								role="tab" aria-selected="false" tabindex="-1"
								onclick="fbsItem()">품목별 판매량</a> <a class="btn nav-link"
								id="marginTab" data-bs-toggle="pill" role="tab"
								aria-selected="false" tabindex="-1" onclick="fbsMargin()">매출</a>
							<a class="btn nav-link" id="gmjTab" data-bs-toggle="pill"
								role="tab" aria-selected="false" tabindex="-1"
								onclick="fgmjMargin()">가맹점별 매출</a> <a class="btn nav-link"
								id="lastTab" data-bs-toggle="pill" role="tab"
								aria-selected="false" tabindex="-1" onclick="fbsLast()">전년
								대비 매출 비교</a>
						</div>
					</div> -->
					<div class="col-9">
						<div class="tab-content" id="v-pills-tabContent"
							style="display: flex;">
							<fieldset class="form-group">
								<select class="form-select " id="store">
									<option id="storeOption" value="none" selected>가맹점 선택</option>
									<c:forEach var="s" items="${store}">
										<option class="store" value="${s.storeNo }">${s.storeNm}
										</option>
									</c:forEach>
								</select>
							</fieldset>
							<fieldset class="form-group">
								<select class="form-select" id="sel" style="display: none">
									<option class="date" value="none">기간 선택</option>
									<option class="date" value="monthOpt">월</option>
									<option class="date" value="quarterOpt">분기</option>
									<option class="date" value="yearOpt">연도</option>
								</select>
							</fieldset>

							<fieldset class="form-group">
								<select class="form-select" id="basicSelect">
									<option value="none" id="yearOption" selected>년도 선택</option>
									<c:forEach var="y" items="${year}">
										<option class="year" value="${y.year}">${y.year}</option>
									</c:forEach>
								</select>
							</fieldset>
							<fieldset class="form-group">
								<select class="form-select " id="basicSelect2">
									<option id="monthOption" value="none" selected>월 선택</option>
									<c:forEach var="m" items="${month}">
										<option class="month" value="${m.month }">${m.month}
										</option>
									</c:forEach>
								</select>
							</fieldset>

							<a href="#" class="btn btn-sm btn-warning" id="bestseller"
								style="display: none">베스트셀러</a>
						</div>
						<div class="tab-pane fade active show" id="v-pills-home">
							<div class="card">
								<div id="best"></div>
								<canvas id="myChart" ></canvas>
								
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</div>


<!--모달-->
<div class="modal fade show" id="exampleModalCenter" tabindex="-1"
	aria-labelledby="exampleModalCenterTitle"
	style="display: none; padding-right: 17px;" aria-modal="true"
	role="dialog">
	<div
		class="modal-dialog modal-dialog-centered modal-dialog-centered modal-dialog-scrollable"
		role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalCenterTitle">베스트셀러</h5>
				<button type="button" class="close" data-bs-dismiss="modal"
					aria-label="Close" onclick="mclose()">
					<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
						viewBox="0 0 24 24" fill="none" stroke="currentColor"
						stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
						class="feather feather-x">
											<line x1="18" y1="6" x2="6" y2="18"></line>
											<line x1="6" y1="6" x2="18" y2="18"></line>
										</svg>
				</button>
			</div>
			<div class="modal-body"></div>
			<div class="modal-footer">
				<button type="button" class="btn btn-light-secondary"
					data-bs-dismiss="modal" onclick="mclose()">
					<i class="bx bx-x d-block d-sm-none"></i> <span
						class="d-none d-sm-block">Close</span>
				</button>
				<button type="button" class="btn btn-primary ms-1"
					data-bs-dismiss="modal">
					<i class="bx bx-check d-block d-sm-none"></i> <span
						class="d-none d-sm-block">Accept</span>
				</button>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>
<%@ include file="../include/footer.jsp"%>

<script>
let data = {};
let chartjs = Chart.getChart("myChart");
let chart;


data.month=month;
data.year=year;

function reset2() {

	
/* 	 $("#basicSelect").val("none");
	  $("#basicSelect2").val("none"); */

	if (chartjs) {
		chartjs.destroy();
		chartjs = null;
	}
	const canvas = document.getElementById('myChart');
	const ctx = canvas.getContext('2d');
	ctx.clearRect(0, 0, canvas.width, canvas.height);

	data.month = "";
	data.monthOpt = "";
	data.quarterOpt = "";
	data.storeNo = "";
	data.year = "";
	data.yearOpt = "";
}

$("#bestseller").on('click', function () {
	let myModal = new bootstrap.Modal(document.getElementById('exampleModalCenter'), {
		backdrop: true
	});
	myModal.show();

	 let activeTab = $(".nav-link.active");
    console.log("현재 활성화된 탭 객체:", activeTab);
    console.log("현재 활성화된 탭 텍스트:", activeTab.text().trim());
    let isMenu = activeTab.text().trim() === "메뉴별 판매량";  
    console.log("isMenu 값:", isMenu);  

    let url = isMenu ? "/bonsa/bestsellerMenu" : "/bonsa/bestsellerItem";
    let title = isMenu ? "메뉴 베스트셀러" : "품목 베스트셀러";


	$.ajax({
		url: url,
		contentType: "application/json;charset=utf-8",
		data: JSON.stringify(data),
		type: "post",
		dataType: "json",
		success: function (resp) {
			console.log(title + " 응답: ", resp);
			let str = `<div class="table-responsive">
         <table class="table table-hover mb-0">
         <thead>
             <tr>
                 <th>순위</th>
                 <th>\${isMenu ? '메뉴' : '품목'}</th>
                 <th>판매량</th>
             </tr>
         </thead><tbody>`;
			$.each(resp, function (idx, item) {
				str += `<tr>
             <td class="text-bold-500">\${item.rank}</td>
             <td>\${isMenu ? item.menuNm : item.itemNm}</td>
             <td>\${item.total}</td>
         </tr>`;
			});
			str += `</tbody></table></div>`;

			$("#exampleModalCenterTitle").text(title);
			$(".modal-body").html(str);
		},
		error: function (error) {
			console.log("에러발생", error);
		}
	});
});


function mclose() {
	$("#exampleModalCenter").css("display", "none");
}


fbsMenu();

function createChart(type, data, options) {
	//reset2();
	if(chart!=null){
		chart.destroy();
		chart=null;
	}
  	document.querySelector("#best").innerHTML="";
  	document.querySelector("#myChart").innerHTML="";
	const ctx = document.getElementById('myChart').getContext('2d');
	chartjs = new Chart(ctx, {
		type: type,
		data: data,
		options: options
	});
}


function fbsMenu() {
	if(chart!=null){
		chart.destroy();
		chart=null;
	}
	if (chartjs) {
		chartjs.destroy();
		chartjs = null;
	}
	const canvas = document.getElementById('myChart');
	const ctx = canvas.getContext('2d');
	ctx.clearRect(0, 0, canvas.width, canvas.height);
  	document.querySelector("#best").innerHTML="";
  	document.querySelector("#myChart").innerHTML="";
	reset2();
	$("#sel").css('display', 'none');
	$("#basicSelect2").css("display", 'block');
	$("#basicSelect").css("display", 'block');
	$("#bestseller").css('display', 'block');
	$("#store").css('display', 'none');
	
	$("#basicSelect").val("none");
	  $("#basicSelect2").val("none");

	$(document).off('change').on('change', '#basicSelect, #basicSelect2', function () {
		let year = $('#basicSelect').val();
		let month = $('#basicSelect2').val();
		if (year !== "none") {
			data.year = year;
		}
		if (month !== "none") {
			data.month = month;
		}

		if (data.year && data.month) {
			if (chartjs) {
				chartjs.destroy();
				chartjs = null;
			}
			console.log("메뉴별 판매량 데이터", data);
			axios.post('/bonsa/getMenu', data)
				.then(function (resp) {
					console.log("메뉴별 판매량 응답: ", resp);

					const labels = resp.data.labels;
					const data = resp.data.data;
					console.log("값확인:", resp, Math.max(...data));
					createChart('bar', { labels: labels, datasets: [{ data: data, borderWidth: 1,label: '메뉴별 판매량', }] }, { scales: { y: { beginAtZero: true } } })
				})
				.catch(function (error) {
					console.log("에러발생", error);
				});
		}
	});
}


function fbsItem() {
	if(chart!=null){
		chart.destroy();
		chart=null;
	}
  	document.querySelector("#best").innerHTML="";
  	document.querySelector("#myChart").innerHTML="";
	reset2();
	$("#sel").css('display', 'none');
	$("#basicSelect2").css("display", 'block');
	$("#bestseller").css('display', 'block');
	$("#store").css('display', 'none');
	
	$("#basicSelect").val("none");
    $("#basicSelect2").val("none");

	$(document).off('change').on('change', '#basicSelect, #basicSelect2', function () {
		let year = $('#basicSelect').val();
		let month = $('#basicSelect2').val();
		if (year !== "none") {
			data.year = year;
		}
		if (month !== "none") {
			data.month = month;
		}

		if (data.year && data.month) {
			if (chartjs) {
				chartjs.destroy();
				chartjs = null;
			}
			console.log("품목별 판매량 데이터", data);

			axios.post('/bonsa/getItem', data)
				.then(function (resp) {
					console.log("품목별 판매량 응답: ", resp);

					const labels = resp.data.labels;
					const data = resp.data.data;
					console.log("값확인:", resp, Math.max(...data));

					createChart('bar', { labels: labels, datasets: [{ data: data, borderWidth: 1,label: '품목별 판매량', }] }, { scales: { y: { beginAtZero: true } } })
				})
				.catch(function (error) {
					console.log("에러발생", error);
				});
		}
	});
}




function fbsMargin() {
	if(chart!=null){
		chart.destroy();
		chart=null;
	}
  	document.querySelector("#best").innerHTML="";
	reset2();
	$("#sel").css('display', 'block');
	$("#sel").val("none");
	$("#basicSelect").css("display", 'none');
	$("#basicSelect2").css("display", 'none');
	$("#bestseller").css('display', 'none');
	$("#store").css('display', 'none');
	
	$("#basicSelect").val("none");
	  

	$(document).off('change').on('change', "#sel, #basicSelect", function () {
		let selectedValue = $("#sel").val();
		let year = $('#basicSelect').val();

		if (selectedValue === 'monthOpt') {
			reset2();
			data.monthOpt = 'y';
			$("#basicSelect").css('display', 'block');
		} else if (selectedValue === 'quarterOpt') {
			reset2();
			data.quarterOpt = 'y';
			$("#basicSelect").css('display', 'block');
		} else if (selectedValue === 'yearOpt') {
			reset2();
			data.yearOpt = 'y';
			$("#basicSelect").css('display', 'none');
		}

		if (year !== "none") {
			data.year = year;
		}

		if ((data.monthOpt || data.quarterOpt) && data.year || data.yearOpt) {
			console.log("ㅎㅇㅎㅇ", data);
			updateChart();
		}
	});
}

function updateChart() {
	console.log("본사매출 데이터", data);

	axios.post('/bonsa/getMargin', data)
		.then(function (resp) {
			console.log("본사매출 응답: ", resp);

			const ctx = document.getElementById('myChart');
			chartjs = new Chart(ctx, {
				data: {
					datasets: [{
						type: 'bar',
						label: '매출',
						data: resp.data.data
					}, {
						type: 'bar',
						label: '예산 총사용액',
						data: resp.data.data2,
					},
					{
						type: 'bar',
						label: '총이익',
						data: resp.data.profit,
					}],
					labels: resp.data.labels
				},
				options: {
					scales: {
						y: {
							beginAtZero: true
						}
					}
				}
			});
		})
		.catch(function (error) {
			console.log("에러발생", error);
		});
}


function formatNumber(num) { //천단위
    return num.toLocaleString(); 
}


function fgmjMargin() {
	if(chart!=null){
		chart.destroy();
		chart=null;
	}
  	document.querySelector("#best").innerHTML="";
  	
	reset2();
	$("#sel").css('display', 'none');
	$("#basicSelect").css("display", 'block');
	$("#basicSelect2").css("display", 'none');
	$("#bestseller").css('display', 'none');

	$(document).off('change').on('change', "#store,#sel,#basicSelect", function () {
		
		let selectedValue = $("#sel").val();
		$("#basicSelect").css('display', 'block');
		console.log("기간선택:", selectedValue);

		let year = $("#basicSelect").val();
		if (year !== "none") {
			data.year = year;
		}
		console.log("어떻게 들어왔어?", data);
		if (data.year) {
			updateChart2();
		}
	});
}

function updateChart2() {
    if (chartjs != null) {
        chartjs.destroy();  
        chartjs = null;  
    }

    const canvas = document.getElementById('myChart');
    const ctx = canvas.getContext('2d');
    ctx.clearRect(0, 0, canvas.width, canvas.height);  // 캔버스 초기화
	
    $.ajax({
        url: "/bonsa/bsGMJMargin",
        type: "get",
        data: data,  
        success: function (response) {
            console.log("가맹점 매출 응답: ", response);
            
            
            let labels = response.map(store => store.storeNm);  

			
            var options = {
                    series: [
                    {
                      name: "매출",
                      data: response.map(store => store.yearlySales)
                    }
                    
                  ],
                    chart: {
                    height: 350,
                    type: 'line',
                    dropShadow: {
                      enabled: true,
                      color: '#000',
                      top: 18,
                      left: 7,
                      blur: 10,
                      opacity: 0.5
                    },
                    zoom: {
                      enabled: false
                    },
                    toolbar: {
                      show: false
                    }
                  },
                  colors: ['#77B6EA', '#545454'],
                  dataLabels: {
                    enabled: true,
                  },
                  stroke: {
                    curve: 'smooth'
                  },
                  title: {
                    text: 'Average High & Low Temperature',
                    align: 'left'
                  },
                  grid: {
                    borderColor: 'grey',
                    
                  },
                  markers: {
                    size: 1
                  },
                  xaxis: {
                    categories: labels,
                    title: {
                      text: '가맹점'
                    }
                  },
                  yaxis: {
                    title: {
                      text: '매출(원)'
                    }
                  },
                  legend: {
                    position: 'top',
                    horizontalAlign: 'right',
                    floating: true,
                    offsetY: -25,
                    offsetX: -5
                  }
                  };

                  chart = new ApexCharts(document.querySelector("#best"), options);
                  chart.render();
        }
    })
    .catch(function (error) {
        console.log("에러발생", error);
    });
}

				

function fbsLast() {
	if(chart!=null){
		chart.destroy();
		chart=null;
	}
  	document.querySelector("#best").innerHTML="";
	reset2();
	$("#sel").css('display', 'none');
	$("#store").css('display', 'none');
	$("#basicSelect2").css("display", 'none');
	$("#bestseller").css('display', 'none');
	$("#basicSelect").css('display', 'block');
	$("#basicSelect").val("none");
	  
	$(document).off('change').on('change', "#basicSelect", function () {
		
		let year = $('#basicSelect').val();
		if (year !== "none") {
			data.year = year;
		}

		if (data.year)  {
			console.log("전년대비 데이터", data);
				updateChart3();
		}
	})
}


function updateChart3(){
	axios.post('/bonsa/lastcompare', data)
	.then(function (resp) {
		console.log("전년대비 판매량 응답: ", resp);
		
		/* const ctx = document.getElementById('myChart');
		chartjs = new Chart(ctx, {
			data: {
				datasets: [{
					type: 'bar',
					label: '작년 매출',
					data: resp.data.data
				}, {
					type: 'bar',
					label: '올해 매출',
					data: resp.data.data2,
				},
				{
					type: 'line',
					label: '증감율',
					data: resp.data.data3,
				}],
				labels: resp.data.labels
			},
			options: {
				scales: {
					y: {
						beginAtZero: true
					}
				}
			}
		}); */
      
		      
		 var options = {
	                series: [{
	                    name: resp.data.labels[0].split("-")[0]+"년",
	                    type: 'column',
	                    data: resp.data.data2
	                }, {
	                    name: resp.data.labels[0].split("-")[0]-1+"년",
	                    type: 'column',
	                    data: resp.data.data
	                }, {
	                    name: '증감율(%)',
	                    type: 'line',
	                    data: resp.data.data3,
	                }],
	                chart: {
	                    height: 350,
	                    type: 'line',
	                    stacked: false
	                },
	                stroke: {
	                    width: [1, 1, 4]
	                },
	                title: {
	                    text: '전년 대비 매출 비교',
	                    align: 'center'
	                },
	                xaxis: {
	                    categories: resp.data.labels
	                },
	                yaxis: [{
	                    title: {
	                        text: '매출액 (원)',
	                    }
	                }, {
	                    opposite: true,
	                    title: {
	                        text: '증감율 (%)'
	                    }
	                }],
	                tooltip: {
	                    y: {
	                        formatter: function(value, { seriesIndex }) {
	                            if(seriesIndex === 2) {
	                                return value + '%';
	                            }
	                            return value + ' 원';
	                        }
	                    }
	                }
	            };
	            chart = new ApexCharts(document.querySelector("#best"), options);
	            chart.render();
})
.catch(function (error) {
	console.log("에러발생", error);
});
}

</script>