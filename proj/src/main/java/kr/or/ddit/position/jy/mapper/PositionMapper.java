package kr.or.ddit.position.jy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.PositionVO;

@Mapper
public interface PositionMapper {

	// 직책 전체 리스트
	public List<PositionVO> listAll();

	
}
