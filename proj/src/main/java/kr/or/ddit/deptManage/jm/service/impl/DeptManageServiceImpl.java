package kr.or.ddit.deptManage.jm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.deptManage.jm.mapper.DeptManageMapper;
import kr.or.ddit.deptManage.jm.service.DeptManageService;
import kr.or.ddit.vo.DeptVO;

@Service
public class DeptManageServiceImpl implements DeptManageService{

	@Autowired
	DeptManageMapper deptManageMapper;
	
	@Override
	public List<DeptVO> getDeptList() {
		return this.deptManageMapper.getDeptList() ;
	}

	@Override
	public int createDept(DeptVO deptVO) {
		return this.deptManageMapper.createDept(deptVO) ;
	}

	@Override
	public int updateDept(DeptVO deptVO) {
		return this.deptManageMapper.updateDept(deptVO) ;
	}

	@Override
	public int deleteDept(DeptVO deptVO) {
		return this.deptManageMapper.deleteDept(deptVO) ;
	}

}
