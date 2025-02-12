package kr.or.ddit.selling.jc.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;
import java.util.stream.Collectors;

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.selling.jc.service.igmjSellingService;
import kr.or.ddit.vo.MenuVO;
import kr.or.ddit.vo.SchdVO;
import kr.or.ddit.vo.SellingVO;
import kr.or.ddit.vo.TBUserVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class gmjSellingController {
	
	@Autowired
	igmjSellingService sellService;
	
	@GetMapping("/gmj/gmj{storeNo}/selling")
	public String gmjSelling(@PathVariable int storeNo,Model model) {
		
		String name = this.sellService.selgmj(storeNo);
		log.info("가맹점 이름: "+name);
		List<SellingVO> year = this.sellService.getYear(storeNo);
		List<SellingVO> month = this.sellService.getMonth(storeNo);
		log.info("year: "+year);
		log.info("month: "+month);
		
		model.addAttribute("name",name);
		model.addAttribute("month",month);
		model.addAttribute("year",year);
		return "selling/gmjSelling";
	}
	
	@GetMapping("/gmj/gmj{storeNo}/sellingMenu")
	public String gmjsellingMenu(@PathVariable int storeNo,Model model) {
		
		String name = this.sellService.selgmj(storeNo);
		log.info("가맹점 이름: "+name);
		List<SellingVO> year = this.sellService.getYear(storeNo);
		List<SellingVO> month = this.sellService.getMonth(storeNo);
		log.info("year: "+year);
		log.info("month: "+month);
		
		model.addAttribute("name",name);
		model.addAttribute("month",month);
		model.addAttribute("year",year);
		return "selling/gmjSellingMenu";
	}
	
	
	@GetMapping("/gmj/gmj{storeNo}/sellingDate")
	public String gmjsellingDate(@PathVariable int storeNo,Model model) {
		
		String name = this.sellService.selgmj(storeNo);
		log.info("가맹점 이름: "+name);
		List<SellingVO> year = this.sellService.getYear(storeNo);
		List<SellingVO> month = this.sellService.getMonth(storeNo);
		log.info("year: "+year);
		log.info("month: "+month);
		
		model.addAttribute("name",name);
		model.addAttribute("month",month);
		model.addAttribute("year",year);
		return "selling/gmjSellingDate";
	}
	
	@GetMapping("/gmj/gmj{storeNo}/sellingInsert")
	public String gmjsellingInsert(@PathVariable int storeNo,Model model) {
		
		String name = this.sellService.selgmj(storeNo);
		log.info("가맹점 이름: "+name);
		List<SellingVO> year = this.sellService.getYear(storeNo);
		List<SellingVO> month = this.sellService.getMonth(storeNo);
		log.info("year: "+year);
		log.info("month: "+month);
		
		model.addAttribute("name",name);
		model.addAttribute("month",month);
		model.addAttribute("year",year);
		return "selling/gmjSellingInsert";
	}
	
	
	
	@GetMapping("/getmenu")
	@ResponseBody
	public Map<String, Object> getGraphData(@RequestParam Map<String, Object> map) {
	    List<SellingVO> sellingList = this.sellService.getAll(map);
	    log.info("메뉴별 매출 => "+sellingList);
	    // 메뉴별 판매량
	    Map<String, Integer> menuSales = new HashMap<>();
	    
		
	    for (SellingVO selling : sellingList) {
	        String menuName = selling.getMenuNm();
	        int amount = selling.getSellingAmount();
	        menuSales.put(menuName, menuSales.getOrDefault(menuName, 0) + amount);
	    }

	    return Map.of("labels", menuSales.keySet(), "data", menuSales.values());
	}
	
	@GetMapping("/getDate")
	@ResponseBody
	public Map<String, Object> getDate(@RequestParam int storeNo) {
		log.info("잘 들어왔?"+storeNo);
		
		List<SellingVO> year = this.sellService.getYear(storeNo);
		List<SellingVO> month = this.sellService.getMonth(storeNo);
		log.info("년"+year);
		log.info("월"+month);
		
		Map<String, Object> map = new HashMap<>();
		map.put("year", year);
		map.put("month", month);
		return map;
	   
	}
	
	@GetMapping("/getmargin")
	@ResponseBody
	public Map<String, Object> getMargin(@RequestParam Map<String, Object> map) {
	    log.info("마진 잘 들어옴?" + map);
	    List<SellingVO> margin = this.sellService.dateGraph(map);
	    List<SellingVO> budget = this.sellService.dateGraph2(map);
	    log.info("마진 리스트 잘 나와?" + margin);
	    log.info("예산 리스트 잘 나와?" + budget);

	    Map<String, Object> result = new HashMap<>();
	    List<String> labels = new ArrayList<>();
	    List<Long> data = new ArrayList<>();
	    List<Long> data2 = new ArrayList<>();


	    for (SellingVO vo : margin) {
            labels.add(vo.getMonthS());
            data.add(vo.getMonthlySales());
	    }
	    
	    for (SellingVO vo : budget) {
            data2.add(vo.getMonthlyYSales());
	    }

	    List<Long> profit = new ArrayList<>();
	    
		
	    for (int i = 0; i < data.size(); i++) {
	        long budgetValue = (i < data2.size()) ? data2.get(i) : 0;  
	        profit.add(data.get(i) - budgetValue);
	    }

		 
	    log.info("data:"+data);
	    log.info("data2:"+data2);
	    result.put("labels", labels);
	    result.put("data", data);
	    result.put("data2", data2);
	    result.put("profit", profit); 
	    
	    return result;
	}


	@GetMapping("/compareWithLast")
	@ResponseBody
	public Map<String, Object> compare(@RequestParam Map<String, Object> map) {
		
		List<SellingVO> compare = this.sellService.compareWithLast(map);
		log.info("작년비교:"+compare);
		Map<String, Object> result = new HashMap<>();
	    List<String> labels = new ArrayList<>();
	    List<Long> data = new ArrayList<>();
	    List<Long> data2 = new ArrayList<>();
	    List<Long> data3 = new ArrayList<>();
	    

	    for (SellingVO vo : compare) {
            labels.add(vo.getTm());
            data.add(vo.getLastYearSales());
            data2.add(vo.getThisYearSales());
            data3.add((long) vo.getGrowthRate());
	    }
	    log.info("작년 data"+data);
	    log.info("올해 data"+data2);
	    log.info("증감율 data"+data3);
	    
	    result.put("labels", labels);
	    result.put("data", data);
	    result.put("data2", data2);
	    result.put("data3", data3);
	    
		 
		return result;
		
	}
		
	
	@GetMapping("/bestSeller")
	@ResponseBody
	public List<SellingVO> bestSeller(@RequestParam Map<String, Object> map) {
		log.info("베스트셀러"+map);
		
		List<SellingVO> bestseller = this.sellService.bestsellerTop5(map);
		log.info("베스트셀러"+bestseller);
		
		return bestseller;
	   
	}
	
	@GetMapping("/bonsa/selling")
	public String bsSellingwr(Model model) {
		
		List<SellingVO> year = this.sellService.getBSYear();
		List<SellingVO> month = this.sellService.getBSMonth();
		List<SellingVO> store = this.sellService.storeNm();
		
		log.info("year: "+year);
		log.info("month: "+month);
		log.info("store: "+store);
		
		model.addAttribute("month",month);
		model.addAttribute("year",year);
		model.addAttribute("store",store);
		return "selling/bsSelling2";
	}
	
	@GetMapping("/bonsa/sellingMenu")
	public String bsSellingMenu(Model model) {
		
		List<SellingVO> year = this.sellService.getBSYear();
		List<SellingVO> month = this.sellService.getBSMonth();
		List<SellingVO> store = this.sellService.storeNm();
		
		log.info("year: "+year);
		log.info("month: "+month);
		log.info("store: "+store);
		
		model.addAttribute("month",month);
		model.addAttribute("year",year);
		model.addAttribute("store",store);
		return "selling/bsSellingMenu";
	}
	
	@GetMapping("/bonsa/sellingItem")
	public String bsSellingItem(Model model) {
		
		List<SellingVO> year = this.sellService.getBSYear();
		List<SellingVO> month = this.sellService.getBSMonth();
		List<SellingVO> store = this.sellService.storeNm();
		
		log.info("year: "+year);
		log.info("month: "+month);
		log.info("store: "+store);
		
		model.addAttribute("month",month);
		model.addAttribute("year",year);
		model.addAttribute("store",store);
		return "selling/bsSellingItem";
	}
	
	
	
	@GetMapping("/bonsa/sellingDate")
	public String bsSelling(Model model) {
		
		List<SellingVO> year = this.sellService.getBSYear();
		List<SellingVO> month = this.sellService.getBSMonth();
		List<SellingVO> store = this.sellService.storeNm();
		
		log.info("year: "+year);
		log.info("month: "+month);
		log.info("store: "+store);
		
		model.addAttribute("month",month);
		model.addAttribute("year",year);
		model.addAttribute("store",store);
		return "selling/bsSellingDate";
	}
	
	
	@GetMapping("/bonsa/sellingGMJ")
	public String bsSellingGMJ(Model model) {
		
		List<SellingVO> year = this.sellService.getBSYear();
		List<SellingVO> month = this.sellService.getBSMonth();
		List<SellingVO> store = this.sellService.storeNm();
		
		log.info("year: "+year);
		log.info("month: "+month);
		log.info("store: "+store);
		
		model.addAttribute("month",month);
		model.addAttribute("year",year);
		model.addAttribute("store",store);
		return "selling/bsSellingGMJ";
	}
	
	
	
	@PostMapping("/bonsa/getMenu")
	@ResponseBody
	public Map<String, Collection<? extends Object>> getMenu(@RequestBody Map<String, Object> map) {
		log.info("메뉴 요청 잘들어옴? "+map);
		
		List<SellingVO> menuList = this.sellService.bsMenu(map);
		log.info("메뉴별 판매량"+menuList);
	    // 메뉴별 판매량
	    Map<String, Integer> menuSales = new HashMap<>();
		
	    for (SellingVO selling : menuList) {
	        String menuName = selling.getMenuNm();
	        int amount = selling.getTotalMenu();
	        menuSales.put(menuName, menuSales.getOrDefault(menuName, 0) + amount);
	    }
	    log.info("menuSales"+menuSales);

	    return Map.of("labels", menuSales.keySet(), "data", menuSales.values());
	}
	
	
	@PostMapping("/bonsa/getItem")
	@ResponseBody
	public Map<String, Collection<? extends Object>> getItem(@RequestBody Map<String, Object> map) {
		log.info("품목 요청 잘들어옴? "+map);
		
		List<SellingVO> itemList = this.sellService.bsItem(map);
		log.info("품목별 판매량"+itemList);
		
		 Map<String, Integer> menuSales = new HashMap<>();
			
		    for (SellingVO selling : itemList) {
		        String menuName = selling.getItemNm();
		        int amount = selling.getTotalItem();
		        menuSales.put(menuName, menuSales.getOrDefault(menuName, 0) + amount);
		    }
		    log.info("menuSales"+menuSales);

		    return Map.of("labels", menuSales.keySet(), "data", menuSales.values());
	   
	}
	
	
	@PostMapping("/bonsa/getMargin")
	@ResponseBody
	public Map<String, Object> getbsMargin(@RequestBody Map<String, Object> map) {
	    log.info("본사 마진 요청 데이터: " + map);
	    List<SellingVO> margin = this.sellService.bsMargin(map);  // 매출 데이터
	    List<SellingVO> budget = this.sellService.bsBudget(map); // 예산 데이터

	    // 통합된 labels 생성
	    Set<String> labelSet = new TreeSet(); // TreeSet으로 정렬된 중복 없는 labels
	    for (SellingVO vo : margin) {
	        labelSet.add(vo.getMonthS());
	    }
	    for (SellingVO vo : budget) {
	        labelSet.add(vo.getMonthY());
	    }

	    List<String> labels = new ArrayList<>(labelSet);

	    // 매출과 예산 데이터를 labels에 맞게 매핑
	    Map<String, Long> salesMap = margin.stream()
	            .collect(Collectors.toMap(SellingVO::getMonthS, SellingVO::getMonthlySales));
	    Map<String, Long> budgetMap = budget.stream()
	            .collect(Collectors.toMap(SellingVO::getMonthY, SellingVO::getMonthlyYSales));

	    List<Long> data = new ArrayList<>();
	    List<Long> data2 = new ArrayList<>();
	    List<Integer> profit = new ArrayList<>();

	    for (String label : labels) {
	        long sales = salesMap.getOrDefault(label, 0L);
	        long budgetValue = budgetMap.getOrDefault(label, 0L);
	        data.add(sales);
	        data2.add(budgetValue);
	        profit.add((int) (sales - budgetValue)); // 총이익 계산
	    }

	    // 결과 생성
	    Map<String, Object> result = new HashMap<>();
	    result.put("labels", labels);
	    result.put("data", data);
	    result.put("data2", data2);
	    result.put("profit", profit);

	    log.info("결과 데이터: labels={}, data={}, data2={}, profit={}", labels, data, data2, profit);
	    return result;
	}

	
	@PostMapping("/bonsa/lastcompare")
	@ResponseBody
	public List<SellingVO> lastcompare(@RequestBody Map<String, Object> map) {
	    log.info("작년비교 요청 잘 들어옴? " + map);

	    List<SellingVO> marginList = this.sellService.bsMargin(map);  // 매출 데이터
	    List<SellingVO> budgetList = this.sellService.bsBudget(map); // 예산 데이터
	    List<SellingVO> lastList = this.sellService.lastcompare(map); // 작년 대비 데이터
	    
	    
	    List<SellingVO> tableVOList = this.sellService.getTable(map); // 본사 매출(매출,예산,작년 종합)
	    log.info("lastcompare->본사 매출(매출,예산,작년 종합) : " + tableVOList);

	    log.info("매출 데이터: " + marginList);
	    log.info("예산 데이터: " + budgetList);
	    log.info("작년 비교 판매량: " + lastList);

	    Set<String> labelSet = new TreeSet<>();
	    marginList.forEach(vo -> labelSet.add(vo.getMonthS()));
	    budgetList.forEach(vo -> labelSet.add(vo.getMonthY()));
	    lastList.forEach(vo -> labelSet.add(vo.getMonthS()));
	    
	    List<String> labels = new ArrayList<>(labelSet); 
	    List<Map<String, Object>> result = new ArrayList<>();
	    
	    
	    
	    for (String label : labels) {
	    	SellingVO marginSelect =new SellingVO();
	    	Map<String, Object> map1 = new HashMap<>();
	    	for (SellingVO margin : marginList) {
				if(margin.getMonthS().equals(label)) {
					marginSelect = margin;
					map1.put("date",marginSelect.getMonthS());
					map1.put("margin",marginSelect.getMonthlySales());
				}
				else {
					map1.put("margin",0);
				}
			}
//	    	result.add(map1);
	    	
	    	SellingVO lastSelect = new SellingVO();
	    	for (SellingVO last : lastList) {
				if(last.getMonthS().equals(label)) {
					lastSelect = last;
					map1.put("date",lastSelect.getMonthS());
					map1.put("growthRate",lastSelect.getGrowthRate());
				}
				else {
					map1.put("growthRate",0);
				}
			}
	    	
	    	
	    	SellingVO budgetSelect = new SellingVO();
	    	for (SellingVO budget : budgetList) {
				if(budget.getMonthY().equals(label)) {
					budgetSelect = budget;
					map1.put("date",budgetSelect.getMonthS());
					map1.put("budget",budgetSelect.getMonthlyYSales());
				}
				else {
					map1.put("budget",0);
				}
			}
	    	
	    	long profit = marginSelect.getMonthlySales()-budgetSelect.getMonthlyYSales();
	    	map1.put("profit", profit);
	    	
	    	result.add(map1);
	    	
	    	//System.out.println();
			
		}
	    
	    
	    return tableVOList;
	}
	
	
	
	@PostMapping("/bonsa/rankgmj")
	@ResponseBody
	public List<SellingVO> gmjrank(@RequestBody Map<String, Object> map) {
		
		List<SellingVO> ranking= this.sellService.gmjrank(map);
		
		return ranking;
		
	}
	

	@PostMapping("/bonsa/lastcompareyear")
	@ResponseBody
	public List<SellingVO> lastcompareyear(@RequestBody Map<String, Object> map) {
		log.info("작년비교 요청 잘들어옴? "+map);
		
		List<SellingVO> lastList = this.sellService.lastcompareyear(map);
		log.info("작년비교 판매량"+lastList);
		return lastList;
	   
	}
	
	@PostMapping("/compareWithLastyear")
	@ResponseBody
	public List<SellingVO> compareWithLastyear(@RequestBody Map<String, Object> map) {
		log.info("작년비교 요청 잘들어옴? "+map);
		
		List<SellingVO> lastList = this.sellService.compareWithLastyear(map);
		log.info("작년비교 판매량"+lastList);
		return lastList;
	   
	}
	
	@PostMapping("/bonsa/bestsellerItem")
	@ResponseBody
	public List<SellingVO> bsBestSeller(@RequestBody Map<String, Object> map) {
		log.info("베스트셀러 요청 잘들어옴? "+map);
		
		List<SellingVO>  bsBestSeller= this.sellService.bsBestSellerItemTop5(map);
		log.info("베스트셀러"+bsBestSeller);
		
		return bsBestSeller;
	   
	}
	
	
	@PostMapping("/bonsa/bestsellerMenu")
	@ResponseBody
	public List<SellingVO> bsBestSeller2(@RequestBody Map<String, Object> map) {
		log.info("베스트셀러 요청 잘들어옴? "+map);
		
		List<SellingVO>  bsBestSeller= this.sellService.bsBestSellerMenuTop5(map);
		log.info("베스트셀러"+bsBestSeller);
		
		return bsBestSeller;
	   
	}
	
	
	@GetMapping("/bonsa/bsGMJMargin")
	@ResponseBody
	public List<SellingVO> bsGMJMargin(@RequestParam Map<String, Object> map) {
		log.info("가맹점별 매출 요청 잘들어옴? "+map);
		
		List<SellingVO>  gmjMargin= this.sellService.bsGMJMargin(map);
		log.info("가맹점별 매출"+gmjMargin);
		
		return gmjMargin;
	   
	}
	
	@GetMapping("/menu")
	@ResponseBody
	public List<MenuVO> menu(@RequestParam Map<String, Object> map) {
		log.info("메뉴 요청 잘들어옴? "+map);
		
		List<MenuVO>  menuList= this.sellService.getMenu();
		log.info("메뉴: "+menuList);
		
		return menuList;
		
	}
	
	@PostMapping("/gmj/mchdr")
	@ResponseBody
	public SellingVO mchdr(@RequestBody SellingVO sellingVO) {
		/*
		매출 등록 요청 : 
		SellingVO(sellingNo=0, storeNo=1, sellingDate=null, 
		sellingTotal=9000, sellingDetailNo=0, menuNo=3, 
		sellingAmount=3, menuNm=null, menuPrice=0, ctgryNm=null, 
		storeNm=null, year=0, month=0, rank=0, totalAmount=0, 
		quarter=null, quarterlySales=0, monthlySales=0, 
		monthS=null, yearlySales=0, yearS=null, quarterY=null, 
		quarterlyYSales=0, monthlyYSales=0, monthY=null, 
		yearlyYSales=0, yearY=null, storeBudgetDate=null, 
		storeBudgetTy=0, lastYearSales=0, thisYearSales=0, 
		growthRate=0, tm=null, lm=null, salePrice=0, itemNo=0, 
		itemNm=null, itemPrice=0, totalItem=0, total=0, totalMenu=0)
		 */
		log.info("매출 등록 요청 : "+sellingVO);
		
		sellingVO = this.sellService.mchdr(sellingVO);
		//나갈때 : SellingVO(sellingNo=138, .., sellingDetailNo=227,..
		log.info("매출 등록 요청 -> result : "+sellingVO);
		
		return sellingVO;
		
	}
	
	@ResponseBody
	@PostMapping("/getTable2")
	public List<SellingVO> getTable2(@RequestBody Map<String, Object> map){
		List<SellingVO> tablelist= this.sellService.getTable2(map);
		
		return tablelist;
	}
	
	@GetMapping("/margin/download")
	public void excelDownload(@RequestParam("year") String year, 
			@RequestParam("type") int type, 
			@RequestParam(value="storeNo", required = false)Integer  storeNo, 
			HttpServletResponse response) throws IOException {
		log.info("매출표 출력:"+year);
	    Map<String, Object> map = new HashMap<>();
	    map.put("year", year);
	    
	    List<SellingVO> table = new ArrayList<>();
	    
	    if(type==1) {
	    	table = this.sellService.getTable(map);
	    }
	    else if(type==2) {
	    	map.put("storeNo", storeNo);
	    	table = this.sellService.getTable2(map);
	    }
	    
	    
	    Workbook wb = new XSSFWorkbook();
	    Sheet sheet = wb.createSheet("매출표");
	    
	    
	    Row yearRow = sheet.createRow(0);
	    Cell yearCell = yearRow.createCell(0);
	    yearCell.setCellValue(year + "년도 매출현황");
	    
	    Row headerRow = sheet.createRow(1);
	    String[] headers = {"날짜", "매출액", "예산 사용액", "총이익", "작년대비매출분석"};
	    
	    for (int i = 0; i < headers.length; i++) {
	        Cell cell = headerRow.createCell(i);
	        cell.setCellValue(headers[i]);
	    }
	    
	    for (int i = 0; i < table.size(); i++) {
	        Row row = sheet.createRow(i + 2);
	        SellingVO vo = table.get(i);
	        
	        Cell monthCell = row.createCell(0);
	        monthCell.setCellValue(vo.getMonthS());
	        
	        Cell salesCell = row.createCell(1);
	        salesCell.setCellValue(vo.getMonthlySales());
	        
	        Cell budgetCell = row.createCell(2);
	        budgetCell.setCellValue(vo.getMonthlyYSales());
	        
	        Cell profitCell = row.createCell(3);
	        profitCell.setCellValue(vo.getProfit());
	        
	        Cell growthCell = row.createCell(4);
	        growthCell.setCellValue(vo.getGrowthRate()+"%");
	    }
	    
	    for (int i = 0; i < headers.length; i++) {
	        sheet.autoSizeColumn(i);
	    }
	    
	    response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
	    response.setHeader("Content-Disposition", "attachment;filename=sales_" + year + ".xlsx");
	    
	    wb.write(response.getOutputStream());
	    wb.close();
	}

	
	

}
