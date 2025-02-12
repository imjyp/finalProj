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
	<h1>가맹점 매출</h1>
	<div class="col-12">
		<div class="card">
			<div class="card-header">
				<h4 class="card-title" id="title"></h4>
			</div>
			<div class="card-body">
			<ul class="nav nav-tabs" id="myTab" role="tablist">
                            <li class="nav-item" role="presentation">
                                <a class="btn nav-link active" id="home-tab" data-bs-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true" onclick="bestSeller()">베스트셀러</a>
                            </li>
                            <li class="nav-item" role="presentation">
                                <a class="btn nav-link" id="profile-tab" data-bs-toggle="tab" href="#profile" role="tab" aria-controls="profile" aria-selected="false" tabindex="-1" onclick="">기간별 매출</a>
                            </li>
                            <li class="nav-item" role="presentation">
                                <a class="btn nav-link" id="contact-tab" data-bs-toggle="tab" href="#contact" role="tab" aria-controls="contact" aria-selected="false" tabindex="-1"onclick="fbsMargin()getGraph()">메뉴별 판매량</a>
                            </li>
                            <li class="nav-item" role="presentation">
                                <a class="btn nav-link" id="contact-tab2" data-bs-toggle="tab" href="#contact" role="tab" aria-controls="contact" aria-selected="false" tabindex="-1"onclick="compareWithLast()">전년 대비 매출 트렌드 분석</a>
                            </li>
                            <li class="nav-item" role="presentation">
                                <a class="nav-link" id="contact-tab3" data-bs-toggle="tab" href="#contact" role="tab" aria-controls="contact" aria-selected="false" tabindex="-1"onclick="mchdr()">보정계수 관리</a>
                            </li>
                        </ul><br><br>
				<div class="row">
					<div class="col-9">
						<div class="tab-content" id="v-pills-tabContent" style="display:flex;" >
							<fieldset class="form-group" >
	                             <select class="form-select"  id="sel" style="display:none">
	                                <option class="date" value="none">기간 선택</option>
	                           		<option class="date" value="monthOpt">월</option>
	                           		<option class="date" value="quarterOpt">분기</option>
	                           		<option class="date" value="yearOpt">연도</option>
	                             </select>
	                         </fieldset>
	                         
							<fieldset class="form-group">
								<select class="form-select" id="basicSelect" >
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
										<option class="month" value="${m.month }">${m.month}</option>
									</c:forEach>
								</select>
							</fieldset>
							</div>
							<div class="tab-pane fade active show" id="v-pills-home">
							<div class="card">
								<div id="jcchart"></div>
								<canvas id="myChart"></canvas>
								<div id="best"></div>
							</div>
						</div>
							
						</div>
						
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2.0.0"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>
<%@ include file="../include/footer.jsp"%>

<script>
let chartjs = Chart.getChart("myChart");
let chart=null;
function mchdr(){
	$("#basicSelect2").css("display", "none");
	$("#basicSelect").css("display", "none");
	$("#sel").css("display", "none");
	//document.querySelector("#jcchart").innerHTML="";
	reset();
	//alert("매출 등록할꺼야?");
	$.ajax({
		url:"/menu",
		type: "get",
		success:function(resp){
			console.log("응답잘 왔니?",resp);
			let str=`<div class="card">
		        <div class="card-header">
		        <h4 class="card-title">매출 등록</h4>
		    </div>
		    <div class="card-content">
		        <div class="card-body">
		                <div class="form-body">
		                    <div class="row">
		                        <div class="col-md-4">
		                            <label for="first-name-horizontal">메뉴</label>
		                        </div>
		                        <fieldset class="col-md-8 form-group">
		                        <select class="form-select" id="menu">
		                        	<option>메뉴선택</option>`;
		                        
		                        $.each(resp, function(idx,m){
			                        str+=` <option value="\${m.menuNo}">\${m.menuNm}</option>`;
		                        })
		                        
		                       str+=` </select>
				                    </fieldset>
				                    <div class="col-md-4">
		                            <label for="howmany">수량</label>
		                        </div>
		                        <div class="col-md-8 form-group">
		                            <input type="number" id="howmany" class="form-control count" name="email-id" placeholder="수량">
		                        </div>
		                        <div class="col-md-4">
		                            <label for="howmuch">메뉴 가격</label>
		                        </div>
		                        <div class="col-md-8 form-group">
		                            <input type="number" id="howmuch" class="form-control unitprice money" name="contact" onkeyup="javascript:fn_totalMoney()"placeholder="가격">
		                        </div>
		                        <div class="col-md-4">
		                            <label for="total">총금액</label>
		                        </div>
		                        <div class="col-md-8 form-group">
		                            <input type="number" id="total" class="form-control total money" name="password" onkeyup="javascript:fn_totalMoney()"placeholder="총금액">
		                        </div>
		                        <div class="col-sm-12 d-flex justify-content-end">
		                            <button class="btn btn-primary me-1 mb-1" onclick="reg()">등록</button>
		                            <button type="reset" class="btn btn-light-secondary me-1 mb-1">취소</button>
		                        </div>
		                    </div>
		                </div>
		        </div>
		    </div>
		</div>`;

		$("#jcchart").html(str);
		}
	})
	

	
}

fn_totalMoney=function(){
	//alert("오니");
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
	
	//selling에 먼저 selling_no, store_no, selling_date insert하고 (store_no만 받고 나머지는 기본으로 들어가기)
	//그 다음에 selling_detail에 데이터 넣고 그 다음에 selling테이블의 selling_total update하기
	//근데 selling_detail의 selling_no은 selectkey로 찾아서 넣어야하나?
	
	$.ajax({
		url:"/gmj/mchdr",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(data2),
		type:"post",
		dataType:"json",
		success:function(resp){
// 			alert(resp);
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




let data={
	"storeNo":${storeNo}
}

$(document).ready(function() {
	 $(document).on('change','#sel, #basicSelect2', function() {
        let selectedValue = $(this).val();
        $("#basicSelect").css("display", "block");
        document.querySelector("#jcchart").innerHTML="";
        
        if(selectedValue === 'monthOpt' ) {
        	reset();
        	document.querySelector("#jcchart").innerHTML="";
            data.monthOpt = 'y';
        }else if(selectedValue === 'quarterOpt'){
        	reset();
        	document.querySelector("#jcchart").innerHTML="";
        	 data.quarterOpt ='y';
        } 
        else if(selectedValue === 'yearOpt'){
        	reset();
        	document.querySelector("#jcchart").innerHTML="";
            $("#basicSelect").css("display", "none");
            data.yearOpt ='y';
            getMargin();
        }
    });
		
	 $(".btn").on('click', function() {
	          reset();
	          document.querySelector("#jcchart").innerHTML="";
		  	  $("#basicSelect2").css("display", "block");
			  $("#basicSelect").css("display", "block");
			  $("#sel").css("display", "none");
			  
	        if ($(this).html() === "기간별 매출") {
	            $("#basicSelect2").css("display", "none");
	            $("#basicSelect").css("display", "none");
	            $("#sel").css("display", "block").val('none');
	            document.querySelector("#jcchart").innerHTML="";
	            getMargin();
	            
	        }
	        else if ($(this).html() === "전년 대비 매출 트렌드 분석") {
			    $("#basicSelect2").css("display", "none");
			    $("#sel").css("display", "none");
			    compareWithLast();
		  }else {
		        updateCurrentTab();
		    }
	    });
	 
	$(document).on('change', '#basicSelect, #basicSelect2', function() {
		document.querySelector("#jcchart").innerHTML="";
	    let year = $('#basicSelect').val();
	    let month = $('#basicSelect2').val();
	    if (year !== "none") {
	      data.year = year;
	    }
	    if (month !== "none") {
	      data.month = month;
	    }
		
    	updateCurrentTab();
  });
	
	

});

function reset2() {
	/* 	 $("#basicSelect").val("none");
		  $("#basicSelect2").val("none"); */

	
		if (myChart) {
			myChart.destroy();
			myChart = null;
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

function updateCurrentTab() {
	
	document.querySelector("#jcchart").innerHTML="";
  let activeTab = $('.btn.nav-link.active').text();
  switch(activeTab) {
    case "베스트셀러":
      bestSeller();
      break;
    case "기간별 매출":
      getMargin();
      break;
    case "메뉴별 판매량":
      getGraph();
      break;
    case "전년 대비 매출 트렌드 분석":
      compareWithLast();
      break;
  }
}

console.log("날짜",data);
$(".card-title").html(`${name} `);
bestSeller();


function bestSeller(){
	const existingChart = Chart.getChart('myChart');
    if (existingChart) {
        existingChart.destroy();
    }

    if(chart != null){
        chart.destroy();
        chart = null;
    }
    
    document.querySelector("#jcchart").innerHTML = "";
    document.querySelector("#myChart").innerHTML = "";

    // 캔버스 초기화
    const canvas = document.getElementById('myChart');
    if (canvas) {
        const ctx = canvas.getContext('2d');
        ctx.clearRect(0, 0, canvas.width, canvas.height);
    }

   
	console.log("베스트셀러",data);
	if (!data.year || !data.month) {
	    $("#jcchart").html("<p>년도와 월을 선택해주세요.</p>");
	    return;
	  }
	$.ajax({
		url:"/bestSeller",
		data:data,
		type: "get",
		success: function(response) {
			console.log("베스트셀러:",response);
			let str=`
			<div style="display:flex">
                <div class="card-content col-12 col-md-6">
                    <div class="table-responsive">
                        <table class="table mb-0 table-lg">
                            <thead>
                                <tr>
                                    <th>순위</th>
                                    <th>메뉴</th>
                                    <th>판매량</th>
                                </tr>
                            </thead>
                            <tbody>`;
                            
			$.each(response, function (idx, map) {
				str+=`<tr>
	                    <td class="text-bold-500">\${map.rank}</td>
	                    <td class="text-bold-500">\${map.menuNm}</td>
	                    <td class="text-bold-500">\${map.totalAmount}</td>
                </tr>`;
             });
			
             str+=` 
                  </tbody>
                </table>
    </div>
</div> 
<div class="col-12 col-md-6" > <canvas id="myChart"></canvas>
</div>
</div>

`;
			document.querySelector("#jcchart").innerHTML="";
			document.querySelector("#myChart").innerHTML="";
			$("#jcchart").html(str);
			
			 const labels = [];
			    const data = [];
			    const backgroundColor = [
			        'rgba(255, 99, 132, 0.8)',   // 빨강
			        'rgba(54, 162, 235, 0.8)',   // 파랑
			        'rgba(255, 206, 86, 0.8)',   // 노랑
			        'rgba(75, 192, 192, 0.8)',   // 청록
			        'rgba(153, 102, 255, 0.8)'   // 보라
			    ];

			    response.forEach(item => {
			        labels.push(item.menuNm);     // 메뉴명
			        data.push(item.totalAmount);  // 판매량
			    });
			    const ctx = document.getElementById('myChart');
			    const chartjs = new Chart(ctx, {
			        type: 'pie',
			        data: {
			            labels: labels,
			            datasets: [{
			                data: data,
			                backgroundColor: backgroundColor,
			                borderWidth: 1
			            }]
			        },
			        options: {
			            responsive: false,
			            plugins: {
			                legend: {
			                    position: 'right'
			                },
			               
			                tooltip: {
			                    callbacks: {
			                        label: function(context) {
			                            const label = context.label || '';
			                            const value = context.raw || 0;
			                            return `\${label}: \${value}개`;
			                        }
			                    }
			                }
			            }
			        }
			    });
			
		}
	})
}

function reset(){
	
	if(chart!=null){
		chart.destroy();
		chart=null;
	}
   if (chartjs != null) {
        chartjs.destroy();  
        chartjs = null;  
    }
   const canvas = document.getElementById('myChart');
   const ctx = canvas.getContext('2d');
   ctx.clearRect(0, 0, canvas.width, canvas.height);  // 캔버스 초기화
	
   
	$("#basicSelect").val("none"); 
  	data.year = "";
  	$("#basicSelect2").val("none"); 
  	document.querySelector("#jcchart").innerHTML="";
  	data.month = "";
  	data.monthOpt="";
  	data.quarterOpt="";
  	data.yearOpt="";
}

function getMargin() {
    console.log("매출 화긴:", data);
    
    if(chart!=null){
		chart.destroy();
		chart=null;
	}
   if (chartjs != null) {
        chartjs.destroy();  
        chartjs = null;  
    }
   const canvas = document.getElementById('myChart');
   const ctx = canvas.getContext('2d');
   ctx.clearRect(0, 0, canvas.width, canvas.height);  // 캔버스 초기화
	
   
    
    if ((!data.monthOpt && !data.quarterOpt && !data.yearOpt) || ((data.monthOpt || data.quarterOpt) && !data.year)) {
    	    $("#jcchart").html("<p>기간과 연도를 선택해주세요.</p>");
    	    return;
    	}
    
    $.ajax({
        url: "/getmargin",
        type: "get",
        data: data,
        success: function(response) {
            console.log("마진", response);
            
            let chartTitle = response.type === 'monthly' ? '월별 매출' :  response.type ==='quarterly'? '분기별 매출':'연도별 매출';
            const ctx = document.getElementById('myChart');
    		chartjs =  new Chart(ctx, {
            	  type: 'bar',
            	  data: {
            	    labels: response.labels,
            	    datasets: [
            	      {
            	        label: '매출',
            	        data: response.data,
            	      },
            	      {
              	        label: '예산 총 사용액',
              	        data: response.data2,
              	      },
            	      {
              	        label: '매출 총이익',
              	        data: response.profit,
              	      }
            	    ]
            	  },
            	});
        }
    });
}


function getGraph() {
	
    if(chart!=null){
		chart.destroy();
		chart=null;
	}
   if (chartjs != null) {
        chartjs.destroy();  
        chartjs = null;  
    }
   const canvas = document.getElementById('myChart');
   const ctx = canvas.getContext('2d');
   ctx.clearRect(0, 0, canvas.width, canvas.height);  // 캔버스 초기화
	
	
	document.querySelector("#jcchart").innerHTML="";
	chart=null;
	console.log("메뉴별 판매량",data);
    
	if (!data.year || !data.month) {
	    $("#jcchart").html("<p>년도와 월을 선택해주세요.</p>");
	    return;
	  }
    $.ajax({
        url: "/getmenu",
        type: "get",
        data: data,
        success: function(response) {
            const labels = response.labels; // 메뉴 이름
            const data = response.data; // 판매량
			console.log("값확인:",response,Math.max(...data ));
			const ctx = document.getElementById('myChart');
			chartjs =  new Chart(ctx, {
          	  type: 'bar',
          	  data: {
          	    labels: labels,
          	    datasets: [
          	      {
          	        label: '판매량',
          	        data: data,
          	      }
          	    ]
          	  },
          	});
        }
    })
           
}

function compareWithLast(){
	
    if(chart!=null){
		chart.destroy();
		chart=null;
	}
   if (chartjs != null) {
        chartjs.destroy();  
        chartjs = null;  
    }
   const canvas = document.getElementById('myChart');
   const ctx = canvas.getContext('2d');
   ctx.clearRect(0, 0, canvas.width, canvas.height);  // 캔버스 초기화
	
	document.querySelector("#jcchart").innerHTML="";
	chart=null;
    if (!data.year) {
        $("#jcchart").html("<p>년도를 선택해주세요.</p>");
        return;
    }
    console.log("작년비교", data);
    $.ajax({
        url: "/compareWithLast",
        type: "get",
        data: data,
        success: function(response) {
        	/* let myChart = new Chart(myCt, {
        	    data: {
        	        datasets: [{
        	            type: 'bar',
        	            label: '올해 매출',
        	            data: response.data2
        	        }, 
        	        {
        	            type: 'bar',
        	            label: '작년 매출',
        	            data: response.data
        	        },
        	        {
        	            type: 'line',
        	            label: '증감율(%)',
        	            data: response.data3,
        	            tension: 0.4  // 선을 부드럽게 만듦
        	        }],
        	        labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
        	    },
        	    options: {
        	    	responsive: true,
        	    	 plugins: {
       			      legend: {
       			        position: 'top',
       			      },
        	    	 },
        	        scales: {
        	            y: {
        	                type: 'linear',
        	                display: true,
        	                position: 'left',
        	            },
        	            y1: {
        	                type: 'linear',
        	                display: true,
        	                position: 'right',
        	                grid: {
        	                    drawOnChartArea: false
        	                }
        	            }
        	        }
        	    }

        	}); */
        	
        	console.log("작년비교:",response);
            var options = {
                series: [{
                    name: response.labels[0].split("-")[0]+"년",
                    type: 'column',
                    data: response.data2
                }, {
                    name: response.labels[0].split("-")[0]-1+"년",
                    type: 'column',
                    data: response.data
                }, {
                    name: '증감율(%)',
                    type: 'line',
                    data: response.data3
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
                    categories: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
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
            document.querySelector("#jcchart").innerHTML = "";
            chart = new ApexCharts(document.querySelector("#jcchart"), options);
            chart.render();
        	
        }
    });
}


</script>
<style type="text/css">
body {
	font-family: Roboto, sans-serif;
}

#myChart{
	height:100px;
	width:300px; 
	margin-left:150px !important;
	padding-top:0px !important;
}

</style>