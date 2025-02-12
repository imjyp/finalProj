package kr.or.ddit.security;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import kr.or.ddit.vo.TBUserVO;
import lombok.Getter;

//CustomUser 		= jsp의 principal
//CustomUser.userVO = jsp의 principal.userVO
@Getter
public class CustomUser extends User{

	private static final long serialVersionUID = 1L;
	private TBUserVO userVO;

	public CustomUser (String username, String password, Collection<? extends GrantedAuthority> authorities){
		super(username, password, authorities);
	}
	
	
	public CustomUser (TBUserVO userVO){
		super(userVO.getUserNo(),userVO.getUserPw(),
				userVO.getAuthList().stream().map(auth -> new SimpleGrantedAuthority(auth.getAuthName())).collect(Collectors.toList()));
		this.userVO = userVO;
	}
	
}