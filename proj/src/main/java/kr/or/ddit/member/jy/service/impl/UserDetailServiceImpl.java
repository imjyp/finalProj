package kr.or.ddit.member.jy.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import kr.or.ddit.alert.jy.service.AlertService;
import kr.or.ddit.member.jy.mapper.MemberMapper;
import kr.or.ddit.member.jy.mapper.UserMapper;
import kr.or.ddit.security.CustomUser;
import kr.or.ddit.vo.AlertVO;
import kr.or.ddit.vo.TBUserVO;
import lombok.extern.slf4j.Slf4j;

//스프링 시큐리티에서 사용자 정보를 가져오는 인터페이스
@Slf4j
@Service
public class UserDetailServiceImpl implements UserDetailsService {

	@Autowired
	UserMapper userMapper;

	@Autowired
	MemberMapper memberMapper;
	
	@Autowired
    AlertService alertService;
	
	//사용자 이름(userNo)으로 사용자의 정보를 가져오는 메서드
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
//		return this.usersMapper.findByEmail(email);
		//1) 사용자 정보를 검색
		//username : 로그인 시 입력 받은 회원의 아이디. <input type="text" name="username"
		log.info("loadUserByUsername->username : " + username);
		
		TBUserVO userVO = this.memberMapper.read(username);
		log.info("loadUserByUsername->userVO : " + userVO);
		
		//알림 목록을 userVO에 넣어줌 시작 ///
//		Map<String, Object> map = new HashMap<>();
		List<AlertVO> alertList = alertService.userAlertList(username, 1, "");
		
		log.info("loadUserByUsername -> alertList : " + alertList);
		
		userVO.setAlerts(alertList);
		//알림 목록을 userVO에 넣어줌 끝 ///
	
		//MVC에서는 Controller로 리턴하지 않고, CustomUser로 리턴함
		//CustomUser : 사용자 정의 유저 정보. extends User를 상속받고 있음
		//2) 스프링 시큐리티의 User 객체의 정보로 넣어줌 => 프링이가 이제부터 해당 유저를 관리
		//User : 스프링 시큐리에서 제공해주는 사용자 정보 클래스
		/*
		 memberVO(우리) 					-> user(시큐리티)
		 -----------------------------------------
		 memId       					-> username
		 memPw					        -> password
		 memEnable       				-> enabled
		 authVOList(권한들)               -> authorities
		 */
		
		
	    
		return userVO==null?null:new CustomUser(userVO);
		
	}
	
}
