package kr.or.ddit.positionManage.jm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Update;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.positionManage.jm.service.PositionManageService;
import kr.or.ddit.vo.PositionVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/positionManage")
public class PositionManageController {
	
	@Autowired
	PositionManageService positionManageService;
	
	//테스트
	@GetMapping("/test")
	public String positionManageTest(Model model) {
		List<PositionVO> positionList = positionManageService.getPositionList();
		log.info("positionManageTest-getPositionList: " + positionList);
        model.addAttribute("positionList", positionList);
		return "positionManage/positionManageTest";
	}
	// 메인페이지 이벤트 리스트 조회
	@GetMapping("/page")
	public String positionManage(Model model) {
		
		return "positionManage/positionManagePage";
	}
	
	//등록
	@ResponseBody
	@PostMapping("/create")
	public String createPosition(@RequestBody PositionVO positionVO) {				
		int count = this.positionManageService.createPosition(positionVO);
		log.info("createPosition-createPosition: " + positionVO);
		if(count  == 1) {
			log.info("createPosition-if: " + "등록성공");
	        return "등록성공";
		}
//		else {
//			log.info("createPosition-elseif: " + "중복데이터");
//	        return "DUPLICATE";
//		}
		
		return "1";
	}
	
	//수정
	@ResponseBody
	@PostMapping("/update")
	public Map<String, String> updatePosition(@RequestBody PositionVO positionVO) {
		log.info("updatePosition-positionVO: " + positionVO);
		
		this.positionManageService.updatePosition(positionVO);
		
		// 성공적으로 저장되었음을 클라이언트에 응답
        Map<String, String> response = new HashMap<>();
        response.put("message", "Event Update successfully");
        return response;
	}
	
	//삭제
	@ResponseBody
	@PostMapping("/delete")
	public String deletePosition(@RequestBody PositionVO positionVO) {
		log.info("deletePosition->positionVO: " + positionVO);
		
		this.positionManageService.deletePosition(positionVO);
		

		// 성공적으로 저장되었음을 클라이언트에 응답
//      Map<String, String> response = new HashMap<>();
//      response.put("message", "Event Delete successfully");
//		return response;
        return "삭제성공";
	}
	
	

	
}
