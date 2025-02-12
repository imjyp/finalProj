package kr.or.ddit.itemSG.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.itemSG.service.ItemService;
import kr.or.ddit.vo.ItemVO;
import lombok.extern.slf4j.Slf4j;

@Controller("sgItemController")
@RequestMapping("/item")
@Slf4j
public class ItemController {
    
    @Autowired
    private ItemService itemService;
    
    @GetMapping("/itemList")
    public String itemList(
            @RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
            @RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
            Model model) {
        
        Map<String, Object> map = new HashMap<>();
        map.put("currentPage", currentPage);
        map.put("keyword", keyword);
        
        List<ItemVO> itemList = this.itemService.itemList(map);
        int total = this.itemService.getTotal(map);
        
        // 페이징 정보 추가
        Map<String, Object> pageData = new HashMap<>();
        pageData.put("currentPage", currentPage);
        pageData.put("total", total);
        pageData.put("keyword", keyword);
        pageData.put("startPage", ((currentPage - 1) / 10) * 10 + 1);
        pageData.put("endPage", Math.min(((currentPage - 1) / 10 + 1) * 10, (total + 9) / 10));
        pageData.put("prev", currentPage > 10);
        pageData.put("next", ((currentPage - 1) / 10 + 1) * 10 < (total + 9) / 10);
        
        model.addAttribute("list", itemList);
        model.addAttribute("data", pageData);
        
        return "item";
    }
    
    @GetMapping("/detail/{itemNo}")
    @ResponseBody
    public ResponseEntity<ItemVO> detail(@PathVariable int itemNo) {
        try {
            ItemVO item = itemService.detail(itemNo);
            log.info("상세 조회 결과: {}", item);
            if (item != null) {
                return ResponseEntity.ok(item);
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
            }
        } catch (Exception e) {
            log.error("품목 상세 조회 중 오류 발생", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }
    
    @PostMapping("/insert")
    @ResponseBody
    public ResponseEntity<Map<String, String>> insert(@RequestBody ItemVO itemVO) {
        Map<String, String> result = new HashMap<>();
        try {
            int res = itemService.insert(itemVO);
            result.put("result", res > 0 ? "success" : "fail");
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            log.error("품목 등록 중 오류 발생", e);
            result.put("result", "fail");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(result);
        }
    }
    
    @PostMapping("/update")
    @ResponseBody
    public ResponseEntity<Map<String, String>> update(@RequestBody ItemVO itemVO) {
        Map<String, String> result = new HashMap<>();
        try {
            int res = itemService.update(itemVO);
            result.put("result", res > 0 ? "success" : "fail");
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            log.error("품목 수정 중 오류 발생", e);
            result.put("result", "fail");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(result);
        }
    }
    
    @PostMapping("/delete/{itemNo}")
    @ResponseBody
    public ResponseEntity<Map<String, String>> delete(@PathVariable int itemNo) {
        Map<String, String> result = new HashMap<>();
        try {
            log.info("품목 삭제 요청 - 품목번호: {}", itemNo);
            int res = itemService.delete(itemNo);
            result.put("result", res > 0 ? "success" : "fail");
            log.info("품목 삭제 결과: {}", res);
            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            log.error("품목 삭제 중 오류 발생 - 품목번호: " + itemNo, e);
            result.put("result", "fail");
            return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    @PostMapping("/deleteItems")
    @ResponseBody
    public ResponseEntity<Map<String, String>> deleteItems(@RequestBody List<Integer> itemNos) {
        Map<String, String> result = new HashMap<>();
        try {
            log.info("품목 다중 삭제 요청 - 품목번호 목록: {}", itemNos);
            int successCount = 0;
            
            for (Integer itemNo : itemNos) {
                int res = itemService.delete(itemNo);
                if (res > 0) successCount++;
            }
            
            if (successCount == itemNos.size()) {
                result.put("status", "success");
                result.put("message", "선택한 품목이 모두 삭제되었습니다.");
            } else {
                result.put("status", "partial");
                result.put("message", String.format("%d개 중 %d개 삭제 성공", itemNos.size(), successCount));
            }
            
            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            log.error("품목 다중 삭제 중 오류 발생", e);
            result.put("status", "error");
            result.put("message", "삭제 처리 중 오류가 발생했습니다.");
            return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}

	/*
	// 품목 리스트 (비동기)
	골뱅이ResponseBody
	골뱅이PostMapping("/itemListAjax")
	public ArticlePage<ItemVO> listAjax(골뱅이RequestBody Map<String, Object> map){
		log.info("list -> map : " + map);
		
		int total = this.itemService.getTotal(map);
		log.info("list -> total : " + total);
		
		List<ItemVO> itemList = this.itemService.list(map);
		
		
		int currentPage = 1;
		
		if(map.get("currentPage") != null) {
			currentPage = Integer.parseInt(map.get("currentPage").toString());
		}
		
		String keyword = "";
	
		if(map.get("keyword") != null) {
			keyword = map.get("keyword").toString();
		}
		
		ArticlePage<ItemVO> articlePage = new ArticlePage<>(total, currentPage, 10, itemList, keyword, "ajax");
	
		return articlePage; 
	}
	*/
