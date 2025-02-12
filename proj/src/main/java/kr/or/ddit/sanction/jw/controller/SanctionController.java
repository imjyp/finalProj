package kr.or.ddit.sanction.jw.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.jstree.jw.service.JstreeDeptService;
import kr.or.ddit.jstree.jw.vo.JstreeDeptVO;
import kr.or.ddit.sanction.jw.service.SanctionService;
import kr.or.ddit.sanction.jw.vo.ReceiveVO;
import kr.or.ddit.sanction.jw.vo.SanctionDocVO;
import kr.or.ddit.sanction.jw.vo.SanctionVO;
import kr.or.ddit.util.ArticlePage;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@RequestMapping("/sanction")
@Controller
public class SanctionController {
	
	@Autowired
	SanctionService sanctionService;
	
	@Autowired
	JstreeDeptService jstreeDeptService;
	
	
	
	
	@GetMapping("/list")//결재문서 목록
	public String sanctionList(
			@RequestParam(value="currentPage", required=false, defaultValue="1")int currentPage,
			@RequestParam(value="keyword", required=false, defaultValue="")String keyword
			, Authentication authentication
			, Model model) {
		//로그인 사원의 userNo
		String userId = authentication.getName();
		
		log.info("detail-userId: "+userId);
		
		int deptNo =  this.sanctionService.getDept(userId);
				
		model.addAttribute("deptNo",deptNo);		
		
		
		return "sanction/list";
	}
	
	@ResponseBody
	@PostMapping("/listAjax")//결잼문서 목록 비동기
	public ArticlePage<SanctionDocVO> listAjax(@RequestBody Map<String, Object> map
												, Model model) {
		
		
		//map: {currentPage=1, keyword=}
		log.info("listAjax->map: "+map);
		
		//keyword로 검색된 전체 데이터의 행수 가져오기
		int total = this.sanctionService.total(map);
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
		
		// SanctionDocVO에 결재문서 데이터 가져오기
		//map: {currentPage=1, keyword=}
		List<SanctionDocVO> SanctionDocVO = this.sanctionService.getList(map);
		log.info("listAjax-SanctionDocVO : "+SanctionDocVO);
		
		//페이지네이션
		ArticlePage<SanctionDocVO> articlePage = 
				new ArticlePage<SanctionDocVO>(total, currentPage, 10, SanctionDocVO, keyword,"ajax");
		log.info("listAjax-articlePage"+articlePage);
		
		
		return articlePage;
	}
	
	@GetMapping("/reportList")//업무보고 목록
	public String reportList(
			@RequestParam(value="currentPage", required=false, defaultValue="1")int currentPage,
			@RequestParam(value="keyword", required=false, defaultValue="")String keyword,	
			Model model) {
		
		
		return "sanction/reportList";
	}
	
	@ResponseBody
	@PostMapping("/reportAjaxList")//업무보고 목록 비동기
	public ArticlePage<SanctionDocVO> reportAjaxList(@RequestBody Map<String, Object> map, 	Model model) {
		
		
		
		//map: {currentPage=1, keyword=}
		log.info("listAjax->map: "+map);
		
		//keyword로 검색된 전체 데이터의 행수 가져오기
		int total = this.sanctionService.mysancTotal(map);
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
		
		// SanctionDocVO에 공지사항 데이터 가져오기
		//map: {currentPage=1, keyword=}
		List<SanctionDocVO> SanctionDocVO = this.sanctionService.getList(map);
		log.info("listAjax-SanctionDocVO : "+SanctionDocVO);
		
		//페이지네이션
		ArticlePage<SanctionDocVO> articlePage = 
				new ArticlePage<SanctionDocVO>(total, currentPage, 10, SanctionDocVO, keyword,"ajax");
		log.info("listAjax-articlePage"+articlePage);
		
		
		return articlePage;
	}
	
	@GetMapping("/mysanc")//내문서함 목록
	public String mysanc(@RequestParam(value="currentPage", required=false, defaultValue="1")int currentPage,
			@RequestParam(value="keyword", required=false, defaultValue="")String keyword) {
		return "sanction/mysanc";
	}
	
	@ResponseBody
	@PostMapping("/mysancListAjax")//내문서함 목록 비동기
	public ArticlePage<SanctionDocVO> mysancListAjax(@RequestBody Map<String, Object> map, Authentication authentication,	Model model) {
		
		//로그인 사원의 userNo
		String userId = authentication.getName();
		
		log.info("mysancListAjax-userId: "+userId);
		
		map.put("userId", userId);
		
		//map: {currentPage=1, keyword=}
		log.info("mysancListAjax->map: "+map);
		
		//keyword로 검색된 전체 데이터의 행수 가져오기
		int total = this.sanctionService.mysancTotal(map);
		//total 값 들어왔는지 확인
		log.info("mysancListAjax-mysancTotal: "+total);
		
		int currentPage = 1;
		//currentPage 값이 변하면 값 업데이트해주기
		if(map.get("currentPage") != null) {
			currentPage = Integer.parseInt(map.get("currentPage").toString());
			
		}
		
		String keyword = "";
		if(map.get("keyword") != null) {
			keyword = map.get("keyword").toString();
		}
		
		// SanctionDocVO에 결재문서 데이터 가져오기
		//map: {currentPage=1, keyword=}
		List<SanctionDocVO> SanctionDocVO = this.sanctionService.getMysancList(map);
		log.info("mysancListAjax-SanctionDocVO : "+SanctionDocVO);
		
		//페이지네이션
		ArticlePage<SanctionDocVO> articlePage = 
				new ArticlePage<SanctionDocVO>(total, currentPage, 10, SanctionDocVO, keyword,"ajax");
		log.info("mysancListAjax-articlePage"+articlePage);
		
		
		return articlePage;
	}
	
	@GetMapping("/pending")//결재대기함 목록
	public String pending(@RequestParam(value="currentPage", required=false, defaultValue="1")int currentPage,
			@RequestParam(value="keyword", required=false, defaultValue="")String keyword) {
		return "sanction/pending";
	}
	
	@ResponseBody
	@PostMapping("/pendingListAjax")//결재대기함 목록 비동기
	public ArticlePage<SanctionVO> pendingListAjax(@RequestBody Map<String, Object> map, Authentication authentication,	Model model) {
		
		//로그인 사원의 userNo
		String userId = authentication.getName();
		
		log.info("pendingListAjax-userId: "+userId);
		
		map.put("userId", userId);
		
		//map: {currentPage=1, keyword=}
		log.info("pendingListAjax->map: "+map);
		
		//keyword로 검색된 전체 데이터의 행수 가져오기
		int total = this.sanctionService.pendingTotal(map);
		//total 값 들어왔는지 확인
		log.info("pendingListAjax-mysancTotal: "+total);
		
		int currentPage = 1;
		//currentPage 값이 변하면 값 업데이트해주기
		if(map.get("currentPage") != null) {
			currentPage = Integer.parseInt(map.get("currentPage").toString());
			
		}
		
		String keyword = "";
		if(map.get("keyword") != null) {
			keyword = map.get("keyword").toString();
		}
		
		// SanctionDocVO에 결재문서 데이터 가져오기
		//map: {currentPage=1, keyword=}
		List<SanctionVO> sanctionVO = this.sanctionService.pendingList(map);
		log.info("pendingListAjax-SanctionDocVO : "+sanctionVO);
		
		//페이지네이션
		ArticlePage<SanctionVO> articlePage = 
				new ArticlePage<SanctionVO>(total, currentPage, 10, sanctionVO, keyword,"ajax");
		log.info("pendingListAjax-articlePage"+articlePage);
		
		
		return articlePage;
	}
	@ResponseBody
	@PostMapping("/reportAjax")//결재대기함 목록 비동기
	public ArticlePage<SanctionDocVO> reportAjax(@RequestBody Map<String, Object> map, Authentication authentication,	Model model) {
		
		//로그인 사원의 userNo
		String userId = authentication.getName();
		
		log.info("pendingListAjax-userId: "+userId);
		
		map.put("userId", userId);
		
		//map: {currentPage=1, keyword=}
		log.info("pendingListAjax->map: "+map);
		
		//keyword로 검색된 전체 데이터의 행수 가져오기
		int total = this.sanctionService.reportTotal(map);
		//total 값 들어왔는지 확인
		log.info("pendingListAjax-mysancTotal: "+total);
		
		int currentPage = 1;
		//currentPage 값이 변하면 값 업데이트해주기
		if(map.get("currentPage") != null) {
			currentPage = Integer.parseInt(map.get("currentPage").toString());
			
		}
		
		String keyword = "";
		if(map.get("keyword") != null) {
			keyword = map.get("keyword").toString();
		}
		
		// SanctionDocVO에 결재문서 데이터 가져오기
		//map: {currentPage=1, keyword=}
		List<SanctionDocVO> sanctionDocVO = this.sanctionService.reportList(map);
		log.info("pendingListAjax-SanctionDocVO : "+sanctionDocVO);
		
		//페이지네이션
		ArticlePage<SanctionDocVO> articlePage = 
				new ArticlePage<SanctionDocVO>(total, currentPage, 10, sanctionDocVO, keyword,"ajax");
		log.info("pendingListAjax-articlePage"+articlePage);
		
		
		return articlePage;
	}
	
	// 문서 상세정보
	@GetMapping("/detail")
	public String detail( int docNo, Authentication authentication, Model model) {
		//로그인 사원의 userNo
		String userId = authentication.getName();
		
		log.info("detail-userId: "+userId);
		
		log.info("detail-docNo: "+docNo);
		SanctionDocVO sanctionDocVO = new SanctionDocVO();
		SanctionDocVO receiveVO = new SanctionDocVO();
		SanctionDocVO fileGroupVO = new SanctionDocVO();
		
		sanctionDocVO = this.sanctionService.detail(docNo);
		receiveVO = this.sanctionService.receive(docNo);
		fileGroupVO = this.sanctionService.fileGroup(docNo);
		log.info("detail-sanctionDocVO: "+sanctionDocVO);
		log.info("detail-receiveVO: "+receiveVO);
		log.info("detail-fileGroupVO: "+fileGroupVO);
		
		model.addAttribute("userId",userId);
		model.addAttribute("sanctionDocVO",sanctionDocVO);
		model.addAttribute("receiveVO",receiveVO);
		model.addAttribute("fileGroupVO",fileGroupVO);
		
		return "sanction/detail";
	}
	
	@ResponseBody
	@PostMapping("/approveAjax")
	 public int approveAjax(@RequestBody Map<String, Object> map ) {
		
		log.info("approveAjax-map: "+ map);
		
		int result = this.sanctionService.approve(map);
		
		return result;
		 
	 }
	
	@ResponseBody
	@PostMapping("/rejectAjax")
	public int rejectAjax(@RequestBody Map<String, Object> map ) {
		//반려 문서, 반려 결재자, 반려사유
		//{docNo=5, sanctionUser=a001, docReject=반려반려}
		log.info("approveAjax-map: "+ map);
		
		//sanction에 update할 데이터 {sanctionUser=a001, docNo=5}
		Map<String, Object> sanctionData = new HashMap<>();
		//sanction_doc에 update할 데이터 {docReject=반려반려}
		Map<String, Object> rejectData = new HashMap<>();
		
		sanctionData.put("docNo",map.get("docNo"));
		sanctionData.put("sanctionUser",map.get("sanctionUser"));
		log.info("rejectAjax-sanctionData: "+sanctionData);
		
		rejectData.put("docReject",map.get("docNo"));
		rejectData.put("docReject",map.get("docReject"));
		log.info("rejectAjax-rejectData: "+rejectData);
		
		int result = this.sanctionService.reject(sanctionData,rejectData);
		
		return result;
		
	}
	
	//기안서 작성 
	@GetMapping("/form")
	public String form(Authentication authentication, Model model) {
		//로그인 사원의 userNo
		String userId = authentication.getName();
		
		log.info("detail-userId: "+userId);
		
		model.addAttribute("userId",userId);
		return "sanction/form";
	}
	

	//결재선 정보 가져오기
	@ResponseBody
	@GetMapping("/deptTree")
	public List<JstreeDeptVO> deptTree() {
		
		List<JstreeDeptVO> jstreeDeptVO = this.jstreeDeptService.deptTree();
		log.info("deptTree-jstreeDeptVO: "+jstreeDeptVO);
		
		return jstreeDeptVO;
	}
	
	//수신부서 정보 가져오기
	@ResponseBody
	@GetMapping("/receiveDept")
	public List<JstreeDeptVO> receiveDept() {
		
		List<JstreeDeptVO> jstreeDeptVO = this.jstreeDeptService.receiveDept();
		log.info("receiveDept-jstreeDeptVO: "+jstreeDeptVO);
		
		return jstreeDeptVO;
	}
	

	// 기안 상신
	@PostMapping("/createPost")
	public String createPost(SanctionDocVO sanctionDocVO
			) {
		//SanctionDocVO(docNo=0, userNo=, docTitle=테스트, docContent="summernote 추가하기", docCreateDate=null, fileGroupNo=0
		//				, docTypeNo=5, docStatus=0, docTypeNm=null, sanctionTypeNm=null, sanctionStatusNm=null, sanctionLine=null
		//				, userNm=null, deptNm=, uploadFiles=[org.springframework.web.multipart.support.StandardMultipartHttpServletRequest$StandardMultipartFile@9cc2f90]
		//				, fileGroupVO=null, sanctionVOList=null, receiveVOList=null)
		log.info("createPost-sanctionDocVO:"+sanctionDocVO); //
		log.info("createPost-sanctionUsers:"+sanctionDocVO.getSanctionUsers()); //createPost-sanctionUsers:[a999000, a555, a001]
		log.info("createPost-sanctionLines:"+sanctionDocVO.getSanctionLines()); //createPost-sanctionLines:[middle, middle, final]
		log.info("createPost-sanctionTypes:"+sanctionDocVO.getSanctionTypes()); //createPost-sanctionTypes:[normal, normal, normal]
		log.info("createPost-receive:"+sanctionDocVO.getReceive());
		
		// List<SanctionVO> 생성
	    List<SanctionVO> sanctionVOList = new ArrayList<SanctionVO>();
	    String[] sanctionUsers = sanctionDocVO.getSanctionUsers();
	    String[] sanctionLines = sanctionDocVO.getSanctionLines();
	    String[] sanctionTypes = sanctionDocVO.getSanctionTypes();

	    for (int i = 0; i < sanctionUsers.length; i++) {
	        SanctionVO sanctionVO = new SanctionVO();
	        sanctionVO.setDocNo(sanctionDocVO.getDocNo());
	        sanctionVO.setSanctionUser(sanctionUsers[i]);
	        sanctionVO.setSanctionLineType(sanctionLines[i]);
	        sanctionVO.setSanctionTypeNo(Integer.parseInt(sanctionTypes[i]));
	        sanctionVOList.add(sanctionVO);
	    }
	    log.info("createPost-sanctionVOList:"+sanctionVOList);
	    
	 // List<SanctionVO> 생성
	    List<ReceiveVO> receiveVOList = new ArrayList<>();
	    String[] receive = sanctionDocVO.getReceive();
	    
	    for(int j = 0; j<receive.length; j++) {
	    	ReceiveVO receiveVO = new ReceiveVO();
	    	receiveVO.setDocNo(sanctionDocVO.getDocNo());
	    	receiveVO.setDeptNo(Integer.parseInt(receive[j]));
	    	receiveVOList.add(receiveVO);
	    }
	    log.info("createPost-receiveVOList:"+receiveVOList);
	    
	    /*
	    SanctionDocVO(docNo=0, userNo=, docTitle=테스트22, docContent="summernote 추가하기", 
	    docCreateDate=null, fileGroupNo=0, docTypeNo=1, docStatus=0, docTypeNm=null, 
	    sanctionTypeNm=null, sanctionStatusNm=null, sanctionLine=null, userNm=null, deptNm=, 
	    uploadFiles=[org.springframework.web.multipart.support.StandardMultipartHttpServletRequest$StandardMultipartFile@4cc82fbc], 
	    fileGroupVO=null, sanctionVOList=null, receiveVOList=null
	    , sanctionUsers=[qwer1234, a555, a999000]
	    , sanctionLines=[middle, middle, final]
	    , sanctionTypes=[1, 1, 1]
	    , receive=[1, 9, 3])
	     */
	    log.info("createPost->sanctionDocVO : " + sanctionDocVO);
	    /*
	    [
	    SanctionVO(sanctionStatusNo=0, docNo=0, sanctionTypeNo=1, sanctionNo=0, sanctionUser=qwer1234, sanctionDate=null, sanctionLineType=middle), 
	    SanctionVO(sanctionStatusNo=0, docNo=0, sanctionTypeNo=1, sanctionNo=0, sanctionUser=a555, sanctionDate=null, sanctionLineType=middle), 
	    SanctionVO(sanctionStatusNo=0, docNo=0, sanctionTypeNo=1, sanctionNo=0, sanctionUser=a999000, sanctionDate=null, sanctionLineType=final)
	    ]
	     */
	    log.info("createPost->sanctionVOList : " + sanctionVOList);
	    /*
	    [
	    ReceiveVO(docNo=0, deptNo=1), 
	    ReceiveVO(docNo=0, deptNo=9), 
	    ReceiveVO(docNo=0, deptNo=3)
	    ]
	     */
	    log.info("createPost->receiveVOList : " + receiveVOList);
		
		this.sanctionService.createPost(sanctionDocVO, sanctionVOList, receiveVOList);
		
		return "redirect:/sanction/mysanc";
	}

}
