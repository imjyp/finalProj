package kr.or.ddit.suggest.jw.controller;

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

import kr.or.ddit.security.CustomUser;
import kr.or.ddit.suggest.jw.VO.ReplyVO;
import kr.or.ddit.suggest.jw.VO.SuggestVO;
import kr.or.ddit.suggest.jw.service.SuggestService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.TBUserVO;
import lombok.extern.slf4j.Slf4j;

//골뱅이PreAuthorize("hasAnyRole('JJ','GH','GMJ','GY')")
@Slf4j
@Controller
@RequestMapping("/suggest")
public class SuggestController {

	@Autowired
	SuggestService suggestService;
	
	
	@GetMapping("/list")//건의사항 목록
	public String suggestList(
			@RequestParam(value="currentPage", required=false, defaultValue="1")int currentPage,
			@RequestParam(value="keyword", required=false, defaultValue="")String keyword,	
			Model model) {
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("currentPage", currentPage);
		map.put("keyword", keyword);
		//사용자에게 입력받은 currentPage와 keyword를 map에 추가
		log.info("map: "+map);
		
		// suggestVO에 공지사항 데이터 가져오기
		List<SuggestVO> suggestVO = this.suggestService.getList(map);
		log.info("list-suggestVO"+suggestVO);
		
		
		//keyword로 검색된 전체 데이터의 행수 가져오기
		int total = this.suggestService.total(map);
		//total 값 들어왔는지 확인
		log.info("list-total"+total);
		
		//페이지네이션
		ArticlePage<SuggestVO> articlePage = 
				new ArticlePage<SuggestVO>(total, currentPage, 10, suggestVO, keyword);
		log.info("list-articlePage"+articlePage);
		
		//페이지네이션 값 보내기
		model.addAttribute("articlePage",articlePage);
		//suggestVO값 보내기
		model.addAttribute("suggestVO",suggestVO);
		
		return "suggest/list";
	}
	
	@ResponseBody
	@PostMapping("/listAjax")//건의사항 목록 비동기
	public ArticlePage<SuggestVO> listAjax(@RequestBody Map<String, Object> map,	Model model) {
		//map: {currentPage=1, keyword=}
		log.info("listAjax->map: "+map);
		
		//keyword로 검색된 전체 데이터의 행수 가져오기
		int total = this.suggestService.total(map);
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
		
		// suggestVO에 건의사항 데이터 가져오기
		//map: {currentPage=1, keyword=}
		List<SuggestVO> suggestVO = this.suggestService.getList(map);
		log.info("listAjax-suggestVO : "+suggestVO);
		
		//페이지네이션
		ArticlePage<SuggestVO> articlePage = 
				new ArticlePage<SuggestVO>(total, currentPage, 10, suggestVO, keyword,"ajax");
		log.info("listAjax-articlePage"+articlePage);
		
		
		return articlePage;
	}
	
	@GetMapping("/create")//건의사항 등록
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
		
		return "suggest/create";		
	}
	
	@PostMapping("/createPost")
	public String createPost(SuggestVO suggestVO) {
		
		
		log.info("createPost-suggestVO: "+ suggestVO);
		
		int result = this.suggestService.createPost(suggestVO);
		
		log.info("cratePost-result: "+result);
		
		 
		return "redirect:/suggest/detail?suggestBoardNo="+suggestVO.getSuggestBoardNo();		
		
	}
	
	@GetMapping("/detail")//건의사항 상세
	public String detail(SuggestVO suggestVO ,Authentication authentication,int suggestBoardNo, Model model) {
		// 로그인 userNo값 가져오기
		String userId = "";
		if(authentication != null) {
			userId = authentication.getName();
			
			log.info("detail-userId: "+userId);
			
		}
		//boardNo의 상세정보 가져오기
		suggestVO = this.suggestService.detail(suggestBoardNo);
		log.info("detail-suggestVO: "+suggestVO);
		
		List<ReplyVO> replyVO = this.suggestService.selectReply(suggestVO);
		log.info("detail-replyVO: "+replyVO);
		
		model.addAttribute("userId", userId);
		model.addAttribute("suggestVO", suggestVO);
		model.addAttribute("replyVO",replyVO);
		
		return "suggest/detail";
		
	}
	
	@PostMapping("/update")//건의사항 수정
	public String update(SuggestVO suggestVO ) {
		
		//update 내용 확인
		log.info("update-suggestVO: "+suggestVO);
		
		int result = this.suggestService.update(suggestVO);
		
		log.info("update-result: "+result);
		
		return "redirect:/suggest/detail?suggestBoardNo="+suggestVO.getSuggestBoardNo();
		
		
	}
	
	  @PostMapping("/delete") //건의사항 삭제
	  public String delete(SuggestVO suggestVO ) {
	  
	  //delete 내용 확인 
	  log.info("delete-suggestVO: "+suggestVO);
	 
	  int result = this.suggestService.delete(suggestVO);
	 
	  log.info("delete-result: "+result);
	  
	  return "redirect:/suggest/list";
	  
	
	 }
	  
	  //댓글 생성
	  @PostMapping("/createReply")
	  public String createReply(ReplyVO replyVO) {
		  
		  //댓글 내용 확인
		  log.info("createReply-replyVO: "+replyVO);
		  
		  int result = this.suggestService.createReply(replyVO);
		  
		  return "redirect:/suggest/detail?suggestBoardNo="+replyVO.getSuggestBoardNo();
		  
	  }
	  
	  @ResponseBody
	  @PostMapping("/updateReply")
	  public int updateReply(@RequestBody Map<String, Object> map) {
	  	
		  log.info("updateReply-map: "+map);
		  
		 int result = this.suggestService.updateReply(map);
		 
		 log.info("updateReply-result: "+result);
		  
	  	return result;
	  }
	  
	  @ResponseBody
	  @PostMapping("/createRereply")
	  public int createRereply(@RequestBody Map<String, Object> map) {
		  
		  log.info("createRereply-map: "+map);
		  
		  ReplyVO reReplyVO = new ReplyVO();
		  reReplyVO.setRepContent((String) map.get("repContent"));
		  reReplyVO.setRepUser((String) map.get("repUser"));
		  reReplyVO.setParentNo((int) map.get("parentNo"));
		  reReplyVO.setSuggestBoardNo((int) map.get("suggestBoardNo"));
		  
		  map.put("reReplyVO", reReplyVO);
		  
		  int result = this.suggestService.createRereply(map);
		  
		  log.info("createRereply-result: "+result);
		  
		  return result;
	  }

	  @ResponseBody
	  @PostMapping("/deleteReply")
	  public int deleteReply(@RequestParam("repNo") int repNo) {
		  
		  log.info("updateReply-map: "+repNo);
		  
		  int result = this.suggestService.deleteReply(repNo);
		  
		  log.info("updateReply-result: "+result);
		  
		  return result;
	  }
	  
	 
}
