package kr.or.ddit.manageSG.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.dept.jy.service.DeptService;
import kr.or.ddit.manageSG.service.HRService;
import kr.or.ddit.member.jy.service.MemberService;
import kr.or.ddit.position.jy.service.PositionService;
import kr.or.ddit.sys.jy.service.SysService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.util.UploadController;
import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.TBUserVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/hr")
public class HRController {

    @Autowired
    private HRService hrService;
    
    @Autowired
    MemberService memberService;
    
    @Autowired
    SysService sysService;
    
    @Autowired
    DeptService deptService;
    
    @Autowired
    PositionService positionService;
    
    
    @Autowired
    UploadController uploadController;
    
    
    @GetMapping("/manage")
    public String getHRList(
    		@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
			@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
			@RequestParam(value = "mainCategory", required = false, defaultValue = "") String mainCategory,
			@RequestParam(value = "subCategory", required = false, defaultValue = "") String subCategory,
			Model model) {
        
    	Map<String, Object> map = new HashMap<String, Object>();
		map.put("currentPage", currentPage);
		map.put("keyword", keyword);
		map.put("mainCategory", mainCategory);
		map.put("subCategory", subCategory);
		
		log.info("getHRList -> map : " + map);
		
		// 회원 리스트
		List<TBUserVO> userList = this.sysService.bonsaList(map);
		log.info("getHRList -> userList : " + userList);
		
		List<?> subCategoryList = null;
		
		if("dept".equals(mainCategory)) {
			subCategoryList = this.deptService.listAll();	// 부서 리스트
		} else if("position".equals(mainCategory)){
			subCategoryList = this.positionService.listAll();	// 직책 리스트
		}
		
		log.info("getHRList -> subCategoryList : " + subCategoryList);
		
		// total
		int total = this.sysService.getTotal(map);
		log.info("getHRList -> total : " + total);
		
		map.put("subCategoryList", subCategoryList);
		
		
		// 페이지 객체 생성(다중 검색)
		ArticlePage<TBUserVO> articlePage = new ArticlePage<TBUserVO>(total, currentPage, 10, userList, map);
		
		model.addAttribute("userList", userList);
		model.addAttribute("articlePage", articlePage);
		
		log.info("articlePage : " + articlePage);
		log.info("articlePage content : " + articlePage.getContent());

        return "hr/manage";
    }

    
    // 회원 정보 상세
 	@ResponseBody
 	@PostMapping("/hrUserDetail/{userNo}")
 	public Map<String, Object> hrUserDetail(@PathVariable("userNo") String userNo) {
 		
 		log.info("hrUserDetail 체킁");
 		
 		log.info("hrUserDetail -> userNo : " + userNo);
 		
 		TBUserVO userVO = this.memberService.read(userNo);
 	     
 	    String defaultProfileUrl = "./resources/upload/profile.png";
 	    String defaultSignUrl = "./resources/upload/sign.png";
 	    
 	    String profileUrl = defaultProfileUrl;
 	    String signUrl = defaultSignUrl;
 		
 	    // 프로필 이미지 경로 설정
 	    if (userVO.getFileGroupVO() != null && !userVO.getFileGroupVO().getFileDetailVOList().isEmpty()) {
 	        profileUrl = "/resources" + userVO.getFileGroupVO().getFileDetailVOList().get(0).getFileSaveLocate();
 	    }

 	    // 서명 이미지 경로 설정
 	    if (userVO.getFileGroupSignVO() != null && !userVO.getFileGroupSignVO().getFileDetailVOList().isEmpty()) {
 	        signUrl = "/resources" + userVO.getFileGroupSignVO().getFileDetailVOList().get(0).getFileSaveLocate();
 	    }

 	    Map<String, Object> map = new HashMap<>();
 	    
 	    map.put("userVO", userVO);
 	    map.put("profileUrl", profileUrl);
 	    map.put("signUrl", signUrl);
         
 	    log.info("hrUserDetail -> profileUrl : " + profileUrl);
 	    log.info("hrUserDetail -> signUrl : " + signUrl);
 		
 		return map;
 	
 	}

 	// 회원 정보 수정
 	@ResponseBody
 	@PostMapping("/hrUpdProfile")
 	public int hrUpdProfile(
 				    @RequestParam(value = "userNo") String userNo, // data-user-no 값
 				    @RequestParam(value = "userProfile", required = false) MultipartFile[] userProfile,
 				    @RequestParam(value = "userSign", required = false) MultipartFile[] userSign,
 				    @RequestParam("userData") String data
 				) throws JsonMappingException, JsonProcessingException {
 		
 		
 		log.info("hrUpdProfile 체킁");
 		log.info("hrUpdProfile -> userNo : " + userNo);
 		
 		Long fileGroupNo = null;
 		Long fileGroupNo2 = null;

 		// 파일 업로드 처리
 	    if (userProfile != null && userProfile.length > 0 && userProfile[0].getOriginalFilename().length() > 0) {
 	        log.info("업로드된 프로필 파일: {}", userProfile[0].getOriginalFilename());
 	        fileGroupNo = uploadController.multiImageUpload(userProfile); 
 	    }

 	    if (userSign != null && userSign.length > 0 && userSign[0].getOriginalFilename().length() > 0) {
 	        log.info("업로드된 서명 파일: {}", userSign[0].getOriginalFilename());
 	        fileGroupNo2 = uploadController.multiImageUpload(userSign); 
 	    }
 		
 		log.info("hrUpdProfile -> fileGroupNo(프로필) : " + fileGroupNo);
 		log.info("hrUpdProfile -> fileGroupNo2(서명) : " + fileGroupNo2);
 		
    	 	
    	 	ObjectMapper objectMapper = new ObjectMapper();
    	 	Map<String, Object> userData = objectMapper.readValue(data, Map.class);
    	 	
 	     
    	 	Map<String, Object> map = new HashMap<>();
    	 	map.put("userNo", userNo);
	 	   	map.put("fileGroupNo", fileGroupNo);
	 	   	map.put("fileGroupNo2", fileGroupNo2);

    	 	map.putAll(userData);
    	 	
    	 	log.info("hrUpdProfile -> map : " + map);
    	 	
    	 	
    	 	int result = this.hrService.hrUpdProfile(map);
    	 	log.info("hrUpdProfile -> result : " + result);
    	 	
 	
 		return result;
 	}
 	
 	
 	// 회원 탈퇴
 	@ResponseBody
 	@PostMapping("/hrDelUser")
 	public int hrDelUser(@RequestBody Map<String, Object> map) { // data-user-no 값) 
    	 	
 		log.info("hrDelUser 체킁");
 		
 		String userNo = (String) map.get("userNo");
 		
 		log.info("hrDelUser -> userNo : " + userNo);
 		
    	 	int result = this.hrService.hrDelUser(userNo);
    	 	
    	 	log.info("hrDelUser -> result : " + result);
    	 
    	 	return result;
 	}
 	
 	
    @GetMapping("/search")
    @ResponseBody
    public List<TBUserVO> searchUsers(
            @RequestParam String keyword,
            @RequestParam(required = false) String deptNo,
            @RequestParam(required = false) String positionNo) {
        return hrService.searchUsers(keyword, deptNo, positionNo);
    }
    
    
    /*
    골뱅이GetMapping("/user/{userNo}")
    골뱅이ResponseBody
    public ResponseEntity<TBUserVO> getUserDetail(@PathVariable String userNo) {
        try {
            TBUserVO user = hrService.getUserDetail(userNo);
            return ResponseEntity.ok(user);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    골뱅이PostMapping("/user/new")
    public String createUser(@ModelAttribute TBUserVO user, 
                            @ModelAttribute EmployeeVO employee,
                            RedirectAttributes ra) {
        boolean result = hrService.createUser(user, employee);
        if (result) {
            ra.addFlashAttribute("message", "사용자가 성공적으로 등록되었습니다.");
        } else {
            ra.addFlashAttribute("error", "사용자 등록에 실패했습니다.");
        }
        return "redirect:/hr/manage";
    }

    골뱅이PostMapping("/user/edit/{userNo}")
    public String updateUser(@PathVariable String userNo,
                            @ModelAttribute TBUserVO user,
                            @ModelAttribute EmployeeVO employee,
                            RedirectAttributes ra) {
        user.setUserNo(userNo);
        employee.setUserNo(userNo);
        boolean result = hrService.updateUser(user, employee);
        if (result) {
            ra.addFlashAttribute("message", "사용자 정보가 성공적으로 수정되었습니다.");
        } else {
            ra.addFlashAttribute("error", "사용자 정보 수정에 실패했습니다.");
        }
        return "redirect:/hr/manage";
    }

    골뱅이PostMapping("/user/delete/{userNo}")
    public String deleteUser(@PathVariable String userNo,
                            RedirectAttributes ra) {
        boolean result = hrService.deleteUser(userNo);
        if (result) {
            ra.addFlashAttribute("message", "사용자가 성공적으로 삭제되었습니다.");
        } else {
            ra.addFlashAttribute("error", "사용자 삭제에 실패했습니다.");
        }
        return "redirect:/hr/manage";
    }

    골뱅이PostMapping("/user/delete")
    골뱅이ResponseBody
    public ResponseEntity<Map<String, Object>> deleteUsers(@RequestBody Map<String, List<String>> request) {
        Map<String, Object> response = new HashMap<>();
        try {
            List<String> userNos = request.get("userNos");
            boolean result = hrService.deleteUsers(userNos);
            response.put("success", result);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
        }
        return ResponseEntity.ok(response);
    }
    */
}