package kr.or.ddit.salary.jc.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import kr.or.ddit.salary.jc.service.iSalaryService;
import kr.or.ddit.vo.SalaryVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class SalaryController {
	@Autowired
	iSalaryService salaryService;
	
	@GetMapping("bonsa/salary")
	public String bssalary(Model model) {
		List<SalaryVO> salaryList = this.salaryService.getBsSalary();
		model.addAttribute("salaryList",salaryList);
		
		return "bsSalary";
	}
	
	
	@GetMapping("gmj/salary")
	public String gmjsalary(Model model) {
		List<SalaryVO> salaryList = this.salaryService.getGmjSalary();
		model.addAttribute("salaryList",salaryList);
		return "gmjSalary";
	}


}
