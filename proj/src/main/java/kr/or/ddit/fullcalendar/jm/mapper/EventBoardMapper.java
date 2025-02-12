package kr.or.ddit.fullcalendar.jm.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.CalendarVO;
import kr.or.ddit.vo.FileGroupVO;

@Mapper
public interface EventBoardMapper {

	public List<CalendarVO> getList(Map<String, Object> map);

	public int total(Map<String, Object> map);

	public CalendarVO detail(int calNm);
	public FileGroupVO fileGroup(int calNm);

	public int update(CalendarVO calendarVO);

	public int delete(CalendarVO calendarVO);

	public int createPost(CalendarVO calendarVO);


}
