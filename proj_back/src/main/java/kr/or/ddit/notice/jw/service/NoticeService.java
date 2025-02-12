package kr.or.ddit.notice.jw.service;

import java.util.List;

import kr.or.ddit.notice.jw.vo.NoticeVO;

public interface NoticeService {

	//공지사항 목록 조회
	public List<NoticeVO> getList();
	
	

}
