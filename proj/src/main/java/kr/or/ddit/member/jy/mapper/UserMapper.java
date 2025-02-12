package kr.or.ddit.member.jy.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.AuthVO;
import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.StoreEmpVO;
import kr.or.ddit.vo.TBUserVO;

@Mapper
public interface UserMapper {
	
	// userNo로 사용자 정보를 가져옴
	public TBUserVO findById(String userNo);

	// 회원가입
	public int save(TBUserVO userVO);

	// 회원가입 요청 후 권한 대기
	public int pending(AuthVO authVO);
	
	// 권한변경(권한 대기 삭제 후 알맞은 권한으로 변경)
	public int updateAuth(AuthVO authVO);

	// 기본 로그인을 위한 유저(TB_USER) 및 권한(AUTH) 테이블이 이미 있는제 체크
	public int beforeChk();

	// 상세정보 입력
	public int details(TBUserVO userVO);

	// 아이이 중복 검사
	public int idDupChk(TBUserVO userVO);

	// 본사 직원 insert
	public int saveEmployee(EmployeeVO employeeVO);

	// 가맹점 직원 insert
	public int saveStoreEmp(StoreEmpVO storeEmpVO);

}
