package kr.or.ddit.manageSG.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.manageSG.mapper.HRMapper;
import kr.or.ddit.vo.DeptVO;
import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.PositionVO;
import kr.or.ddit.vo.TBUserVO;

@Service
public class HRServiceImpl implements HRService {

    @Autowired
    private HRMapper hrMapper;

    @Override
    public List<TBUserVO> getUserList(int page, int size, String deptNo, String positionNo, String keyword) {
        Map<String, Object> params = new HashMap<>();
        params.put("page", page);
        params.put("size", size);
        params.put("deptNo", deptNo);
        params.put("positionNo", positionNo);
        params.put("keyword", keyword);
        
        return hrMapper.selectUserList(params);
    }

    @Override
    public int getTotalUsers(String deptNo, String positionNo, String keyword) {
        Map<String, Object> params = new HashMap<>();
        params.put("deptNo", deptNo);
        params.put("positionNo", positionNo);
        params.put("keyword", keyword);
        
        return hrMapper.getTotalUsers(params);
    }

    @Override
    public List<DeptVO> getDeptList() {
        return hrMapper.selectDeptList();
    }

    @Override
    public List<PositionVO> getPositionList() {
        return hrMapper.selectPositionList();
    }

    @Override
    public List<TBUserVO> searchUsers(String keyword, String deptNo, String positionNo) {
        Map<String, Object> params = new HashMap<>();
        params.put("keyword", keyword);
        params.put("deptNo", deptNo);
        params.put("positionNo", positionNo);
        
        return hrMapper.searchUsers(params);
    }

    @Override
    public TBUserVO getUserDetail(String userNo) {
        return hrMapper.selectUserDetail(userNo);
    }

    @Override
    @Transactional
    public boolean createUser(TBUserVO user, EmployeeVO employee) {
        try {
            int userResult = hrMapper.insertUser(user);
            int empResult = hrMapper.insertEmployee(employee);
            return userResult > 0 && empResult > 0;
        } catch (Exception e) {
            throw new RuntimeException("사용자 등록 중 오류 발생", e);
        }
    }

    @Override
    @Transactional
    public boolean updateUser(TBUserVO user, EmployeeVO employee) {
        try {
            int userResult = hrMapper.updateUser(user);
            int empResult = hrMapper.updateEmployee(employee);
            return userResult > 0 && empResult > 0;
        } catch (Exception e) {
            throw new RuntimeException("사용자 수정 중 오류 발생", e);
        }
    }

    @Override
    @Transactional
    public boolean deleteUser(String userNo) {
        try {
            return hrMapper.deleteUser(userNo) > 0;
        } catch (Exception e) {
            throw new RuntimeException("사용자 삭제 중 오류 발생", e);
        }
    }

    // 회원 정보 수정
	@Override
	public int hrUpdProfile(Map<String, Object> map) {
		return this.hrMapper.hrUpdProfile(map);
	}

	// 회원 탈퇴
	@Override
	public int hrDelUser(String userNo) {
		return this.hrMapper.hrDelUser(userNo);
	}
}