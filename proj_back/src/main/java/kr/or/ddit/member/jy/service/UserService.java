package kr.or.ddit.member.jy.service;

import kr.or.ddit.vo.TBUserVO;
import kr.or.ddit.vo.UsersVO;

public interface UserService {
	
	//회원 가입
	public int save(TBUserVO memberVO);
	
}
