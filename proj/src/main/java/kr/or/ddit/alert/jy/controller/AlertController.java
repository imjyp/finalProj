package kr.or.ddit.alert.jy.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletRequest;
import kr.or.ddit.alert.jy.service.AlertService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.AlertVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class AlertController {

    private final SimpMessagingTemplate messagingTemplate;
    private final AlertService alertService;

    // 알림 웹소켓 테스트
    @GetMapping("/alertTest")
    public String alert(Model model) {
    	
    	 Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    	 String userNo = auth.getName();
	    
	    model.addAttribute("userNo", userNo);
        return "alert/alertPage";
    }
    
    // 알림 페이지로 이동
    @GetMapping("/alert")
    public String alertPage(@AuthenticationPrincipal UserDetails userDetails, Model model) {
        
    	log.info("alertPage 체킁");
    	
    	String userNo = userDetails.getUsername();
        List<AlertVO> alertList = alertService.userAlertList(userNo, 1, "");
        
        log.info("alertPage -> alertList : " + alertList);
        
        model.addAttribute("alertList", alertList);
        model.addAttribute("userNo", userNo);
        return "alert/alertPage"; 
    }
    

    // 실시간 알림 전송 메서드 (WebSocket 메시지 처리)
    @MessageMapping("/sendNotification")
    public void sendNotification(AlertVO alertVO) {
    	
    	log.info("sendNotification 체킁");
    	log.info("sendNotification -> alertVO : " + alertVO);
    	
        // 수신자에게 알림 전송
        String destination = "/sub/userAlertList/" + alertVO.getUserNo();
        
        log.info("sendNotification -> destination : " + destination);
        
        messagingTemplate.convertAndSend(destination, alertVO);
    }

    // 알림 목록 조회
    @ResponseBody
    @GetMapping("/userAlertList")
    public ArticlePage<AlertVO> userAlertList(@AuthenticationPrincipal UserDetails userDetails,
    		@RequestParam(name = "currentPage", defaultValue = "1") int currentPage,
            @RequestParam(name = "keyword", defaultValue = "") String keyword				
    		) {
        
    	log.info("userAlertList 체킁");
    	String userNo = userDetails.getUsername();
    	log.info("userAlertList -> userNo : " + userNo);
    	
        List<AlertVO> alertList = alertService.userAlertList(userNo, currentPage, keyword);
        log.info("userAlertList -> alerts : " + alertList);
        
        int total = this.alertService.total(userNo, keyword);
		log.info("userAlertList ->  total : " + total);
		
		ArticlePage<AlertVO> articlePage = new ArticlePage<>(total, currentPage, 10, alertList, keyword, "");
		
		
        return articlePage;
    }
    
    // 알림을 확인 상태로 변경
    @ResponseBody
    @PostMapping("/updAlertChk")
    public String updAlertChk(@RequestParam("alertNo") int alertNo, @AuthenticationPrincipal UserDetails userDetails) {
    	
    	log.info("updAlertChk 체킁");
    	
    	String userNo = userDetails.getUsername();
    	log.info("updAlertChk -> userNo : " + userNo);
    	
        boolean success = alertService.updAlertChk(alertNo, userNo);
        
        return success ? "success" : "fail";
    }
    
    // 안 읽음 알림 갯수
    @ResponseBody
    @GetMapping("/unreadCnt")
    public int unreadCnt(String userNo, @AuthenticationPrincipal UserDetails userDetails) {
    	
    	log.info("unreadCnt 체킁");
    	
        userNo = userDetails.getUsername();
        log.info("unreadCnt -> userNo : " + userNo);
        
        int count = alertService.unreadCnt(userNo);
        
        log.info("unreadCnt -> count : " + count);
        
        return count;
    }

    
}
