package kr.or.ddit.member.jy.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.TBUserVO;
import kr.or.ddit.vo.UsersVO;

@Mapper
public interface UserMapper {
	
	//email로 사용자 정보를 가져옴
//	public UsersVO findByEmail(String email);

	//회원가입
	public int save(TBUserVO userVO);

	//권한등록
	public int saveAuths(TBUserVO userVO);

	//기본 로그인을 위한 유저(TB_MEMBERS) 및 권한(TB_AUTHS) 테이블이 이미 있는제 체크
	public int beforeChk();

}
