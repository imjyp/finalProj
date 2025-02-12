package kr.or.ddit.member.jy.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.member.jy.service.MemberService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.TBUserVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	MemberService memberService;
	
	@GetMapping("/list")
	public String list(@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
			@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
			Model model) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("currentPage", currentPage);
		map.put("keyword", keyword);
		log.info("list -< map : " + map);
		
		List<TBUserVO> userList = this.memberService.list(map);
		
		// total, currentPage, size, content, keyword
		int total = this.memberService.getTotal(map) ;		// map
		log.info("list -> total : " + total);
		
		// 페이지 객체 생성
		ArticlePage<TBUserVO> articlePage = 
				new ArticlePage<TBUserVO>(total, currentPage, 10, userList, keyword);
				
		model.addAttribute("userList", userList);
		model.addAttribute("articlePage", articlePage);
		
		return "member/list";
	}
	
}
