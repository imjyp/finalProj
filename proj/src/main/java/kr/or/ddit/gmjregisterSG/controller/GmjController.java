package kr.or.ddit.gmjregisterSG.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.gmjregisterSG.service.GmjService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.BillVO;
import kr.or.ddit.vo.StoreVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
/* @Controller */
public class GmjController {
	
	
	@Autowired
    GmjService gmjService;
    
    @GetMapping("/gmjGR")
    public String gmjRegister(Model model) {
    	
    	List<StoreVO> best = this.gmjService.bestGMJ();
    	model.addAttribute("best",best);
    	log.info("best:"+best);
        return "gmjmanage/gmjregister";
    }
    
    @ResponseBody
    @PostMapping("/gmjAjax")
    public ArticlePage gmjAjax(@RequestBody Map<String, Object> map) {
    	log.info("gmj -> map : " + map);
		int total = this.gmjService.getTotal(map);
		
		List<BillVO> billList = this.gmjService.list(map);
		log.info("gmj -> itemList : " + billList);
		
		int currentPage = 1;

		if(map.get("currentPage") != null) {
			currentPage = Integer.parseInt(map.get("currentPage").toString());
		}
		
		String keyword= "";
		
		if(map.get("keyword") != null) {
			keyword = map.get("keyword").toString();
		}
		
		ArticlePage<BillVO> articlePage = new ArticlePage<>(total, currentPage, 10, billList, keyword, "ajax");
	
		return articlePage;
    }
    
    @ResponseBody
    @PostMapping("/gmj/search")
    public List<StoreVO> search(@RequestBody Map<String, Object>map ) {
    	
    	log.info("검색 키워드: "+map);
    	String keyword = map.get("keyword").toString();
    	List<StoreVO> gmjlist = this.gmjService.searchGmj(keyword);
    	log.info("검색: "+gmjlist);
    	return gmjlist;
    }
    
    @ResponseBody
    @PostMapping("/gmjDelete")
    public int gmjDelete(@RequestBody Map<String, Object>map ) {
    	 
    	log.info("삭제 map: "+map);
    	List<Integer> storeNos = (List<Integer>) map.get("storeNos");
    	 if (storeNos == null || storeNos.isEmpty()) {
    	        log.error("storeNos가 비어있습니다.");
    	        return 0; 
    	    }
    	 
    	int result = this.gmjService.deleteGmj(storeNos);
    	log.info("삭제 완료?: "+result);
    	return result;
    }
    
    @GetMapping("/store/detail")
    public String detail(@RequestParam int storeNo, Model model) {
    	  StoreVO store = this.gmjService.getStoreByNo(storeNo);
    	
    	StoreVO total = this.gmjService.budgetfordetail(storeNo);
    	if(total != null ) {
    		model.addAttribute("total", total);
    	}
	    model.addAttribute("store", store);
	    
	    return "gmjmanage/storeDetail";
    }
    
    @ResponseBody
    @PostMapping("/gmjInsert")
    public int gmjInsert(@RequestBody Map<String, Object>map ) {
    	 
    	log.info("등록 map: "+map);
    	int result = this.gmjService.insertGmj(map);
    	log.info("등록 완료?: "+result);
    	return result;
    }
    
    
    @ResponseBody
    @PostMapping("/saveStoreDetails")
    public int saveStoreDetails(@RequestBody Map<String, Object> map ) {
    	 
    	log.info("가맹점 수정 map: "+map);
    	 
    	int result = this.gmjService.updateGmj(map);
    	log.info("수정 완료?: "+result);
    	return result;
    }
    
  
}