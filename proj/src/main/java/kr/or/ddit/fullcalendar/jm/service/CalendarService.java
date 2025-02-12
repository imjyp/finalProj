package kr.or.ddit.fullcalendar.jm.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.CalendarVO;

public interface CalendarService {

	public List<CalendarVO> getAllEvent();

	public int saveEvent(CalendarVO calendarVO);

	public int updateEvent(CalendarVO calendarVO);

	public int deleteEvent(CalendarVO calendarVO);

	public int insertEvent(Map<String, Object> map);

	public int updateContent(Map<String, Object> map);

}
