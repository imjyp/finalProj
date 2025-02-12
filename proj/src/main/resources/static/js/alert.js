

// 읽지 않은 알림 개수 뱃지에 나타내기
function updUnreadCnt() {
	$.ajax({
		url: '/unreadCnt',
		type: 'GET',
		dataType: 'json',
		success: function(count) {
			$('#alertBadge').text(count);
		},
		error: function(xhr, status, error) {
			console.error("읽지 않은 알림 개수 가져오기 실패:", error);
		}
	});
}

$(document).ready(function() {
	console.log("alert.js 체킁");

	updUnreadCnt();

	//setInterval(updUnreadCnt, 600000);


	alertList(1, "");

	// input hidden 값 가져오기
	var userNo = $('#userNo').val();
	var csrfToken = $('#csrfToken').val();

	console.log("userNo : ", userNo, ", csrfToken : ", csrfToken);

	if (userNo) {
		console.log("userNo : ", userNo);
		connect();  // 로그인 후 웹소켓 연결
	} else {
		console.error('userNo 오류');
		return;
	}

	// 연결 상태 처리 함수
	function setConnected(connected) {
		console.log("setConnected 체킁 : ", connected);
		if (connected) {
			$('#liveToast').removeClass('hide');  // 연결되면 토스트 알림 보이기
		} else {
			$('#liveToast').addClass('hide');  // 연결이 끊어지면 토스트 알림 숨기기
		}
	}


	// WebSocket 연결 
	function connect() {
		console.log("connect() 체킁");

		// WebSocket 설정
		const hostName = location.href.split("/")[2];
		console.log("로컬 : ", hostName);

		// Stomp.js 클라이언트 설정
		const stompClient = new StompJs.Client({
			brokerURL: `ws://${hostName}/gs-guide-websocket`,
			reconnectDelay: 100000, // 재접속 시도 간격 (ms)
			debug: function(str) {
				console.log("디버깅 : " + str);
			}
		});

		let mySessionId;

		stompClient.onConnect = (frame) => {
			console.log("웹소켓 연결 성공 :" + frame);

			setConnected(true);
			mySessionId = frame.headers['user-name'];
			console.log('연결된 user-name : ' + mySessionId);

			// 알림 구독
			stompClient.subscribe(`/sub/userAlertList/${userNo}`, (notification) => {
				console.log("받은 알림 :" + notification.body);
				try {
					let data = JSON.parse(notification.body);
					console.log("알림 데이터:" + data);

					// 알림 처리 함수 호출
					incAlertCnt();
					// addAlert(data);

					// 알림을 토스트로 표시
					showToast(data);

				} catch (error) {
					console.error("알림 메시지 처리 중 오류:", error);
				}
			});
		};

		// WebSocket 에러 처리
		stompClient.onWebSocketError = (error) => {
			console.error('WebSocket 에러:', error);
		};

		// STOMP 에러 처리
		stompClient.onStompError = (frame) => {
			console.error('Broker 에러: ' + frame.headers['message']);
			console.error('추가 오류 세부사항: ' + frame.body);
		};

		// WebSocket 활성화
		stompClient.activate();  // 웹소켓 연결 시작
	}

	// 메시지 전송 
	function sendNotification(alertVO) {
		stompClient.send("/app/sendNotification", {}, JSON.stringify(alertVO));  // 클라이언트가 이 경로로 알림을 전송
	}


	/* 알림을 드롭다운 메뉴에 추가하고 카운트를 증가
	function addAlert(alertVO) {
		console.log('드롭다운에 추가된 새로운 알림 : ', alertVO);
		// 드롭다운 메뉴에 새로운 알림 추가
		var $dropdownTop = $('#alert-dropdown-top');

		if ($dropdownTop.length) {
			var alertItem = $('<a>')
				.addClass('dropdown-item')
				.attr('href', '/alert') // 알림 목록 페이지로 이동
				.attr('onclick', 'updAlertChk(' + alertVO.alertNo + ')')
				.html(alertVO.alertCn + '<br><small>' + formatDate(alertVO.alertCreate) + '</small>');

			// 최신 알림을 상단에 추가
			$dropdownTop.prepend(alertItem);
		}

		// 토스트 메시지 표시
		showToast(alertVO.alertCn, alertVO.alertCreate);

		// 알림 카운트 증가
		incAlertCnt();
	}
	*/

	// 알림 카운트 증가
	function incAlertCnt() {
		var $alertBadge = $('#alertBadge');
		if ($alertBadge.length) {
			var count = parseInt($alertBadge.text()) || 0;
			count += 1;
			$alertBadge.text(count);
		}
	}

	// 알림 카운트를 감소시키는 함수
	function decAlertCnt() {
		var $alertBadge = $('#alertBadge');
		if ($alertBadge.length) {
			var count = parseInt($alertBadge.text()) || 0;
			if (count > 0) {
				count -= 1;
				$alertBadge.text(count);
			}
		}
	}

	/* 알림 버튼 클릭 시 카운트 초기화
	$('#dropdownMenuButton5').on('click', function() {
		$('#alert-count-top').text('0');
	});
	*/

	// 알림을 클릭했을 때 알림 상태를 업데이트하는 함수
	window.updAlertChk = function(alertNo, alertUrl) {
		$.ajax({
			url: '/updAlertChk',
			type: 'POST',
			data: { alertNo: alertNo },
			headers: {
				'X-CSRF-TOKEN': csrfToken
			},
			success: function(response) {
				if (response === 'success') {
					decAlertCnt();
					console.error('알림 읽음으로 변경 성공');
				} else {
					console.error('알림 읽음으로 변경 실패');
				}
				window.location.href = alertUrl;
			},
			error: function(xhr, status, error) {
				console.error('알림 읽음으로 변경 중 오류 발생', error);
				window.location.href = alertUrl;
			}
		});
	};

	// 알림 리스트 조회
	function alertList(currentPage = 1, keyword = "") {
		console.log("alertList -> currentPage: ", currentPage, "keyword: ", keyword);

		$.ajax({
			url: "/userAlertList",
			type: "GET",
			dataType: "json",
			data: {
				currentPage: currentPage,
				keyword: keyword
			},
			headers: {
				'X-CSRF-TOKEN': $('#csrfToken').val() // CSRF 토큰 설정 (필요 시)
			},
			success: function(articlePage) {
				console.log("articlePage : ", articlePage);
				console.log("articlePage.content : ", articlePage.content);

				let str = "";

				$.each(articlePage.content, function(idx, alertVO) {

					// 알림 유형 변환
					var alertType = "";
					switch (alertVO.alertTy) {
						case 2:
							alertType = "댓글";
							break;
						case 3:
							alertType = "안전재고";
							break;
						case 4:
							alertType = "계산서요청";
							break;
						case 5:
							alertType = "계산서발행";
							break;
						default:
							alertType = "결재";
					}

					// 상태 변환
					var statusBadge = alertVO.alertChk == 1
						? '<span class="badge bg-warning">미확인</span>'
						: '<span class="badge bg-success">확인</span>';

					// 알림 생성일 포맷 (JSP에서 처리되므로 여기서는 단순 출력)
					var alertCreate = formatDate(alertVO.alertCreate);

					str += `<tr>
	                    <td class="text-center">${alertVO.rnum}</td>
	                    <td class="text-center">${alertType}</td>
	                    <td class="text-start">
							<a href="#" onclick="updAlertChk(${alertVO.alertNo}, '${alertVO.alertUrl}'); return false;">
					            ${alertVO.alertCn}
					        </a>
						</td>
	                    <td class="text-center">${alertCreate}</td>
	                    <td class="text-center">${statusBadge}</td>
	                </tr>`;
				});
				$("#alertsTby").html(str);
				$(".divPagingArea").html(articlePage.pagingArea);
			},
			error: function(xhr, status, error) {
				console.error('Error fetching alerts:', error);
			}
		});
	}


	function showToast(notification) {
		console.log("showToast 체킁");

		// 알림 유형
		if (notification.alertTy) {
			var alertType;
			switch (notification.alertTy) {
				case 1:
					alertType = "결재";
					break;
				case 2:
					alertType = "댓글";
					break;
				case 3:
					alertType = "안전재고";
					break;
				case 4:
					alertType = "계산서요청";
					break;
				case 5:
					alertType = "계산서발행";
					break;
				default:
					alertType = "알림";
			}
			$('#toast-alert-ty').text(alertType);
		} else {
			$('#toast-alert-ty').text("알림");
		}

		// 알림 내용
		$('#toast-alert-cn').text(notification.alertCn);

		// 알림 생성 시간 
		const timestamp = new Date(notification.alertCreate).toLocaleTimeString();
		$('#toast-create').text(timestamp);

		// 토스트 요소 선택 및 표시
		var toastElement = $('#liveToast')[0];
		console.log("토스트 요소 :", toastElement);

		if (toastElement) {
			var toast = new bootstrap.Toast(toastElement);
			toast.show();
		} else {
			console.error("토스트 요소를 찾을 수 없음");
		}
	}


	// 날짜 포맷 함수 (예시)
	function formatDate(datetimeStr) {
		var date = new Date(datetimeStr);
		var year = date.getFullYear();
		var month = ("0" + (date.getMonth() + 1)).slice(-2);
		var day = ("0" + date.getDate()).slice(-2);
		var hours = ("0" + date.getHours()).slice(-2);
		var minutes = ("0" + date.getMinutes()).slice(-2);
		return `${year}-${month}-${day} ${hours}:${minutes}`;
	}

	// 페이지네이션
	$(document).on("click", ".clsPagingArea", function() {
		//클릭한 것은 하나
		// <a .. data-current-page="2" data-keyword="".. class="page-link clsPagingArea">2</a>
		let currentPage = $(this).data("currentPage");	// 2
		let keyword = "";

		console.log("페이지 클릭 처리 -> currentPage : ", currentPage);

		// 회원 목록 호출
		alertList(currentPage, keyword);
	});

});
