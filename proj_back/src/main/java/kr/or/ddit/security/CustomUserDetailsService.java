package kr.or.ddit.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import kr.or.ddit.member.jy.mapper.MemberMapper;
import kr.or.ddit.vo.TBUserVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomUserDetailsService implements UserDetailsService{

	@Autowired
	private MemberMapper memberMapper;
	
	@Override
	public UserDetails loadUserByUsername (String username)throws UsernameNotFoundException {
		log.debug("CKK1 {}",username);
	
		TBUserVO memberVO = memberMapper.read(username);
		if(memberVO != null) {
			return new CustomUser(memberVO);
		}else {
			throw new UsernameNotFoundException(username);
		}
	}
}