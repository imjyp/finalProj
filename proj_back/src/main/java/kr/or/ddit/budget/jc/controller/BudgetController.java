package kr.or.ddit.budget.jc.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import kr.or.ddit.budget.jc.service.iBudgetService;
import kr.or.ddit.vo.HeadBudgetVO;
import kr.or.ddit.vo.StoreVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class BudgetController {
	@Autowired
	iBudgetService bgService;
	
	@GetMapping("/bonsa/budget")
	public String budget(Model model) {
		List<HeadBudgetVO> bgList= this.bgService.getBudget();
		model.addAttribute("bgList",bgList);
		return "bsbudget";
	}
	
	
	@GetMapping("/gmj/budget")
	public String budget2(Model model) {
		List<StoreVO> bgList= this.bgService.getBudget2();
		List<StoreVO> gmjList= this.bgService.gmjList();
		
		model.addAttribute("bgList",bgList);
		model.addAttribute("gmjList",gmjList);
		log.info("가맹점 정보: "+bgList);
		log.info("가맹점 리스트: "+gmjList);
		return "gmjbudget";
	}
	

}
