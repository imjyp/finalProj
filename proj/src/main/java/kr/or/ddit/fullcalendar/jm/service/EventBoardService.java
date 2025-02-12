package kr.or.ddit.fullcalendar.jm.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.CalendarVO;
import kr.or.ddit.vo.FileGroupVO;


public interface EventBoardService {
	
	//이벤트 목록 조회
	public List<CalendarVO> getList(Map<String, Object> map);
	
	//검색된 전체 행 수 가져오기
	public int total(Map<String, Object> map);

	//이벤트 상세정보
	public CalendarVO detail(int calNm); //기본정보
	public FileGroupVO fileGroup(int calNm); //파일정보

	//이벤트 수정
	public int update(CalendarVO calendarVO);

	//이벤트 삭제
	public int delete(CalendarVO calendarVO);

	//이벤트 등록
	public int createPost(CalendarVO calendarVO);

	

}
