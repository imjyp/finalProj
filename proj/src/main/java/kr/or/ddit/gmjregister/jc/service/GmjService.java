package kr.or.ddit.gmjregister.jc.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.BillVO;
import kr.or.ddit.vo.StoreVO;

public interface GmjService {
    List<StoreVO> searchGmj(String keyword);
    int deleteGmj(List<Integer> storeNos);
    StoreVO getGmjDetail(String storeNo);
    int insertGmj(Map<String, Object> map);
    int updateGmj(Map<String, Object> map);
    Map<String, Object> getGmjListWithPaging(int page, int size);
	List<BillVO> list(Map<String, Object> map);
	int getTotal(Map<String, Object> map);
	StoreVO getStoreByNo(int storeNo);
	List<StoreVO> bestGMJ();
	StoreVO budgetfordetail(int storeNo);
	int gmjdrno();
}