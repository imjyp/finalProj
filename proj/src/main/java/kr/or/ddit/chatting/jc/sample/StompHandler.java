package kr.or.ddit.chatting.jc.sample;


import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.Message;
import org.springframework.messaging.MessageChannel;
import org.springframework.messaging.simp.stomp.StompCommand;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.messaging.support.ChannelInterceptor;
import org.springframework.messaging.support.MessageHeaderAccessor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import jakarta.security.auth.message.AuthException;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.chatting.jc.service.iChattingService;
import kr.or.ddit.security.CustomUser;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Component
public class StompHandler implements ChannelInterceptor {
    
    private Map<String, String> sessionUserMap = new ConcurrentHashMap<>();
    
    @Autowired
    GreetingController greetingController;
    
    @Autowired
    iChattingService chatService;
    
    @Override
    public Message<?> preSend(Message<?> message, MessageChannel channel) {
        StompHeaderAccessor accessor = MessageHeaderAccessor.getAccessor(message, StompHeaderAccessor.class);
        
        log.info("preSend->message : " + message);
        
        if (accessor != null) {
        	//StompCommand: CONNECT
        	log.debug("StompCommand: " + accessor.getCommand());
        	
        	 if (StompCommand.CONNECT.equals(accessor.getCommand())) {
                 log.debug("CONNECT 진입");
                 try {
                	 Authentication authentication = null;
                     log.info("인증?"+authentication);
                     
                     if (authentication != null && authentication.getPrincipal() instanceof CustomUser) {
                         CustomUser customUser = (CustomUser) authentication.getPrincipal();
                         accessor.setUser(authentication);
                         String sessionId = accessor.getSessionId();
                         //*******           세션고유아이	로그인 아이디
                         sessionUserMap.put(sessionId, customUser.getUsername());
                         
                         log.info("사용자 계정: " + customUser.getUsername());
                         log.info("접속한 유저: " + sessionUserMap.values());
                     }
                     
                 } catch (Exception e) {
                     log.error("인증 처리 중 오류 발생: ", e);
                 }
            	
            } else if (StompCommand.SUBSCRIBE.equals(accessor.getCommand())) {
                // 구독 요청 처리
                String destination = accessor.getDestination();
                log.info("Subscribe destination: " + destination);
            } else if (StompCommand.SEND.equals(accessor.getCommand())) {
            	String destination = accessor.getDestination();
                log.info("Send destination: " + destination); // 전송 경로 확인용 로그
                
                // 모든 채팅 메시지 허용
                if (destination != null && (
                    destination.startsWith("/pub/chat/enter") || 
                    destination.startsWith("/pub/chat/message")
                )) {
                    return message;
                }
            } else if (StompCommand.DISCONNECT.equals(accessor.getCommand())) {
                String sessionId = accessor.getSessionId();
                String username = sessionUserMap.remove(sessionId);
                log.info("나간 유저: " + username);
                log.info("남아있는 유저: " + sessionUserMap.values());
            }
        }
        
        return message;
    }
}
