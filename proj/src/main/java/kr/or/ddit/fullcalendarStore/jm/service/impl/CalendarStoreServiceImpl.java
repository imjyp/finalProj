package kr.or.ddit.fullcalendarStore.jm.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.fullcalendarStore.jm.mapper.CalendarStoreMapper;
import kr.or.ddit.fullcalendarStore.jm.service.CalendarStoreService;
import kr.or.ddit.vo.CalendarVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CalendarStoreServiceImpl implements CalendarStoreService{
	
	@Autowired
	CalendarStoreMapper calendarStoreMapper;

	@Override
	public List<CalendarVO> getAllStore() {
		return this.calendarStoreMapper.getAllStore();
	}

	@Override
	public int saveEvent(CalendarVO calendarVO) {
		return this.calendarStoreMapper.saveEvent(calendarVO);
	}

	@Override
	public int updateEvent(CalendarVO calendarVO) {
		return this.calendarStoreMapper.updateEvent(calendarVO);
	}

	@Override
	public int deleteEvent(CalendarVO calendarVO) {
		return this.calendarStoreMapper.deleteEvent(calendarVO);
	}

	@Override
	public int insertEvent(Map<String, Object> map) {
		return this.calendarStoreMapper.insertEvent(map);
	}

	@Override
	public int updateContent(Map<String, Object> map) {
		return this.calendarStoreMapper.updateContent(map);
	}
	
}
