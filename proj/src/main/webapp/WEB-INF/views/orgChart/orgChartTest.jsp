<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>

<!-- 조직도 script 설치 -->
<script src="https://balkan.app/js/OrgChart.js"></script>

<head>

	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>조직도</title>
	<link rel="stylesheet" href="/dist/assets/compiled/css/app.css">
	<link rel="stylesheet" href="/css/common2.css">
	<link rel="shortcut icon" type="image/x-icon" href="/kor/images/favicon.ico">
<!-- 	<link rel="stylesheet" href="/dist/assets/compiled/css/app-dark.css"> -->
	<link rel="stylesheet" href="/dist/assets/compiled/css/iconly.css">
<!-- 	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"> -->
	
	
<!-- sweetAlert 버전 1 -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<!-- sweetAlert 버전2 -->
<!-- sweetAlert -->
<link rel="stylesheet" href="/css/sweetalert2.min.css">
<script type="text/javascript" src="/js/sweetalert2.min.js"></script>
	
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/top.jsp"%>
</head>
<style>
.swal-body{
	font-family : 'NotoSansKR' ; 
	font-size :500 !important;
}

#main {
  margin-top: 141px; 
}
</style>

<div id="main">
        <%@ include file="../include/top.jsp" %>
        <div class="card">
        
            <!-- 왼쪽: 제목과 브레드크럼 (col-md-6) -->
	        <div class="col-md-6 d-flex align-items-center">
	          <nav aria-label="breadcrumb" class="ms-3">
	            <ol class="breadcrumb mb-0">
	              <li class="breadcrumb-item"><a href="/main">Home</a></li>
	              <li class="breadcrumb-item active"><a href="/orgChart/test">조직도</a></li>
	            </ol>
	          </nav>
	        </div>
            
            <div class="card-body">
	            <style>
				  /* 부모 컨테이너: 브라우저 창에 따라 높이를 지정하고 overflow 설정 */
				  #orgChartContainer {
				      width: 100%;
				      height: 80vh;  /* 뷰포트 높이의 80% */
				      overflow: auto; /* 내용이 넘치면 스크롤바 생성 */
				      border: 1px solid #ddd;
				      box-sizing: border-box;
				  }
				  /* 조직도 영역에 최소 크기를 지정 (데이터에 따라 적절히 조정) */
				  #tree {
				      min-width: 900px;  /* 조직도 가로 길이 */
				      min-height: auto;  /* 조직도 세로 길이 */
				  }
				</style>
                <!-- 조직도 렌더링 영역 -->
				<div id="orgChartContainer">
                	<div id="tree"></div>
                </div>
            </div>
        </div>
    </div>

<script type="text/javascript">


//Ajax를 사용하여 서버에서 데이터 가져오기
var chart; // 전역 변수 선언
$.ajax({
  url: '/orgChart/orgList', // 데이터를 제공하는 서버의 URL
  method: 'GET', // HTTP 요청 메서드
  dataType: 'json', // 서버에서 반환될 데이터 타입
  success: function (orgChartList) {
	// 서버에서 받은 데이터를 기반으로 OrgChart 초기화
    var chart = new OrgChart(document.getElementById("tree"), { // 전역 변수
    	template: "ana", // 사용자 정의 템플릿 'ana' 사용
    	nodeMouseClick: OrgChart.action.none, // 노드 클릭 비활성화
    	mouseScrool: OrgChart.action.none, // 마우스 스크롤 비활성화
	    enableSearch: false, //검색
	    enableDragDrop: false, // 드래그앤드랍
	    fit: true,  // 창 크기 조절 시 자동 맞춤
	    menu: {
	        pdf: { text: "Export PDF" },
	        png: { text: "Export PNG" },
	        svg: { text: "Export SVG" },
	        csv: { text: "Export CSV" }
	    },
	    nodeBinding: {
	        field_0: "name" // 데이터의 'name' 값을 노드에 표시
	    },
	    nodes: orgChartList // 서버에서 받은 데이터 사용
	});
  },
  error: function (xhr, status, error) {
    console.error("조직도 데이터를 가져오는 중 오류 발생:", error);
  }
});

//추가적인 정의를 위한 초기 설정 (현재는 비어 있음)
OrgChart.templates.ana.defs = "";
//노드 크기 설정 (가로 250px, 세로 120px)
OrgChart.templates.ana.size = [250, 120];
//연결선 조정 (현재 모든 값이 0이므로 기본 위치)
OrgChart.templates.ana.linkAdjuster = {
    fromX: 0,
    fromY: 0,
    toX: 0,
    toY: 0
};
//클릭 효과 제거 (Ripple 애니메이션 없음)
OrgChart.templates.ana.ripple = {
    radius: 0,
    color: "#000000",
    rect: null
};
//SVG 기본 구조 설정
OrgChart.templates.ana.svg = 
    `<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" 
        style="display:block;" width="{w}" height="{h}" viewBox="{viewBox}">{content}
    </svg>`;
 // 노드 배경을 노란색(#ffc107)으로 설정
OrgChart.templates.ana.node = 
    `<rect x="0" y="0" height="{h}" width="{w}" fill="#ffc107" stroke-width="1" stroke="#aeaeae" rx="7" ry="7"></rect>`;
 // 기본적인 부모-자식 간 연결선 스타일
OrgChart.templates.ana.link = 
    `<path stroke-linejoin="round" stroke="#aeaeae" stroke-width="1px" fill="none" d="{rounded}" />`;
 // 보조(어시스턴트) 연결선 스타일
OrgChart.templates.ana.assistanseLink = 
    `<path stroke-linejoin="round" stroke="#aeaeae" stroke-width="2px" fill="none" 
    d="M{xa},{ya} {xb},{yb} {xc},{yc} {xd},{yd} L{xe},{ye}" />`;
 // 포인터 아이콘을 원형(circle)으로 설정
OrgChart.templates.ana.pointer = 
    `<g data-pointer="pointer" transform="matrix(0,0,0,0,100,100)">
        <radialGradient id="pointerGradient">
            <stop stop-color="#ffffff" offset="0" />
            <stop stop-color="#C1C1C1" offset="1" />
        </radialGradient>
        <circle cx="16" cy="16" r="16" stroke-width="1" stroke="#acacac" fill="url(#pointerGradient)"></circle>
    </g>`;
 // 확장/축소 버튼 크기 설정
OrgChart.templates.ana.expandCollapseSize = 30;
//'+' 버튼 스타일
OrgChart.templates.ana.plus = 
    `<circle cx="15" cy="15" r="15" fill="#ffffff" stroke="#aeaeae" stroke-width="1"></circle>
    <line x1="4" y1="15" x2="26" y2="15" stroke-width="1" stroke="#aeaeae"></line>
    <line x1="15" y1="4" x2="15" y2="26" stroke-width="1" stroke="#aeaeae"></line>`; 
 // '-' 버튼 스타일
OrgChart.templates.ana.minus = 
    `<circle cx="15" cy="15" r="15" fill="#ffffff" stroke="#aeaeae" stroke-width="1"></circle>
    <line x1="4" y1="15" x2="26" y2="15" stroke-width="1" stroke="#aeaeae"></line>`;
//노드 메뉴 버튼을 3개의 흰색 점(circle)으로 표시
OrgChart.templates.ana.nodeMenuButton = 
    `<g style="cursor:pointer;" transform="matrix(1,0,0,1,225,105)" data-ctrl-n-menu-id="{id}">
        <rect x="-4" y="-10" fill="#000000" fill-opacity="0" width="22" height="22"></rect>
        <circle cx="0" cy="0" r="2" fill="#ffffff"></circle>
        <circle cx="7" cy="0" r="2" fill="#ffffff"></circle><circle cx="14" cy="0" r="2" fill="#ffffff"></circle>
    </g>`;
// 메뉴버튼
OrgChart.templates.ana.menuButton = 
    `<div style="position:absolute;right:{p}px;top:{p}px; width:40px;height:50px;cursor:pointer;" data-ctrl-menu="">
        <hr style="background-color: #7A7A7A; height: 3px; border: none;">
        <hr style="background-color: #7A7A7A; height: 3px; border: none;">
        <hr style="background-color: #7A7A7A; height: 3px; border: none;">
    </div>`;
 // 노드 내 텍스트 스타일
OrgChart.templates.ana.field_0 = 
    `<text data-width="200" style="font-size: 30px;" fill="#ffffff" x="125" y="70" text-anchor="middle">{val}</text>`;
 // 링크(연결선) 텍스트 스타일
OrgChart.templates.ana.link_field_0 = 
    `<text text-anchor="middle" fill="#aeaeae" data-width="290" x="0" y="0" style="font-size:10px;">{val}</text>`;

OrgChart.templates.ana.padding = [50, 20, 35, 20];




//(선택 사항) 창 크기 변경 시 차트 다시 그리기
$(window).resize(function(){
   if(chart && typeof chart.redraw === "function") {
       chart.redraw();
   }
});

</script>


<%@ include file="../include/footer.jsp" %>