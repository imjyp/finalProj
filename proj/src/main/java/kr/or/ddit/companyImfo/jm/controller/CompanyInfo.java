package kr.or.ddit.companyImfo.jm.controller;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/companyInfo")
public class CompanyInfo {

	
	//테스트
	@GetMapping("/test")
	public String companyInfoTest(Model model) {
		
		return "companyInfo/companyInfoTest";
	}
	
	// 메인페이지 이벤트 리스트 조회
	@GetMapping("/page")
	public String companyInfo(Model model) {
		
		return "companyInfo/companyInfoPage";
	}

	
}
