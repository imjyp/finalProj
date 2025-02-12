package kr.or.ddit.item.jy.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.item.jy.service.ItemService;
import kr.or.ddit.vo.ItemVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/item")
@Slf4j
public class ItemController {
    
    @Autowired
    private ItemService itemService;
    
    @GetMapping("/list")
    public String itemList(
            @RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
            @RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
            Model model) {
        
        Map<String, Object> map = new HashMap<>();
        map.put("currentPage", currentPage);
        map.put("keyword", keyword);
        
        List<ItemVO> itemList = this.itemService.list(map);
        int total = this.itemService.getTotal(map);
        
        model.addAttribute("list", itemList);
        model.addAttribute("total", total);
        
        return "item";
    }
}

	/*
	// 품목 리스트 (비동기)
	골뱅이ResponseBody
	골뱅이PostMapping("/itemListAjax")
	public ArticlePage<ItemVO> listAjax(골뱅이RequestBody Map<String, Object> map){
		log.info("list -> map : " + map);
		
		int total = this.itemService.getTotal(map);
		log.info("list -> total : " + total);
		
		List<ItemVO> itemList = this.itemService.list(map);
		
		
		int currentPage = 1;
		
		if(map.get("currentPage") != null) {
			currentPage = Integer.parseInt(map.get("currentPage").toString());
		}
		
		String keyword = "";
	
		if(map.get("keyword") != null) {
			keyword = map.get("keyword").toString();
		}
		
		ArticlePage<ItemVO> articlePage = new ArticlePage<>(total, currentPage, 10, itemList, keyword, "ajax");
	
		return articlePage; 
	}
	*/
