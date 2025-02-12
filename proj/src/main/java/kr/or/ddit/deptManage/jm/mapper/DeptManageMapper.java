package kr.or.ddit.deptManage.jm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.DeptVO;
import kr.or.ddit.vo.PositionVO;

@Mapper
public interface DeptManageMapper {

	public List<DeptVO> getDeptList();
	
	public int createDept(DeptVO deptVO);

	public int updateDept(DeptVO deptVO);

	public int deleteDept(DeptVO deptVO);

}