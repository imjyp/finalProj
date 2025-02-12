package kr.or.ddit.sys.jy.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.mail.MessagingException;
import kr.or.ddit.auth.jy.service.AuthService;
import kr.or.ddit.config.MailService;
import kr.or.ddit.dept.jy.service.DeptService;
import kr.or.ddit.member.jy.service.MemberService;
import kr.or.ddit.member.jy.service.StoreEmpService;
import kr.or.ddit.mypage.jc.service.iMypageService;
import kr.or.ddit.position.jy.service.PositionService;
import kr.or.ddit.sys.jy.service.SysService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.util.UploadController;
import kr.or.ddit.vo.AuthVO;
import kr.or.ddit.vo.DeptVO;
import kr.or.ddit.vo.PositionVO;
import kr.or.ddit.vo.StoreEmpVO;
import kr.or.ddit.vo.StoreVO;
import kr.or.ddit.vo.TBUserVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/sys")
public class SysController {

	@Autowired
	SysService sysService;
	
	@Autowired
	AuthService authService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	DeptService deptService;
	
	@Autowired
	PositionService positionService;

	@Autowired
	StoreEmpService storeEmpService;
	@Autowired
	MailService mail;
	
	
	@Autowired
	UploadController uploadController;

	@Autowired
	iMypageService mypageService;
	
	@Autowired
	UserDetailsService userDetailsService; 
	
	
	@GetMapping("/list")
	public String list(
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
			@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
			@RequestParam(value = "mainCategory", required = false, defaultValue = "") String mainCategory,
			@RequestParam(value = "subCategory", required = false, defaultValue = "") String subCategory,
			Model model
			) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("currentPage", currentPage);
		map.put("keyword", keyword);
		map.put("mainCategory", mainCategory);
		map.put("subCategory", subCategory);
		
		log.info("list -> map : " + map);
		
		
		// 회원 리스트
		List<TBUserVO> userList = this.sysService.userlist(map);
		log.info("list -> userList : " + userList);
		
		/*
		// 부서 리스트
		List<DeptVO> deptList = this.deptService.listAll();
		log.info("list -> deptList : " + deptList);

		// 직책 리스트
		List<PositionVO> positionList = this.positionService.listAll();
		log.info("list -> positionList : " + positionList);
		
		// 가맹점 리스트
		List<StoreEmpVO> storeEmpList = this.storeEmpService.listAll();
		log.info("list -> storeEmpList : " + storeEmpList);
		
		// 권한 리스트
		List<AuthVO> authList = this.authService.listAll();
		log.info("list -> authList : " + authList);
		*/
		
		List<?> subCategoryList = null;
		
		if("dept".equals(mainCategory)) {
			subCategoryList = this.deptService.listAll();	// 부서 리스트
		} else if("position".equals(mainCategory)){
			subCategoryList = this.positionService.listAll();	// 직책 리스트
		}
		
		log.info("list -> subCategoryList : " + subCategoryList);
		
		// total
		int total = this.sysService.getTotal(map);
		log.info("list -> total : " + total);
		
		map.put("subCategoryList", subCategoryList);
		
		
		// 페이지 객체 생성(다중 검색)
		ArticlePage<TBUserVO> articlePage = new ArticlePage<TBUserVO>(total, currentPage, 10, userList, map);
		
		model.addAttribute("userList", userList);
		
//		model.addAttribute("deptList", deptList);
//		model.addAttribute("positionList", deptList);
//		model.addAttribute("storeEmpList", storeEmpList);
//		model.addAttribute("authList", authList);
		
		/*
		log.info("userList -> userVO.deptNm : " + userVO.getDeptNm());
		log.info("userList -> userVO.positionNm : " + userVO.getPositionNm());
		log.info("userList -> userVO.authName : " + userVO.getAuthName());
		log.info("userList -> userVO.authDate : " + userVO.getAuthDate());
		*/
		model.addAttribute("articlePage", articlePage);
		
		log.info("articlePage : " + articlePage);
		log.info("articlePage content : " + articlePage.getContent());
		
		return "sys/manageAuth";
		
	}
	
	/* 권한 수정 */
	@Transactional	// 하나의 트랜잭션에서 2개의 update 쿼리 실행
	@ResponseBody
	@PutMapping("/updateUserAuth")
	public Map<String, Object> updateUserAuth(@RequestBody TBUserVO userVO) throws MessagingException {
		log.info("updateUserAuth -> userVO : " + userVO);
		
		// 인증여부 수정
		int userResult = this.sysService.updateEnabled(userVO);
		log.info("updateUserAuth -> userResult : " + userResult);
		
		// 권한 수정
		int authResult = this.sysService.updateUserAuth(userVO);
		log.info("updateUserAuth -> authResult : " + authResult);
		
		Map<String,Object> result = new HashMap<>();
		result.put("userResult", userResult);
		result.put("authResult", authResult);
		log.info("updateUserAuth -> result : " + result);
		
		String mail2 = userVO.getUserMail();
		log.info("메일 화긴"+mail2);
		if (authResult > 0) {
			try {
				mail.sendAuth(mail2);
				log.info("✅ 권한 변경 알림 이메일 전송 완료 -> 대상: {}", userVO.getUserMail());
			} catch (MessagingException e) {
				log.error("🚨 이메일 전송 실패 -> 대상: {}", userVO.getUserMail(), e);
			}
		}

		return result; 
		
	}

	// 회원 정보 상세
	@ResponseBody
	@PostMapping("/userDetail/{userNo}")
	public Map<String, Object> userDetail(@PathVariable("userNo") String userNo) {
		
		log.info("userDetail 체킁");
		
		log.info("userDetail -> userNo : " + userNo);
		
		TBUserVO userVO = this.memberService.read(userNo);
	     
	    String defaultProfileUrl = "/resources/upload/profile.png";
	    String defaultSignUrl = "/resources/upload/sign.png";
	    
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
        
	    log.info("userDetail -> profileUrl : " + profileUrl);
	    log.info("userDetail -> signUrl : " + signUrl);
		
		return map;
	
	}

	// 회원 정보 수정
	@ResponseBody
	@PostMapping("/updProfile")
	public int updProfile(
				    @RequestParam(value = "userNo") String userNo, // data-user-no 값
				    @RequestParam(value = "userProfile", required = false) MultipartFile[] userProfile,
				    @RequestParam(value = "userSign", required = false) MultipartFile[] userSign,
				    @RequestParam("userData") String data
				) throws JsonMappingException, JsonProcessingException {
		
		
		log.info("updProfile 체킁");
		log.info("updProfile -> userNo : " + userNo);
		
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
		
		log.info("updProfile -> fileGroupNo(프로필) : " + fileGroupNo);
		log.info("updProfile -> fileGroupNo2(서명) : " + fileGroupNo2);
		
   	 	
   	 	ObjectMapper objectMapper = new ObjectMapper();
   	 	Map<String, Object> userData = objectMapper.readValue(data, Map.class);
   	 	
	     
   	 	Map<String, Object> map = new HashMap<>();
   	 	map.put("userNo", userNo);
	   	map.put("fileGroupNo", fileGroupNo);
	   	map.put("fileGroupNo2", fileGroupNo2);

   	 	map.putAll(userData);
   	 	
   	 	log.info("updProfile -> map : " + map);
   	 	
   	 	
   	 	int result = this.mypageService.udpateProfile(map);
   	 	log.info("updProfile -> result : " + result);
   	 	
	
		return result;
	}
	
	// 회원 탈퇴
	@ResponseBody
	@PostMapping("/delUser")
	public int delUser(@RequestBody Map<String, Object> map) { // data-user-no 값) 
   	 	
		log.info("delUser 체킁");
		
		String userNo = (String) map.get("userNo");
		
		log.info("delUser -> userNo : " + userNo);
		
   	 	int result = this.mypageService.deleteUser(userNo);
   	 	
   	 	log.info("delUser -> result : " + result);
   	 
   	 	return result;
	}
	
	// 써머리
	@ResponseBody
    @GetMapping("/summary")
    public Map<String, Object> summary() {
		log.info("summary 체킁");
		
        Map<String, Object> summary = this.sysService.summary();
        log.info("summary -> summary : " + summary);
        return summary;
    }
	
}
