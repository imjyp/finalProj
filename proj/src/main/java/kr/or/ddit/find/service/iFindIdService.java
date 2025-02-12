package kr.or.ddit.find.service;

import java.util.Map;

import kr.or.ddit.vo.TBUserVO;

public interface iFindIdService {

	TBUserVO findId(Map<String, Object> map);

	int findPw(Map<String, Object> map);

	int pwdUpdate(Map<String, Object> map);

	int updatepwd(Map<String, Object> map);

}
