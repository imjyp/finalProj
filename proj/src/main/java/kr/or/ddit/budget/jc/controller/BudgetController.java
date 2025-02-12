package kr.or.ddit.budget.jc.controller;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.budget.jc.service.iBudgetService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.util.UrlAccessController;
import kr.or.ddit.vo.HeadBudgetVO;
import kr.or.ddit.vo.StoreVO;
import lombok.extern.slf4j.Slf4j;


@Controller
@Slf4j
public class BudgetController {
	@Autowired
	iBudgetService bgService;
	
	@Autowired
	UrlAccessController urlAccessController;
	
	@GetMapping("/bonsa/budget")
	public String budget(@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
			@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
			Model model, HeadBudgetVO budgetVO) {

		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("currentPage", currentPage); 
		map.put("keyword", keyword);
		
		log.info("하잉: "+map);
		List<HeadBudgetVO> bgList = this.bgService.ysgrlist(map);
		
		log.info("list -> bgList : " + bgList);
		map.put("type", 1);
		  
		 int total = this.bgService.getTotalBS(); 
		 log.info("본사예산 토탈:"+total);
		 // 수정 할것. 토탈값 이상
		 ArticlePage<HeadBudgetVO> articlePage = new ArticlePage<HeadBudgetVO>(total, currentPage, 10, bgList,keyword);
		 model.addAttribute("articlePage", articlePage);
		 model.addAttribute("bgList", bgList); 
		 
		
		return "budget/bsbudget";
	}
	
	@GetMapping("/bonsa/budget/type=2")
	public String budget2(@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
			@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
			Model model, HeadBudgetVO budgetVO) {

		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("currentPage", currentPage); 
		map.put("keyword", keyword);
		
		log.info("하잉: "+map);
		List<HeadBudgetVO> bgList2 = this.bgService.yssylist(map);
		 log.info("list -> bgList2 : " + bgList2);
		 int total2 = this.bgService.getTotal(map); 
		 ArticlePage<HeadBudgetVO> articlePage2 = new ArticlePage<HeadBudgetVO>(total2, currentPage, 10, bgList2,keyword);
		 
		 List<HeadBudgetVO> yearList= this.bgService.yearlist();
		 model.addAttribute("articlePage2", articlePage2);
		 model.addAttribute("bgList2", bgList2); 
		 log.info("yearList:"+yearList);
		 model.addAttribute("yearList", yearList); 
		
		return "budget/bsbudget2";
	}
	@ResponseBody
	@PostMapping("/bonsa/budgetList")
	public ArticlePage<HeadBudgetVO> listAjax(@RequestBody Map<String, Object> map) {
		
		log.info("listAjax -> map : " + map);
		int currentPage = 1;
		String keyword = "";
		if(map.get("currentPage") != null) {
			currentPage = Integer.parseInt(map.get("currentPage").toString());
		}
		if(map.get("keyword") != null) {
			keyword = map.get("keyword").toString();
		}
		
		int total = this.bgService.getTotal(map);
		log.info("listAjax -> total : " + total);
		
		
		List<HeadBudgetVO> yssylist = this.bgService.yssylist(map);
		log.info("listAjax -> yssylist : " + yssylist);
		

		ArticlePage<HeadBudgetVO> articlePage = new ArticlePage<>(total, currentPage, 10, yssylist, keyword, "ajax");
		return articlePage;
	}
	
	@ResponseBody
	@PostMapping("/bonsa/insertBudget")
	public int insertBudget(@RequestBody Map<String, Object> map) {
		log.info("insertBudget=>map"+map);
		int result = this.bgService.insertBudget(map);
		log.info("insertBudget => result: "+result);
		
		return result;
	}
	
	@ResponseBody
	@PostMapping("/bonsa/updateBudget")
	public int updateBudget(@RequestBody Map<String, Object> map) {
		log.info("updateBudget=>map"+map);
		int result = this.bgService.updateBudget(map);
		log.info("updateBudget => result: "+result);
		
		return result;
	}
	
	@ResponseBody
	@PostMapping("/bonsa/delete")
	public int deleteBudget(@RequestBody Map<String, Object> map) {
		log.info("deleteBudget=>map"+map);
		//int chk = this.bgService.chkDelete(map);
		int result = this.bgService.deleteBudget(map);
		log.info("deleteBudget => result: "+result);
		
		return result;
	}
	
	
	/*
	[권한의 대표 목적]
	1. 메뉴 확인 분기
	2. 버튼 기능 분기
	 */
	//a PreAuthorize("hasAnyRole('GMJ')")
	@GetMapping("/gmj/gmj{storeNo}/budget")
	public String budget3(@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
			@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
			Model model, StoreVO storeVO, @PathVariable int storeNo,
			Principal principal) {
		
		// URL 접근 불가
		if (principal == null) {
			return "redirect:/main";
		}

		log.info("storeNo:"+storeNo);
		
		//로그인 한 아이디
		String userNo = principal.getName();
		
		int accessResult = this.urlAccessController.getUrlAccess(storeNo, userNo);
		log.info("budget3->accessResult : " + accessResult);
		
		//URL 접근 불가
		if(accessResult<1) {
			return "redirect:/main";
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("currentPage", currentPage); 
		map.put("keyword", keyword);
		map.put("storeNo", storeNo);
		
		log.info("하잉: "+map);
		List<StoreVO> bgList = this.bgService.ysgrlist2(map);
		
		log.info("list -> 가맹점 bgList : " + bgList);
		 
		 int total = this.bgService.getTotalGMJ(); 
		 ArticlePage<StoreVO> articlePage = new ArticlePage<StoreVO>(total, currentPage, 10, bgList,keyword);
		 model.addAttribute("articlePage", articlePage);
		 model.addAttribute("bgList", bgList); 
		
		return "budget/gmjbudget";
	}
	
	
	@GetMapping("/gmj/gmj{storeNo}/budget/type=2")
	public String budget4(@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
			@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
			Model model, StoreVO storeVO, @PathVariable int storeNo) {
		
		log.info("storeNo:"+storeNo);
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("currentPage", currentPage); 
		map.put("keyword", keyword);
		map.put("storeNo", storeNo);
		
		log.info("하잉: "+map);
		List<StoreVO> bgList = this.bgService.ysgrlist2(map);
		
		log.info("list -> 가맹점 bgList : " + bgList);
		 
		 List<HeadBudgetVO> bgList2 = this.bgService.yssylist2(map);
		 log.info("list -> bgList2 : " + bgList2);
		 int total2 = this.bgService.getTotal2(map); 
		 log.info("list -> total2 : " + total2);
		 ArticlePage<HeadBudgetVO> articlePage2 = new ArticlePage<HeadBudgetVO>(total2, currentPage, 10, bgList2,keyword);
		 
		 List<HeadBudgetVO> yearList= this.bgService.yearlist2(storeNo);
		 model.addAttribute("articlePage2", articlePage2);
		 model.addAttribute("bgList2", bgList2); 
		 model.addAttribute("storeNo",storeNo);
		 log.info("yearList:"+yearList);
		 model.addAttribute("yearList", yearList); 
		 
		
		return "budget/gmjbudget2";
	}
		

		
		@ResponseBody
		@PostMapping("/gmj{storeNo}/budgetList")
		public ArticlePage<HeadBudgetVO> listAjax( @PathVariable int storeNo,
				@RequestBody Map<String, Object> map) {
			
			log.info("listAjax -> map : " + map);
			map.put("storeNo", storeNo);
			
			int total = this.bgService.getTotal2(map);
			log.info("listAjax -> total : " + total);
			
			List<HeadBudgetVO> yssylist = this.bgService.yssylist2(map);
			log.info("listAjax -> yssylist : " + yssylist);
			
			int currentPage = 1;
			if(map.get("currentPage") != null) {
				currentPage = Integer.parseInt(map.get("currentPage").toString());
			}
			
			String keyword = "";
			if(map.get("keyword") != null) {
				keyword = map.get("keyword").toString();
			}
			
			
			ArticlePage<HeadBudgetVO> articlePage = new ArticlePage<>(total, currentPage, 10, yssylist, keyword, "ajax");
			
			return articlePage;
		}
		
		@ResponseBody
		@PostMapping("/gmj{storeNo}/insertBudget")
		public int insertBudget(@PathVariable int storeNo, @RequestBody Map<String, Object> map) {
			map.put("storeNo", storeNo);
			log.info("insertBudget 가맹점 =>map"+map);
			int result = this.bgService.insertBudget2(map);
			log.info("insertBudget 가맹점 => result: "+result);
			
			return result;
		}
		
		@ResponseBody
		@PostMapping("/gmj{storeNo}/updateBudget")
		public int updateBudget(@PathVariable int storeNo, @RequestBody Map<String, Object> map) {
			map.put("storeNo", storeNo);
			log.info("updateBudget=>map"+map);
			int result = this.bgService.updateBudget2(map);
			log.info("updateBudget => result: "+result);
			
			return result;
		}
	
}
