package kr.or.ddit.commuteSG.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.SchdVO;

public interface CommuteService {
    List<SchdVO> getAllCommuteList(Map<String, Object> params);
    List<Map<String, Object>> getMonthlyStats(Map<String, Object> params);
    List<String> getDeptList();
    int getTotalCommuteCount(Map<String, Object> params);
}