package kr.or.ddit.commuteSG.mapper;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Mapper;
import kr.or.ddit.vo.SchdVO;

@Mapper
public interface CommuteMapper2 {
    List<SchdVO> getStoreCommuteList(Map<String, Object> params);
    Map<String, Object> getStoreMonthlyStats(Map<String, Object> params);
    int getTotalStoreCommuteCount(Map<String, Object> params);
}