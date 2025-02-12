package kr.or.ddit.member.jy.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.member.jy.mapper.MemberMapper;
import kr.or.ddit.member.jy.service.MemberService;
import kr.or.ddit.vo.TBUserVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberMapper memberMapper;
	
	// 회원 목록
	@Override
	public List<TBUserVO> list(Map<String, Object> map) {
		return this.memberMapper.list(map);
	}

	// 전체 행의 수
	@Override
	public int getTotal(Map<String, Object> map) {
		return this.memberMapper.getTotal(map);
	}

 
	// 로그인 및 회원 정보 상세
	@Override
	public TBUserVO read(String userNo) {
		return this.memberMapper.read(userNo);
	}

}
