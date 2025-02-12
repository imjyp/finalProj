package kr.or.ddit.chatting.jc.sample;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;
import org.springframework.web.socket.WebSocketMessage;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.vo.ChatVO;
import lombok.extern.slf4j.Slf4j;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Slf4j
public class SampleWebSocketHandler extends TextWebSocketHandler {

    private static List<WebSocketSession> list = new ArrayList<>();

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        log.info("## 누군가 접속");

        // WebSocketSession에서 attributes로 사용자 정보 가져오기
        Map<String, Object> attributes = session.getAttributes();
        String username = (String) attributes.get("username");

        if (username != null) {
            log.info(username + "님이 입장하셨습니다.");
        } else {
            log.warn("사용자 인증 정보가 없습니다.");
        }

        list.add(session);
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        String uMsg = message.getPayload();  // 클라이언트가 보낸 메시지
        Map<String, Object> attributes = session.getAttributes();

        // WebSocket 세션에서 인증된 사용자 정보 확인
        String username = (String) attributes.get("username");

        // 받은 메시지를 다른 클라이언트에게 전달
        for (WebSocketSession s : list) {
            if (s != session) {
                s.sendMessage(new TextMessage(username + ": " + message.getPayload()));
            }
        }

        log.debug("클라이언트가 보낸 메시지 {}", uMsg);

        // 메시지 포맷 변경 (예: JSON 변환)
        ObjectMapper objMapper = new ObjectMapper();
        ChatVO chatvo = objMapper.readValue(uMsg, ChatVO.class);
        log.info("변환 성공? {}", chatvo);

        chatvo.setChatSendContent("메시지: " + chatvo.getChatSendContent());
        String jsonMsg = objMapper.writeValueAsString(chatvo);

        TextMessage txtMsg = new TextMessage(jsonMsg);

        // 접속한 사람들 모두에게 메시지 전송 (broadcast)
        for (WebSocketSession webSocketSession : list) {
            if (session != webSocketSession) {  // 보낸 사람이 아닐 때만
                if (webSocketSession.isOpen()) {
                    webSocketSession.sendMessage(txtMsg);
                }
            }
        }
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        log.info("## 누군가 떠남");
        list.remove(session);

        String username = (String) session.getAttributes().get("username");
        if (username != null) {
            log.info(username + "님이 퇴장하셨습니다.");
        }
    }
}
