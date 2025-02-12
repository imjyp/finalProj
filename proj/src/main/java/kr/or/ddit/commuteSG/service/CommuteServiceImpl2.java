package kr.or.ddit.commuteSG.service;

import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.or.ddit.commuteSG.mapper.CommuteMapper2;
import kr.or.ddit.vo.SchdVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CommuteServiceImpl2 implements CommuteService2 {
    
    @Autowired
    private CommuteMapper2 commuteMapper2;
    
    @Override
    public List<SchdVO> getStoreCommuteList(Map<String, Object> params) {
        return commuteMapper2.getStoreCommuteList(params);
    }
    
    @Override
    public Map<String, Object> getStoreMonthlyStats(Map<String, Object> params) {
        return commuteMapper2.getStoreMonthlyStats(params);
    }
    
    @Override
    public int getTotalStoreCommuteCount(Map<String, Object> params) {
        return commuteMapper2.getTotalStoreCommuteCount(params);
    }
}
