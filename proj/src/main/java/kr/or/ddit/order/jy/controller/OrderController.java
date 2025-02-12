package kr.or.ddit.order.jy.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.item.jy.service.ItemService;
import kr.or.ddit.order.jy.service.OrderService;
import kr.or.ddit.security.CustomUser;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.ItemVO;
import kr.or.ddit.vo.StoreOrderDetailVO;
import kr.or.ddit.vo.StoreOrderVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class OrderController {

	@Autowired
	ItemService itemService;
	
	@Autowired
	OrderService orderService;
	
	
	// 가맹점 발주 페이지
	@GetMapping("/gmj/order")
	public String storeOrder(Authentication authentication, Model model) {
		authentication = SecurityContextHolder.getContext().getAuthentication();
		log.info("storeOrder -> authentication :"  + authentication);
		
		CustomUser user = (CustomUser) authentication.getPrincipal();
	    log.info("storeOrderPage -> user : " + user);
	    
		Integer storeNo = user.getUserVO().getStoreNo();
		log.info("storeOrder -> storeNo :"  + storeNo);
		
	    model.addAttribute("user", user);
	    
		return "order/storeOrder";
	}
	
	// 가맹점 발주 시 품목리스트(발주/주문)
	@ResponseBody
	@PostMapping("/gmj/orderAjax")
	public ArticlePage<ItemVO> storeOrder(Authentication authentication
									, @RequestBody Map<String, Object> map){
		
		authentication = SecurityContextHolder.getContext().getAuthentication();
		log.info("storeOrder -> authentication :"  + authentication);
		
		CustomUser user = (CustomUser) authentication.getPrincipal();
		log.info("storeOrder -> user :"  + user);
		
		Integer storeNo = user.getUserVO().getStoreNo();
		log.info("storeOrder -> storeNo :"  + storeNo);
		
		
		log.info("gmj -> map : " + map);
		int total = this.itemService.getTotal(map);
		
		List<ItemVO> itemList = this.itemService.list(map);
		log.info("gmj -> itemList : " + itemList);
		
		
		int currentPage = 1;

		if(map.get("currentPage") != null) {
			currentPage = Integer.parseInt(map.get("currentPage").toString());
		}
		
		String keyword= "";
		
		if(map.get("keyword") != null) {
			keyword = map.get("keyword").toString();
		}
		
		ArticlePage<ItemVO> articlePage = new ArticlePage<>(total, currentPage, 10, itemList, keyword, "");
	
		return articlePage;
		
	}
	
	// 가맹점 발주
	////selectedItems data : ["3","5","16", "28","13"]
	@ResponseBody
	@PostMapping("/gmj/insertOrder")
	public Map<String, Object> insertOrder(Authentication authentication
							, StoreOrderVO storeOrderVO) {
		/*
		StoreOrderVO(storeOrderStatus=0, storeOrderSum=0, billNo=0, storeOrderTitle=null, storeOrderNo=0, 
		storeNo=0, storeOrderDate=null, fileGroupNo=0, 
		selectedItems=[
			ItemVO(itemNo=3, itemNm=null, itemPrice=0, salePrice=0, storeNo=0, storeOrderNo=0), 
			ItemVO(itemNo=5, itemNm=null, itemPrice=0, salePrice=0, storeNo=0, storeOrderNo=0), 
			ItemVO(itemNo=16, itemNm=null, itemPrice=0, salePrice=0, storeNo=0, storeOrderNo=0), 
			ItemVO(itemNo=28, itemNm=null, itemPrice=0, salePrice=0, storeNo=0, storeOrderNo=0), 
			ItemVO(itemNo=13, itemNm=null, itemPrice=0, salePrice=0, storeNo=0, storeOrderNo=0)
		], 
		storeOrderDetailList=null, storeNm=null, totalPrice=0, uploadFiles=null, fileGroupVO=null, 
		rnum=0)
		 */
		log.info("insertOrder->storeOrderVO : " + storeOrderVO);
		
		authentication = SecurityContextHolder.getContext().getAuthentication();
		log.info("insertOrder -> authentication :"  + authentication);
		
		CustomUser user = (CustomUser) authentication.getPrincipal();
		log.info("insertOrder -> user :"  + user);
		
		Integer storeNo = user.getUserVO().getStoreNo();
		String storeNm = user.getUserVO().getStoreNm();
		//storeNo :1
		log.info("insertOrder -> storeNo :"  + storeNo);
		//storeNm :삼성관점
		log.info("insertOrder -> storeNm :"  + storeNm);
		
		storeOrderVO.setStoreNo(storeNo);
		storeOrderVO.setStoreNm(storeNm);
		
		Map<String, Object> map = new HashMap<>();
		/*
		StoreOrderVO(storeOrderStatus=0, storeOrderSum=0, billNo=0, storeOrderTitle=null, 
		storeOrderNo=0, storeNo=1, storeOrderDate=null, fileGroupNo=0, 
		selectedItems=[
			ItemVO(itemNo=3, itemNm=null, itemPrice=0, salePrice=0, storeNo=0, storeOrderNo=0), 
			ItemVO(itemNo=5, itemNm=null, itemPrice=0, salePrice=0, storeNo=0, storeOrderNo=0), 
			ItemVO(itemNo=16, itemNm=null, itemPrice=0, salePrice=0, storeNo=0, storeOrderNo=0), 
			ItemVO(itemNo=28, itemNm=null, itemPrice=0, salePrice=0, storeNo=0, storeOrderNo=0), 
			ItemVO(itemNo=13, itemNm=null, itemPrice=0, salePrice=0, storeNo=0, storeOrderNo=0)], 
		storeOrderDetailList=null, storeNm=삼성관점, totalPrice=0, uploadFiles=null, fileGroupVO=null, 
		rnum=0)
		 */
		log.info("insertOrder -> storeOrderVO :"  + storeOrderVO);
		
		// 발주 버튼 클릭 시 발주서 테이블에 insert
		int result = this.orderService.insertOrder(storeOrderVO);
		log.info("insertOrder -> result :"  + result);
		
		if(result > 0) {
			int storeOrderNo = storeOrderVO.getStoreOrderNo();
			//storeOrderNo :299
			log.info("insertOrder -> storeOrderNo :"  + storeOrderNo);
			
//			String storeOrderDate = storeOrderVO.getStoreOrderDate();
			//storeOrderDate :null
//			log.info("insertOrder -> storeOrderDate :"  + storeOrderDate);
			
			/*
			StoreOrderVO(storeOrderStatus=0, storeOrderSum=0, billNo=0, storeOrderTitle=null, 
			storeOrderNo=0, storeNo=1, storeOrderDate=null, fileGroupNo=0, 
			selectedItems=[
				ItemVO(itemNo=3, itemNm=null, itemPrice=0, salePrice=0, storeNo=0, storeOrderNo=0), 
				ItemVO(itemNo=5, itemNm=null, itemPrice=0, salePrice=0, storeNo=0, storeOrderNo=0), 
				ItemVO(itemNo=16, itemNm=null, itemPrice=0, salePrice=0, storeNo=0, storeOrderNo=0), 
				ItemVO(itemNo=28, itemNm=null, itemPrice=0, salePrice=0, storeNo=0, storeOrderNo=0), 
				ItemVO(itemNo=13, itemNm=null, itemPrice=0, salePrice=0, storeNo=0, storeOrderNo=0)], 
			storeOrderDetailList=null, storeNm=삼성관점, totalPrice=0, uploadFiles=null, fileGroupVO=null, 
			rnum=0)
			 */
			List<ItemVO> selectedItems = storeOrderVO.getSelectedItems();
			List<Integer> items = new ArrayList<Integer>();
			
			boolean insertODResult = true;
			
			if(selectedItems != null && !selectedItems.isEmpty()) {
				for(ItemVO itemVO : selectedItems) {
					items.add(itemVO.getItemNo());//번외*** : 3,5,16,28,13
				}
			}
			
			//jsp에서 사용할 List<ItemVO> selectedItems
			List<ItemVO> selectedItems2 = this.itemService.selectedItems(items);
			log.info("insertOrdr->selectedItems2 : " + selectedItems2);
			
			//itemNm, itemPrice, salePrice를 채우자
			selectedItems = selectedItems2;
			
			if(selectedItems != null && !selectedItems.isEmpty()) {
				for(ItemVO itemVO : selectedItems) {
					StoreOrderDetailVO storeOrderDetailVO = new StoreOrderDetailVO();
					//storeOrderNo :299
					storeOrderDetailVO.setStoreOrderNo(storeOrderNo);//ok
					storeOrderDetailVO.setItemNo(itemVO.getItemNo());//ok
					storeOrderDetailVO.setItemNm(itemVO.getItemNm());
					storeOrderDetailVO.setItemPrice(itemVO.getItemPrice());
					storeOrderDetailVO.setSalePrice(itemVO.getSalePrice());
					//3,5,16,28,13
					log.info("insertOrder -> itemNo :"  + itemVO.getItemNo());
					
					// 발주 버튼 클릭 시 발주 상세 테이블에 insert
					int itemResult = orderService.insertOD(storeOrderDetailVO);
					log.info("insertOrder -> itemResult :"  + itemResult);
					
					if(itemResult <= 0) {
						insertODResult = false;
						break;
					}
				}
			}
			
			map.put("storeNo", storeNo); //storeNo :1
			map.put("storeNm", storeNm);  //삼성관점
			map.put("storeOrderNo", storeOrderNo);//storeOrderNo :299	
//			map.put("storeOrderDate", storeOrderDate);//null
			map.put("selectedItems", selectedItems);//List<ItemVO> selectedItems

			map.put("orderResult", result);	//1
			map.put("insertDetailResult", insertODResult);	//1
			
			
		}else {
			map.put("orderResult", result);
			map.put("insertDetailResult", false);
		}
		
		return map;
	}
	
	// 가맹점 발주 상세 업데이트
	@ResponseBody
	@PostMapping("/gmj/updateOD")
	public int updateOD(@RequestBody List<StoreOrderDetailVO> storeOrderDetailList) {
		/*
		[
			StoreOrderDetailVO(storeOrderNo=67, itemNo=4, storeOrderAmount=2, storeOrderPrice=24000, selectedItems=null, runm=0, itemNm=null
			, itemPrice=0, salePrice=0, storeNo=null), 
			StoreOrderDetailVO(storeOrderNo=67, itemNo=5, storeOrderAmount=1, storeOrderPrice=12000, selectedItems=null, runm=0, itemNm=null, 
			itemPrice=0, salePrice=0, storeNo=null)
		]
		
		BEGIN 
		UPDATE STORE_ORDER_DETAIL SET STORE_ORDER_AMOUNT = 2, STORE_ORDER_PRICE = 24000 WHERE STORE_ORDER_NO = 67 AND ITEM_NO = 4 
		UPDATE STORE_ORDER_DETAIL SET STORE_ORDER_AMOUNT = 1, STORE_ORDER_PRICE = 12000 WHERE STORE_ORDER_NO = 67 AND ITEM_NO = 5 
		END
		 */
		log.info("updateOD -> storeOrderDetailList :" + storeOrderDetailList);
		
		int result = this.orderService.updateOD(storeOrderDetailList);
		log.info("updateOD -> result :" + result);
		
		return result;
	}
	
	// 가맹점 발주 업데이트
	//formData.append('uploadFiles', file); => <input type="file" name="uploadFiles"..
	@ResponseBody
	@PutMapping("/gmj/updateOrder")
	public int updateOrder(Authentication authentication, StoreOrderVO storeOrderVO
			, MultipartFile[] uploadFiles) {
		log.info("updateOrder 체킁");
		/*
		 StoreOrderVO(storeOrderNo=159, storeNo=1, storeOrderDate=2025-01-15, fileGroupNo=0, storeOrderStatus=0, 
		 storeOrderSum=200000, selectedItems=null, storeOrderDetailList=null, totalPrice=0, 
		 uploadFiles=[org.springframework.web.multipart.support.StandardMultipartHttpServletRequest$StandardMultipartFile@50e05bcc], 
		 fileGroupVO=null)
		 */
		log.info("updateOrder -> storeOrderVO :" + storeOrderVO);
		log.info("uploadFiles: {}", Arrays.toString(uploadFiles));
		
		authentication = SecurityContextHolder.getContext().getAuthentication();
		log.info("updateOrder -> authentication :"  + authentication);
		
		CustomUser user = (CustomUser) authentication.getPrincipal();
		Integer storeNo = user.getUserVO().getStoreNo();
		log.info("updateOrder -> user :" + user);
		
		int storeOrderNo = storeOrderVO.getStoreOrderNo();
		int checkNo = orderService.checkNo(storeOrderNo);
		log.info("updateOrder -> checkNo :" + checkNo);
		
		log.info("updateOrder -> storeNo :" + storeNo);
		
		/*  총 금액
		int totalPrice = 0;
		
		for(StoreOrderDetailVO storeOrderDetailVO : storeOrderVO.getStoreOrderDetailList()) {
			totalPrice += storeOrderDetailVO.getStoreOrderPrice() * storeOrderDetailVO.getStoreOrderAmount();
			log.info("updateOrder -> storeOrderDetailVO :" + storeOrderDetailVO);
		    }
		
		storeOrderVO.setStoreOrderSum(totalPrice);
		*/
		
		int result = this.orderService.updateOrder(storeOrderVO);
		log.info("updateOrder -> result :" + result);
		
		return result;
	}
	
	/* 가맹점별 발주 내역 조회 */
	@ResponseBody
	@PostMapping("/gmj/orderList")
	public ArticlePage<StoreOrderVO> orderList(Authentication authentication, @RequestBody Map<String, Object> map){
		log.info("orderList 체킁");
		
		authentication = SecurityContextHolder.getContext().getAuthentication();
		log.info("storeOrder -> authentication :"  + authentication);
		
		CustomUser user = (CustomUser) authentication.getPrincipal();
		log.info("storeOrder -> user :"  + user);
		
		Integer storeNo = user.getUserVO().getStoreNo();
		log.info("storeOrder -> storeNo :"  + storeNo);
		
		map.put("storeNo", storeNo);
		
		log.info("orderList ->  map : " + map);
		
		
		int total = this.orderService.getGmjOtotal(map);
		log.info("orderList ->  total : " + total);
		
		List<StoreOrderVO> storeOrderList = this.orderService.gmjOrderList(map);
		log.info("orderList ->  storeOrderList : " + storeOrderList);
		
		int currentPage = 1;
		if(map.get("currentPage") != null) {
			currentPage = Integer.parseInt(map.get("currentPage").toString());
		}
		
		String keyword = "";
		if(map.get("keyword") != null) {
			keyword = map.get("keyword").toString();
		}
		
		ArticlePage<StoreOrderVO> articlePage = new ArticlePage<>(total, currentPage, 10, storeOrderList, keyword, "");
		
		return articlePage;

	}
	
	// 가맹점별 발주 상세 조회
	@ResponseBody
	@PostMapping("/gmj/orderDetail")
	public Map<String, Object> gmjODList(@RequestBody Map<String, Object> map) {
		log.info("체킁 gmjODList");
		
		Integer storeOrderNo = (Integer) map.get("storeOrderNo");
		log.info("gmjODList -> storeOrderNo : " + storeOrderNo);
		
		map.put("storeOrderNo", storeOrderNo);
		
		List<StoreOrderDetailVO> storeOrderDetailVO = orderService.orderDetailList(map);
		log.info("gmjODList -> storeOrderDetailVO : " + storeOrderDetailVO);
		
		
		// 발주 테이블 정보 가져오기
		StoreOrderVO storeOrderVO = orderService.getStoreOrder(storeOrderNo);
		log.info("gmjODList -> storeOrderVO : " + storeOrderVO);
		
		if(storeOrderVO != null) {
			map.put("storeOrderNo", storeOrderNo);
			map.put("storeNo", storeOrderVO.getStoreNo());
			map.put("storeNm", storeOrderVO.getStoreNm());
		}
		
		Map<String, Object> result = new HashMap<>();
		result.put("storeOrderVO", storeOrderVO);
		result.put("storeOrderDetailVO", storeOrderDetailVO);
		
		return result;
		
	}
	
	/* 가맹점 재발주
	@ResponseBody
	@PutMapping("/gmj/reorder")
	public int reorder(Authentication authentication, StoreOrderVO storeOrderVO , MultipartFile[] uploadFiles) {
		
		log.info("reorder 체킁");
		
		log.info("updateOrder -> storeOrderVO :" + storeOrderVO);
		log.info("uploadFiles: {}", Arrays.toString(uploadFiles));
		
		authentication = SecurityContextHolder.getContext().getAuthentication();
		log.info("updateOrder -> authentication :"  + authentication);
		
		CustomUser user = (CustomUser) authentication.getPrincipal();
		Integer storeNo = user.getUserVO().getStoreNo();
		log.info("updateOrder -> user :" + user);
		
		int result = this.orderService.reorder(storeOrderVO);
		
		return result;
	}
	*/
	
	// 가맹점 발주 회수
	@ResponseBody
	@PutMapping("/gmj/cancelOrder")
	public int cancelOrder(@RequestBody List<StoreOrderVO> storeOrderList) {
		
		log.info("cancelOrder -> storeOrderList : "+ storeOrderList);
		
		int result = 0;
	    for (StoreOrderVO storeOrderVO : storeOrderList) {
	        result += orderService.cancelOrder(storeOrderList);
	        log.info("cancelOrder -> result : "+ result);
	    }
		
//		int result = this.billService.updOS(storeOrderList);
		
		return result;
	}
	
	// 가맹점 발주 현황
	@ResponseBody
	@PostMapping("/gmj/statusAjax")
	public List<StoreOrderVO> gmjStatusAjax(Authentication authentication, @RequestBody StoreOrderVO storeOrderVO){

		log.info("gmjStatusAjax 체킁");
		log.info("gmjStatusAjax -> storeOrderVO : " + storeOrderVO);
		
		authentication = SecurityContextHolder.getContext().getAuthentication();
		log.info("gmjStatusAjax -> authentication :"  + authentication);
		
		CustomUser user = (CustomUser) authentication.getPrincipal();
		log.info("gmjStatusAjax -> user :"  + user);
		
		Integer storeNo = user.getUserVO().getStoreNo();
		log.info("gmjStatusAjax -> storeNo :"  + storeNo);
		
		// 가맹점 번호 설정
	    storeOrderVO.setStoreNo(storeNo);
		
		List<StoreOrderVO> statusList = this.orderService.gmjStatusAjax(storeOrderVO);
		log.info("gmjStatusAjax -> statusList :"  + statusList);
		
		return statusList;
		
	}
	
	// 본사 발주/주문 관리 리스트
	@GetMapping("/bonsa/order")
	public String bonsaOrder() {
		return "bill/bonsaBill";
	}
	
	// 본사 발주/주문 리스트
	@ResponseBody
	@PostMapping("/bonsa/orderAjax")
	public ArticlePage<StoreOrderVO> bonsaOrderList(@RequestBody Map<String, Object> map) {
		
		log.info("bonsaOrderList -> map : " + map);
		
		int total = orderService.getOTotal(map);
		log.info("bonsaOrderList -> total : " + total);
		
		List<StoreOrderVO> storeOrderVO = orderService.orderList(map);
		log.info("bonsaOrderList -> storeOrderVO : " + storeOrderVO);
		
		int currentPage = 1;
				
		if(map.get("currentPage") != null) {
			currentPage = Integer.parseInt(map.get("currentPage").toString());
		}
		
		String keyword = "";
		
		if(map.get("keyword") != null) {
			keyword = map.get("keyword").toString();
		}
		
		ArticlePage<StoreOrderVO> articlePage = new ArticlePage<StoreOrderVO>(total, currentPage, 10, storeOrderVO, keyword, "");
		
		return articlePage;
	}
	
	// 본사 발주 상세 조회
	@ResponseBody
	@PostMapping("/bonsa/orderDetail")
	public Map<String, Object> orderDetailList(@RequestBody Map<String, Object> map) {
		log.info("체킁 orderDetailList");
		
		Integer storeOrderNo = (Integer) map.get("storeOrderNo");
		log.info("bonsaOrderList -> storeOrderNo : " + storeOrderNo);
		
		map.put("storeOrderNo", storeOrderNo);
		
		List<StoreOrderDetailVO> storeOrderDetailVO = orderService.orderDetailList(map);
		log.info("bonsaOrderList -> storeOrderDetailVO : " + storeOrderDetailVO);
		
		// 발주 테이블 정보 가져오기
				StoreOrderVO storeOrderVO = orderService.getStoreOrder(storeOrderNo);
				log.info("gmjODList -> storeOrderVO : " + storeOrderVO);
				
				if(storeOrderVO != null) {
					map.put("storeOrderNo", storeOrderNo);
					map.put("storeNo", storeOrderVO.getStoreNo());
					map.put("storeNm", storeOrderVO.getStoreNm());
				}
				
				Map<String, Object> result = new HashMap<>();
				result.put("storeOrderVO", storeOrderVO);
				result.put("storeOrderDetailVO", storeOrderDetailVO);
				
		return result;
	}
	
	// 본사 발주 현황
	@ResponseBody
	@PostMapping("/bonsa/statusAjax")
	public List<StoreOrderVO> statusAjax(@RequestBody StoreOrderVO storeOrderVO){

		log.info("statusAjax 체킁");
		
		List<StoreOrderVO> statusList = this.orderService.statusAjax(storeOrderVO);
		log.info("statusAjax -> statusList :"  + statusList);
		
		return statusList;
		
	}
	
	// 발주서 엑셀 내보내기
	@PostMapping("/exl/download")
    public void downloadExcel(
            @RequestParam("storeNo") int storeNo,
            @RequestParam("storeNm") String storeNm,
            @RequestParam("storeOrderNo") int storeOrderNo,
            @RequestParam("storeOrderTitle") String storeOrderTitle,
            @RequestParam("storeOrderSum") int storeOrderSum, 
            @RequestParam("storeOrderDate") String storeOrderDate,
            @RequestParam("storeOrderDetailList") String storeOrderDetailList,
            HttpServletResponse response
    		) {
        // 1. 로그 
        System.out.println("downloadExcel -> storeNo: " + storeNo);
        System.out.println("downloadExcel -> storeNm: " + storeNm);
        System.out.println("downloadExcel -> storeOrderNo: " + storeOrderNo);
        System.out.println("downloadExcel -> storeOrderTitle: " + storeOrderTitle);
        System.out.println("downloadExcel -> storeOrderSum: " + storeOrderSum);
        System.out.println("downloadExcel -> storeOrderDate: " + storeOrderDate);
        System.out.println("downloadExcel -> storeOrderDetailList: " + storeOrderDetailList);
        
        // 2. JSON 문자열을 StoreOrderDetailVO 리스트로 변환
        ObjectMapper objectMapper = new ObjectMapper();
        List<StoreOrderDetailVO> detailList = null;
        try {
            StoreOrderDetailVO[] detailsArray = objectMapper.readValue(storeOrderDetailList, StoreOrderDetailVO[].class);
            detailList = Arrays.asList(detailsArray);
        } catch (IOException e) {
            e.printStackTrace();
            try {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "발주 상세 정보 파싱 실패");
            } catch (IOException ioException) {
                ioException.printStackTrace();
            }
            return;
        }

        // 3. StoreOrderVO 객체 생성 및 데이터 설정
        StoreOrderVO storeOrder = new StoreOrderVO();
        storeOrder.setStoreNo(storeNo);
        storeOrder.setStoreNm(storeNm);
        storeOrder.setStoreOrderNo(storeOrderNo);
        storeOrder.setStoreOrderTitle(storeOrderTitle);
        storeOrder.setStoreOrderSum(storeOrderSum);
        storeOrder.setStoreOrderDate(storeOrderDate);
        storeOrder.setStoreOrderDetailList(detailList);

        // 4. Apache POI를 사용하여 엑셀 워크북과 시트 생성
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("발주서");

        // 5. 스타일 설정
        // 5.1. 제목 스타일
        CellStyle titleStyle = workbook.createCellStyle();
        Font titleFont = workbook.createFont();
        titleFont.setBold(true);
        titleFont.setFontHeightInPoints((short) 16);
        titleStyle.setFont(titleFont);
        titleStyle.setAlignment(HorizontalAlignment.CENTER);
        titleStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        setBorders(titleStyle, BorderStyle.THIN); 

        // 5.2. 헤더 스타일
        CellStyle headerStyle = workbook.createCellStyle();
        Font headerFont = workbook.createFont();
        headerFont.setBold(true);
        headerStyle.setFont(headerFont);
        headerStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
        headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        headerStyle.setAlignment(HorizontalAlignment.CENTER);
        headerStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        setBorders(headerStyle, BorderStyle.THIN);

        // 5.3. 데이터 셀 스타일
        CellStyle dataStyle = workbook.createCellStyle();
        dataStyle.setAlignment(HorizontalAlignment.CENTER);
        dataStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        dataStyle.setBorderBottom(BorderStyle.THIN);
        dataStyle.setBorderTop(BorderStyle.THIN);
        dataStyle.setBorderLeft(BorderStyle.THIN);
        dataStyle.setBorderRight(BorderStyle.THIN);

        // 폰트 설정
        Font dataFont = workbook.createFont();
        dataFont.setFontName("Arial");
        dataFont.setFontHeightInPoints((short) 12);
        dataStyle.setFont(dataFont);
        
        // 5.4. 날짜 스타일
        CellStyle dateStyle = workbook.createCellStyle();
        CreationHelper createHelper = workbook.getCreationHelper();
        dateStyle.setDataFormat(createHelper.createDataFormat().getFormat("yyyy-MM-dd"));
        dateStyle.setAlignment(HorizontalAlignment.CENTER);
        dateStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        setBorders(dateStyle, BorderStyle.THIN);
        
        // 5.5. 금액 포맷 스타일 (천 단위 콤마)
        CellStyle currencyStyle = workbook.createCellStyle();
        currencyStyle.setDataFormat(createHelper.createDataFormat().getFormat("#,##0"));
        currencyStyle.setAlignment(HorizontalAlignment.RIGHT);
        currencyStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        setBorders(currencyStyle, BorderStyle.THIN);

        int rowNum = 0;

        // 6. 상단 제목 (병합 셀)
        Row titleRow = sheet.createRow(rowNum++);
        Cell titleCell = titleRow.createCell(0);
        titleCell.setCellValue("발주서");
        titleCell.setCellStyle(titleStyle);
        // 셀 병합 (A1:F1)
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 5));

        // 빈 행 추가
        rowNum++;

        // 7. 발주 기본 정보 제목 (병합 셀 A3:F3)
        Row basicInfoTitleRow = sheet.createRow(rowNum++);
        Cell basicInfoTitleCell = basicInfoTitleRow.createCell(0);
        basicInfoTitleCell.setCellValue("발주 기본 정보");
        basicInfoTitleCell.setCellStyle(headerStyle);
        sheet.addMergedRegion(new CellRangeAddress(rowNum-1, rowNum-1, 0, 5));

        // 8. 발주 번호 및 발주일 (A4:B4 병합, D4:E4 병합)
        Row basicInfoRow1 = sheet.createRow(rowNum++);
        
        // 발주 번호 (A4:B4 병합)
        Cell cellA = basicInfoRow1.createCell(0);
        cellA.setCellValue("발주 번호");
        cellA.setCellStyle(headerStyle);
        sheet.addMergedRegion(new CellRangeAddress(rowNum-1, rowNum-1, 0, 1));
        
        // 발주 번호 값 (C4)
        Cell cellC = basicInfoRow1.createCell(2);
        cellC.setCellValue(storeOrder.getStoreOrderNo());
        cellC.setCellStyle(dataStyle);
        
        // 발주일 (D4:E4 병합)
        Cell cellD = basicInfoRow1.createCell(3);
        cellD.setCellValue("발주일");
        cellD.setCellStyle(headerStyle);
        sheet.addMergedRegion(new CellRangeAddress(rowNum-1, rowNum-1, 3, 4));
        
        // 발주일 값 (F4)
        Cell cellF = basicInfoRow1.createCell(5);
        String dateStr = storeOrder.getStoreOrderDate();
        if (dateStr != null && !dateStr.isEmpty()) {
            cellF.setCellValue(dateStr); // 문자열로 설정
            cellF.setCellStyle(dataStyle);
        } else {
            cellF.setCellValue("-");
            cellF.setCellStyle(dataStyle);
        }

        // 9. 가맹점 번호 및 가맹점 이름 (A5:B5 병합, D5:E5 병합)
        Row basicInfoRow2 = sheet.createRow(rowNum++);
        
        // 가맹점 번호 (A5:B5 병합)
        Cell cellA2 = basicInfoRow2.createCell(0);
        cellA2.setCellValue("가맹점 번호");
        cellA2.setCellStyle(headerStyle);
        sheet.addMergedRegion(new CellRangeAddress(rowNum-1, rowNum-1, 0, 1));
        
        // 가맹점 번호 값 (C5)
        Cell cellC2 = basicInfoRow2.createCell(2);
        cellC2.setCellValue(storeOrder.getStoreNo());
        cellC2.setCellStyle(dataStyle);
        
        // 가맹점 이름 (D5:E5 병합)
        Cell cellD2 = basicInfoRow2.createCell(3);
        cellD2.setCellValue("가맹점 이름");
        cellD2.setCellStyle(headerStyle);
        sheet.addMergedRegion(new CellRangeAddress(rowNum-1, rowNum-1, 3, 4));
        
        // 가맹점 이름 값 (F5)
        Cell cellF2 = basicInfoRow2.createCell(5);
        cellF2.setCellValue(storeOrder.getStoreNm());
        cellF2.setCellStyle(dataStyle);
        
        // 10. 발주 기본 정보 (제목)
        Row basicInfoRow3 = sheet.createRow(rowNum++);
        Cell cell9 = basicInfoRow3.createCell(0);
        cell9.setCellValue("제목");
        cell9.setCellStyle(headerStyle);
       
        // 셀 병합 (B3:F3)
        sheet.addMergedRegion(new CellRangeAddress(rowNum-1, rowNum-1, 1, 5));
        
        Cell cell10 = basicInfoRow3.createCell(1);
        cell10.setCellValue(storeOrder.getStoreOrderTitle());
        cell10.setCellStyle(dataStyle);

        // 빈 행 추가
        rowNum++;

        // 11. 품목 상세 정보 제목 (병합 셀)
        Row detailInfoTitleRow = sheet.createRow(rowNum++);
        Cell detailInfoTitleCell = detailInfoTitleRow.createCell(0);
        detailInfoTitleCell.setCellValue("품목 상세 정보");
        detailInfoTitleCell.setCellStyle(headerStyle);
        sheet.addMergedRegion(new CellRangeAddress(rowNum-1, rowNum-1, 0, 5));

        // 12. 품목 상세 정보 테이블 헤더
        Row detailHeaderRow = sheet.createRow(rowNum++);
        String[] detailHeaders = {"품목 번호", "품목 이름", "원가", "판매가", "수량", "가격"};
        for (int i = 0; i < detailHeaders.length; i++) {
            Cell headerCell = detailHeaderRow.createCell(i);
            headerCell.setCellValue(detailHeaders[i]);
            headerCell.setCellStyle(headerStyle);
        }

        // 13. 품목 상세 정보 테이블 데이터
        double totalAmount = 0.0;
        int totalQuantity = 0;

        for (StoreOrderDetailVO detail : storeOrder.getStoreOrderDetailList()) {
            Row detailRow = sheet.createRow(rowNum++);
            Cell detailCell1 = detailRow.createCell(0);
            detailCell1.setCellValue(detail.getItemNo());
            detailCell1.setCellStyle(dataStyle);

            Cell detailCell2 = detailRow.createCell(1);
            detailCell2.setCellValue(detail.getItemNm());
            detailCell2.setCellStyle(dataStyle);

            Cell detailCell3 = detailRow.createCell(2);
            detailCell3.setCellValue(detail.getStoreOrderPrice()); 
            detailCell3.setCellStyle(currencyStyle);

            Cell detailCell4 = detailRow.createCell(3);
            detailCell4.setCellValue(detail.getStoreOrderPrice()); 
            detailCell4.setCellStyle(currencyStyle);

            Cell detailCell5 = detailRow.createCell(4);
            detailCell5.setCellValue(detail.getStoreOrderAmount());
            detailCell5.setCellStyle(dataStyle);

            Cell detailCell6 = detailRow.createCell(5);
            double priceTotal = detail.getStoreOrderAmount() * detail.getStoreOrderPrice();
            detailCell6.setCellValue(priceTotal);
            detailCell6.setCellStyle(currencyStyle);

            totalAmount += priceTotal;
            totalQuantity += detail.getStoreOrderAmount();
        }

        // 14. 총 수량과 총 금액
        Row totalRowExcel = sheet.createRow(rowNum++);
        Cell totalLabelCell1 = totalRowExcel.createCell(0);
        totalLabelCell1.setCellValue("총 수량");
        totalLabelCell1.setCellStyle(headerStyle);
        Cell totalValueCell1 = totalRowExcel.createCell(1);
        totalValueCell1.setCellValue(totalQuantity);
        totalValueCell1.setCellStyle(dataStyle);

        Cell totalLabelCell2 = totalRowExcel.createCell(2);
        totalLabelCell2.setCellValue("총 금액");
        totalLabelCell2.setCellStyle(headerStyle);
        Cell totalValueCell2 = totalRowExcel.createCell(3);
        totalValueCell2.setCellValue(totalAmount);
        totalValueCell2.setCellStyle(currencyStyle);

        // 셀 병합 (D4:F4)
        sheet.addMergedRegion(new CellRangeAddress(rowNum-1, rowNum-1, 3, 5));

        // 15. "CAFE@BEAN" 추가 (맨 아래 병합 셀)
        Row footerRow = sheet.createRow(rowNum++);
        Cell footerCell = footerRow.createCell(0);
        footerCell.setCellValue("CAFE@BEAN");
        CellStyle footerStyle = workbook.createCellStyle();
        Font footerFont = workbook.createFont();
        footerFont.setBold(true);
        footerStyle.setFont(footerFont);
        footerStyle.setAlignment(HorizontalAlignment.CENTER);
        footerStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        setBorders(footerStyle, BorderStyle.THIN);
        sheet.addMergedRegion(new CellRangeAddress(rowNum-1, rowNum-1, 0, 5));
        footerCell.setCellStyle(footerStyle);

        // 16. 열 너비 자동 조정 및 확대
        for (int i = 0; i < 6; i++) { // 총 6개의 열
            sheet.setColumnWidth(i, 20 * 256); // 20 characters wide
        }

        // 17. 응답 헤더 설정
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        String storeOrderDateStr = "-";
        if (storeOrder.getStoreOrderDate() != null && !storeOrder.getStoreOrderDate().isEmpty()) {
            storeOrderDateStr = storeOrder.getStoreOrderDate();
        }
        String fileName = storeOrderDateStr + "_" + storeNm + "_발주서.xlsx";
        try {
            String encodedFileName = java.net.URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
            response.setHeader("Content-Disposition", "attachment; filename*=UTF-8''" + encodedFileName);
        } catch (Exception e) {
            e.printStackTrace();
            response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
        }

        // 18. 워크북을 응답 스트림에 작성
        try (ServletOutputStream out = response.getOutputStream()) {
            workbook.write(out);
            workbook.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // 셀에 경계선 추가 유틸리티 메서드
    private void setBorders(CellStyle style, BorderStyle borderStyle) {
        style.setBorderBottom(borderStyle);
        style.setBorderTop(borderStyle);
        style.setBorderLeft(borderStyle);
        style.setBorderRight(borderStyle);
    	}
	}	
		/* 가맹점 - 품목/견적/계산/발주 리스트 조회 (동기)
		@GetMapping("/gmj{storeNo}/order")
		public String storeOrder(
			@PathVariable int storeNo,
			@RequestParam(value = "tab", required = false, defaultValue = "item") String tab,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
			@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
			Model model) {
		log.info("tab: {}", tab);
		Map<String, Object> map = new HashMap<>();
		log.info("storeOrder -> map : " + map);
		
		log.info("storeOrder -> tab: {}", tab);
		
		map.put("currentPage", currentPage);
		map.put("keyword", keyword);
		map.put("storeNo", storeNo);
		map.put("tab", tab);
		
		log.info("storeOrder->map : " + map);
		
		List<ItemVO> itemList = this.itemService.list(map);
		log.info("storeOrder -> itemList : " + itemList);
		
		int total = this.orderService.getTotal(map);
		log.info("storeOrder -> total : " + total);
		
		ArticlePage<ItemVO> articlePage1 =
				new ArticlePage<>(total, currentPage, 10, itemList, keyword);
		
		model.addAttribute("itemList", itemList);
		model.addAttribute("articlePage1", articlePage1);
		String orderTab = 
		
		model.addAttribute("orderTab", orderTab);
		model.addAttribute("estimateTab", estimateTab);
		model.addAttribute("orderTab", orderTab);
		List<EstimateVO> estimateList = this.orderService.estimateList(map);
		log.info("storeOrder -> estimateList : " + estimateList);
		
		int Etotal = this.orderService.getETotal(map);
		log.info("storeOrder -> total : " + total);
		
		
		ArticlePage<EstimateVO> articlePage2 = new ArticlePage<>(total, currentPage, 10, estimateList, keyword);
		
		model.addAttribute("estimateList", estimateList);
		model.addAttribute("articlePage2", articlePage2);
		
		log.info("storeOrder -> articlePage2 : " + articlePage2);
		
		//String returnStr = "";
		
			
			log.info("storeOrder -> articlePage1 : " + articlePage1);
			
		//	returnStr = "order/storeOrder";
			
			
		// 견적(estimate) tab
		}else if("estimate".equals(tab)) {
			
			
		//	returnStr = "order/storeOrder";
		
		// 계산(bill) tab
		}else if("bill".equals(tab)) {
			List<BillVO> billList = this.orderService.billList(map);
			log.info("storeOrder -> billList : " + billList);
			
			int total = this.orderService.getBTotal(map);
			log.info("storeOrder -> total : " + total);
			
			
			ArticlePage<BillVO> articlePage3 = new ArticlePage<>(total, currentPage, 10, billList, keyword);
			
			model.addAttribute("billList", billList);
			model.addAttribute("articlePage3", articlePage3);
			
			log.info("storeOrder -> articlePage3 : " + articlePage3);
			
		//	returnStr = "order/storeOrder";
		
		// 발주/주문 관리 리스트
		}else {
			
		}
		return "order/storeOrder";
		}
		*/
		

	/* 가맹점 - 품목 리스트 조회 (비동기)
	@ResponseBody
	@PostMapping("/gmj/itemListAjax")
	public ArticlePage<ItemVO> itemListAjax(@RequestBody Map<String, Object> map) {
		
		log.info("itemListAjax -> map : " + map);
//		log.info("itemList -> storeNo : " + storeNo);
//		map.put("storeNo", storeNo);
		
//		map.put("currentPage", 1);
//		map.put("keyword", "");
		
		int total = itemService.getTotal(map);
		log.info("itemListAjax -> total : " + total);
		
		List<ItemVO> itemList = itemService.list(map);
		log.info("itemListAjax -> itemList : " + itemList);
		
		int currentPage = 1;
				
		if(map.get("currentPage") != null) {
			currentPage = Integer.parseInt(map.get("currentPage").toString());
		}
		
		String keyword = "";
		
		if(map.get("keyword") != null) {
			keyword = map.get("keyword").toString();
		}
		
		ArticlePage<ItemVO> articlePage = new ArticlePage<>(total, currentPage, 10, itemList, keyword, "");
		
//		model.addAttribute("total", total);
//		model.addAttribute("itemList", itemList);
//		model.addAttribute("currentPage", 1);
		
		return articlePage;
	}
	*/
	
	
