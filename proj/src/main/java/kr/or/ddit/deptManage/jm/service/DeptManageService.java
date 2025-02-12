package kr.or.ddit.deptManage.jm.service;

import java.util.List;

import kr.or.ddit.vo.DeptVO;

public interface DeptManageService {
 
	public List<DeptVO> getDeptList();
	
	public int createDept(DeptVO deptVO);

	public int updateDept(DeptVO deptVO);

	public int deleteDept(DeptVO deptVO);

}
