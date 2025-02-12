package kr.or.ddit.find.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import kr.or.ddit.find.mapper.FindIdMapper;
import kr.or.ddit.vo.TBUserVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class FindIdServiceImpl implements iFindIdService{

	@Autowired
	FindIdMapper mapper;
	@Autowired
	BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@Override
	public TBUserVO findId(Map<String, Object> map) {
		return this.mapper.findId(map);
	}

	@Override
	public int findPw(Map<String, Object> map) {
		return this.mapper.findPw(map);
	}

	@Override
	public int pwdUpdate(Map<String, Object> map) {
		String userPw = map.get("newPwd").toString();
		userPw = this.bCryptPasswordEncoder.encode(userPw);
		log.info("save->userPw : " + userPw);
		map.put("newPwd",userPw);
		
		return this.mapper.pwdUpdate(map);
	}

	@Override
	public int updatepwd(Map<String, Object> map) {
		String userPw = map.get("userPw").toString();
		userPw = this.bCryptPasswordEncoder.encode(userPw);
		log.info("save->userPw : " + userPw);
		map.put("userPw",userPw);
		
		
		return this.mapper.updatepwd(map);
	}

}
