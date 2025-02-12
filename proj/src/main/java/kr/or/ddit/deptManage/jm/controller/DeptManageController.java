package kr.or.ddit.deptManage.jm.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.deptManage.jm.service.DeptManageService;
import kr.or.ddit.vo.DeptVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/deptManage")
public class DeptManageController {

	@Autowired
	DeptManageService deptManageService ;
	
	//테스트
	@GetMapping("/test")
	public String deptManageTest(Model model) {
		List<DeptVO> getDeptList = deptManageService.getDeptList();
		log.info("deptManageTest-getDeptList: " + getDeptList);
        model.addAttribute("getDeptList", getDeptList);
		return "deptManage/deptManageTest";
	}
	
	// 메인페이지 이벤트 리스트 조회
	@GetMapping("/page")
	public String deptManagePage(Model model) {
		List<DeptVO> getDeptList = deptManageService.getDeptList();
		log.info("deptManagePage-getDeptList: " + getDeptList);
        model.addAttribute("getDeptList", getDeptList);
		return "deptManage/deptManagePage";
	}
	
	//등록
	@ResponseBody
	@PostMapping("/create")
	public String createDept(@RequestBody DeptVO deptVO) {
		
		this.deptManageService.createDept(deptVO);
		log.info("createDept-count: " + deptVO);
        return "SUCCESS";
		
//		if(count  == 1) {
//			log.info("createDept-if: " + "등록성공");
//	        return "SUCCESS";
//		}
//		else {
//			log.info("createDept-else: " + "중복데이터");
//	        return "DUPLICATE";
//		}
		
	}
	
	//수정
	@ResponseBody
	@PostMapping("/update")
	public Map<String, String> updateDept(@RequestBody DeptVO deptVO) {
		log.info("updateDept-deptVO: " + deptVO);
		this.deptManageService.updateDept(deptVO);
		
		// 성공적으로 저장되었음을 클라이언트에 응답
        Map<String, String> response = new HashMap<>();
        response.put("message", "Event Update successfully");
        return response;
	}
	
	//삭제
	@ResponseBody
	@PostMapping("/delete")
	public String deleteDept(@RequestBody DeptVO deptVO) {
		log.info("deleteDept->deptVO: " + deptVO);
		this.deptManageService.deleteDept(deptVO);
		
		// 성공적으로 저장되었음을 클라이언트에 응답
//      Map<String, String> response = new HashMap<>();
//      response.put("message", "Event Delete successfully");
//		return response;
        return "삭제성공";
	}
	
	

	
}
