package kr.or.ddit.dept.jy.service;

import java.util.List;

import kr.or.ddit.vo.DeptVO;

public interface DeptService {

	// 부서 전체 리스트
	public List<DeptVO> listAll();
}
