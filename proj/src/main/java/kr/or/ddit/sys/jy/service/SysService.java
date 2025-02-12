package kr.or.ddit.sys.jy.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.DeptVO;
import kr.or.ddit.vo.PositionVO;
import kr.or.ddit.vo.TBUserVO;

public interface SysService {

	
	// type 목록
	public List<TBUserVO> userlist(Map<String, Object> map);

	// 권한명 수정
	public int updateUserAuth(TBUserVO userVO);

	// 인증여부 수정
	public int updateEnabled(TBUserVO userVO);

	// 전체 행의 수
	public int getTotal(Map<String, Object> map);

	// 써머리
	public Map<String, Object> summary();

	// 본사 직원 목록
	public List<TBUserVO> bonsaList(Map<String, Object> map);


	 
}
