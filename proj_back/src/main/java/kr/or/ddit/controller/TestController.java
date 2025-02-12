package kr.or.ddit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class TestController {

	//메뉴가 위에
	@GetMapping("/")
	public String test() {
		return "home";
	}
	
	//로그인했을때. 메뉴가 옆에
	@GetMapping("/main")
	public String main() {
		return "index";
	}
		
		
	@GetMapping("/findPassword")
	public String findPassword() {
		return "findPassword";
	}
	
	
	
}
