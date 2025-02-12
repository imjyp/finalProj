package kr.or.ddit.fullcalendar.jm.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.CalendarVO;

@Mapper
public interface CalendarMapper {

	public List<CalendarVO> getAllEvent();

	public int saveEvent(CalendarVO calendarVO);

	public int updateEvent(CalendarVO calendarVO);

	public int deleteEvent(CalendarVO calendarVO);

	public int insertEvent(Map<String, Object> map);

	public int updateContent(Map<String, Object> map);

	

}
