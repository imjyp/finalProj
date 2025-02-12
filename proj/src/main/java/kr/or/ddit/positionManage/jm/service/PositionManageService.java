package kr.or.ddit.positionManage.jm.service;

import java.util.List;

import kr.or.ddit.vo.PositionVO;

public interface PositionManageService {
 
	public List<PositionVO> getPositionList();

	public int createPosition(PositionVO positionVO);
	
	public int updatePosition(PositionVO positionVO);
	
	public int deletePosition(PositionVO positionVO);


}
