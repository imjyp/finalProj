package kr.or.ddit.mypage.jc.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.mypage.jc.mapper.MypageMapper;
import kr.or.ddit.vo.SalaryVO;
import kr.or.ddit.vo.SchdVO;
import kr.or.ddit.vo.TBUserVO;

@Service
public class MypageServiceImpl implements iMypageService {

	@Autowired
	MypageMapper mapper;
	
	@Override
	public int start(Map<String, Object> map) {
		return this.mapper.start(map);
	}

	@Override
	public int end(Map<String, Object> map) {
		return this.mapper.end(map);
	}

	@Override
	public int chk(Map<String, Object> map) {
		return this.mapper.chk(map);
	}

	@Override
	public List<SchdVO> workinglist(Map<String, Object> map) {
		return this.mapper.workinglist(map);
	}

	@Override
	public TBUserVO profile(String userNo) {
		return this.mapper.profile(userNo);
	}

	@Transactional
	@Override
	public int udpateProfile(Map<String, Object> map) {
		return this.mapper.udpateProfile(map);
	}

	@Override
	public int deleteUser(String userNo) {
		return this.mapper.deleteUser(userNo);
	}

	@Override
	public int updateStatus(Map<String, Object> map) {
		return this.mapper.updateStatus(map);
	}

	@Override
	public SchdVO getwork(Map<String, Object> map) {
		return this.mapper.getwork(map);
	}

	@Override
	public List<SalaryVO> salary(String userNo) {
		return this.mapper.salary(userNo);
	}

}
