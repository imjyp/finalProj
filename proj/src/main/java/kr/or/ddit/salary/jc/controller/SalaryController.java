package kr.or.ddit.salary.jc.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.salary.jc.service.iSalaryService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.SalaryVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class SalaryController {
	@Autowired
	iSalaryService salaryService;
	
	@GetMapping("/bonsa/salary")
	public String bssalary(Model model,
			@RequestParam(value = "positionNo", required = false, defaultValue = "0") int positionNo,
			@RequestParam(value = "deptNo", required = false, defaultValue = "0") int deptNo ) {
		Map<String, Object> map = new HashMap();
		
		map.put("positionNo", positionNo);
		map.put("deptNo", deptNo);
		
		log.info("샐러리맵:"+map);
		
		List<SalaryVO> deptList = this.salaryService.deptList();
		List<SalaryVO> positionList = this.salaryService.positionList();
		List<EmployeeVO> people = this.salaryService.filterP(map);
		
		List<SalaryVO> yearlist = this.salaryService.year();
		List<SalaryVO> monthlist = this.salaryService.month();
		
		log.info("년도 리스트"+yearlist);
		log.info("월 리스트"+monthlist);
		
		model.addAttribute("deptList",deptList);
		model.addAttribute("positionList",positionList);
		model.addAttribute("people",people);
		model.addAttribute("year",yearlist);
		model.addAttribute("month",monthlist);
		
		
		return "salary/bsSalary";
	}
	
	
	 @ResponseBody
	 @PostMapping("/filter") public List<EmployeeVO> filter(@RequestBody Map<String,Object> map){
		 List<EmployeeVO> dlist = salaryService.filterP(map);
		 log.info("필터링준비!:"+map);
		 log.info("필터링:"+dlist);
	 
		 return dlist; 
	 }
	 
	
	@ResponseBody
	@PostMapping("/bonsa/salarylist")
	public  ArticlePage<SalaryVO> salaybonsa(@RequestBody Map<String, Object> map) {
		List<SalaryVO> salaryList = this.salaryService.getBsSalary(map);
		
		log.info("listAjax -> map: "+map);
		log.info("salaryList -> salaryList: "+salaryList);
		
		int total = this.salaryService.getTotal2(map);
		log.info("listAjax -> total: "+total);
		
		int currentPage = Integer.parseInt(map.get("currentPage").toString());
		String keyword = map.get("keyword").toString();
		
		
		ArticlePage<SalaryVO> articlepage = new ArticlePage<SalaryVO>(total, currentPage, 10, salaryList,keyword,"ajax");
		log.info("본사 비동기 articlepage:"+articlepage);
		return articlepage;
	}
	
	
	@GetMapping("/gmj/gmj{storeNo}/salary")
	public String gmjsalary(Model model,@PathVariable int storeNo) {
		
		List<SalaryVO> yearlist = this.salaryService.year2();
		List<SalaryVO> monthlist = this.salaryService.month2();
		List<SalaryVO > empList = this.salaryService.gmjemplist(storeNo);
		
		log.info("년도 리스트"+yearlist);
		log.info("월 리스트"+monthlist);
		log.info("직원 리스트"+empList);
		
		model.addAttribute("year",yearlist);
		model.addAttribute("month",monthlist);
		model.addAttribute("storeNo",storeNo);
		model.addAttribute("empList",empList);
		return "salary/gmjSalary";
	}
	
	
	@ResponseBody 
	@PostMapping("/salarylist")
	public ArticlePage<SalaryVO> salaryList(@RequestBody Map<String, Object>map){
		
		log.info("listAjax -> map: "+map);
		
		int total = this.salaryService.getTotal(map);
		log.info("listAjax -> total: "+total);
		
		int currentPage = Integer.parseInt(map.get("currentPage").toString());
		String keyword = map.get("keyword").toString();
		
		List<SalaryVO> list =this.salaryService.getGmjSalary(map);
		
		ArticlePage<SalaryVO> articlepage = new ArticlePage<SalaryVO>(total, currentPage, 10, list,keyword,"ajax");
		log.info("가맹점 비동기 articlepage:"+articlepage);
		
		
		return articlepage;
	}
	
	
	
	@ResponseBody
	@PostMapping("/bonsa/insertSalary")
	public int insertSalary(@RequestBody Map<String, Object> map) {
		log.info("insertSalary-> map: "+map);
		int result=this.salaryService.insertSalary(map);
		log.info("급여 인서트: "+result);
		return result;
	}

	@ResponseBody
	@PostMapping("/bonsa/editSalary")
	public int editSalary(@RequestBody Map<String, Object> map) {
		log.info("editSalary-> map: "+map);
		int result=this.salaryService.editSalary(map);
		return result;
	}
	
	
	@ResponseBody
	@PostMapping("/payAll")
	public int payAll() {
		int result=this.salaryService.insertAll();
		/*
		 * int result2=0; 
		 * log.info("payAll->result: "+result);
		 * 
		 * if(result!=0) { 
		 * 	result2 = this.salaryService.editSalary(); 
		 * }
		 */
		int result2=this.salaryService.editSalary();
		log.info("payAll->result2: "+result2);
		return result2;
	}
	
	
	@ResponseBody
	@PostMapping("/payAllGMJ")
	public int payAllGMJ(@RequestBody Map<String, Object> map) {
		log.info("가맹점 직원 지급:"+map);
		int result=this.salaryService.insertAllGMJ(Integer.parseInt(map.get("storeNo").toString()));
		
		int result2=this.salaryService.editSalary();
		log.info("payAllGMJ->result: "+result2);
		return result2;
	}

}
