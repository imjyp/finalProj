  <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en"> 
   
    <title>Hello WebSocket</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <link href="/main.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@stomp/stompjs@7.0.0/bundles/stomp.umd.min.js"></script>
    <script src="/app.js"></script>
</head>
<body>
<noscript><h2 style="color: #ff0000">Seems your browser doesn't support Javascript! Websocket relies on Javascript being
    enabled. Please enable
    Javascript and reload this page!</h2></noscript>
<div id="main-content" class="container">
    <div class="row">
        <div class="col-md-6">
            <form class="form-inline">
                <div class="form-group">
                    <label for="connect">WebSocket connection:</label>
                    <button id="connect" class="btn btn-default" type="button">Connect</button>
                    <button id="disconnect" class="btn btn-default" type="button" disabled="disabled">Disconnect
                    </button>
                </div>
            </form>
        </div>
    </div>
    <div class="row">
    <div class="col-md-12">
        <div id="chat-messages" class="chat-container">
        </div><br>
         <div >
            <form class="form-inline" enctype="multipart/form-data">
			    <div class="form-group">
			        <input type="hidden" id="chatRoomNo" value="1">
			        <input type="text" id="content" class="form-control" placeholder="입력">
			        <input type="file" id="uploadFiles" name="uploadFiles" multiple class="form-control">
			    </div>
			    <button id="send" class="btn btn-default" type="button">Send</button>
			</form>

        </div>
    </div>
</div>

</div>
</body>

</html>


<script type="text/javascript">
let hostName = location.href.split("/")[2];
console.log("로컬:",hostName);
let mySessionId;

const stompClient = new StompJs.Client({
    brokerURL: "ws://"+hostName+"/gs-guide-websocket",
    
});

/*
1. Connect 버튼을 누르면 WebSocket 연결이 시작됨
2. 연결이 성공하면 onConnect 콜백이 실행됨
3. onConnect 내부에서 '/sub/chat/room' 채널을 구독
4. 구독 후에는 해당 채널로 전송되는 모든 메시지를 수신할 수 있음 
 
 */
stompClient.onConnect = (frame) => {
    setConnected(true);
    mySessionId = frame.headers['user-name']; 
    console.log('Connected: ' + mySessionId);
    stompClient.subscribe('/sub/chat/room', (message) => {
    	 console.log("Received message:", message.body);
         try {
             let receivedData = JSON.parse(message.body);
             let isMine = receivedData.senderNo === mySessionId;
             
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
    $("#disconnect").prop("disabled", !connected);
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

function disconnect() {
    stompClient.deactivate();
    setConnected(false);
    console.log("Disconnected");
}


/* function showMessage(message, isMine) {
    
    let messageElement = $('<div>').addClass('message');
    if (isMine) {
        messageElement.addClass('sent').text(message.chatSendContent);
    } else {
        messageElement.addClass('received').text(message.chatSendContent);
    }
    console.log("messageElement : ", messageElement);
    $("#chat-messages").append(messageElement);//*******
    
    $("#chat-messages").scrollTop($("#chat-messages")[0].scrollHeight);
} */

function sendMsg() {
    let formData = new FormData();
    formData.append("chatRoomNo", $("#chatRoomNo").val());
    formData.append("senderNo", mySessionId);
    formData.append("chatSendContent", $("#content").val());
    
    let files = $("#uploadFiles")[0].files;
    if (files.length > 0) {
        for (let i = 0; i < files.length; i++) {
            formData.append("uploadFiles", files[i]);
        }
    }
    console.log("폼데이터:",formData);

    $.ajax({
        url: '/createPost',
        type: 'POST',
        data: formData,
        processData: false,
        contentType: false,
        success: function(result) {
            console.log("폼데이터 응답:",result);
        	
            let messageObj = {
           		mySessionId:mySessionId,
           		chatRoomNo: result.chatRoomNo,
                senderNo: result.senderNo,
                chatSendContent: result.chatSendContent,
                fileGroupNo: result.fileGroupNo,
                fileSaveLocate: result.fileSaveLocate,
                fileOriginalName: result.fileOriginalName
            };
            console.log("messageObj :",messageObj);
            
            stompClient.publish({
                destination: "/pub/chat/enter",
                body: JSON.stringify(messageObj),
            
            });
            
            $("#content").val('');
            $("#uploadFiles").val('');
        },
        error: function(xhr, status, error) {
            console.error('전송 실패:', error);
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

    let contentElement = $('<p>').text(message.chatSendContent);
    messageElement.append(contentElement);

    console.log("파일: ",message);
    console.log("파일 fileGroupNo: ",message.fileGroupNo);
    console.log("파일 fileSaveLocate: ",message.fileSaveLocate);
    console.log("파일 fileOriginalName: ",message.fileOriginalName);
    
    if (message.fileGroupNo) {
        let fileLink = $('<a>')
            .attr('href', '/downloadFile?fileName=' + message.fileSaveLocate)
            .text(message.fileOriginalName);
        messageElement.append(fileLink);
    }

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
</script>

<style>
    .chat-container {
        height: 400px;
        overflow-y: auto;
        border: 1px solid #ddd;
        padding: 10px;
    }
    .message {
        max-width: 70%;
        margin-bottom: 10px;
        padding: 8px;
        border-radius: 8px;
        clear: both;
    }
    .sent {
        float: right;
        background-color: #dcf8c6;
    }
    .received {
        float: left;
        background-color: #ebebeb;
    }
</style>
