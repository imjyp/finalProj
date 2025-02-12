package kr.or.ddit.position.jy.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.position.jy.mapper.PositionMapper;
import kr.or.ddit.position.jy.service.PositionService;
import kr.or.ddit.vo.PositionVO;

@Service
public class PositionServiceImpl implements PositionService {

	@Autowired
	PositionMapper positionMapper;
	
	// 직책 전체 리스트
	@Override
	public List<PositionVO> listAll() {
		return this.positionMapper.listAll();
	}

}
