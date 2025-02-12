package kr.or.ddit.gmjregisterSG.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.BillVO;
import kr.or.ddit.vo.StoreVO;

/*@Mapper*/
public interface GmjMapper {
    
    List<StoreVO> searchGmj(String keyword);
    int deleteGmj(List<Integer> storeNos);
    StoreVO selectGmjDetail(String storeNo);
    int insertGmj(Map<String, Object> map);
    int updateGmj(Map<String, Object> map);
    int getTotalCount();
    List<StoreVO> selectGmjListWithPaging(Map<String, Integer> params);
	List<BillVO> list(Map<String, Object> map);
	int getTotal(Map<String, Object> map);
	StoreVO getStoreByNo(int storeNo);
	List<StoreVO> bestGMJ();
	StoreVO budgetfordetail(int storeNo);
}