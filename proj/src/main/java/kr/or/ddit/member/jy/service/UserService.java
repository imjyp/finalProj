package kr.or.ddit.member.jy.service;

import kr.or.ddit.vo.AuthVO;
import kr.or.ddit.vo.TBUserVO;
import kr.or.ddit.vo.UsersVO;

public interface UserService {
	
	//회원 가입
	public int save(TBUserVO userVO);
	
	

	// 상세 정보 입력
	public int details(TBUserVO userVO);

	// 아이디 중복 검사
	public int idDupChk(TBUserVO userVO);

}
