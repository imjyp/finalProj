package kr.or.ddit.fullcalendar.jm.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.fullcalendar.jm.mapper.CalendarMapper;
import kr.or.ddit.fullcalendar.jm.service.CalendarService;
import kr.or.ddit.vo.CalendarVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CalendarServiceImpl implements CalendarService{
	
	@Autowired
	CalendarMapper calendarMapper;

	@Override
	public List<CalendarVO> getAllEvent() {
		return this.calendarMapper.getAllEvent();
	}

	@Override
	public int saveEvent(CalendarVO calendarVO) {
		return this.calendarMapper.saveEvent(calendarVO);
	}

	@Override
	public int updateEvent(CalendarVO calendarVO) {
		return this.calendarMapper.updateEvent(calendarVO);
	}

	@Override
	public int deleteEvent(CalendarVO calendarVO) {
		return this.calendarMapper.deleteEvent(calendarVO);
	}

	@Override
	public int insertEvent(Map<String, Object> map) {
		return this.calendarMapper.insertEvent(map);
	}

	@Override
	public int updateContent(Map<String, Object> map) {
		return this.calendarMapper.updateContent(map);
	}
	
	
	
}
