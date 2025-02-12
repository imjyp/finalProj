package kr.or.ddit.notice.jw.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.notice.jw.vo.NoticeVO;

@Mapper
public interface NoticeMapper {

	public List<NoticeVO> getList();

}
