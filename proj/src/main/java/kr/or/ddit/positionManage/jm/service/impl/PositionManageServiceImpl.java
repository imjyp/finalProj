package kr.or.ddit.positionManage.jm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.positionManage.jm.mapper.PositionManageMapper;
import kr.or.ddit.positionManage.jm.service.PositionManageService;
import kr.or.ddit.vo.PositionVO;

@Service
public class PositionManageServiceImpl implements PositionManageService{

	@Autowired
	PositionManageMapper positionManageMapper;
	
	@Override
	public List<PositionVO> getPositionList() {
		return this.positionManageMapper.getPositionList() ;
	}

	@Override
	public int createPosition(PositionVO positionVO) {
		return this.positionManageMapper.createPosition(positionVO) ;
	}

	@Override
	public int updatePosition(PositionVO positionVO) {
		return this.positionManageMapper.updatePosition(positionVO) ;
	}

	@Override
	public int deletePosition(PositionVO positionVO) {
		return this.positionManageMapper.deletePosition(positionVO) ;
	}

}
