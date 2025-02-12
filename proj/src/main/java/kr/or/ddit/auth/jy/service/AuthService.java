package kr.or.ddit.auth.jy.service;

import java.util.List;

import kr.or.ddit.vo.AuthVO;
import kr.or.ddit.vo.TBUserVO;

public interface AuthService {

	// 권한 목록
	public List<AuthVO> listAll();

}
