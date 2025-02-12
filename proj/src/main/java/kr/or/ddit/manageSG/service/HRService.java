package kr.or.ddit.manageSG.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.DeptVO;
import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.PositionVO;
import kr.or.ddit.vo.TBUserVO;

public interface HRService {
    List<TBUserVO> getUserList(int page, int size, String deptNo, String positionNo, String keyword);
    int getTotalUsers(String deptNo, String positionNo, String keyword);
    List<DeptVO> getDeptList();
    List<PositionVO> getPositionList();
    List<TBUserVO> searchUsers(String keyword, String deptNo, String positionNo);
    TBUserVO getUserDetail(String userNo);
    boolean createUser(TBUserVO user, EmployeeVO employee);
    boolean updateUser(TBUserVO user, EmployeeVO employee);
    boolean deleteUser(String userNo);
//	boolean deleteUsers(List<String> userNos);
	
	
	// 회원 정보 수정
	public int hrUpdProfile(Map<String, Object> map);
	
	// 회원 탈퇴
	int hrDelUser(String userNo);
}