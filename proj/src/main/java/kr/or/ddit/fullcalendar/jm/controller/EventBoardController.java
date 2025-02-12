package kr.or.ddit.fullcalendar.jm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
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

import kr.or.ddit.fullcalendar.jm.service.EventBoardService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.CalendarVO;
import kr.or.ddit.vo.FileGroupVO;
import lombok.extern.slf4j.Slf4j;

//EnableMethodSecurity(securedEnabled = true, prePostEnabled = true)에 의해서
//.requestMatchers("/eventBoard/**").hasAnyRole("GY","IS","JJ","GH","MR","GMJ") 뿐만 아니라
//클래스 또는 메소드 레벨에서도 접근제한이 가능
@Slf4j
@Controller
@RequestMapping("/eventBoard")
public class EventBoardController {
	
	@Autowired
	EventBoardService eventBoardService;
	
	//@PreAuthorize("hasAnyRole('ROLE_GY','ROLE_IS','ROLE_JJ','ROLE_GH','ROLE_MR','ROLE_GMJ')")
	@GetMapping("/list")//이벤트 게시글 목록
	public String eventBoardList(
			@RequestParam(value="currentPage", required=false, defaultValue="1")int currentPage,
			@RequestParam(value="keyword", required=false, defaultValue="")String keyword,	
			Model model) {
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("currentPage", currentPage);
		map.put("keyword", keyword);
		//사용자에게 입력받은 currentPage와 keyword를 map에 추가
		log.info("map: "+map);
		// CalendarVO에 이벤트 게시글 데이터 가져오기
		List<CalendarVO> calendarVO = this.eventBoardService.getList(map);
		log.info("list-calendarVO"+calendarVO);
		
		//keyword로 검색된 전체 데이터의 행수 가져오기
		int total = this.eventBoardService.total(map);
		//total 값 들어왔는지 확인
		log.info("list-total"+total);		
		//페이지네이션
		ArticlePage<CalendarVO> articlePage = 
				new ArticlePage<CalendarVO>(total, currentPage, 10, calendarVO, keyword);
		log.info("list-articlePage"+articlePage);		
		//페이지네이션 값 보내기
		model.addAttribute("articlePage",articlePage);
		//calendarVO값 보내기
		model.addAttribute("calendarVO",calendarVO);		
		return "eventBoard/list";
	}
	
	@ResponseBody
	@PostMapping("/listAjax")//이벤트 게시글 목록 비동기
	public ArticlePage<CalendarVO> listAjax(@RequestBody Map<String, Object> map,	Model model) {
		//map: {currentPage=1, keyword=}
		log.info("listAjax->map: "+map);		
		//keyword로 검색된 전체 데이터의 행수 가져오기
		int total = this.eventBoardService.total(map);
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
		
		// CalendarVO에 이벤트 게시글 데이터 가져오기
		//map: {currentPage=1, keyword=}
		List<CalendarVO> calendarVO = this.eventBoardService.getList(map);
		log.info("listAjax-calendarVO : "+calendarVO);
		
		//페이지네이션
		ArticlePage<CalendarVO> articlePage = 
		new ArticlePage<CalendarVO>(total, currentPage, 10, calendarVO, keyword,"ajax");
		log.info("listAjax-articlePage"+articlePage);
		return articlePage;
	}
	
	@GetMapping("/create") // 이벤트 게시글 등록
	public String create() {
		return "eventBoard/create";
	}

	@PostMapping("/createPost")
	public String createPost(CalendarVO calendarVO) {
		log.info("createPost -> calendarVO: {}", calendarVO);

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
   	 	String userNo = auth.getName();
   	 	calendarVO.setUserNo(userNo);
   	 	
        // 캘린더 서비스로 이벤트 저장
		log.info("createPost-calendarVO: " + calendarVO);
		int result = this.eventBoardService.createPost(calendarVO);
		log.info("cratePost-result: " + result);
	    
		return "redirect:/eventBoard/list";
	}

	@GetMapping("/detail") // 이벤트 게시글 상세
	public String detail(int calNm, Model model) {
		// calNm의 상세정보 가져오기
		CalendarVO calendarVO = this.eventBoardService.detail(calNm); //이벤트 상세게시글 전송
		FileGroupVO fileGroupVO  = this.eventBoardService.fileGroup(calNm); //파일그룹 전송
		
		log.info("detail-calendarVO: " + calendarVO);
		log.info("detail-fileGroup: " + fileGroupVO);
		
		model.addAttribute("calendarVO", calendarVO); //이벤트 상세게시글 전송
		model.addAttribute("fileGroupVO", fileGroupVO); //파일그룹 전송
		
		return "eventBoard/detail";
	}

	@PostMapping("/update") // 이벤트 게시글 수정
	public String update(CalendarVO calendarVO) {
		// update 내용 확인
		log.info("update-calendarVO: " + calendarVO);
		int result = this.eventBoardService.update(calendarVO);
		log.info("update-result: " + result);
		return "redirect:/eventBoard/detail?calNm="+calendarVO.getCalNm();
	}

	@PostMapping("/delete") // 이벤트 게시글 삭제
	public String delete(CalendarVO calendarVO) {
		// delete 내용 확인
		log.info("delete-calendarVO: " + calendarVO);
		int result = this.eventBoardService.delete(calendarVO);
		log.info("delete-result: " + result);
		return "redirect:/eventBoard/list";

	}

}
