package kr.or.ddit.sys.jy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.TBUserVO;

@Mapper
public interface SysMapper {

	// type 리스트
	public List<TBUserVO> userList(Map<String, Object> map);

	// 권한명 수정
	public int updateUserAuth(TBUserVO userVO);

	// 인증여부 수정
	public int updateEnabled(TBUserVO userVO);

	// 전체 행의 수
	public int getTotal(Map<String, Object> map);

	// 써머리
	public Map<String, Object> summary();

	// 본사 직원 목록
	public List<TBUserVO> bonsaList(Map<String, Object> map);

	
}
