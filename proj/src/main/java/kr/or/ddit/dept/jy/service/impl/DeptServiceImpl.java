package kr.or.ddit.dept.jy.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.dept.jy.mapper.DeptMapper;
import kr.or.ddit.dept.jy.service.DeptService;
import kr.or.ddit.vo.DeptVO;

@Service
public class DeptServiceImpl implements DeptService{

	@Autowired
	DeptMapper deptMapper;
	
	@Override
	public List<DeptVO> listAll() {
		return this.deptMapper.listAll();
	}

	
}