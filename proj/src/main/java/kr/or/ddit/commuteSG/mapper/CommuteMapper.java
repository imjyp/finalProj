package kr.or.ddit.commuteSG.mapper;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.SchdVO;
import kr.or.ddit.vo.DeptVO;
import kr.or.ddit.vo.TBUserVO;
import kr.or.ddit.vo.EmployeeVO;

@Mapper
public interface CommuteMapper {
    // 출퇴근 기록 조회 (SchdVO 사용)
    List<SchdVO> getAllCommuteList(Map<String, Object> params);
    
    // 월별 통계 (SchdVO, DeptVO 활용)
    List<Map<String, Object>> getMonthlyStats(Map<String, Object> params);
    
    // 부서 목록 조회 (DeptVO 사용)
    List<String> getDeptList();
    
    int getTotalCommuteCount(Map<String, Object> params);
}
