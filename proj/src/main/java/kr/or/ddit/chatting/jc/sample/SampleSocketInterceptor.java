package kr.or.ddit.chatting.jc.sample;

import java.security.Principal;
import java.util.Map;

import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.HandshakeInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import kr.or.ddit.vo.AlertVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class SampleSocketInterceptor implements HandshakeInterceptor {

    
   // WebSocket 연결 전에 Principal 정보를 WebSocketSession에 담아주는 기능
   @Override
    public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler, Map<String, Object> attributes) throws Exception {
        if (request instanceof ServletServerHttpRequest) {
            ServletServerHttpRequest servletRequest = (ServletServerHttpRequest) request;
            HttpServletRequest httpServletRequest = servletRequest.getServletRequest();
            Principal user = httpServletRequest.getUserPrincipal();
            if (user != null) {
                attributes.put("username", user.getName());
                log.info("WebSocket Handshake 성공: {}", user.getName());
                return true;
            }
        }
        log.warn("WebSocket Handshake 실패: 인증되지 않은 사용자");
        response.setStatusCode(org.springframework.http.HttpStatus.FORBIDDEN);
        return false;
    }
   
   /* WebSocket 연결 전에 SecurityContext에서 인증 정보를 WebSocketSession에 담아주는 기능
    골뱅이Override
    public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler, Map<String, Object> attributes) throws Exception {
        // SecurityContext에서 인증 정보를 가져옴
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        log.info("authentication"+authentication);
        if (authentication != null && authentication.isAuthenticated()) {
            // 인증된 사용자 정보가 있으면 이를 WebSocket 세션에 담기
            attributes.put("username", authentication.getName());  // 사용자 이름 또는 필요한 정보를 담을 수 있음.
            return true;  // Handshake 성공
        }

        // 인증되지 않은 경우
        response.setStatusCode(org.springframework.http.HttpStatus.FORBIDDEN);
        return false;  // Handshake 실패
    }
   */
    
    
    
    
   @Override
    public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler, Exception exception) {
        // afterHandshake에서는 'attributes'에 직접 접근할 수 없으므로, 별도의 처리가 필요하지 않다면 로그만 남깁니다.
        log.info("WebSocket Handshake 완료");
    }
    
}