package kr.or.ddit.mypage.jc.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.SalaryVO;
import kr.or.ddit.vo.SchdVO;
import kr.or.ddit.vo.TBUserVO;

public interface iMypageService {

	int start(Map<String, Object> map);

	int end(Map<String, Object> map);

	int chk(Map<String, Object> map);

	List<SchdVO> workinglist(Map<String, Object> map);

	TBUserVO profile(String userNo);

	int udpateProfile(Map<String, Object> map);

	int deleteUser(String userNo);

	int updateStatus(Map<String, Object> map);

	SchdVO getwork(Map<String, Object> map);

	List<SalaryVO> salary(String userNo);

}
