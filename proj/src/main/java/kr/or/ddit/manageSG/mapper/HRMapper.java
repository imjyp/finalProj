package kr.or.ddit.manageSG.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.DeptVO;
import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.PositionVO;
import kr.or.ddit.vo.TBUserVO;

@Mapper
public interface HRMapper {
    List<TBUserVO> selectUserList(Map<String, Object> params);
    int getTotalUsers(Map<String, Object> params);
    List<DeptVO> selectDeptList();
    List<PositionVO> selectPositionList();
    List<TBUserVO> searchUsers(Map<String, Object> params);
    TBUserVO selectUserDetail(String userNo);
    int insertUser(TBUserVO user);
    int insertEmployee(EmployeeVO employee);
    int updateUser(TBUserVO user);
    int updateEmployee(EmployeeVO employee);
    int deleteUser(String userNo);
    
    // 회원 정보 수정
	public int hrUpdProfile(Map<String, Object> map);
	
	// 회원 탈퇴
	public int hrDelUser(String userNo);
	
}