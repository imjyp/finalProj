package kr.or.ddit.auth.jy.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.auth.jy.mapper.AuthMapper;
import kr.or.ddit.auth.jy.service.AuthService;
import kr.or.ddit.vo.AuthVO;
import java.util.Date;
import java.util.List;

@Service
public class AuthServiceImpl implements AuthService {

    @Autowired
    AuthMapper authMapper;

	@Override
	public List<AuthVO> listAll() {
		return this.authMapper.listAll();
	}

    /*
    @Override
    public int updateAuth(String userNo, String authName) {
        // AuthVO 객체 생성
        AuthVO authVO = new AuthVO();
        authVO.setUserNo(userNo);  // userNo 설정
        authVO.setAuthName(authName);  // authName 설정
        authVO.setAuthDate(new Date());  // 권한 부여 날짜 설정
    
        
        // 권한 변경을 위해 Mapper 호출
        return this.authMapper.updateAuth(authVO);
    }
     */
}
