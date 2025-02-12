package kr.or.ddit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import kr.or.ddit.alert.jy.service.AlertService;
import kr.or.ddit.itdmenuSG.service.ItdmenuService;
import kr.or.ddit.vo.AlertVO;
import kr.or.ddit.vo.MenuVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class TestController {
	@Autowired
    private ItdmenuService itdmenuService;
	
	//메뉴가 위에
	@GetMapping("/")
	public String test() {
		return "test";
	}
	
	//로그인했을때. 메뉴가 옆에
	@GetMapping("/main")
	public String main(Model model) {
		List<MenuVO> menus= this.itdmenuService.getMenuList();
		log.info("메뉴:"+menus);
        model.addAttribute("menuList",menus );
		return "test";
	}
		
	
	@GetMapping("/alarm")
	public String alarm() {
		return "alarm";
	}
	
	//메뉴가 위에
	@GetMapping("/test")
	public String test2() {
		return "test";
	}
}
