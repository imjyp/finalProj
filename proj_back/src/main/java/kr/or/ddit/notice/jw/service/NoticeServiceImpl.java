package kr.or.ddit.notice.jw.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.notice.jw.mapper.NoticeMapper;
import kr.or.ddit.notice.jw.vo.NoticeVO;

@Service
public class NoticeServiceImpl implements NoticeService {
	
	@Autowired
	NoticeMapper noticeMapper;

	@Override
	public List<NoticeVO> getList() {
		return this.noticeMapper.getList();
	}

}
