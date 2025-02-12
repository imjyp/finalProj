package kr.or.ddit.notice.jw.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.notice.jw.service.NoticeService;
import kr.or.ddit.notice.jw.vo.NoticeVO;
import kr.or.ddit.security.CustomUser;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.TBUserVO;
import lombok.extern.slf4j.Slf4j;

//EnableMethodSecurity(securedEnabled = true, prePostEnabled = true)에 의해서
//.requestMatchers("/notice/**").hasAnyRole("GY","IS","JJ","GH","MR","GMJ") 뿐만 아니라
//클래스 또는 메소드 레벨에서도 접근제한이 가능
@Slf4j
@Controller
@RequestMapping("/notice")
public class NoticeController {

	@Autowired
	NoticeService noticeService;
	
	//골뱅이PreAuthorize("hasAnyRole('ROLE_GY','ROLE_IS','ROLE_JJ','ROLE_GH','ROLE_MR','ROLE_GMJ')")
	@GetMapping("/list")//공지사항 목록
	public String noticeList(
			@RequestParam(value="currentPage", required=false, defaultValue="1")int currentPage,
			@RequestParam(value="keyword", required=false, defaultValue="")String keyword,	
			Model model) {
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("currentPage", currentPage);
		map.put("keyword", keyword);
		//사용자에게 입력받은 currentPage와 keyword를 map에 추가
		log.info("map: "+map);
		
		// NoticeVO에 공지사항 데이터 가져오기
		List<NoticeVO> noticeVO = this.noticeService.getList(map);
		log.info("list-noticeVO"+noticeVO);
		
		
		//keyword로 검색된 전체 데이터의 행수 가져오기
		int total = this.noticeService.total(map);
		//total 값 들어왔는지 확인
		log.info("list-total"+total);
		
		//페이지네이션
		ArticlePage<NoticeVO> articlePage = 
				new ArticlePage<NoticeVO>(total, currentPage, 10, noticeVO, keyword);
		log.info("list-articlePage"+articlePage);
		
		//페이지네이션 값 보내기
		model.addAttribute("articlePage",articlePage);
		//noticeVO값 보내기
		model.addAttribute("noticeVO",noticeVO);
		
		return "notice/list";
	}
	
	@ResponseBody
	@PostMapping("/listAjax")//공지사항 목록 비동기
	public ArticlePage<NoticeVO> listAjax(@RequestBody Map<String, Object> map,	Model model) {
		//map: {currentPage=1, keyword=}
		log.info("listAjax->map: "+map);
		
		//keyword로 검색된 전체 데이터의 행수 가져오기
		int total = this.noticeService.total(map);
		//total 값 들어왔는지 확인
		log.info("listAjax-total"+total);
		
		int currentPage = 1;
		//currentPage 값이 변하면 값 업데이트해주기
		if(map.get("currentPage") != null) {
			currentPage = Integer.parseInt(map.get("currentPage").toString());
			
		}
		
		String keyword = "";
		if(map.get("keyword") != null) {
			keyword = map.get("keyword").toString();
		}
		
		// NoticeVO에 공지사항 데이터 가져오기
		//map: {currentPage=1, keyword=}
		List<NoticeVO> noticeVO = this.noticeService.getList(map);
		log.info("listAjax-noticeVO : "+noticeVO);
		
		//페이지네이션
		ArticlePage<NoticeVO> articlePage = 
				new ArticlePage<NoticeVO>(total, currentPage, 10, noticeVO, keyword,"ajax");
		log.info("listAjax-articlePage"+articlePage);
		
		
		return articlePage;
	}
	
	@GetMapping("/create")//공지사항 등록
	public String create(Authentication authentication, Model model) {
		authentication = SecurityContextHolder.getContext().getAuthentication();
		log.info("create -> authentication :"  + authentication);
		
		CustomUser user = (CustomUser) authentication.getPrincipal();
		log.info("create -> user :"  + user);
		
		TBUserVO tbUserVO= new TBUserVO();
		
		
		String userNo = user.getUsername();
		String userNm = user.getUserVO().getUserNm();
		
		log.info("create -> authentication :"+userNo);
		log.info("create -> authentication :"+userNm);
		
		tbUserVO.setUserNo(userNo);
		tbUserVO.setUserNm(userNm);
		log.info("create -> tbUserVO :"+tbUserVO);
		
		model.addAttribute("tbUserVO",tbUserVO);
		return "notice/create";		
	}
	
	@PostMapping("/createPost")
	public String createPost(NoticeVO noticeVO) {
		
		log.info("createPost-noticeVO: "+ noticeVO);
		
		int result = this.noticeService.createPost(noticeVO);
		
		log.info("cratePost-result: "+result);
		
		 
		return "redirect:/notice/detail?boardNo="+noticeVO.getBoardNo();		
		
	}
	
	@GetMapping("/detail")//공지사항 상세
	public String detail(NoticeVO noticeVO ,Authentication authentication,int boardNo, Model model) {
		String userId ="";
		if(authentication != null) {
			// 로그인 userNo값 가져오기
			userId = authentication.getName();
			log.info("detail-userId: "+userId);
			
		}
		
		//boardNo의 상세정보 가져오기
		noticeVO = this.noticeService.detail(boardNo);
		log.info("detail-noticeVO: "+noticeVO);
		
		
		model.addAttribute("userId", userId);
		model.addAttribute("noticeVO", noticeVO);
		
		return "notice/detail";
		
	}
	
	@PostMapping("/update")//공지사항 수정
	public String update(NoticeVO noticeVO ) {
		
		//update 내용 확인
		log.info("update-noticeVO: "+noticeVO);
		
		int result = this.noticeService.update(noticeVO);
		
		log.info("update-result: "+result);
		
		return "redirect:/notice/detail?boardNo="+noticeVO.getBoardNo();
		
		
	}
	
	  @PostMapping("/delete") //공지사항 삭제
	  public String delete(NoticeVO noticeVO ) {
	  
	  //delete 내용 확인 
	  log.info("delete-noticeVO: "+noticeVO);
	 
	  int result = this.noticeService.delete(noticeVO);
	 
	  log.info("delete-result: "+result);
	  
	  return "redirect:/notice/list";
	  
	
	 }
	 
}
