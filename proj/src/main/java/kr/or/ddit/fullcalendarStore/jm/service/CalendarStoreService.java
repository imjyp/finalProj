package kr.or.ddit.fullcalendarStore.jm.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.CalendarVO;

public interface CalendarStoreService {

	public List<CalendarVO> getAllStore();

	public int saveEvent(CalendarVO calendarVO);

	public int updateEvent(CalendarVO calendarVO);

	public int deleteEvent(CalendarVO calendarVO);

	public int insertEvent(Map<String, Object> map);

	public int updateContent(Map<String, Object> map);

}
