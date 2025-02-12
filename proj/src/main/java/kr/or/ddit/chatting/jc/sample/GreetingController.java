package kr.or.ddit.chatting.jc.sample;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.HtmlUtils;

import jakarta.servlet.http.HttpSession;
import kr.or.ddit.chatting.jc.service.iChattingService;
import kr.or.ddit.security.CustomUser;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.BillVO;
import kr.or.ddit.vo.ChatVO;
import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.FileDetailVO;
import kr.or.ddit.vo.UsersVO;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
public class GreetingController {
	
	@Autowired
	iChattingService chatService;
	
	/*
	 	client가 메시지를 보내면 서버에 메시지가 전달된다
	 	controller의 a MessageMapping 에 의해 메시지를 받는다
	 	controller의 a SendTo로 특정 topic(/1)을 구독(/room)하는 클라이언트에게 메시지를 보낸다
	 	
	 * */
	
	@GetMapping("/chattingRoom")
	public String chattingRoom(Model model) {
		/*
		List<EmployeeVO> peoplelist = this.chatService.listPeople();
		log.info("회원목록",peoplelist);
		model.addAttribute("peoplelist",peoplelist);
		*/
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
   	 	String userNo = auth.getName();
	    
	    model.addAttribute("userNo", userNo);
		return "chat/chattingRoom";
	}
	
	
	@ResponseBody
	@PostMapping("/peopleSearch")
	public List<EmployeeVO> peopleSearch(@RequestBody Map<String, Object> map){
		log.info("peopleSearch -> map : " + map);
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
   	 	String userNo = auth.getName();
		log.info("peopleSearch -> userNo : " + userNo);
		
		String keyword= "";
		
		if(map.get("keyword") != null) {
			keyword = map.get("keyword").toString();
		}
		
		map.put("userNo", userNo);
		
		List<EmployeeVO> filtered = this.chatService.filter(map);
		
		log.info("peopleSearch -> filtered : " + filtered);
	
		return filtered;
		
	} 
    
    @GetMapping("/chat")
    public String chatting(Model model) {
    	
    	 Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    	 String userNo = auth.getName();
	    
	    model.addAttribute("userNo", userNo);
        return "chat/chatting";
    }

    @MessageMapping("/chat/enter")
    @SendTo("/sub/chat/room")
    public ChatVO greeting(ChatVO chatvo, Map<String,Object> map, SimpMessageHeaderAccessor headerAccessor) throws Exception {
        Principal authentication = headerAccessor.getUser();  //시큐리티 정보
    	//Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        log.info("principal:"+authentication);
        String username = authentication.getName();
        log.info("username:"+username);
        log.info("mySessionId:"+map.get("mySessionId"));
        log.info("fileSaveLocate:"+map.get("fileSaveLocate"));
        
        // 메시지 처리
        if (username.equals(map.get("mySessionId"))) {	//stomp 정보랑 시큐리티 정보 비교
            chatvo.setSenderNo(username);
        }
        chatvo.setChatSendContent(HtmlUtils.htmlEscape(chatvo.getChatSendContent()));
        
        if(map.get("fileGroupNo")!=null ) {
        	chatvo.setFileSaveLocate(HtmlUtils.htmlEscape(map.get("fileSaveLocate").toString()));
        	chatvo.setFileOriginalName(HtmlUtils.htmlEscape(map.get("fileOriginalName").toString()));
        	
        }
        
        return chatvo;
    }
    
    /*
    formData -> chatRoomNo:1
    formData -> senderNo:gmj001
    formData -> receiverNo:a001
    formData -> chatSendContent:ㅁㅁ
     */
    @ResponseBody
    @PostMapping("/createPost")
    public Map<String, Object> createPost(@ModelAttribute ChatVO chatvo) {
    	/*
    	ChatVO(chatRoomNo=3, userNo=null, chatSendNo=0, chatSendContent=aa, fileGroupNo=0, 
    	chatSendDate=null, chatSendDel=0, receiverNo=a999, senderNo=a001, chatRoomNm=null, 
    	chatRoomStatus=0, chatRoomCreate=null, chatRoomDel=0, chatNo=0, rcptnDate=null, 
    	rcptnDel=0, rcptnChk=0, uploadFiles=null, fileGroupNm=null, fileRegdate=null, 
    	fileGroupTy=0, fileNo=0, fileOriginalName=null, fileSaveName=null, fileSaveLocate=null, 
    	fileSize=0, fileExt=null, fileMime=null, fileFancysize=null, fileSaveDate=null, 
    	fileDowncount=0)
    	 */
        log.info("createPost-chatVO: " + chatvo);
        if (chatvo.getChatSendContent() == null || chatvo.getChatSendContent().trim().isEmpty()) {
            chatvo.setChatSendContent(""); // 빈 문자열로 설정
        }
        
        
        long fileGroupNo = chatService.createPost(chatvo);
        log.info("createPost-fileGroupNo: " + fileGroupNo);
        
        Map<String, Object> response = new HashMap();
        response.put("chatRoomNo", chatvo.getChatRoomNo());
        response.put("senderNo", chatvo.getSenderNo());
        response.put("chatSendContent", chatvo.getChatSendContent());
        response.put("receiverNo", chatvo.getReceiverNo());
        
        
       if(fileGroupNo>0) {
    	  List<FileDetailVO> files= this.chatService.selectFileDetail(fileGroupNo);
    	  log.info("createPost-files: " + files);
    	  
    	  if(files != null && !files.isEmpty()) {
              FileDetailVO fileDetail = files.get(0);
              response.put("fileGroupNo", fileGroupNo);
              response.put("fileSaveLocate", fileDetail.getFileSaveLocate());
              response.put("fileOriginalName", fileDetail.getFileOriginalName());
              response.put("fileSize", fileDetail.getFileSize());
              response.put("fileMime", fileDetail.getFileMime());
          }
       }
       
        return response;
    }

    // /chattingRoom에서 이름을 클릭 시 채팅창에 관련된 채팅내역 출력
    //{"userNo":"a001","sessionId":"a999"},
    @ResponseBody
    @PostMapping("/chatSendList")
    public List<ChatVO> chatSendList(String userNo, String sessionId) {
    	log.info("chatSendList->userNo : " + userNo);
    	log.info("chatSendList->sessionId : " + sessionId);
    	
    	Map<String,Object> map = new HashMap<String,Object>();
    	map.put("senderNo", sessionId);
    	map.put("receiverNo", userNo);
//    	chatSendList->map : {senderNo=a999, receiverNo=a001}
    	log.info("chatSendList->map : " + map);
    	
    	List<ChatVO> chatVOList = this.chatService.chatSendList(map);
    	
    	
    	
    	log.info("chatSendList->chatVOList : " + chatVOList);
    	
    	
    	return chatVOList;
    }
    
}
