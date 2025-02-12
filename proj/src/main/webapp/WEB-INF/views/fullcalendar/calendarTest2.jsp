<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>
<script src='fullcalendar/dist/index.global.js'></script>
<!DOCTYPE html>

<sec:authorize access="isAuthenticated()">
    <%@ include file="../include/header.jsp" %>
    <header class="mb-3">
        <a href="#" class="burger-btn d-block d-xl-none">
            <i class="bi bi-justify fs-3"></i>
        </a>
</header>
</sec:authorize>

<div id="main">
<%@ include file="../include/top.jsp" %>
	<div id="page-heading">
			<div class="col-md-2 text-center">
				<p>이벤트 일정</p>
			</div>
			<div class="col-md-8">
				<div class="card">
                		<div id="calendar" ></div>
             	</div>
			</div>
	</div>
</div>
<div class="modal fade" id="addModal" tabindex="-1" aria-labelledby="addModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addModalLabel">일정 입력</h5>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="newTitle">제목:</label>
                    <input type="text" class="form-control" id="newTitle" placeholder="제목을 입력하세요" value="">
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
                <!-- <div class="form-group">
                    <label for="newTextColor">글자색:</label>
                    <input type="color" class="form-control" id="newTextColor" disabled>
                    this 선택이 바뀌면 나 자신을 함수의 파라미터로 던짐
					<select class="form-select" onchange="fnNewTextColor(this)">
                        <option value="" disabled selected>선택해주세요</option>
                        <option value="#000000" >검정</option>
                        <option value="#FFFFFF" >하얀</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="newBgColor">배경색:</label>
                    <input type="color" class="form-control" id="newBgColor" disabled>
					<select class="form-select" onchange="fnNewBgColor(this)">
						<option value="" readonly>선택해주세요</option>
                        <option value="#FF6B6B" >밝은 레드</option>
                        <option value="#4ECDC4" >밝은 민트</option>
                        <option value="#FFD93D" >밝은 옐로우</option>
						<option value="#1A535C" >짙은 청록</option>
						<option value="#5E60CE" >보랏빛 블루</option>
						<option value="#FF924C" >따뜻한 오렌지</option>
                    </select>
                </div> -->
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" id="saveCancelEventBtn" data-bs-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-primary" id="saveEventBtn">저장</button>
            </div>
        </div>
    </div>
</div>

<script>


let data={
  	calTitle:"",
  	calContent:"",
  	calStart:"",
  	calEnd:"",
};   

var calendarEl = document.getElementById('calendar');
var calendar = new FullCalendar.Calendar(calendarEl, {
  initialView: 'dayGridMonth',
  selectable: true,
  editable:true,
  displayEventTime: false, 
  events: "/calendar/events",
  select: function (info) {
	  console.log("셀렉트:",info);
	  
	  let myModal = new bootstrap.Modal(document.getElementById('addModal'), {
	    backdrop: true 
		});
		myModal.show();
		
		let startDate = new Date(info.startStr).toISOString().slice(0, 16); 
	    let endDate = new Date(info.endStr).toISOString().slice(0, 16); 
	    console.log("시작 날짜:", startDate, "종료 날짜:", endDate);
	    
	    $("#newStart").val(startDate); 
	    $("#newEnd").val(endDate);     
	    
      let title= $("#eventTitle").val();
     let content = $("#eventNY").val();
     
     data.calContent=content;
     data.calTitle=title;
     data.calStart=info.startStr;
     data.calEnd=info.endStr;
     
     console.log("데이타",data);
      if (title) {
          calendar.addEvent({
              title: title,
              start: info.startStr,
              end: info.endStr,
              allDay: info.allDay,
              extendedProps: {
                  description: content 
              }
          });
      }
      calendar.unselect(); 
  },
  eventDrop: function(info) {
    handleEventDrop(info);
  },
  eventClick: function(arg) {
	    console.log("이벤트:", arg);
	    console.log("이벤트 제목:", arg.event.title);
	    console.log("이벤트 제목:", arg.event.title);
	    console.log("이벤트 시작:", arg.event.start);
	    console.log("이벤트 종료:", arg.event.end);

	    let myModal = new bootstrap.Modal(document.getElementById('addModal'), {
	        backdrop: true 
	    });
	    myModal.show();
		
	    $("#newTitle").val(arg.event.title); // 제목 설정

	    if (arg.event.start) {
	        let startDate = new Date(arg.event.start).toISOString().slice(0, 16); 
	        $("#newStart").val(startDate); 
	    }
	    if (arg.event.end) {
	        let endDate = new Date(arg.event.end).toISOString().slice(0, 16); 
	        $("#newEnd").val(endDate); 
	    }
	    
	    if (arg.event.extendedProps && arg.event.extendedProps.description) {
	        $("#newContent").val(arg.event.extendedProps.description); // 내용 설정
	    }
	    
  },
 
});
calendar.render();

function handleEventDrop(info) {
	console.log("드롭!",info.event.start);
	if (info.event.start) {
        let startDate = new Date(info.event.start).toISOString().slice(0, 10); 
        data.calStart=startDate;
        console.log("드롭!",startDate);
    }
    if (info.event.end) {
        let endDate = new Date(info.event.end).toISOString().slice(0, 10); 
        data.calEnd=endDate;
        console.log("드롭!",endDate);
    }
	
  var event = info.event;
  var newStart = event.start;
  var newEnd = event.end || newStart;
  
  // 새로운 시작 및 종료 시간으로 이벤트 업데이트
  event.setDates(newStart, newEnd);
  
  // 서버에 변경사항 저장 (AJAX 요청 등)
  updateEventOnServer(event);
}

function updateEventOnServer(event) {
	  // AJAX 요청을 사용하여 서버에 업데이트된 이벤트 정보 전송
	  $.ajax({
	    url: '/calendar/updateEvent',
	    method: 'POST',
	    data: JSON.stringify(data),
	    success: function(response) {
	      console.log('이벤트가 성공적으로 업데이트되었습니다.');
	    },
	    error: function(xhr, status, error) {
	      console.error('이벤트 업데이트 중 오류 발생:', error);
	    }
	  });
	}
	
$("#saveEventBtn").on('click',function(){
    
	$.ajax({
		url:"/calendar/insertEvent",
		type:"post",
		contentType: "application/json", 
        dataType: "json",  
        data: JSON.stringify(data), 
        success: function (resp) {
        	if(resp>0){
        		alert("성공");
        		let myModal = new bootstrap.Modal(document.getElementById('addModal'));
        		myModal.hide();
        	}
        }
		
	})
})

</script>

<%@ include file="../include/footer.jsp" %>
