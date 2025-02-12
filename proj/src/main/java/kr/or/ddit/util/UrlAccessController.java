package kr.or.ddit.util;

import java.util.HashMap;
import java.util.Map;

import org.apache.catalina.StoreManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import kr.or.ddit.member.jy.mapper.StoreEmpMapper;
import lombok.extern.slf4j.Slf4j;

/* URL 접근 통제
 1. 가맹점 별로 URL을 나눈다
  - 골뱅이GetMapping("/gmj/gmj{storeNo}/budget")
 2. 서로 다른 가맹점으로는 접근할 수 없다
  - 1) 접근 URL : /gmj/gmj9/budget에서 9
  - 2) 로그인 아이디 : asdf13
  - 3) SELECT COUNT(*) FROM STORE_EMP WHERE STORE_NO = 9 AND USER_NO = 'asdf13';
 */
@Slf4j
@Controller
public class UrlAccessController {
	
	@Autowired
	StoreEmpMapper storeEmpMapper;
	
	public int getUrlAccess(int storeNo, String userNo) {
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("storeNo", storeNo);
		map.put("userNo", userNo);
		
		//서로 다른 가맹점으로는 접근할 수 없다. 1이상 : 접근 가능 / 0 : 접근 불가
		int result = this.storeEmpMapper.getUrlAccess(map);
		log.info("getUrlAccess->result : " + result);
		
		return result;
	}
	
}







