package kr.or.ddit.gmjregister.jc.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.gmjregister.jc.mapper.GmjMapper;
import kr.or.ddit.vo.BillVO;
import kr.or.ddit.vo.StoreVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class GmjServiceImpl implements GmjService {
    
	@Autowired
    GmjMapper gmjMapper;
    
    @Override
    public List<StoreVO> searchGmj(String keyword) {
        return gmjMapper.searchGmj(keyword);
    }
    
    @Override
    @Transactional
    public int deleteGmj(List<Integer> storeNos) {
        return gmjMapper.deleteGmj(storeNos);
    }
    
    @Override
    public StoreVO getGmjDetail(String storeNo) {
        return gmjMapper.selectGmjDetail(storeNo);
    }
    
    @Override
    public int insertGmj(Map<String, Object> map) {
        return gmjMapper.insertGmj(map);
    }
    
    @Override
    public int updateGmj(Map<String, Object> map) {
        return gmjMapper.updateGmj(map);
    }
    
    @Override
    public Map<String, Object> getGmjListWithPaging(int page, int size) {
        int total = gmjMapper.getTotalCount();
        int totalPages = (int) Math.ceil((double) total / size);
        
        Map<String, Integer> params = new HashMap<>();
        params.put("start", (page - 1) * size);
        params.put("end", page * size);
        
        List<StoreVO> list = gmjMapper.selectGmjListWithPaging(params);
        
        Map<String, Object> result = new HashMap<>();
        result.put("list", list);
        result.put("total", total);
        result.put("totalPages", totalPages);
        result.put("currentPage", page);
        
        return result;
    }

	@Override
	public List<BillVO> list(Map<String, Object> map) {
		return this.gmjMapper.list(map);
	}

	@Override
	public int getTotal(Map<String, Object> map) {
		return this.gmjMapper.getTotal(map);
	}

	@Override
	public StoreVO getStoreByNo(int storeNo) {
		return this.gmjMapper.getStoreByNo(storeNo);
	}

	@Override
	public List<StoreVO> bestGMJ() {
		return this.gmjMapper.bestGMJ();
	}

	@Override
	public StoreVO budgetfordetail(int storeNo) {
		return this.gmjMapper.budgetfordetail(storeNo);
	}

	@Override
	public int gmjdrno() {
		return this.gmjMapper.gmjdrno();
	}

}