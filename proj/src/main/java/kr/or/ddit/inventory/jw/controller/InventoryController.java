package kr.or.ddit.inventory.jw.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.gmjregister.jc.service.GmjService;
import kr.or.ddit.inventory.jw.service.InventoryService;
import kr.or.ddit.inventory.jw.vo.InventoryVO;
import kr.or.ddit.sanction.jw.vo.SanctionVO;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.BillVO;
import kr.or.ddit.vo.ItemVO;
import kr.or.ddit.vo.StoreVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/inventory")
public class InventoryController {
	
	@Autowired
	InventoryService inventoryService;
	
	@Autowired
    GmjService gmjService;
	
	@GetMapping("/list")//재고현황 목록
	public String list(@RequestParam(value="currentPage", required=false, defaultValue="1")int currentPage,
			@RequestParam(value="keyword", required=false, defaultValue="")String keyword) {
		return "inventory/list";
	}
	
	@ResponseBody
	@PostMapping("/inventoryListAjax")//재고현황 목록 비동기
	public ArticlePage<ItemVO> inventoryListAjax(@RequestBody Map<String, Object> map, 	Model model) {
		
		
		//map: {currentPage=1, keyword=}
		log.info("pendingListAjax->map: "+map);
		
		//keyword로 검색된 전체 데이터의 행수 가져오기
		int total = this.inventoryService.inventoryTotal(map);
		//total 값 들어왔는지 확인
		log.info("pendingListAjax-mysancTotal: "+total);
		
		int currentPage = 1;
		//currentPage 값이 변하면 값 업데이트해주기
		if(map.get("currentPage") != null) {
			currentPage = Integer.parseInt(map.get("currentPage").toString());
			
		}
		
		String keyword = "";
		if(map.get("keyword") != null) {
			keyword = map.get("keyword").toString();
		}
		
		// SanctionDocVO에 결재문서 데이터 가져오기
		//map: {currentPage=1, keyword=}
		List<ItemVO> itemVO = this.inventoryService.inventoryList(map);
		log.info("pendingListAjax-SanctionDocVO : "+itemVO);
		
		//페이지네이션
		ArticlePage<ItemVO> articlePage = 
				new ArticlePage<ItemVO>(total, currentPage, 10, itemVO, keyword,"ajax");
		log.info("pendingListAjax-articlePage"+articlePage);
		
		
		return articlePage;
	}
	@ResponseBody
	@PostMapping("/inventoryDetailAjax")//재고현황 상세 목록 비동기
	public ArticlePage<InventoryVO> inventoryDetailAjax(@RequestBody Map<String, Object> map, Model model) {
		
		
		//map: {currentPage=1, keyword=}
		log.info("inventoryDetailAjax->map: "+map);
		
		//keyword로 검색된 전체 데이터의 행수 가져오기
		int total = this.inventoryService.inventoryDetailTotal(map);
		//total 값 들어왔는지 확인
		log.info("inventoryDetailAjax-mysancTotal: "+total);
		
		int currentPage = 1;
		//currentPage 값이 변하면 값 업데이트해주기
		if(map.get("currentPage") != null) {
			currentPage = Integer.parseInt(map.get("currentPage").toString());
			
		}
		
		String keyword = "";
		if(map.get("keyword") != null) {
			keyword = map.get("keyword").toString();
		}
		
		// SanctionDocVO에 결재문서 데이터 가져오기
		//map: {currentPage=1, keyword=}
		List<InventoryVO> inventoryVO = this.inventoryService.inventoryDetailList(map);
		log.info("inventoryDetailAjax-SanctionDocVO : "+inventoryVO);
		
		//페이지네이션(1 : 첫번째 모달)
		ArticlePage<InventoryVO> articlePage = 
				new ArticlePage<InventoryVO>(total, currentPage, 10, inventoryVO, keyword,"ajax",1);
		log.info("inventoryDetailAjax-articlePage"+articlePage);
		
		
		return articlePage;
	}
	
	@ResponseBody
	@PostMapping("/inventoryOutgoingAjax")//출고현황 상세 목록 비동기
	public ArticlePage<InventoryVO> inventoryOutgoingAjax(@RequestBody Map<String, Object> map, Model model) {
		
		
		//map: {currentPage=1, keyword=}
		log.info("inventoryDetailAjax->map: "+map);
		
		//keyword로 검색된 전체 데이터의 행수 가져오기
		int total = this.inventoryService.inventoryOutgoingTotal(map);
		//total 값 들어왔는지 확인
		log.info("inventoryDetailAjax-mysancTotal: "+total);
		
		int currentPage = 1;
		//currentPage 값이 변하면 값 업데이트해주기
		if(map.get("currentPage") != null) {
			currentPage = Integer.parseInt(map.get("currentPage").toString());
			
		}
		
		String keyword = "";
		if(map.get("keyword") != null) {
			keyword = map.get("keyword").toString();
		}
		
		// SanctionDocVO에 결재문서 데이터 가져오기
		//map: {currentPage=1, keyword=}
		List<InventoryVO> inventoryVO = this.inventoryService.inventoryOutgoingList(map);
		log.info("inventoryDetailAjax-SanctionDocVO : "+inventoryVO);
		
		//페이지네이션(1 : 첫번째 모달)
		ArticlePage<InventoryVO> articlePage = 
				new ArticlePage<InventoryVO>(total, currentPage, 10, inventoryVO, keyword,"ajax",2);
		log.info("inventoryDetailAjax-articlePage"+articlePage);
		
		
		return articlePage;
	}
	@ResponseBody
	@GetMapping("/getItemAjax")//재고현황 상세 목록 비동기
	public List<ItemVO> getItemAjax() {
		
		
		
		//map: {currentPage=1, keyword=}
		List<ItemVO> itemVO = this.inventoryService.getItem();
		log.info("inventoryDetailAjax-itemVO : "+itemVO);
		
		
		
		
		return itemVO;
	}
	@ResponseBody
	@PostMapping("/create")//재고 등록 비동기
	public int create(@RequestBody List<InventoryVO> map) {
		
		log.info("create-map: "+map);
		
		
		// SanctionDocVO에 결재문서 데이터 가져오기
		//map: {currentPage=1, keyword=}
		int result = this.inventoryService.create(map);
		log.info("create-result : "+result);
		
		
		
		
		return result;
	}
	
	/**/
	@ResponseBody
	@PostMapping("/updateSafetyAmount")//재고 등록 비동기
	public int updateSafetyAmount(@RequestBody List<ItemVO> map) {
		
		log.info("create-map: "+map);
		
		
		// SanctionDocVO에 결재문서 데이터 가져오기
		//map: {currentPage=1, keyword=}
		int result = this.inventoryService.updateSafetyAmount(map);
		log.info("updateSafetyAmount-result : "+result);
		
		
		
		
		return result;
	}
	
	
	
	@GetMapping("/gmjGR")
    public String gmjRegister(Model model) {
    	
    	List<StoreVO> best = this.gmjService.bestGMJ();
    	int storeNextNo = this.gmjService.gmjdrno();
    	model.addAttribute("best",best);
    	model.addAttribute("storeNextNo",storeNextNo);
    	log.info("best:"+best);
        return "inventory/gmjItem";
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
	
	/*@ResponseBody
	@PostMapping("/outcomingList")
	public ArticlePage<InventoryVO> outcomingList(@RequestBody Map<String, Object> map){
		
		log.info("outcomingList -> map : " + map);
		
		int total = this.inventoryService.getTotal(map);
		log.info("outcomingList -> total : " + total);
		
		List<InventoryVO> outcomingList = this.inventoryService.outcomingList(map);
		log.info("outcomingList -> outcomingList : " + outcomingList);
		
		int currentPage = 1;
		
		if(map.get("currentPage") != null) {
			currentPage = Integer.parseInt(map.get("currentPage").toString());
		}
		
		String keyword = "";
		
		if(map.get("keyword") != null) {
			keyword = map.get("keyword").toString();
		}
		
		ArticlePage<InventoryVO> articlePage = new ArticlePage<>(total, currentPage, 10, outcomingList, keyword, "ajax");
		
		return articlePage;
		
	}*/
}
