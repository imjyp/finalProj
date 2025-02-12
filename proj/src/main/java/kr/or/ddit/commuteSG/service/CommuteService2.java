package kr.or.ddit.commuteSG.service;

import java.util.List;
import java.util.Map;
import kr.or.ddit.vo.SchdVO;

public interface CommuteService2 {
    List<SchdVO> getStoreCommuteList(Map<String, Object> params);
    Map<String, Object> getStoreMonthlyStats(Map<String, Object> params);
    int getTotalStoreCommuteCount(Map<String, Object> params);
}