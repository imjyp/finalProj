package kr.or.ddit.member.jy.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.TBUserVO;

public interface MemberService {
 
	// 회원 목록
	public List<TBUserVO> list(Map<String, Object> map);

	// 전체 행의 수
	public int getTotal(Map<String, Object> map);

	
	public TBUserVO read (String userNo);
}
