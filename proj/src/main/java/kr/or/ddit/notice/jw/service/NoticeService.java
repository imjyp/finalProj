package kr.or.ddit.notice.jw.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.notice.jw.vo.NoticeVO;

public interface NoticeService {

	//공지사항 목록 조회
	public List<NoticeVO> getList(Map<String, Object> map);

	//검색된 전체 행 수 가져오기
	public int total(Map<String, Object> map);

	//공지사항 상세정보
	public NoticeVO detail(int boardNo);

	//공지사항 수정
	public int update(NoticeVO noticeVO);

	//공지사항 삭제
	public int delete(NoticeVO noticeVO);

	//공지사항 등록
	public int createPost(NoticeVO noticeVO);
	
	

}
