package kr.or.ddit.resource.jw.controller;

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

import kr.or.ddit.resource.jw.service.ResourceService;
import kr.or.ddit.resource.jw.vo.ResourceVO;
import kr.or.ddit.security.CustomUser;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.TBUserVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/resource")
public class ResourceController {

	@Autowired
	ResourceService resourceService;
	
	
	@GetMapping("/list")//자료실 목록
	public String resourceList(
			@RequestParam(value="currentPage", required=false, defaultValue="1")int currentPage,
			@RequestParam(value="keyword", required=false, defaultValue="")String keyword,	
			Authentication authentication,Model model) {
		
		String userId = "";
		if(authentication != null) {
			userId = authentication.getName();
			
			log.info("detail-userId: "+userId);
			
		}
		
		model.addAttribute("userId", userId);
		/*Map<String,Object> map = new HashMap<String,Object>();
		map.put("currentPage", currentPage);
		map.put("keyword", keyword);
		//사용자에게 입력받은 currentPage와 keyword를 map에 추가
		log.info("map: "+map);
		
		// ResourceVO에 자료실 데이터 가져오기
		List<ResourceVO> resourceVO = this.resourceService.getList(map);
		log.info("list-resourceVO"+resourceVO);
		
		
		//keyword로 검색된 전체 데이터의 행수 가져오기
		int total = this.resourceService.total(map);
		//total 값 들어왔는지 확인
		log.info("list-total : "+total);
		
		//페이지네이션
		ArticlePage<ResourceVO> articlePage = 
				new ArticlePage<ResourceVO>(total, currentPage, 10, resourceVO, keyword);
		log.info("list-articlePage"+articlePage);
		
		//페이지네이션 값 보내기
		model.addAttribute("articlePage",articlePage);
		//resourceVO값 보내기
		model.addAttribute("resourceVO",resourceVO);
		*/
		return "resource/list";
	}
	
	@ResponseBody
	@PostMapping("/listAjax")//자료실 목록 비동기
	public ArticlePage<ResourceVO> listAjax(@RequestBody Map<String, Object> map,	Model model) {
		//map: {currentPage=1, keyword=}
		//log.info("listAjax->map: "+map);
		
		int currentPage = 1;
		//currentPage 값이 변하면 값 업데이트해주기
		if(map.get("currentPage") != null) {
			currentPage = Integer.parseInt(map.get("currentPage").toString());
			
		}
		
		String keyword = "";
		if(map.get("keyword") != null) {
			keyword = map.get("keyword").toString();
		}
		
		//keyword로 검색된 전체 데이터의 행수 가져오기
		int total = this.resourceService.total(map);
		//total 값 들어왔는지 확인
		//log.info("listAjax-total : "+total);
		
		// ResourceVO에 자료실 데이터 가져오기
		//map: {currentPage=1, keyword=}
		List<ResourceVO> resourceVO = this.resourceService.getList(map);
		//log.info("listAjax-resourceVO : "+resourceVO);
		
		//페이지네이션
		ArticlePage<ResourceVO> articlePage = 
				new ArticlePage<ResourceVO>(total, currentPage, 10, resourceVO, keyword,"ajax");
		//log.info("listAjax-articlePage : "+articlePage);
		
		
		return articlePage;
	}
	
	@GetMapping("/create")//자료실 등록
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
		
		return "resource/create";		
	}
	
	@PostMapping("/createPost")
	public String createPost(ResourceVO resourceVO) {
		
		log.info("createPost-resourceVO: "+ resourceVO);
		
		int result = this.resourceService.createPost(resourceVO);
		
		log.info("cratePost-result: "+result);
		
		 
		return "redirect:/resource/list";		
		
	}
	
	@ResponseBody
	@PostMapping("/detailAjax")//자료실 상세
	public ResourceVO detailAjax(@RequestBody Map<String, Object> map) {
		
		log.info("detailAjax-map: " + map);
		
		ResourceVO resourceVO = this.resourceService.detail(map);
		
		
		return resourceVO;
		
	}
	
	@PostMapping("/update")//자료실 수정
	public String update(ResourceVO resourceVO ) {
		
		//update 내용 확인
		log.info("update-resourceVO: "+resourceVO);
		
		int result = this.resourceService.update(resourceVO);
		
		log.info("update-result: "+result);
		
		return "redirect:/resource/list";
		
		
	}
	
	  //요청파라미터 : JSONString{"boardNo":48}
	  @ResponseBody
	  @PostMapping("/delete") //자료실 삭제
	  public int delete(@RequestBody Map<String, Object> map ) {
	  
	  //delete 내용 확인 
	  log.info("delete-resourceVO: "+map);
	 
	  int result = this.resourceService.delete(map);
	 
	  log.info("delete-result: "+result);
	  
	  return result ;
	  
	
	 }
	 
}
