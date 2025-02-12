package kr.or.ddit.positionManage.jm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.PositionVO;

@Mapper
public interface PositionManageMapper {

	public List<PositionVO> getPositionList();

	public int createPosition(PositionVO positionVO);

	public int updatePosition(PositionVO positionVO);

	public int deletePosition(PositionVO positionVO);

}