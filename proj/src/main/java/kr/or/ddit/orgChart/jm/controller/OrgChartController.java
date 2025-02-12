package kr.or.ddit.orgChart.jm.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.orgChart.jm.service.OrgChartService;
import kr.or.ddit.vo.OrgChartVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/orgChart")
public class OrgChartController {
	
	@Autowired
	OrgChartService orgChartService;
	
	//테스트 리스트 조회
	@GetMapping("/test")
	public String orgChartTest(Model model) {
		List<OrgChartVO> listOrgChart = this.orgChartService.listOrgChart();
		log.info("orgChartTest->listOrgChart: " + listOrgChart);
		model.addAttribute("listOrgChart",listOrgChart);
		return "orgChart/orgChartTest";
	}
	
	// 리스트 조회
	@GetMapping("/page")
	public String orgChartPage(Model model) {
		List<OrgChartVO> listOrgChart = this.orgChartService.listOrgChart(); 
		log.info("orgChartPage->listOrgChart: " + listOrgChart);
		model.addAttribute("listOrgChart",listOrgChart);
		return "orgChart/orgChartPage";
	}
	
	//부서 데이터 list 형식으로 반환
	@GetMapping("/orgList")
	@ResponseBody
	public List<Map<String, Object>> getDeptList() {
	    List<OrgChartVO> orgCharts = this.orgChartService.listOrgChart();
		log.info("getDeptList-> orgCharts 출력:" + orgCharts);
        // orgList는 반환할 이벤트 목록을 담기 위한 List<Map<String, Object>> 객체입니다.(각 이벤트를 Map객체 변환)
        List<Map<String, Object>> orgChartList = new ArrayList<>();
        
        // events 목록에 있는 각 CalendarVO 객체를 순차적으로 처리합니다.
        for (int i = 0; i < orgCharts.size(); i++) {
        	OrgChartVO orgChart = orgCharts.get(i);
        	// eventData는 각 이벤트 정보를 저장하는 Map 객체입니다.(이벤트 정보를 Map 형태로 변환)
            // Map에 저장되는 키(key)와 값(value)의 구조는 JSON 형식으로 변환됩니다.
            Map<String, Object> orgChartData = new HashMap<>();
            
            //기본 필드 데이터(Non-standard Fields)
            orgChartData.put("level", orgChart.getLevel());	//
            orgChartData.put("name", orgChart.getName());	//
            orgChartData.put("pid", orgChart.getParent());	//
            orgChartData.put("id", orgChart.getId());	//
            orgChartData.put("img", orgChart.getImg());	//
            
            // orgChartData를 orgCjartList에 추가합니다. (Map을 orgCjartList에 추가)
            orgChartList.add(orgChartData);
            // 개별 이벤트 로그 출력
            log.info("getDeptList-> orgChartData 출력: {} + {}", orgChartData.get("id"), orgChartData);
        }
	    return orgChartList;
	}
	

	
//	//부서 데이터를 children 있는 계층 구조로 반환
//	@GetMapping("/orgList2")
//	@ResponseBody
//	public ResponseEntity<Map<String, Object>> getDeptHierarchy() {
//		Map<String, Object> hierarchy = this.orgChartService.getDeptHierarchyForTree();
//	    log.info("getDeptHierarchy->hierarchy: " + hierarchy);
//	    return ResponseEntity.ok(hierarchy);
//	}
	
//	// 생성
//	@ResponseBody
//	@PostMapping("/create")
//	public String createOrgChart(@RequestBody OrgChartVO orgChartVO) {
//		log.info("createOrgChart->orgChartVO: " + orgChartVO);
//		this.orgChartService.createOrgChart(orgChartVO);
//		return "/orgChart/orgChartTest";
//	}
//	// 수정	
//	@ResponseBody
//	@PostMapping("/update")
//	public String updateOrgChart(@RequestBody OrgChartVO orgChartVO) {
//		log.info("updateOrgChart->orgChartVO: " + orgChartVO);
//		this.orgChartService.updateOrgChart(orgChartVO);
//		return "/orgChart/orgChartTest";
//	}
//	//삭제
//	@ResponseBody
//	@PostMapping("/delete")
//	public String deleteOrgChart(@RequestBody OrgChartVO orgChartVO) {
//		log.info("deleteOrgChart->orgChartVO: " + orgChartVO);
//		this.orgChartService.deleteOrgChart(orgChartVO);
//		return "/orgChart/orgChartTest";
//	}
	

}