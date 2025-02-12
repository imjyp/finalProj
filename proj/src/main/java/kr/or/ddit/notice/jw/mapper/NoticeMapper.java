package kr.or.ddit.notice.jw.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.notice.jw.vo.NoticeVO;

@Mapper
public interface NoticeMapper {

	public List<NoticeVO> getList(Map<String, Object> map);

	public int total(Map<String, Object> map);

	public NoticeVO detail(int boardNo);

	public int update(NoticeVO noticeVO);

	public int delete(NoticeVO noticeVO);

	public int createPost(NoticeVO noticeVO);

}
