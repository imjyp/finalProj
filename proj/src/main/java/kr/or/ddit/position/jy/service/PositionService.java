package kr.or.ddit.position.jy.service;

import java.util.List;

import kr.or.ddit.vo.PositionVO;

public interface PositionService {

	// 직책 전체 리스트
	public List<PositionVO> listAll();
}
