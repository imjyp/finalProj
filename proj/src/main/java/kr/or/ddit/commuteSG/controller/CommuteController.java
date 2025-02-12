package kr.or.ddit.commuteSG.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.commuteSG.service.CommuteService;
import kr.or.ddit.vo.SchdVO;
import kr.or.ddit.vo.DeptVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/commute")
public class CommuteController {
    
    @Autowired
    private CommuteService commuteService;
    
    // 초기 페이지 로딩
    @GetMapping("")
    public String getCommutePage(Model model) {
        List<String> deptList = commuteService.getDeptList();
        log.info("getCommutePage->deptList : " + deptList);
        model.addAttribute("deptList", deptList);
        return "commute";
    }
    
    // AJAX 요청 처리
    @GetMapping("/list")
    @ResponseBody
    public Map<String, Object> getCommuteList(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String searchDate,
            @RequestParam(required = false) String deptNm,
            @RequestParam(required = false) String status) {
        
        Map<String, Object> params = new HashMap<>();
        params.put("page", page);
        params.put("size", size);
        params.put("searchDate", searchDate);
        params.put("deptNm", deptNm);
        params.put("status", status);
        
        //{size=10, searchDate=2025-01, page=1, deptNm=, status=}
        log.info("getCommuteList params: {}", params);
        
        List<SchdVO> commuteList = commuteService.getAllCommuteList(params);
        log.info("개똥이commuteList : " + commuteList);
        int totalItems = commuteService.getTotalCommuteCount(params);
        int totalPages = (int) Math.ceil((double) totalItems / size);
        
        Map<String, Object> response = new HashMap<>();
        response.put("commuteList", commuteList);
        response.put("currentPage", page);
        response.put("totalPages", totalPages);
        
        return response;
    }
    
    @PostMapping("/stats")
    @ResponseBody
    public List<Map<String, Object>> getMonthlyStats(
            @RequestParam String searchDate,
            @RequestParam(required = false) String deptNm) {
        Map<String, Object> params = new HashMap<>();
        params.put("searchDate", searchDate);
        params.put("deptNm", deptNm);
        log.info("getMonthlyStats params: {}", params);
        return commuteService.getMonthlyStats(params);
    }
}

