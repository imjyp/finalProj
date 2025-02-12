package kr.or.ddit.commuteSG.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.commuteSG.mapper.CommuteMapper;
import kr.or.ddit.vo.SchdVO;
import kr.or.ddit.vo.DeptVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CommuteServiceImpl implements CommuteService {
    
    @Autowired
    private CommuteMapper commuteMapper;
    
    @Override
    public List<SchdVO> getAllCommuteList(Map<String, Object> params) {
        log.info("getAllCommuteList params: {}", params);
        return commuteMapper.getAllCommuteList(params);
    }
    
    @Override
    public List<Map<String, Object>> getMonthlyStats(Map<String, Object> params) {
        log.info("getMonthlyStats params: {}", params);
        return commuteMapper.getMonthlyStats(params);
    }
    
    @Override
    public List<String> getDeptList() {
        return commuteMapper.getDeptList();
    }
    
    @Override
    public int getTotalCommuteCount(Map<String, Object> params) {
        return commuteMapper.getTotalCommuteCount(params);
    }
}
