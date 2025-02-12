package kr.or.ddit.notice.jw.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.notice.jw.mapper.NoticeMapper;
import kr.or.ddit.notice.jw.vo.NoticeVO;

@Service
public class NoticeServiceImpl implements NoticeService {
	
	@Autowired
	NoticeMapper noticeMapper;

	@Override
	public List<NoticeVO> getList(Map<String, Object> map) {
		return this.noticeMapper.getList(map);
	}

	@Override
	public int total(Map<String, Object> map) {
		return this.noticeMapper.total(map);
	}

	@Override
	public NoticeVO detail(int boardNo) {
		return this.noticeMapper.detail(boardNo);
	}

	@Override
	public int update(NoticeVO noticeVO) {
		return this.noticeMapper.update(noticeVO);
	}

	@Override
	public int delete(NoticeVO noticeVO) {
		return this.noticeMapper.delete(noticeVO);
	}

	@Override
	public int createPost(NoticeVO noticeVO) {
		return this.noticeMapper.createPost(noticeVO);
	}

}
