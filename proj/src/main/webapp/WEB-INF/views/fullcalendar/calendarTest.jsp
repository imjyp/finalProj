<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>


<!-- FullCalendar CSS -->
<link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.css" rel="stylesheet" />
<!-- Bootstrap CSS (추가) -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- FullCalendar JS -->
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>

<!DOCTYPE html>

<head>

	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>이벤트 캘린더</title>
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

<body>
 <div id="main">
     <div class="card">
	  <div class="card-header">
	    <div class="container-fluid">
	      <div class="row align-items-center">

	<!-- 왼쪽: 제목과 브레드크럼 (col-md-6) -->
	        <div class="col-md-6 d-flex align-items-center">
	          <nav aria-label="breadcrumb" class="ms-3">
	            <ol class="breadcrumb mb-0">
	              <li class="breadcrumb-item"><a href="/main">Home</a></li>
	              <li class="breadcrumb-item active"><a href="/calendar/test">이벤트 캘린더</a></li>
	            </ol>
	          </nav>
	        </div>
	        
	        </div> <!-- /.row.align-items-center -->
	    </div> <!-- /.container-fluid -->
	  </div> <!-- /.card-header -->
	</div> <!-- /.card -->

	<div class="card" style="size: ">
		<!-- THE CALENDAR -->
		<div id="calendar" ></div>
	</div>



<!-- 일정 입력을 위한 모달 시작 -->
<div class="modal fade" id="addModal" tabindex="-1" aria-labelledby="addModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addModalLabel">일정 입력</h5>
            </div>
            <div class="modal-body">
             <div class="form-group">
		        <input type="checkbox" id="autoFillCheckbox">
		        <label for="autoFillCheckbox">자동 입력</label>
		    </div>
                <div class="form-group">
                    <label for="newTitle">제목:</label>
                    <input type="text" class="form-control" id="newTitle" placeholder="제목을 입력하세요">
                </div>
                <div class="form-group">
                    <label for="newContent">내용:</label>
                    <textarea class="form-control" id="newContent" placeholder="내용을 입력하세요"></textarea>
                </div>
				<div class="form-group">
                    <label for="newStart">시작날짜:</label>
                    <input type="datetime-local" class="form-control" id="newStart"  value="">
                </div>
                <div class="form-group">
                    <label for="newEnd">종료날짜:</label>
                    <input type="datetime-local" class="form-control" id="newEnd"  value="">
                </div>
                <div class="form-group">
                    <label for="newTextColor">글자색:</label>
                    <input type="color" class="form-control" id="newTextColor" disabled>
                    <!-- this 선택이 바뀌면 나 자신을 함수의 파라미터로 던짐 -->
					<select class="form-select" onchange="fnNewTextColor(this)">
<!--                         <option value="" disabled selected>선택해주세요</option> -->
<!--                         <option value="#000000" >검정</option> -->
                        <option value="#FFFFFF" selected>하얀</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="newBgColor">배경색:</label>
                    <input type="color" class="form-control" id="newBgColor" disabled>
					<!-- this 선택이 바뀌면 나 자신을 함수의 파라미터로 던짐 -->
					<select class="form-select" onchange="fnNewBgColor(this)">
						<option value="" readonly>선택해주세요</option>
                        <option value="#FF6B6B" >빨간색</option>
                        <option value="#4ECDC4" >민트색</option>
                        <option value="#FFD93D" >노란색</option>
						<option value="#5E60CE" >보라색</option>
						<option value="#FF924C" >오렌지색</option>
                    </select>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-warning ms-1" id="saveCancelEventBtn" data-bs-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-dark ms-1" id="saveEventBtn">저장</button>
            </div>
        </div>
    </div>
</div>
<!-- 일정 입력을 위한 모달 끝 -->

<!-- 이벤트 수정 모달 시작 -->
<div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editModalLabel">이벤트 수정</h5>
            </div>
            <div class="modal-body">
                <!-- 모달수정 내용 영역 시작 -->
                <div class="form-group" hidden>
                    <label for="editNm">번호:</label>
                    <input type="number" class="form-control" id="editNm" disabled>
                </div>
                <div class="form-group">
                    <label for="editTitle">제목:</label>
                    <input type="text" class="form-control" id="editTitle" placeholder="제목을 입력하세요" disabled>
                </div>
                <div class="form-group">
                    <label for="editContent">내용:</label>
                    <textarea class="form-control" id="editContent" placeholder="내용을 입력하세요" disabled></textarea>
                </div>
                <div class="form-group">
                    <label for="editStart">시작날짜:</label>
                    <input type="datetime-local" class="form-control" id="editStart" disabled>
                </div>
                <div class="form-group">
                    <label for="editEnd">종료날짜:</label>
                    <input type="datetime-local" class="form-control" id="editEnd" disabled>
                </div>
                <div class="form-group">
                    <label for="editTextColor">글자색:</label>
                    <input type="color" class="form-control" id="editTextColor" disabled>
                    <!-- this 선택이 바뀌면 나 자신을 함수의 파라미터로 던짐 -->
                    <select class="form-select" id="selTextColor" onchange="fnEditTextColor(this)" disabled>
<!--                     	<option value="#000000" >검정</option> -->
                        <option value="#FFFFFF" selected>하얀</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="editBgColor">배경색:</label>
                   	<input type="color" class="form-control" id="editBgColor" disabled>
                   	<!-- this 선택이 바뀌면 나 자신을 함수의 파라미터로 던짐 -->
					<select class="form-select" id="selBgColor" onchange="fnEditBgColor(this)" disabled>
                        <option value="" disabled selected>선택해주세요</option>
                        <option value="#FF6B6B" >빨간색</option>
                        <option value="#4ECDC4" >민트색</option>
                        <option value="#FFD93D" >노란색</option>
						<option value="#5E60CE" >보라색</option>
						<option value="#FF924C" >오렌지색</option>                       
                    </select>
				</div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-warning ms-1" id="editCancelEventBtn" data-bs-dismiss="modal">닫기</button>
            	<button type="button" class="btn btn-warning ms-1" id="editEventBtn">수정</button>
                <button type="button" class="btn btn-dark ms-1" id="updateEventBtn" hidden="">수정완료</button>
                <button type="button" class="btn btn-warning ms-1" id="deleteEventBtn">삭제</button>
            </div>
        </div>
    </div>
    </div>
</div>
<!-- 메인 끝 -->
	

<script>
//색상 선택 함수
function fnEditTextColor(obj){
	console.log("선택한 색, value : ",obj.value);
	document.getElementById('editTextColor').value = obj.value;
}
function fnEditBgColor(obj){
	document.getElementById('editBgColor').value = obj.value;
}
function fnNewTextColor(obj){
	document.getElementById('newTextColor').value = obj.value;
}
function fnNewBgColor(obj){
	document.getElementById('newBgColor').value = obj.value;
}

document.addEventListener('DOMContentLoaded', function () {
	let selectedEvent = null;
	 var autoFillCheckbox = document.getElementById('autoFillCheckbox');

	    autoFillCheckbox.addEventListener('change', function() {
	        if (this.checked) {
	            document.getElementById('newTitle').value = '[발렌타인데이] 마음을 전하세요 ❤';
	            document.getElementById('newContent').value = '초코가 들어간 메뉴를 단돈 100원에 구매가능합니다. 발렌타인데이에 소중한 인연에게 선물해보세요';
	            document.getElementById('newTextColor').value = '#FFFFFF';
	            document.getElementById('newBgColor').value = '#ff0000';
	        } 
	    });
	
    var calendarEl = document.getElementById('calendar'); // 캘린더 엘리먼트 가져오기
    var calendar = new FullCalendar.Calendar(calendarEl, { // 캘린더 객체 생성
    	
//크기 조정
   	expandRows: true,			//각 행 높이를 동일한 높이로 강제변경
   	contentHeight: '600px',	// 달력의 보기 영역 높이를 설정
//    	contentHeight: 'auto',	// 달력의 보기 영역 높이를 설정
   	height: 'auto', 			// 높이를 픽셀 단위로 지정
//     width: '100%', 				// 너비를 설정
//      width: '400px', 			// 너비를 설정
    width: 'auto',
    
   	aspectRatio: 4, // 너비 대비 높이 비율 설정
   	//handleWindowResize: true, // 창 크기에 따라 자동 조절
   	initialView: 'dayGridMonth', //초기 뷰 기본설정: 월별 격자 뷰
   	
   	selectable: true, // 이벤트 선택 가능 여부(등록되지 않은 날짜까지 선택됌)
   	editable: true, // 드래그 이벤트 편집 가능
   	durationEditable: true, // 이벤트의 길이 조정 가능
   	displayEventTime: false, //이벤트 날짜/시간에 대한 텍스트를 표시할지 여부
   	dayMaxEventRows: 4, // 해당날짜에 행 단위 이벤트 최대 몇개까지 표시
    
    dayMinWidth: '600px', // 너무 좁아져서 일자 셀이 더 이상 맞지않을 때 dayMinWidth가로 스크롤바
    
   	eventDisplay: 'block', 		// 이벤트가 항상 보이도록 설정
    stickyFooterScrollbar: true, //상단의 날짜 헤더를 뷰포트에 고정
   	
    eventTimeFormat: { // 이벤트 시간 형식 설정
        hour: '2-digit',
        minute: '2-digit',
        meridiem: false,
        hour12: false
    },
	headerToolbar: {
	       left: 'AddButton prevYear,prev,today,next,nextYear',
	       center: 'title',
	       right: 'dayGridMonth,timeGridWeek,timeGridDay'
	},
    
    timeZone: 'UTC', // 타임존 사용
//     eventOverlap: true, //동일한 시간대의 이벤트 중첩
    events: '/calendar/events',	// 이벤트 데이터 가져오기: 서버에서 JSON 데이터 가져오기
    
 // 이벤트 드롭 시
    eventDrop: function(info) {
    	var event = info.event;
        var newStart = event.start;
        var newEnd = event.end || newStart;
        
        var startDate = new Date(newStart);
        var endDate = new Date(newEnd);
        
        var formattedStart = startDate.toISOString().slice(0, 16); // "2025-01-13T09:00"
        var formattedEnd = endDate.toISOString().slice(0, 16);  
        
        console.log("formattedStart:",formattedStart);
        console.log("formattedEnd:",formattedEnd);
        console.log("info:",info);
        console.log("info.event:",info.event);
        console.log("info.event.extendsProps:",info.event.extendedProps.Nm);
        
        $.ajax({
            url: '/calendar/updateEvent',
            method: 'PUT',
            contentType: "application/json", 
            dataType: "json",  
            data: JSON.stringify({
              calNm:info.event.extendedProps.Nm,
              calStart: formattedStart,
              calEnd: formattedEnd
            }),
            success: function(response) {
            	if(response>0){
	              alert('이벤트가 성공적으로 업데이트되었습니다.');
            	}
            },
            error: function() {
              alert('이벤트 업데이트 중 오류가 발생했습니다.');
              info.revert();
            }
          });
     },
    select:function(info){
    	resetModalFields();
    	console.log("셀렉트:",info);
    	var addModal = new bootstrap.Modal(document.getElementById('addModal'));
    	addModal.show();
    	let startDate = new Date(info.startStr).toISOString().slice(0, 16); 
	    let endDate = new Date(info.endStr).toISOString().slice(0, 16); 
	    console.log("시작 날짜:", startDate, "종료 날짜:", endDate);
	    
	    $("#newStart").val(startDate); 
	    $("#newEnd").val(endDate); 
	    
	    
	    
	    document.getElementById('saveEventBtn').onclick = function() {
			// 등록된 데이터를 서버에 전송
            var saveTitle = document.getElementById('newTitle').value;
            var saveContent = document.getElementById('newContent').value;
            var saveStart = document.getElementById('newStart').value;
          	var saveEnd = document.getElementById('newEnd').value;
            var saveTextColor = document.getElementById('newTextColor').value;
            var saveBgColor = document.getElementById('newBgColor').value;
            
            console.log("타이틀",saveTitle);
            console.log("내용",saveContent);
            console.log("시작",saveStart);
            console.log("종료",saveEnd);
            console.log("색깔",saveTextColor);
            console.log("배경",saveBgColor);
            
            if(!saveStart && !saveEnd || new Date(saveStart) > new Date(saveEnd)) {
				alert("종료일이 시작일보다 전입니다. 다시 입력해주세요.");
            }else{
            if(saveTitle && saveStart) {
            	if (saveStart === saveEnd) {
            		let offset = 9 * 60 * 60 * 1000; // +9시간 kst 시간
            		let endDate = new Date(new Date(saveStart).getTime()+offset);
            	    
            		endDate.setMinutes(endDate.getMinutes() + 1); // Minutes 으로 1분추가
            		saveEnd = endDate.toISOString().slice(0, 16); // ISO 형식 변환
                }
          	// 서버로 등록 요청
                fetch('/calendar/saveEvent', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                     calTitle: saveTitle,		// 등록된 제목
                     calContent: saveContent,	// 등록된 내용
                     calStart: saveStart,		// 시작일
                     calEnd: saveEnd,			// 종료일
                     textColor: saveTextColor,	// 등록된 글자색
                     bgColor: saveBgColor,		// 등록된 배경색
                    }),
                })
                .then(response => response.json())
                .then(() => {
                    alert('일정이 등록되었습니다.');
                    addModal.hide();// 모달 닫기
                    calendar.refetchEvents();	// 이벤트 등록 후 캘린더 새로 고침
                })
                .catch(err => console.log('일정 등록 중 오류 발생:', err));
         	}else{
				alert("제목 다시 입력해주세요.");
         	} 
           }
		};
    },
    
    // 이벤트 클릭 시 발생하는 이벤트 핸들러
    eventClick: function (info) {
    		console.log("이벤트 제목:", info.event.title);
		    const dEditTitle = document.getElementById('editTitle');         // 수정된 제목   
	        const dEditContent = document.getElementById('editContent');       // 수정된 내용   
	        const dEditStart = document.getElementById('editStart');         // 시작일      
	        const dEditEnd = document.getElementById('editEnd');           // 종료일      
	        const dEelTextColor = document.getElementById('selTextColor');      // 수정된 글자색  
	        const dEelBgColor = document.getElementById('selBgColor');        // 수정된 배경색  
	        
	        const hUpdateEventBtn = document.getElementById('updateEventBtn');	//수정완료 버튼
	        const dEditEventBtn = document.getElementById('editEventBtn');	//수정 버튼
	        
	        dEditTitle.disabled = true;
	        dEditContent.disabled = true; 
	        dEditStart.disabled = true;
	        dEditEnd.disabled = true;
	        dEelTextColor.disabled = true;
	        dEelBgColor.disabled = true;
	        
	        hUpdateEventBtn.hidden = true;
	        dEditEventBtn.hidden = false;
	        
	     	// 클릭한 이벤트의 세부 정보 가져오기
			var event = info.event;
			// 수정할 이벤트의 현재 값을 입력 필드에 채우기 기본값으로 지정되어 있지 않은 변수는 extendedProps 입력하기
		   	document.getElementById('editNm').value = event.extendedProps.Nm;
			document.getElementById('editTitle').value = event.title || null;
			document.getElementById('editContent').value = event.extendedProps.content || null;
			document.getElementById('editStart').value = event.start.toISOString().slice(0, 16);
			document.getElementById('editEnd').value = event.end.toISOString().slice(0, 16);
		    document.getElementById('editTextColor').value = event.textColor || null;
		    document.getElementById('editBgColor').value = event.backgroundColor || null;

	        // 수정 모달 생성 후 띄우기
	        var editModal = new bootstrap.Modal(document.getElementById('editModal'));
	        editModal.show();
	        
	        // 수정에서 삭제 버튼
		    document.getElementById('deleteEventBtn').onclick = function () {
		    	if (event.extendedProps.Nm) {
		         	// 서버로 삭제 요청
	                fetch('/calendar/deleteEvent', {
	                    method: 'DELETE',
	                    headers: { 'Content-Type': 'application/json' },
	                    body: JSON.stringify({
	                    	calNm: event.extendedProps.Nm	// 원래 번호
	                    }),
	                })
	            	.then(response => response.json())
	           		.then(() => {
	                calendar.refetchEvents();	// 이벤트 삭제 후 캘린더 새로 고침
	                alert('일정이 삭제되었습니다.');
	                editModal.hide();// 모달 닫기
	            	})
	            		.catch(err => console.log(err));
				}
		    }
	        
		 	// 입력된 데이터를 전송 취소하기 위한 버튼 클릭 이벤트 처리
            document.getElementById('editCancelEventBtn').onclick = function() {
                editModal.hide();// 모달 닫기
         	};
        
		        // 수정된 데이터를 서버에 전송하기 위한 버튼 클릭 이벤트 처리
			    document.getElementById('editEventBtn').onclick = function () {
					// 수정버튼 클릭시 입력 가능으로 변경
			        dEditTitle.disabled = false;
			        dEditContent.disabled = false; 
			        dEditStart.disabled = false;
			        dEditEnd.disabled = false;
			        dEelTextColor.disabled = false;
			        dEelBgColor.disabled = false;
			        
			        hUpdateEventBtn.hidden = false;
			        dEditEventBtn.hidden = true;
			        
	        		// 수정된 데이터를 서버에 전송하기 위한 버튼 클릭 이벤트 처리
		           	document.getElementById('updateEventBtn').onclick = function() {
		            	// 수정된 데이터를 서버에 전송
		               var updatedTitle = document.getElementById('editTitle').value;
		               var updatedContent = document.getElementById('editContent').value;
		               var updatedTextColor = document.getElementById('editTextColor').value;
		               var updatedBgColor = document.getElementById('editBgColor').value;
		              
		               var updatedStart = document.getElementById('editStart').value;
		               var updatedEnd =  document.getElementById('editEnd').value;
		               
		               if(!updatedStart && !updatedEnd || new Date(updatedStart) > new Date(updatedEnd)){
		               	alert("종료일이 시작일보다 전입니다. 다시 입력해주세요.");
		               }else{
			         	if (updatedTitle && updatedStart) {
			         		if (updatedStart === updatedEnd) {
			         			let offset = 9 * 60 * 60 * 1000; // +9시간 kst 시간
			         			// startDate를 복사하여 새로운 Date 객체 생성
                                let endDate = new Date(new Date(updatedStart).getTime()+offset);
                              	//endDate.setHours(endDate.getHours() + 9); // Hours으로 9시간 추가
                              	
                                endDate.setMinutes(endDate.getMinutes() + 1); // Minutes으로 1분 추가
                                updatedEnd = endDate.toISOString().slice(0, 16); // ISO 형식 변환
	                        }
				         	// 서버로 업데이트 요청
			                fetch('/calendar/updateEvent', {
			                    method: 'PUT',
			                    headers: { 'Content-Type': 'application/json' },
			                    body: JSON.stringify({
			                    	calNm: event.extendedProps.Nm,	// 원래 번호
				                    calTitle: updatedTitle,			// 수정된 제목
				                    calContent: updatedContent,		// 수정된 내용
				                    calStart: updatedStart,			// 시작일
				                    calEnd: updatedEnd,				// 종료일
				                    textColor: updatedTextColor,	// 수정된 글자색
				                    bgColor: updatedBgColor,		// 수정된 배경색
			                    }),
			                })
		                	.then(response => response.json())
		               		.then(() => {
		                    calendar.refetchEvents();	// 이벤트 수정 후 캘린더 새로 고침
		                    alert('일정이 수정되었습니다.');
		                    editModal.hide();// 모달 닫기
		                	})
		                		.catch(err => console.log('일정 등록 중 오류가 발생:',err));
						}else{
							alert("제목과 시작일을 입력해주세요");
						}
		               }
					};//수정완료 버튼
			};//수정버튼
		},//단일 이벤트 객체 선택
        
		
		//커스텀 버튼 생성
        customButtons: {
             AddButton: { //커스텀 버튼 함수 이름
               text: '일정추가', //커스텀 버튼 표시되는 이름
               click: function() {
         		// 입력 필드 초기화
                document.getElementById('newTitle').value = '';
                document.getElementById('newContent').value = '';
                document.getElementById('newStart').value = null;
                document.getElementById('newEnd').value = null;
                document.getElementById('newTextColor').value = '#FFFFFF'; // 기본 색상
                document.getElementById('newBgColor').value = '#FFFFFF'; // 기본 색상
                
                // 입력 모달 생성 후 띄우기
         		var addModal = new bootstrap.Modal(document.getElementById('addModal'));
         		addModal.show();
                
             	// 입력된 데이터를 전송 취소하기 위한 버튼 클릭 이벤트 처리
                document.getElementById('saveCancelEventBtn').onclick = function() {
					document.getElementById('newTitle').value = '';
                    document.getElementById('newContent').value = '';
                    document.getElementById('newStart').value = null;
					document.getElementById('newEnd').value = null;
					document.getElementById('newTextColor').value = null; // 기본 색상
					document.getElementById('newBgColor').value = null; // 기본 색상
					calendar.refetchEvents();	// 이벤트 등록 후 캘린더 새로 고침
					addModal.hide();// 모달 닫기
             	};
             	
                // 입력된 데이터를 서버에 전송하기 위한 버튼 클릭 이벤트 처리
				document.getElementById('saveEventBtn').onclick = function() {
					// 등록된 데이터를 서버에 전송
	                var saveTitle = document.getElementById('newTitle').value;
	                var saveContent = document.getElementById('newContent').value;
	                var saveStart = document.getElementById('newStart').value;
	              	var saveEnd = document.getElementById('newEnd').value;
	                var saveTextColor = document.getElementById('newTextColor').value;
	                var saveBgColor = document.getElementById('newBgColor').value;
	                
	                console.log("타이틀",saveTitle);
	                console.log("내용",saveContent);
	                console.log("시작",saveStart);
	                console.log("종료",saveEnd);
	                console.log("색깔",saveTextColor);
	                console.log("배경",saveBgColor);
	                
	                // 시작일or종료일이 비어있거나 조건 유효하지 않은지 확인
	                if(!saveStart && !saveEnd || new Date(saveStart) > new Date(saveEnd)) {
						alert("종료일이 시작일보다 전입니다. 다시 입력해주세요.");
	                }else{
                    if(saveTitle && saveStart) {
                    	if (saveStart === saveEnd) {
                    		let offset = 9 * 60 * 60 * 1000; // +9시간 kst 시간
                    		let endDate = new Date(new Date(saveStart).getTime()+offset);
                    	    
                    		endDate.setMinutes(endDate.getMinutes() + 1); // Minutes 으로 1분추가
                    		saveEnd = endDate.toISOString().slice(0, 16); // ISO 형식 변환
                        }
                  	// 서버로 등록 요청
                        fetch('/calendar/saveEvent', {
                            method: 'POST',
                            headers: { 'Content-Type': 'application/json' },
                            body: JSON.stringify({
                             calTitle: saveTitle,		// 등록된 제목
                             calContent: saveContent,	// 등록된 내용
                             calStart: saveStart,		// 시작일
                             calEnd: saveEnd,			// 종료일
                             textColor: saveTextColor,	// 등록된 글자색
                             bgColor: saveBgColor,		// 등록된 배경색
                            }),
                        })
                        .then(response => response.json())
                        .then(() => {
                            alert('일정이 등록되었습니다.');
                            addModal.hide();// 모달 닫기
                            calendar.refetchEvents();	// 이벤트 등록 후 캘린더 새로 고침
                        })
                        .catch(err => console.log('일정 등록 중 오류 발생:', err));
                 	}else{
						alert("제목 다시 입력해주세요.");
                 	} 
	               }
				};	//saveEventBtn 호출 버튼
               } //커스텀 버튼 클릭시
             } //커스텀 버튼 함수이름
         },//커스텀 버튼 생성 명렁어 끝부분
     });     
     calendar.render();  // 캘린더 렌더링
 });
 
function resetModalFields() {
    // 새 이벤트 등록 모달 필드 초기화
    document.getElementById('newTitle').value = '';
    document.getElementById('newContent').value = '';
    document.getElementById('newStart').value = '';
    document.getElementById('newEnd').value = '';
    
    document.getElementById('newTextColor').value = '#FFFFFF';
    document.getElementById('newBgColor').value = '#FFFFFF';

    // 기존 이벤트 수정 모달 필드 초기화
    document.getElementById('editNm').value = '';
    document.getElementById('editTitle').value = '';
    document.getElementById('editContent').value = '';
    document.getElementById('editStart').value = '';
    document.getElementById('editEnd').value = '';
    
    document.getElementById('editTextColor').value = '#FFFFFF';
    document.getElementById('editBgColor').value = '#FFFFFF';
}
</script>
<%@ include file="../include/footer.jsp" %>