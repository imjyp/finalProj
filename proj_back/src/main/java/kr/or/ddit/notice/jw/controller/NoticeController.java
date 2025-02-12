package kr.or.ddit.notice.jw.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.notice.jw.service.NoticeService;
import kr.or.ddit.notice.jw.vo.NoticeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/notice")
public class NoticeController {

	@Autowired
	NoticeService noticeService;
	
	@GetMapping("/list")
	public String noticeList(Model model) {
		
		// NoticeVO에 공지사항 데이터 가져오기
//		List<NoticeVO> noticeVO = this.noticeService.getList();
//		
//		model.addAttribute("noticeVO",noticeVO);
		
		return "notice/list";
	}
}
