package kr.or.ddit.member.jy.service;

import java.util.List;

import kr.or.ddit.vo.StoreEmpVO;

public interface StoreEmpService {

	// 가맹점 직원 목록
	public List<StoreEmpVO> listAll();
}
