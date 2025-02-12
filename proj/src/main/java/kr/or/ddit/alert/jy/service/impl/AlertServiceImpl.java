package kr.or.ddit.alert.jy.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

import kr.or.ddit.alert.jy.mapper.AlertMapper;
import kr.or.ddit.alert.jy.service.AlertService;
import kr.or.ddit.vo.AlertVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class AlertServiceImpl implements AlertService {

	@Autowired
    SimpMessagingTemplate messagingTemplate;
    
    @Autowired
    AlertMapper alertMapper;

    // 알림 insert + 수신자에게 알림 발송
    @Override
    public void alert(String userNo, String content, int alertType, String alertPk, String alertUrl) {
        AlertVO alertVO = new AlertVO();
        
        alertVO.setAlertCn(content);
        alertVO.setAlertChk(1); // 미확인 상태
        alertVO.setAlertCreate(new Date());
        alertVO.setAlertTy(alertType);
        alertVO.setUserNo(userNo);
        alertVO.setAlertPk(alertPk);
        alertVO.setAlertUrl(alertUrl);
        alertVO.setAlertFile(0); 

        log.info("alert -> alertVO : " + alertVO); 
        
        alertMapper.insertAlert(alertVO);

        // 실시간으로 알림 전송
        sendNotification(alertVO);
    }
    
    
	// 특정 사용자에 대한 알림 목록 조회
    @Override
    public List<AlertVO> userAlertList(String userNo, int currentPage, String keyword) {
        return alertMapper.userAlertList(userNo, currentPage, keyword);
    }


    // 실시간 알림 전송 메서드 (WebSocket 메시지 처리)
	@Override
	public void sendNotification(AlertVO alert) {
		
		// WebSocket을 통해 알림 전송
	    String destination = "/sub/userAlertList/" + alert.getUserNo();  // 모든 사용자에게 전송
	    
	    messagingTemplate.convertAndSend(destination, alert);
	}

	
	// 알람 목록 전체 행 개수
	@Override
	public int total(String userNo, String keyword) {
		return this.alertMapper.total(userNo, keyword);
	}

	
	// 특정 알림을 확인 상태로 변경
	@Override
	public boolean updAlertChk(int alertNo, String userNo) {
		try {
            AlertVO alert = alertMapper.getAlert(alertNo, userNo);
            if (alert != null && alert.getAlertChk() != 2) { 
                alertMapper.updAlertChk(alertNo, userNo);
                return true;
            }
        } catch (Exception e) {
            log.error("알림을 읽음 상태로 변경하는 중 오류 발생", e);
        }
        return false;
		
	}
	
	
	// 특정 알림 조회
	public AlertVO getAlett(int alertNo, String userNo) {
		return alertMapper.getAlert(alertNo, userNo);
	}


	// 안 읽음 알림 갯수
	@Override
	public int unreadCnt(String userNo) {
		return this.alertMapper.unreadCnt(userNo);
	}
    
    /* 특정 사용자에게 알림 발송
    골뱅이Override
    public void sendAlertToUser(String userNo, AlertVO alert) {
        String destination = "/sub/userAlertList/" + userNo;
        messagingTemplate.convertAndSend(destination, alert);
    }
    */
}