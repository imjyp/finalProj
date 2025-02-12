<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!-- fullcalendar 스크립트와 스타일시트 추가 시작 -->
<link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>
<!-- <script src='fullcalendar/dist/index.global.js'></script> -->
<!-- fullcalendar 스크립트와 스타일시트 추가 끝 -->

<!DOCTYPE html>

<!-- Spring Security: 로그인 상태 체크 -->
<sec:authorize access="isAuthenticated()">
    <%@ include file="../include/header.jsp" %>
    <!-- 모바일용 버튼 -->
    <header class="mb-3">
        <a href="#" class="burger-btn d-block d-xl-none">
            <i class="bi bi-justify fs-3"></i>
        </a>
</header>
</sec:authorize>

<!-- 비회원 페이지 -->
<sec:authorize access="!isAuthenticated()">
    <%@ include file="../include/top.jsp" %>
</sec:authorize>

<!-- 일정 입력을 위한 모달 시작 -->
<div class="modal fade" id="addModal" tabindex="-1" aria-labelledby="addModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addModalLabel">일정 입력</h5>
            </div>
            <div class="modal-body">
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
                    <input type="datetime-local" class="form-control" id="newStart">
                </div>
                <div class="form-group">
                    <label for="newEnd">종료날짜:</label>
                    <input type="datetime-local" class="form-control" id="newEnd">
                </div>
                <div class="form-group">
                    <label for="newTextColor">글자색:</label>
                    <input type="color" class="form-control" id="newTextColor" disabled>
                    <!-- this 선택이 바뀌면 나 자신을 함수의 파라미터로 던짐 -->
					<select class="form-select" onchange="fnNewTextColor(this)">
                        <option value="" disabled>선택해주세요</option>
                        <option value="#000000" >검정</option>
                        <option value="#FFFFFF" >하얀</option>
						<option value="#FF0000" >빨강</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="newBgColor">배경색:</label>
                    <input type="color" class="form-control" id="newBgColor" disabled>
					<!-- this 선택이 바뀌면 나 자신을 함수의 파라미터로 던짐 -->
					<select class="form-select" onchange="fnNewBgColor(this)">
						<option value="" disabled>선택해주세요</option>
                        <option value="#FF6B6B" >밝은 레드</option>
                        <option value="#4ECDC4" >밝은 민트</option>
                        <option value="#FFD93D" >밝은 옐로우</option>
						<option value="#1A535C" >짙은 청록</option>
						<option value="#5E60CE" >보랏빛 블루</option>
						<option value="#FF924C" >따뜻한 오렌지</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="newWriter">작성자:</label>
                    <input type="text" class="form-control" id="newWriter" placeholder="작성자를 입력하세요">
                </div>
                <div class="form-group">
                    <label for="newCalendarTy">구분 코드:</label>
                    <input type="number" class="form-control" id="newCalendarTy" placeholder="구분 코드를 입력하세요">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" id="saveCancelEventBtn" data-bs-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-primary" id="saveEventBtn">저장</button>
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
                <div class="form-group">
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
                    	<option value="#000000" >검정</option>
                        <option value="#FFFFFF" >하얀</option>
						<option value="#FF0000" >빨강</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="editBgColor">배경색:</label>
                   	<input type="color" class="form-control" id="editBgColor" disabled>
                   	<!-- this 선택이 바뀌면 나 자신을 함수의 파라미터로 던짐 -->
					<select class="form-select" id="selBgColor" onchange="fnEditBgColor(this)" disabled>
                        <option value="" disabled>선택해주세요</option>
                        <option value="#FF6B6B" >밝은 레드</option>
                        <option value="#4ECDC4" >밝은 민트</option>
                        <option value="#FFD93D" >밝은 옐로우</option>
						<option value="#1A535C" >짙은 청록</option>
						<option value="#5E60CE" >보랏빛 블루</option>
						<option value="#FF924C" >따뜻한 오렌지</option>                        
                    </select>
				</div>
                <div class="form-group">
                    <label for="editWriter">작성자:</label>
                    <input type="text" class="form-control" id="editWriter" placeholder="작성자를 입력하세요" disabled>
                </div>
                <div class="form-group">
                    <label for="editCalendarTy">구분 코드:</label>
                    <input type="number" class="form-control" id="editCalendarTy" placeholder="구분 코드를 입력하세요" disabled>
                </div>
                <!-- 모달수정 내용 영역 끝 -->
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" id="editCancelEventBtn" data-bs-dismiss="modal">닫기</button>
            	<button type="button" class="btn btn-primary" id="editEventBtn">수정</button>
                <button type="button" class="btn btn-primary" id="updateEventBtn" hidden="">수정완료</button>
                <button type="button" class="btn btn-primary" id="deleteEventBtn">삭제</button>
            </div>
        </div>
    </div>
</div>


<!-- 실제 화면을 담을 영역 시작 -->
<div id="main">
	<div id="page-heading">
			<div class="col-md-2 text-center">
				<p>테스트 상자</p>
			</div>
			<div class="col-md-8">
				<div class="card">
                		<div id="calendar" ></div>
             	</div>
			</div>
	</div>
</div>

<!-- 실제 화면을 담을 영역 끝 -->

<!-- fullcalendar 본문 시작 -->
<script>
//일정 수정, 저장 색깔 선택시 동적으로 선택한색 표시
//onchange fnTextColor(this)
//this : <select 요소 그 자체 -> obj 즉 obj는 <select 요소 그 자체
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

// 캘린더 시작 스크립트(풀캘린더 설정)
// DOMContentLoaded 이벤트 리스너 등록: HTML 문서가 완전히 로드된 후에 실행되는 함수
document.addEventListener('DOMContentLoaded', function () {
	// 캘린더 엘리먼트 가져오기
    var calendarEl = document.getElementById('calendar');
    // 캘린더 객체 생성 
    var calendar = new FullCalendar.Calendar(calendarEl, {
    	
//     	slotMinTime: '09:00', // Day 캘린더 시작 시간
//         slotMaxTime: '18:00', // Day 캘린더 종료 시간	
    	expandRows: true,		//각 행 높이를 동일한 높이로 강제변경
        contentHeight: 'auto',	// 달력의 보기 영역 높이를 설정
        height: 'auto', // 높이를 픽셀 단위로 지정
        width: '100%',  // 너비를 100%로 설정
        //aspectRatio: 1.5,    // 캘린더의 너비와 높이 비율 설정 (너비: 높이 비율)
        //expandRows: false, //  행 높이를 동일한 높이로 강제변경
    // headerToolbar 속성의 값()
	headerToolbar: {
       left: 'prevYear,prev,today,next,nextYear," ",AddButton',
       center: 'title',
       right: 'dayGridMonth,timeGridWeek,timeGridDay'
   	},
 	// 초기 뷰 기본설정: 월별 격자 뷰
    initialView: 'dayGridMonth',	// 초기 뷰
    selectable: true,	// 이벤트 선택 가능 여부
    editable: false,	// 드래그 이벤트 편집 가능
    durationEditable: true, // 이벤트의 길이 조정 불가
    handleWindowResize: false, //창 크기에 따라 자동으로 조절할지 여부
    displayEventTime: false,
    
    dayMaxEventRows: 3, // 해당날짜에 행 단위 이벤트 최대 몇개까지 표시
    eventTimeFormat: { // 이벤트 시간 형식 설정
        hour: '2-digit',
        minute: '2-digit',
        meridiem: false
    },
    timeZone: 'UTC', // 타임존 사용
    
    
    
    
    events: '/calendar/events',	// 이벤트 데이터 가져오기: 서버에서 JSON 데이터 가져오기
    // 이벤트 클릭 시 발생하는 이벤트 핸들러
    eventClick: function (info) {
		    const dEditTitle = document.getElementById('editTitle');         // 수정된 제목   
	        const dEditContent = document.getElementById('editContent');       // 수정된 내용   
	        const dEditStart = document.getElementById('editStart');         // 시작일      
	        const dEditEnd = document.getElementById('editEnd');           // 종료일      
	        const dEelTextColor = document.getElementById('selTextColor');      // 수정된 글자색  
	        const dEelBgColor = document.getElementById('selBgColor');        // 수정된 배경색  
	        const dEditWriter = document.getElementById('editWriter');        // 수정된 작성자  
	        const dEditCalendarTy = document.getElementById('editCalendarTy');    // 수정된 구분 코드
	        
	        const hUpdateEventBtn = document.getElementById('updateEventBtn');	//수정완료 버튼
	        const dEditEventBtn = document.getElementById('editEventBtn');	//수정 버튼
	        
	        dEditTitle.disabled = true;
	        dEditContent.disabled = true; 
	        dEditStart.disabled = true;
	        dEditEnd.disabled = true;
	        dEelTextColor.disabled = true;
	        dEelBgColor.disabled = true;
	        dEditWriter.disabled = true;
	        dEditCalendarTy.disabled = true;
	        
	        hUpdateEventBtn.hidden = true;
	        dEditEventBtn.hidden = false;
	        
	     	// 클릭한 이벤트의 세부 정보 가져오기
			var event = info.event;
			// 수정할 이벤트의 현재 값을 입력 필드에 채우기
		   	document.getElementById('editNm').value = event.extendedProps.Nm;
			document.getElementById('editTitle').value = event.title || null;
			document.getElementById('editContent').value = event.extendedProps.content || null;
			document.getElementById('editStart').value = event.start.toISOString().slice(0, 16);
			document.getElementById('editEnd').value = event.end.toISOString().slice(0, 16);
		    document.getElementById('editTextColor').value = event.textColor || null;
		    document.getElementById('editBgColor').value = event.backgroundColor || null;
		    document.getElementById('editWriter').value = event.extendedProps.writer || null;
		    document.getElementById('editCalendarTy').value = event.extendedProps.calendarTy || null;

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
			        dEditWriter.disabled = false;
			        dEditCalendarTy.disabled = false;
			        
			        hUpdateEventBtn.hidden = false;
			        dEditEventBtn.hidden = true;
			        
	        		// 수정된 데이터를 서버에 전송하기 위한 버튼 클릭 이벤트 처리
		           	document.getElementById('updateEventBtn').onclick = function() {
		            	// 수정된 데이터를 서버에 전송
		               var updatedTitle = document.getElementById('editTitle').value;
		               var updatedContent = document.getElementById('editContent').value;
		               var updatedTextColor = document.getElementById('editTextColor').value;
		               var updatedBgColor = document.getElementById('editBgColor').value;
		               var updatedWriter = document.getElementById('editWriter').value;
		               var updatedCalendarTy = document.getElementById('editCalendarTy').value;
		              
		               var updatedStart = document.getElementById('editStart').value;
		               var updatedEnd =  document.getElementById('editEnd').value;
		               
		               if(updatedEnd==null || updatedStart>=updatedEnd){
		               	alert("종료일이 시작일보다 전입니다. 다시 입력해주세요.");
		               }else{
			         	if (updatedTitle && updatedStart) {
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
				                    bgColor: updatedBgColor,		// 수정된 작성자
				                    writer: updatedWriter,			// 수정된 배경색
				                    calendarTy: updatedCalendarTy	// 수정된 구분 코드
			                    }),
			                })
		                	.then(response => response.json())
		               		.then(() => {
		                    calendar.refetchEvents();	// 이벤트 수정 후 캘린더 새로 고침
		                    alert('일정이 수정되었습니다.');
					        
		                    editModal.hide();// 모달 닫기
		                	})
		                		.catch(err => console.log(err));
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
                document.getElementById('newTextColor').value = '#000000'; // 기본 색상
                document.getElementById('newBgColor').value = '#FFFFFF'; // 기본 색상
                document.getElementById('newWriter').value = '';
                document.getElementById('newCalendarTy').value = null;
                // 입력 모달 생성 후 띄우기
         		var addModal = new bootstrap.Modal(document.getElementById('addModal'));
         		addModal.show();
                
             	// 입력된 데이터를 전송 취소하기 위한 버튼 클릭 이벤트 처리
                document.getElementById('saveCancelEventBtn').onclick = function() {
					document.getElementById('newTitle').value = '';
                    document.getElementById('newContent').value = '';
                    document.getElementById('newStart').value = null;
					document.getElementById('newEnd').value = null;
					document.getElementById('newTextColor').value = '#000000'; // 기본 색상
					document.getElementById('newBgColor').value = '#FFFFFF'; // 기본 색상
					document.getElementById('newWriter').value = '';
					document.getElementById('newCalendarTy').value = null;
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
	                var saveWriter = document.getElementById('newWriter').value;
	                var saveCalendarTy = document.getElementById('newCalendarTy').value;
	                
	                if(saveEnd == null || saveStart >= saveEnd) {
						alert("종료일이 시작일보다 전입니다. 다시 입력해주세요.+");
	                }else{
                    if(saveTitle && saveStart) {
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
                             bgColor: saveBgColor,		// 등록된 작성자
                             writer: saveWriter,			// 등록된 배경색
                             calendarTy: saveCalendarTy	// 등록된 구분 코드
                            }),
                        })
                        .then(response => response.json())
                        .then(() => {
                            alert('일정이 등록되었습니다.');
                            calendar.refetchEvents();	// 이벤트 등록 후 캘린더 새로 고침
                            addModal.hide();// 모달 닫기
                        })
                        .catch(err => console.log(err));
                 	}else{
						alert("제목 다시 입력해주세요.");
                 	} 
	               }
				};	//saveEventBtn 호출 버튼
				
               } //커스텀 버튼 클릭시
             } //커스텀 버튼 함수이름
         },//커스텀 버튼 생성 명렁어 끝부분
         
// 		// 날짜 클릭 시 발생하는 이벤트 핸들러 시작
// 		dateClick: function (info) {
		
// 		},	// 날짜 클릭 시 발생하는 이벤트 핸들러 끝

     });     
     calendar.render();  // 캘린더 렌더링
     
  	// 작은 캘린더 (왼쪽)
     var smallCalendarEl = document.getElementById('smallCalendarView');
     var smallCalendar = new FullCalendar.Calendar(smallCalendarEl, {
         initialView: 'dayGridMonth', // 작은 캘린더는 월별 뷰로만
         headerToolbar: {
             left: 'prev,next,today', // 날짜 조회만
             center: 'title',
             right: 'dayGridMonth'
         },
         events: '/calendar/events', // 같은 이벤트 데이터를 공유
         editable: false, // 수정 불가
         selectable: false, // 선택 불가
         eventClick: function(info) {
             alert("이벤트 세부사항을 보려면 큰 캘린더에서 클릭하세요.");
         }
     });
     smallCalendar.render();
     
 });
</script>
<!-- fullcalendar 본문 끝 -->
<!-- 본문 끝 -->

<%@ include file="../include/footer.jsp" %>
