package kr.or.ddit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class PageController {
	
	//.requestMatchers("/ceo/**").hasRole("CEO")
	//해당 요청은 로그인을 해야하고, 
	//	로그인 한 계정의 권한이 ROLE_CEO 이어야 함
	@GetMapping("/ceo/index")
	public String ceoPage() {
		log.info("ceo폴더의 index.jsp를 forwarding");
				
		return "ceo/index";
	}
	
	//로그인은 됐지만 해당URL에 접근 권한이 없을 때
	@GetMapping("/accessError")
	public String accessError() {
		log.info("accessError.jsp를 포워딩");
		return "accessError";
	}
	
	
}



