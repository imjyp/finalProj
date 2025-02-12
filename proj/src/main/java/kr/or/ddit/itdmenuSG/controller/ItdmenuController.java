package kr.or.ddit.itdmenuSG.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import kr.or.ddit.itdmenuSG.service.ItdmenuService;
import kr.or.ddit.vo.FileDetailVO;
import kr.or.ddit.vo.FileGroupVO;
import kr.or.ddit.vo.MenuVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ItdmenuController {

    @Autowired
    private ItdmenuService itdmenuService;

    @GetMapping("/itdmenu")
    public String alertPage(Model model) {
    	List<MenuVO> menus= this.itdmenuService.getMenuList();
    	
    	
    	
    	log.info("메뉴:"+menus);
        model.addAttribute("menuList",menus );
        return "itdmenu";
    }
}