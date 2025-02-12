<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<script src="https://cdn.jsdelivr.net/npm/@stomp/stompjs@7.0.0/bundles/stomp.umd.min.js"></script>
<%@ include file="../include/header.jsp"%>
<link rel="stylesheet" href="/css/common2.css">
<div id="main">
<%@ include file="../include/top.jsp" %>

<div class="card">
		<div class="card-header">
			<div class="container-fluid">

				<header class="mb-3">
					<a href="#" class="burger-btn d-block d-xl-none"> <i
						class="bi bi-justify fs-3"></i>
					</a>
				</header>
				<div class="page-heading row"
					style="margin-top: 130px; margin-bottom: 0px">

					<div class="col-6 d-flex align-items-center">
						<nav aria-label="breadcrumb" class="ms-3">
							<ol class="breadcrumb mb-0">
								<li class="breadcrumb-item"><a href="/main">Home</a></li>
								<li class="breadcrumb-item active"><a href="/chattingRoom">채팅</a></li>
							</ol>
						</nav>
					</div>
					<div class="col-6 d-flex justify-content-end"></div>
				</div>
			</div>
		</div>
	</div>
	
    
    <div class="page-content">
    <section class="section">
        <div class="row" id="table-hover-row">
            <div class="col-5 box" style="border:1.5px solid lightgrey; margin-left:30px ;border-radius:30px; ">
                <div class="card">
                    <div class="card-header">
                        <h4 class="card-title col-5" >회원 목록</h4>
                        <div style="display:flex" class="col-4">
                        	<input class="form-control" type="text" placeholder="Default Input" value="내 계정: ${userNo}">
                        </div>
                    </div>
                     <input type="text" id="keyword" class="form-control" placeholder="검색" value="" style="margin-left:30px"> 
                    <div class="card-content">
                        <div class="table-responsive">
                            <table class="table table-hover mb-0">
                                <thead>
                                    <tr>
                                        <th>프로필</th>
                                        <th>이름</th>
                                        <th>부서</th>
                                        <th>직책</th>
                                    </tr>
                                </thead>
                                <tbody id="tbd">
                                   
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        <div class="col-6 box" style="display:none; margin-left:70px;" id="chatting">
            <div id="chat-messages" class="chat-container"style="">
            </div><br>
             <div >
                <form class="form-inline" enctype="multipart/form-data">
                    <div class="form-group" style="display:flex; ">
                        <input type="text" id="content" class="form-control" placeholder="입력" style="width:80%; " >
                        
                        <div class="p-3 py-4 mb-2 text-body text-center rounded" onclick="document.getElementById('uploadFiles').click()" style="cursor: pointer;">
                            <svg class="bi" width="1em" height="1em" fill="currentColor">
                                <use xlink:href="/dist/assets/static/images/bootstrap-icons.svg#upload"></use>
                            </svg>
                        </div>
                        <input type="file" id="uploadFiles" name="uploadFiles" multiple class="form-control" style="display: none;">
                    
                        <div id="fileNames" style="font-size: 0.9em; color: gray; margin-top: 5px;"></div>
                        <button id="send" class="btn btn-warning" type="button" >전송</button>
                    </div>
                </form>
    
            </div>
        </div>
        </div>
    </section>
    </div>
    
</div>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>

<style>
#send{
	margin-top:15px;
	width:100px;
	height:50px;
}

#content{
	margin-top:15px;
	width:100px;
	height:50px;
}
.section {
    height: 400px; 
}

.table-responsive {
    overflow-y: auto;
    max-height: 500px;
     padding:30px;
}

.card-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.search-container {
    display: flex;
    justify-content: flex-end;
    width: 100%;
}
.chat-container {
    height: 400px;
    overflow-y: auto;
    border: 1px solid #ddd;
    border-radius:30px;
    padding: 10px;
    border:1.5px solid;
}

.message {
    max-width: 70%;
    margin-bottom: 10px;
    padding: 8px;
    border-radius: 8px;
    clear: both;
    color:black;
    word-wrap: break-word;
}

.sent {
    float: right;
    background-color: #ffd65b;
    margin-left: auto;
    margin-right: 10px;
}

.received {
    float: left;
    background-color: #e5e5e5;
    margin-right: auto;
    margin-left: 10px;
}

.timestamp {
    display: block;
    font-size: 0.8em;
    color: gray;
    margin-top: 5px;
}
</style>

<script>
// 포맷팅 함수 추가
function formatTimestamp(timestamp) {
    let date = new Date(timestamp);
    let options = {
        year: 'numeric',
        month: '2-digit',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit'
    };
    return new Intl.DateTimeFormat('ko-KR', options).format(date);
}

let hostName = location.href.split("/")[2];
console.log("로컬:",hostName);
let mySessionId;

const stompClient = new StompJs.Client({
    brokerURL: "ws://"+hostName+"/gs-guide-websocket",
    
});

stompClient.onConnect = (frame) => {
    setConnected(true);
    mySessionId = frame.headers['user-name']; 
    console.log('Connected: ' + mySessionId);
    stompClient.subscribe('/sub/chat/room', (message) => {
         console.log("Received message:", message.body);
         try {
             let receivedData = JSON.parse(message.body);
             let isMine = receivedData.senderNo === mySessionId;
             console.log("receivedData.senderNo:",receivedData.senderNo);
             console.log("mySessionId:",mySessionId);
             
             showMessage(receivedData, isMine);
             
         } catch (error) {
             console.error("Error parsing received message:", error);
         }
    });
};

stompClient.onWebSocketError = (error) => {
    console.error('Error with websocket', error);
};

stompClient.onStompError = (frame) => {
    console.error('Broker reported error: ' + frame.headers['message']);
    console.error('Additional details: ' + frame.body);
};

function setConnected(connected) {
    $("#connect").prop("disabled", connected);
    if (connected) {
        $("#conversation").show();
    }
    else {
        $("#conversation").hide();
    }
    $("#greetings").html("");
}

function connect() {
    stompClient.activate();
}

let messageObj = {};

$("#uploadFiles").on("change", function () {
    const files = this.files; // 선택된 파일들
    const fileNames = Array.from(files).map(file => file.name).join(", "); // 파일명 나열
    $("#fileNames").text(fileNames); // 파일명을 표시
});


function sendMsg() {
    let formData = new FormData();
    formData.append("chatRoomNo", chatRoomNo);
    formData.append("senderNo", mySessionId);
    formData.append("receiverNo", messageObj.receiverNo);

    // 채팅 내용 가져오기
    let chatContent = $("#content").val().trim();
    let files = $("#uploadFiles")[0].files;

    // 파일도 없고 내용도 없으면 전송하지 않음
    if (!chatContent && files.length === 0) {
        //alert("내용이나 파일을 입력하세요.");
        return;
    }

    // 내용 추가 (내용이 없으면 빈 문자열로 설정)
    formData.append("chatSendContent", chatContent || "");

    // 파일 추가
    if (files.length > 0) {
        for (let i = 0; i < files.length; i++) {
            formData.append("uploadFiles", files[i]);
        }
    }

    // 폼데이터 값 확인
    for (let key of formData.keys()) {
        console.log("formData -> " + key + ":" + formData.get(key));
    }

    $.ajax({
        url: '/createPost',
        type: 'POST',
        data: formData,
        processData: false,
        contentType: false,
        success: function (result) {
            console.log("폼데이터 응답:", result);

            // 메시지 객체 생성
            messageObj = {
                mySessionId: mySessionId,
                chatRoomNo: result.chatRoomNo,
                senderNo: result.senderNo,
                chatSendContent: result.chatSendContent || "", // 내용이 없으면 빈 문자열
                fileGroupNo: result.fileGroupNo,
                receiverNo: result.receiverNo,
                fileSaveLocate: result.fileSaveLocate,
                fileOriginalName: result.fileOriginalName,
                chatSendDate: result.chatSendDate
            };
            console.log("messageObj :", messageObj);

            stompClient.publish({
                destination: "/app/chat/enter",
                body: JSON.stringify(messageObj),
            });

            // 입력값 초기화
            $("#content").val("");
            $("#uploadFiles").val("");
            $("#fileNames").text(""); // 파일명 초기화
        },
        error: function (xhr, status, error) {
            console.error("전송 실패:", error);
        }
    });
}



function showMessage(message, isMine) {
    let messageElement = $('<div>').addClass('message');
    if (isMine) {
        messageElement.addClass('sent');
    } else {
        messageElement.addClass('received');
    }

    if (!isMine) {
        // 수신자일 경우에만 userNm과 프로필 사진 표시
       /*  let profileImage = $('<img>')
            .addClass('avatar avatar-sm')
            .attr('src', message.fileSaveLocate || '/default-profile.png') // 기본 프로필 설정
            .attr('alt', '프로필 사진');
        messageElement.append(profileImage);
 */
        // 수신자의 userNm 추가
        if (message.userNm) {
            let userNameElement = $('<span>').addClass('user-nm').text(message.userNm);
            messageElement.append(userNameElement);
        }
    }

    // 파일 링크 추가
    if (message.fileGroupNo) {
        let fileLink = $('<a>')
            .attr('href', '/downloadFile?fileName=' + message.fileSaveLocate)
            .text(message.fileOriginalName || '파일 다운로드');
        messageElement.append(fileLink);
    }

    // 메시지 내용 추가 (내용이 있을 경우에만 추가)
    if (message.chatSendContent && message.chatSendContent.trim() && message.chatSendContent!=null) {
        let contentElement = $('<p>').text(message.chatSendContent);
        messageElement.append(contentElement);
    }
   

    // 타임스탬프 추가
    let formattedDate = formatTimestamp(message.chatSendDate);
    let timestampElement = $('<span>').addClass('timestamp').text(formattedDate);
    messageElement.append(timestampElement);

    $("#chat-messages").append(messageElement);
    $("#chat-messages").scrollTop($("#chat-messages")[0].scrollHeight);
}



function showGreeting(message) {
    $("#greetings").append("<tr><td>" + message + "</td></tr>");
}

$(function () {
    $("form").on('submit', (e) => e.preventDefault());
    $( "#connect" ).click(() => connect());
    $( "#disconnect" ).click(() => disconnect());
    $( "#send" ).click(() => sendMsg());
});

let data = {};

list();
function list() {
    $.ajax({
        url: "/peopleSearch",
        contentType: "application/json;charset=utf-8",
        data: JSON.stringify(data),
        type: "post",
        dataType: "json",
        success: function(result) {
            console.log("result", result);
            let str = "";
            $.each(result, function(idx, map) {
                str += `
                    <tr class="table-row connect" data-chat-room-no="\${idx + 1}" style="cursor:pointer">
                        <td><img class="avatar avatar-sm" src="/resources\${map.fileSaveLocate}" alt="" srcset=""></td>
                        <td class="hidden-userNo" hidden>\${map.userNo}</td>
                        <td class="text-bold-500">\${map.userNm}</td>
                        <td>\${map.deptNo}</td>
                        <td class="text-bold-500">\${map.positionNm}</td>
                    </tr>`;
            });
            $("#tbd").html(str);
        }
    });
}

let chatRoomNo = "";

$("#tbd").on("click", ".table-row", function() {
    let userNo = $(this).children(".hidden-userNo").text(); // 클릭한 직원
    let sessionId = "${userNo}"; // 로그인 한 직원 (주의: 서버 사이드에서 올바르게 설정되었는지 확인)
    let newChatRoomNo  = $(this).data("chat-room-no");
    console.log("userNo : " + userNo);
    console.log("sessionId : " + sessionId);
    console.log("newChatRoomNo : " + newChatRoomNo);
    
    if (chatRoomNo !== newChatRoomNo) {
        $("#chat-messages").html(""); 
        chatRoomNo = newChatRoomNo;
        
        messageObj = {
            receiverNo: userNo,
            chatRoomNo: newChatRoomNo
        };
        
        $("#chatting").css('display', "block");
        
        console.log("Chat room changed to:", newChatRoomNo);
    } 
    
    //***1:1 채팅목록 불러오기
    // 클릭된 직원 : userNo, 로그인 직원 : sessionId 

    $.ajax({
        url:"/chatSendList",
        data:{"userNo":userNo,"sessionId":sessionId},
        type:"post",
        dataType:"json",
        success:function(result){
            console.log("result : ", result);
            
            let str = "";
            let temp = "";
            
            $.each(result, function(idx, chatVO){
            	
                if(sessionId === chatVO.senderNo){
                    temp = "sent";
                } else {
                    temp = "received";
                }
                
                let messageContent = "<p>" + chatVO.chatSendContent + "</p>";
                let timestamp = "<span class='timestamp'>" + formatTimestamp(chatVO.chatSendDate) + "</span>";
                
                let fileLink = "";
                if(chatVO.fileGroupNo){
                    fileLink = "<a href='/downloadFile?fileName=" + chatVO.fileSaveLocate + "'>" + chatVO.fileOriginalName + "</a>";
                }
                
                let userNameElement = "";
                let profileImage = "";
                if(temp === "received"){
                    // 수신자일 경우에만 userNm과 프로필 사진 표시
                    if(chatVO.userNm){
                        userNameElement = "<span class='user-nm'>" + chatVO.userNm + "</span>";
                    }
                }
                
                let cont = "";
                if(chatVO.chatSendContent){
                	cont="<p>"+chatVO.chatSendContent+"</p>"
                }
                
                str += "<div class='message " + temp + "'>" + userNameElement;
                if(temp=="received"){
                	str+="<br>"+cont + fileLink + timestamp + "</div>";
                }
                else{
                	str+=cont + fileLink + timestamp + "</div>";
                }
            });
            
            $("#chat-messages").html(str);
            $("#chat-messages").scrollTop($("#chat-messages")[0].scrollHeight);
            
            connect();
        }
    });

});

/* $("#search").on('click', function() {
    data.keyword = $("#keyword").val();
    console.log("Data", data);
    list();
});
 */

$("#content").on('keypress', function(e) {
    if (e.which === 13) { 
        console.log("대화내용", $("#content").val());
        sendMsg();
    }
});

$("#keyword").on('keypress', function(e) {
    if (e.which === 13) { 
        data.keyword = $("#keyword").val();
        console.log("Data", data);
        list();
    }
});
</script>
<style>
.avatar{
    width:40px;
    height:40px;
}

.timestamp {
    display: block;
    font-size: 0.8em;
    color: gray;
    margin-top: 5px;
}
/* .box {
    border-left: 1px solid #dee2e6;
    padding-left: 20px;
    min-height: 400px;  
} */
</style>
