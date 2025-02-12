package kr.or.ddit.alert.jy.service;

import java.util.List;

import kr.or.ddit.vo.AlertVO;

public interface AlertService {
	
	// 사용자에게 알림 전송
    public void alert(String recipient, String content, int alertType, String alertPk, String alertUrl);

    // 특정 사용자의 알림 목록 조회
    public List<AlertVO> userAlertList(String userNo, int currentPage, String keyword);

    // 실시간 알림 전송 메서드 (WebSocket 메시지 처리)
    public void sendNotification(AlertVO alertVO);

    // 알람 목록 전체 행 개수
	public int total(String userNo, String keyword);

	// 특정 알림을 확인 상태로 변경
	public boolean updAlertChk(int alertNo, String userNo);
	
	// 안 읽음 알림 갯수
	public int unreadCnt(String userNo);

}