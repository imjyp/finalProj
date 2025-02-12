package kr.or.ddit.mypage.jc.controller;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.mypage.jc.service.iMypageService;
import kr.or.ddit.util.UploadController;
import kr.or.ddit.vo.SalaryVO;
import kr.or.ddit.vo.SchdVO;
import kr.or.ddit.vo.TBUserVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MypageController {
	@Autowired
	iMypageService mypage;
	
	@Autowired
	UserDetailsService user; 
	
	@Autowired
	UploadController controller;

	@GetMapping("/mypage")
	public String alertPage(Model model) {
		
		/*
		 * Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		 * String userNo = auth.getName(); log.info("peopleSearch -> userNo : " +
		 * userNo); TBUserVO profile =this.mypage.profile(userNo); log.info("프로필 : " +
		 * profile); model.addAttribute("profile",profile);
		 */
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userNo = auth.getName();
		List<SalaryVO> salaryList =this.mypage.salary(userNo);
		log.info("마페"+salaryList);
		
		model.addAttribute("salaryList",salaryList);
		
		return "mypage";
	}
	
	@ResponseBody
	@PostMapping("/start")
	public int start(@RequestBody Map<String, Object> map) {
		log.info("출근??"+map);
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
   	 	String userNo = auth.getName();
		log.info("peopleSearch -> userNo : " + userNo);
		map.put("userNo", userNo);
		LocalDate currentDate = LocalDate.now();
	    LocalTime currentTime = LocalTime.now();
	    map.put("schdulDate", currentDate.format(DateTimeFormatter.ofPattern("yyyy/MM/dd"))); // 날짜
	    map.put("attend", currentTime.format(DateTimeFormatter.ofPattern("HH:mm:ss"))); // 시간

		int result=0;
		int result2=0;
		
		int cnt = this.mypage.chk(map);
		if(cnt==0) {
			result = this.mypage.start(map);
			result2 = this.mypage.updateStatus(map);
		}
		
		return result;
	}
	
	
	@ResponseBody
	@PostMapping("/end")
	public int end(@RequestBody Map<String, Object> map) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
   	 	String userNo = auth.getName();
   	 	map.put("userNo", userNo);
		log.info("퇴근??"+map);
		LocalDate currentDate = LocalDate.now();
	    LocalTime currentTime = LocalTime.now();
	    map.put("schdulDate", currentDate.format(DateTimeFormatter.ofPattern("yyyy/MM/dd"))); // 날짜
	    map.put("attend", currentTime.format(DateTimeFormatter.ofPattern("HH:mm:ss"))); // 시간
		int result = this.mypage.start(map);
		return result;
	}
	
	@ResponseBody
	@PostMapping("/list")
	public List<SchdVO> list(@RequestBody Map<String, Object> map) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
   	 	String userNo = auth.getName();
   	 	map.put("userNo", userNo);
   	 	log.info("리스트map"+map);
   	 	
   	 	List<SchdVO> schList = this.mypage.workinglist(map);
   	 	log.info("리스트"+schList);
		return schList;
	}
	
	
	@ResponseBody
	@PostMapping("/udpateProfile")
	public int udpateProfile( @RequestParam(value = "userProfile", required = false) MultipartFile[] userProfile,
	        @RequestParam(value = "userSign", required = false) MultipartFile[] userSign,
            				@RequestParam("userData") String data) throws JsonMappingException, JsonProcessingException {
		//udpateProfile->userProfile : null
		log.info("udpateProfile->userProfile : " + userProfile);
		//udpateProfile->userSign : [Lorg.springfr
		log.info("udpateProfile->userSign : " + userSign);
		
		if(userSign!=null) {
			//udpateProfile->userSign[0].getOriginalFilename() : 도장.png
			log.info("udpateProfile->userSign[0].getOriginalFilename() : " + userSign[0].getOriginalFilename());
		}
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
   	 	String userNo = auth.getName();
   	 	
   	 	log.info("auth:"+auth);
   	 	ObjectMapper objectMapper = new ObjectMapper();
   	 	Map<String, Object> userData = objectMapper.readValue(data, Map.class);
   	 	
	   	 long fileGroupNo = 0L;
	     long fileGroupNo2 = 0L;
	   	 if (userProfile != null && userProfile[0].getOriginalFilename().length() > 0) {
	         fileGroupNo = this.controller.multiImageUpload(userProfile);
	     }
	     if (userSign != null && userSign[0].getOriginalFilename().length() > 0) {
	         fileGroupNo2 = this.controller.multiImageUpload(userSign);
	     }
   	 	Map<String, Object> map = new HashMap<>();
   	 	map.put("userNo", userNo);
   	 	map.put("fileGroupNo", fileGroupNo);
   	 	map.put("fileGroupNo2", fileGroupNo2);
   	 	map.putAll(userData);
   	 	/*
   	 	 map{userNm=감부장, userNo=a999, fileGroupNo2=0, userPhone=01011111111, 
   	 	 userMail=, userAddr2=104-502, userBirth=2025-01-22, 
   	 	 userAddr1=서울 관악구 국회단지11길 4, userZip=08713, fileGroupNo=0}
   	 	 */
   	 	log.info("프로필 수정 : "+map);
   	 	
   	 	int result = this.mypage.udpateProfile(map);
   	 	log.info("수정? "+result);
   	 	
   	 	
   	 	if(result > 0) {
   	 	
	   		UserDetails updatedUser = user.loadUserByUsername(userNo);  
	        Authentication oldAuth = SecurityContextHolder.getContext().getAuthentication();
	
	        UsernamePasswordAuthenticationToken newAuth =
	                new UsernamePasswordAuthenticationToken(
	                        updatedUser, 
	                        oldAuth.getCredentials(), 
	                        oldAuth.getAuthorities()
	                );
	
	        SecurityContextHolder.getContext().setAuthentication(newAuth);
	     }
   	
		return 1;
	}
	
	@ResponseBody
	@PostMapping("/deleteUser")
	public int deleteUser() {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
   	 	String userNo = auth.getName();
   	 	
   	 	int result = this.mypage.deleteUser(userNo);
   	 	return result;
	}
	
	@GetMapping("/excel/download")
	public void excelDownload( @RequestParam("searchDate") String searchDate, HttpServletResponse response) throws IOException {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
   	 	String userNo = auth.getName();
   	 	TBUserVO userinfo= this.mypage.profile(userNo);
   	 	String userNm = userinfo.getUserNm();
   	 	
   	 	log.info("다운로드 받을 준비돼썽?{}",userNo);
   	 	log.info("다운로드 받을 준비돼썽?{}",searchDate);
   	 	
   	 	Map<String, Object> map = new HashMap<>();
   	 	map.put("userNo", userNo);
   	 	map.put("searchDate", searchDate);
   	 	
	    Workbook wb = new XSSFWorkbook();
	    CreationHelper createHelper = wb.getCreationHelper();
	    CellStyle dateStyle = wb.createCellStyle();
	    dateStyle.setDataFormat(
	    	    createHelper.createDataFormat().getFormat("yyyy-MM-dd")
	    	);
	    
	    Sheet sheet = wb.createSheet("근태기록");
	    Row row = null;
	    Cell cell = null;
	    
	    row = sheet.createRow(0);
	    cell = row.createCell(0); 
	    cell.setCellValue(userNm + "근무일지");
	    
	    int rowNum = 1;
	    
	    row = sheet.createRow(rowNum++);
	    cell = row.createCell(0); 
	    cell.setCellValue("근무일");
	    cell = row.createCell(1); 
	    cell.setCellValue("출근시각");
	    cell = row.createCell(2); 
	    cell.setCellValue("퇴근시각");
	    cell = row.createCell(3); 
	    cell.setCellValue("근무시간");
	    cell = row.createCell(4); 
	    cell.setCellValue("비고");

	    List<SchdVO> dataList = this.mypage.workinglist(map);
	    log.info("데이터 잘 나왔엉?"+dataList);
	    for (SchdVO vo : dataList) {
	        row = sheet.createRow(rowNum++);
	        cell = row.createCell(0); 
	        
	        Date schdulDate = vo.getSchdulDate();
	        if(schdulDate != null){
	            cell.setCellValue(schdulDate); 
	            cell.setCellStyle(dateStyle); // 날짜 포맷 적용
	        } else {
	            cell.setCellValue("");
	        }
	        cell = row.createCell(1); 
	        cell.setCellValue(vo.getAttend());
	        cell = row.createCell(2); 
	        cell.setCellValue(vo.getLeave());
	        cell = row.createCell(3); 
	        cell.setCellValue(vo.getWorkingTime());
	        cell = row.createCell(4); 
	        cell.setCellValue(vo.getStatus());
	    }


	    response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
	    response.setHeader("Content-Disposition", "attachment;filename=\"workingTime.xlsx\"");

	    wb.write(response.getOutputStream());
	    wb.close();
	}

	
	@ResponseBody
	@PostMapping("/workingtable")
	public SchdVO table(@RequestBody Map<String, Object>map) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
   	 	String userNo = auth.getName();
   	 	map.put("userNo", userNo);
   	 	SchdVO schvo = this.mypage.getwork(map);
   	 	log.info("마이페이지 테이블:"+schvo);
   	 	log.info("마이페이지 map:"+map);
   	 	return schvo;
		
	}
	
	
	
}
