package kr.or.ddit.auth.jy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.AuthVO;

@Mapper
public interface AuthMapper {

	// 권한 변경
	public int updateAuth(AuthVO authVO);
	
	// 권한 목록
	public List<AuthVO> listAll();

}
