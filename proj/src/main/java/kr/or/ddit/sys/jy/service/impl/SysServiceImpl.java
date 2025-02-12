package kr.or.ddit.sys.jy.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.sys.jy.mapper.SysMapper;
import kr.or.ddit.sys.jy.service.SysService;
import kr.or.ddit.vo.DeptVO;
import kr.or.ddit.vo.PositionVO;
import kr.or.ddit.vo.TBUserVO;

@Service
public class SysServiceImpl implements SysService {

	@Autowired
	SysMapper sysMapper;
	
	// type 리스트
	@Override
	public List<TBUserVO> userlist(Map<String, Object> map) {
		return this.sysMapper.userList(map);
	}

	// 권한명 수정
	@Override
	public int updateUserAuth(TBUserVO userVO) {
		return this.sysMapper.updateUserAuth(userVO);
	}

	// 인증여부 수정
	@Override
	public int updateEnabled(TBUserVO userVO) {
		return this.sysMapper.updateEnabled(userVO);
	}

	// 전체 행의 수
	@Override
	public int getTotal(Map<String, Object> map) {
		return this.sysMapper.getTotal(map);
	}

	
	// 써머리
	@Override
	public Map<String, Object> summary() {
		return this.sysMapper.summary();
	}

	// 본사 직원 목록
	@Override
	public List<TBUserVO> bonsaList(Map<String, Object> map) {
		return this.sysMapper.bonsaList(map);
	}


}
