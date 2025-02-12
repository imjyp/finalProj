package kr.or.ddit.bill.jy.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.Arrays;
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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.bill.jy.service.BillService;
import kr.or.ddit.order.jy.service.OrderService;
import kr.or.ddit.security.CustomUser;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.BillVO;
import kr.or.ddit.vo.StoreOrderDetailVO;
import kr.or.ddit.vo.StoreOrderVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class BillController {

	@Autowired
	BillService billService;
	
	@Autowired
	OrderService orderService;
	
	@GetMapping("/bonsa/bill")
	public String billPage() {
		
		return "bill/bonsaBill";
	}
	
	// 본사 계산 insert 및 발주 billNo update
	@ResponseBody
	@PostMapping("/bonsa/insertBill")
	public Map<String, Object> insertBill(@RequestBody BillVO billVO){
		log.info("insertBill -> billVO : " + billVO);
			
		Map<String, Object> map = new HashMap<>();
		
		int storeOrderNo = billVO.getStoreOrderNo();
		log.info("insertBill -> storeOrderNo : " + storeOrderNo);
		
		/* 계산 테이블에 insert */
		int result = this.billService.insertBill(billVO);
		log.info("insertBill -> result : " + result);
		
		if (result > 0) {
			 map.put("result", result);

			 // insert된 billNo
			 int billNo = billVO.getBillNo();
			 log.info("insertBill -> billNo : " + billNo);
			 map.put("billNo", billNo);
			 
			// 계산서 발행 버튼 클릭 시 발주 테이블에 billNo update
			int updateResult = this.orderService.updateBillNo(storeOrderNo, billNo);
			log.info("insertBill -> updateResult : " + updateResult);
			
			if(updateResult > 0) {
				map.put("updateResult", updateResult);
				
				// 발주 테이블 정보 가져오기
				StoreOrderVO storeOrderVO = orderService.getStoreOrder(storeOrderNo);
				log.info("insertBill -> storeOrderVO : " + storeOrderVO);
				
				if(storeOrderVO != null) {
					map.put("storeOrderNo", storeOrderNo);
					map.put("storeNo", storeOrderVO.getStoreNo());
					map.put("storeNm", storeOrderVO.getStoreNm());
					map.put("storeOrderDate", storeOrderVO.getStoreOrderDate());
					
				}
			
				 // jsp에서 사용할 List<StoreOrderDetailVO> selectedItems
				 List<StoreOrderDetailVO> selectedItems = orderService.orderDetailList(map);
				 log.info("insertBill -> selectedItems : " + selectedItems);
				 	
				 if(selectedItems != null && !selectedItems.isEmpty()) {
					 map.put("selectedItems", selectedItems);	
					 /*
						for(StoreOrderDetailVO storeOrderDetailVO : selectedItems) {
							storeOrderDetailVO.getItemNo();
							storeOrderDetailVO.getItemNm();
							storeOrderDetailVO.getStoreOrderAmount();
							storeOrderDetailVO.getStoreOrderPrice();
							storeOrderDetailVO.getStoreNo();
							
							log.info("insertBill -> storeOrderDetailVO :"  + storeOrderDetailVO);
					}
					*/
				}
			}else {
                map.put("updateResult", "fail");	// update 실패
            }
		}else {
			 map.put("result", result);	// insert 실패
		}
		return map;
	}
	
	// 본사 발주 반려
	@ResponseBody
	@PutMapping("/bonsa/updOS")
	public int updOS(@RequestBody List<StoreOrderVO> storeOrderList) {
		
		log.info("updOS -> storeOrderList : "+ storeOrderList);
		
		int result = 0;
	    for (StoreOrderVO storeOrderVO : storeOrderList) {
	        result += billService.updOS(storeOrderList);
	        log.info("updOS -> result : "+ result);
	    }
		
//		int result = this.billService.updOS(storeOrderList);
		
		return result;
	}
	
	// 본사 계산 update
	@ResponseBody
	@PutMapping("/bonsa/updateBill")
	public int updateBill(@ModelAttribute BillVO billVO, @RequestParam("uploadFiles") MultipartFile[] uploadFiles) {
		log.info("updateBill 체킁");
		
		log.info("updateBill -> billVO : " + billVO);
		
		/*
		int storeNo = 0;
		
		StoreOrderVO storeOrderVO = new StoreOrderVO();
		storeOrderVO.setStoreNo(storeNo);
		billVO.setStoreOrderVO(storeOrderVO);
		
		log.info("updateBill -> storeNo : " + storeNo);
		*/
		int result = this.billService.updateBill(billVO);
		log.info("updateBill -> result : " + result);
		
		return result;
	}
	
	// 본사 계산서 리스트
	@ResponseBody
	@PostMapping("/bonsa/billAjax")
	public ArticlePage<BillVO> billAjax(@RequestBody Map<String, Object> map){
		
		log.info("billAjax -> map : " + map);
		int total = this.billService.getTotal(map);
		
		List<BillVO> billList = this.billService.list(map);
		log.info("billAjax -> billList : " + billList);
		
		int currentPage = 1;

		if(map.get("currentPage") != null) {
			currentPage = Integer.parseInt(map.get("currentPage").toString());
		}
		
		String keyword= "";
		
		if(map.get("keyword") != null) {
			keyword = map.get("keyword").toString();
		}
		
		ArticlePage<BillVO> articlePage2 = new ArticlePage<>(total, currentPage, 10, billList, keyword, "ajax");
	
		return articlePage2;
	} 
	
	
	// 본사 계산서 detail
	@ResponseBody
	@PostMapping("/bonsa/billDetail")
	public Map<String, Object> billDetail(@RequestBody Map<String, Object> map) {
		
		log.info("billDetail -> map :" + map);
		
		Integer billNo = (Integer) map.get("billNo");
		
		BillVO billVO = this.billService.billDetail(map);
		log.info("billDetail -> billVO :" + billVO);
		
		int storeOrderNo = billVO.getStoreOrderVO().getStoreOrderNo(); 
		log.info("billDetail -> storeOrderNo : " + storeOrderNo);
		
		// 발주 테이블 정보 가져오기
		StoreOrderVO storeOrderVO = orderService.getStoreOrder(storeOrderNo);
		log.info("billDetail -> storeOrderVO : " + storeOrderVO);
		
		if(storeOrderVO != null) {
			map.put("storeOrderNo", storeOrderNo);
			map.put("storeNo", storeOrderVO.getStoreNo());
			map.put("storeNm", storeOrderVO.getStoreNm());
		}
		
		// jsp에서 사용할 List<StoreOrderDetailVO> selectedItems
		List<StoreOrderDetailVO> storeOrderDetails = orderService.orderDetailList(map);
		log.info("billDetail -> storeOrderDetails : " + storeOrderDetails);
		
		Map<String, Object> result = new HashMap<>();
		result.put("billVO", billVO);
		result.put("storeOrderDetails", storeOrderDetails);
		
		return result;
	}
	
	
	
	// 가맹점 계산서 발행 리스트
	@ResponseBody
	@PostMapping("/gmj/billAjax")
	public  ArticlePage<BillVO> gmjBillAjax(Authentication authentication, @RequestBody Map<String, Object> map){
		
		log.info("gmjBillAjax 체킁");
		
		authentication = SecurityContextHolder.getContext().getAuthentication();
		log.info("storeOrder -> authentication :"  + authentication);
		
		CustomUser user = (CustomUser) authentication.getPrincipal();
		log.info("storeOrder -> user :"  + user);
		
		Integer storeNo = user.getUserVO().getStoreNo();
		log.info("storeOrder -> storeNo :"  + storeNo);
		
		map.put("storeNo", storeNo);
		
		log.info("billAjax -> map : " + map);
		
		int total = this.billService.getgmjBTotal(map);
		
		List<BillVO> gmjBList = this.billService.gmjBList(map);
		log.info("gmjBillAjax -> gmjBList : " + gmjBList);
		
		int currentPage = 1;

		if(map.get("currentPage") != null) {
			currentPage = Integer.parseInt(map.get("currentPage").toString());
		}
		
		String keyword= "";
		
		if(map.get("keyword") != null) {
			keyword = map.get("keyword").toString();
		}
		
		ArticlePage<BillVO> articlePage2 = new ArticlePage<>(total, currentPage, 10, gmjBList, keyword, "ajax");
	
		return articlePage2;
	} 
	
	
	// 가맹점 계산서 detail
	@ResponseBody
	@PostMapping("/gmj/billDetail")
	public Map<String, Object> gmjBillDetail(Authentication authentication, @RequestBody Map<String, Object> map) {
		
		log.info("gmjBillDetail 체킁");
		
		authentication = SecurityContextHolder.getContext().getAuthentication();
		log.info("storeOrder -> authentication :"  + authentication);
		
		CustomUser user = (CustomUser) authentication.getPrincipal();
		log.info("storeOrder -> user :"  + user);
		
		Integer storeNo = user.getUserVO().getStoreNo();
		log.info("storeOrder -> storeNo :"  + storeNo);
		
		map.put("storeNo", storeNo);
		
		log.info("gmjBillDetail -> map :" + map);
		
		Integer billNo = (Integer) map.get("billNo");
		
		BillVO billVO = this.billService.gmjBillDetail(map);
		log.info("gmjBillDetail -> billVO :" + billVO);
		
		int storeOrderNo = billVO.getStoreOrderVO().getStoreOrderNo(); 
		log.info("gmjBillDetail -> storeOrderNo : " + storeOrderNo);
		
		// 발주 테이블 정보 가져오기
		StoreOrderVO storeOrderVO = orderService.getStoreOrder(storeOrderNo);
		log.info("gmjBillDetail -> storeOrderVO : " + storeOrderVO);
		
		if(storeOrderVO != null) {
			map.put("storeOrderNo", storeOrderNo);
			map.put("storeNo", storeOrderVO.getStoreNo());
			map.put("storeNm", storeOrderVO.getStoreNm());
		}
		
		// jsp에서 사용할 List<StoreOrderDetailVO> selectedItems
		List<StoreOrderDetailVO> storeOrderDetails = orderService.orderDetailList(map);
		log.info("gmjBillDetail -> storeOrderDetails : " + storeOrderDetails);
		
		Map<String, Object> result = new HashMap<>();
		result.put("billVO", billVO);
		result.put("storeOrderDetails", storeOrderDetails);
		
		return result;
	}
	
	// 계산서 엑셀 내보내기
	@PostMapping("/exl/download/bill")
    public void downloadExcelBill(
    		@RequestParam("billNo") int billNo,
            @RequestParam("storeNo") int storeNo,
            @RequestParam("storeNm") String storeNm,
            @RequestParam("storeOrderNo") int storeOrderNo,
            @RequestParam("billTitle") String billTitle,
            @RequestParam("storeOrderSum") int storeOrderSum, 
            @RequestParam("billDate") String billDate,
            @RequestParam("storeOrderDetailList") String storeOrderDetailListJson,
            HttpServletResponse response
    ) {
        // 1. 로그 
		System.out.println("downloadExcelBill -> billNo: " + billNo);
        System.out.println("downloadExcelBill -> storeNo: " + storeNo);
        System.out.println("downloadExcelBill -> storeNm: " + storeNm);
        System.out.println("downloadExcelBill -> storeOrderNo: " + storeOrderNo);
        System.out.println("downloadExcelBill -> billTitle: " + billTitle);
        System.out.println("downloadExcelBill -> storeOrderSum: " + storeOrderSum);
        System.out.println("downloadExcelBill -> billDate: " + billDate);
        System.out.println("downloadExcelBill -> storeOrderDetailListJson: " + storeOrderDetailListJson);

        // 2. JSON 문자열을 StoreOrderDetailVO 리스트로 변환
        ObjectMapper objectMapper = new ObjectMapper();
        List<StoreOrderDetailVO> detailList;
        try {
            StoreOrderDetailVO[] detailsArray = objectMapper.readValue(storeOrderDetailListJson, StoreOrderDetailVO[].class);
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
        storeOrder.setStoreOrderSum(storeOrderSum);
        storeOrder.setStoreOrderDetailList(detailList);

        // 4. BillVO 객체 생성 및 데이터 설정
        BillVO billVO = new BillVO();
        billVO.setBillNo(billNo);
        billVO.setBillDate(billDate);
        billVO.setBillTitle(billTitle);

        // 5. Apache POI를 사용하여 엑셀 워크북과 시트 생성
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("계산서");

        // 6. 스타일 설정
        // 제목
        CellStyle titleStyle = workbook.createCellStyle();
        Font titleFont = workbook.createFont();
        titleFont.setBold(true);
        titleFont.setFontHeightInPoints((short) 16);
        titleStyle.setFont(titleFont);
        titleStyle.setAlignment(HorizontalAlignment.CENTER);
        titleStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        setBorders(titleStyle, BorderStyle.THIN); 

        // 헤더 스타일
        CellStyle headerStyle = workbook.createCellStyle();
        Font headerFont = workbook.createFont();
        headerFont.setBold(true);
        headerStyle.setFont(headerFont);
        headerStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
        headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        headerStyle.setAlignment(HorizontalAlignment.CENTER);
        headerStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        setBorders(headerStyle, BorderStyle.THIN);

        // 데이터 스타일
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

        // 금액 스타일 (천 단위 콤마)
        CellStyle currencyStyle = workbook.createCellStyle();
        currencyStyle.setDataFormat(workbook.getCreationHelper().createDataFormat().getFormat("#,##0"));
        currencyStyle.setAlignment(HorizontalAlignment.RIGHT);
        currencyStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        setBorders(currencyStyle, BorderStyle.THIN);

        int rowNum = 0;

        // 7. 상단 제목 (병합 셀 A1:F1)
        Row titleRow = sheet.createRow(rowNum++);
        Cell titleCell = titleRow.createCell(0);
        titleCell.setCellValue("계산서");
        titleCell.setCellStyle(titleStyle);
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 5));

        // 빈 행 추가
        sheet.createRow(rowNum++);

        // 8. 계산서 기본 정보 제목 (병합 셀 A3:F3)
        Row basicInfoTitleRow = sheet.createRow(rowNum++);
        Cell basicInfoTitleCell = basicInfoTitleRow.createCell(0);
        basicInfoTitleCell.setCellValue("계산서 기본 정보");
        basicInfoTitleCell.setCellStyle(headerStyle);
        sheet.addMergedRegion(new CellRangeAddress(rowNum-1, rowNum-1, 0, 5));

        // 9. 계산서 번호 및 계산일 (A4:B4 병합, D4:E4 병합)
        Row basicInfoRow1 = sheet.createRow(rowNum++);

        // 계산서 번호 (A4:B4 병합)
        Cell cellA = basicInfoRow1.createCell(0);
        cellA.setCellValue("계산서 번호");
        cellA.setCellStyle(headerStyle);
        sheet.addMergedRegion(new CellRangeAddress(rowNum-1, rowNum-1, 0, 1));

        // 계산서 번호 값 (C4)
        Cell cellC = basicInfoRow1.createCell(2);
        cellC.setCellValue(billVO.getBillNo()); 
        cellC.setCellStyle(dataStyle);

        // 계산일 (D4:E4 병합)
        Cell cellD = basicInfoRow1.createCell(3);
        cellD.setCellValue("계산일");
        cellD.setCellStyle(headerStyle);
        sheet.addMergedRegion(new CellRangeAddress(rowNum-1, rowNum-1, 3, 4));

        // 계산일 값 (F4)
        Cell cellF = basicInfoRow1.createCell(5);
        if (billVO.getBillDate() != null && !billVO.getBillDate().isEmpty()) {
            cellF.setCellValue(billVO.getBillDate());
            cellF.setCellStyle(dataStyle);
        } else {
            cellF.setCellValue("-");
            cellF.setCellStyle(dataStyle);
        }

        // 10. 가맹점 번호 및 가맹점 이름 (A5:B5 병합, D5:E5 병합)
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

        // 11. 제목 (A6:F6 병합)
        Row basicInfoRow3 = sheet.createRow(rowNum++);
        Cell cellA3 = basicInfoRow3.createCell(0);
        cellA3.setCellValue("제목");
        cellA3.setCellStyle(headerStyle);
        sheet.addMergedRegion(new CellRangeAddress(rowNum-1, rowNum-1, 0, 5));

        Cell cellA3Value = basicInfoRow3.createCell(0);
        cellA3Value.setCellValue(billVO.getBillTitle());
        cellA3Value.setCellStyle(dataStyle);

        // 빈 행 추가
        sheet.createRow(rowNum++);

        // 12. 품목 상세 정보 제목 (병합 셀 A7:F7)
        Row detailInfoTitleRow = sheet.createRow(rowNum++);
        Cell detailInfoTitleCell = detailInfoTitleRow.createCell(0);
        detailInfoTitleCell.setCellValue("품목 상세 정보");
        detailInfoTitleCell.setCellStyle(headerStyle);
        sheet.addMergedRegion(new CellRangeAddress(rowNum-1, rowNum-1, 0, 5));

        // 13. 품목 상세 정보 테이블 헤더
        Row detailHeaderRow = sheet.createRow(rowNum++);
        String[] detailHeaders = {"발주 번호", "품목 번호", "품목 이름", "수량", "가격", "합계"};
        for (int i = 0; i < detailHeaders.length; i++) {
            Cell headerCell = detailHeaderRow.createCell(i);
            headerCell.setCellValue(detailHeaders[i]);
            headerCell.setCellStyle(headerStyle);
        }

        // 14. 품목 상세 정보 테이블 데이터
        double totalAmount = 0.0;
        int totalQuantity = 0;

        for (StoreOrderDetailVO detail : storeOrder.getStoreOrderDetailList()) {
            Row detailRow = sheet.createRow(rowNum++);
            Cell detailCell1 = detailRow.createCell(0);
            detailCell1.setCellValue(storeOrderNo); // 발주 번호는 storeOrderNo로 설정
            detailCell1.setCellStyle(dataStyle);

            Cell detailCell2 = detailRow.createCell(1);
            detailCell2.setCellValue(detail.getItemNo());
            detailCell2.setCellStyle(dataStyle);

            Cell detailCell3 = detailRow.createCell(2);
            detailCell3.setCellValue(detail.getItemNm());
            detailCell3.setCellStyle(dataStyle);

            Cell detailCell4 = detailRow.createCell(3);
            detailCell4.setCellValue(detail.getStoreOrderAmount());
            detailCell4.setCellStyle(dataStyle);

            Cell detailCell5 = detailRow.createCell(4);
            detailCell5.setCellValue(detail.getStoreOrderPrice());
            detailCell5.setCellStyle(currencyStyle);

            Cell detailCell6 = detailRow.createCell(5);
            double priceTotal = detail.getStoreOrderAmount() * detail.getStoreOrderPrice();
            detailCell6.setCellValue(priceTotal);
            detailCell6.setCellStyle(currencyStyle);

            totalAmount += priceTotal;
            totalQuantity += detail.getStoreOrderAmount();
        }

        // 15. 총 수량과 총 금액 (병합 셀 D9:F9)
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
        
        // 병합 (D9:F9)
        sheet.addMergedRegion(new CellRangeAddress(rowNum-1, rowNum-1, 3, 5));

        // 16. "CAFE@BEAN" 추가 (병합 셀 A10:F10)
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

        // 18. 응답 헤더 설정
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        String billDateStr = (billVO.getBillDate() != null && !billVO.getBillDate().isEmpty()) ? billVO.getBillDate() : "-";
        String fileName = billDateStr + "_" + storeNm + "_계산서.xlsx";
        try {
            String encodedFileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
            response.setHeader("Content-Disposition", "attachment; filename*=UTF-8''" + encodedFileName);
        } catch (Exception e) {
            e.printStackTrace();
            response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
        }

        // 19. 워크북을 응답 스트림에 작성
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
	
	/* 가맹점 발주/주문 현황 리스트
	골뱅이ResponseBody
	골뱅이PostMapping("/gmj/statusAjax")
	public ArticlePage<Map<String, Object>> gmjStatusAjax(Authentication authentication, @RequestBody Map<String, Object> map){
		
		log.info("gmjStatusAjax 체킁");
		
		authentication = SecurityContextHolder.getContext().getAuthentication();
		log.info("storeOrder -> authentication :"  + authentication);
		
		CustomUser user = (CustomUser) authentication.getPrincipal();
		log.info("storeOrder -> user :"  + user);
		
		Integer storeNo = user.getUserVO().getStoreNo();
		log.info("storeOrder -> storeNo :"  + storeNo);
		
		map.put("storeNo", storeNo);
		
		log.info("gmjStatusAjax -> map : " + map);
		
		int total = this.billService.getGmjSTotal(map);
		
		List<BillVO> gmjBillList = this.billService.gmjBList(map);
		log.info("gmjStatusAjax -> gmjBillList : " + gmjBillList);
		
		List<StoreOrderVO> gmjStoreOrderList = this.orderService.gmjOrderList(map);
		log.info("gmjStatusAjax -> gmjStoreOrderList : " + gmjStoreOrderList);
		
		
		List<Map<String, Object>> statusList = new ArrayList<>();
		
		for (BillVO billVO : gmjBillList) {
			Map<String, Object> statusMap = new HashMap<>();
			statusMap.put("type", "계산");
			statusMap.put("no", billVO.getBillNo());
			statusMap.put("title", billVO.getBillTitle());
			statusMap.put("storeNo", billVO.getStoreNo());
			statusMap.put("storeNm", billVO.getStoreNm());
			statusMap.put("date", billVO.getBillDate());
			statusMap.put("status", billVO.getBillStatus());
			
			statusList.add(statusMap);
			log.info("gmjStatusAjax -> billVO storeNo : " + billVO.getStoreNo());
			log.info("gmjStatusAjax -> billVO storeNm : " + billVO.getStoreNm());
			log.info("gmjStatusAjax -> billVO status : " + billVO.getBillStatus());
		}
		
		for (StoreOrderVO storeOrderVO : gmjStoreOrderList) {
			Map<String, Object> statusMap = new HashMap<>();
			statusMap.put("type", "발주");
			statusMap.put("no", storeOrderVO.getStoreOrderNo());
			statusMap.put("title", storeOrderVO.getStoreOrderTitle());
			statusMap.put("storeNo", storeOrderVO.getStoreNo());
			statusMap.put("storeNm", storeOrderVO.getStoreNm());
			statusMap.put("date", storeOrderVO.getStoreOrderDate());
			statusMap.put("status", storeOrderVO.getStoreOrderStatus());
			
			statusList.add(statusMap);
			
			log.info("gmjStatusAjax -> storeOrderVO storeNo : " + storeOrderVO.getStoreNo());
			log.info("gmjStatusAjax -> storeOrderVO storeNm : " + storeOrderVO.getStoreNm());
			
		}
		
		log.info("gmjStatusAjax -> statusList : " + statusList);
		
		
		// 최신순 정렬 (billDate 기준)
		statusList.sort((o1, o2) -> {
		    try {
		    	// 날짜 변환을 위한 포맷 설정
		    	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		    	
		        // string을 date로 변환
		        Date date1 = o1.get("date") != null ? dateFormat.parse(o1.get("date").toString()) : new Date(0); // null이면 가장 과거
		        Date date2 = o2.get("date") != null ? dateFormat.parse(o2.get("date").toString()) : new Date(0); // null이면 가장 과거
		        return date2.compareTo(date1); // 최신순
		    } catch (ParseException e) {
		        e.printStackTrace();
		        return 0; 
		    }
		});
		
		int currentPage = 1;
		
		if(map.get("currentPage") != null) {
			currentPage = Integer.parseInt(map.get("currentPage").toString());
		} 
		
		String keyword= "";
		
		if(map.get("keyword") != null) {
			keyword = map.get("keyword").toString();
		}
		
		ArticlePage<Map<String, Object>> articlePage = new ArticlePage<>(total, currentPage, 10, statusList , keyword, "ajax");
		
		
		/* 10개씩 페이지 처리 but 토탈이랑 statusList.size() 매치 불가로 코드 수정 필요
		int itemPage = 10;	// 한 페이지당 항목 표시 수
		
		int currentPage = 1;
		
		if(map.get("currentPage") != null) {
			currentPage = Integer.parseInt(map.get("currentPage").toString());
		} else {
			currentPage = 1;
		}
		
		int start = (currentPage - 1) * itemPage;
		int end = Math.min(start + itemPage, statusList.size());
		
		log.info("statusAjax -> statusList.size() : " + statusList.size());
		
		List<Map<String, Object>> pageList = new ArrayList<>();
		
		if(start < statusList.size()) {
			pageList = statusList.subList(start, end);
		} else {
			pageList = new ArrayList<>();
		}
		
		map.put("pageList", pageList);
		
		log.info("statusAjax -> pageList : " + pageList);
		
		String keyword= "";
		
		if(map.get("keyword") != null) {
			keyword = map.get("keyword").toString();
		}
		
		ArticlePage<Map<String, Object>> articlePage = new ArticlePage<>(total, currentPage, itemPage, pageList, keyword, "ajax");
		
		
	
		return articlePage;
	}
	 */
}
