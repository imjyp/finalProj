package kr.or.ddit.dept.jy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.DeptVO;

@Mapper
public interface DeptMapper {

	// 부서 전체 리스트
	public List<DeptVO> listAll();

	
}
