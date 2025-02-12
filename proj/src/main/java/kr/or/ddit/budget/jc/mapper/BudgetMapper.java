package kr.or.ddit.budget.jc.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.StoreVO;
import kr.or.ddit.vo.HeadBudgetVO;

@Mapper
public interface BudgetMapper {
	List<HeadBudgetVO> getBudget();
	List<StoreVO> getBudget2();
	List<StoreVO> gmjList();
	int getTotal(Map<String, Object> map);
	List<HeadBudgetVO> ysgrlist(Map<String, Object> map);
	int insertBudget(Map<String, Object> map);
	int updateBudget(Map<String, Object> map);
	List<HeadBudgetVO> yssylist(Map<String, Object> map);
	List<HeadBudgetVO> yearlist();
	List<StoreVO> ysgrlist2(Map<String, Object> map);
	int getTotal2(Map<String, Object> map);
	List<HeadBudgetVO> yssylist2(Map<String, Object> map);
	List<HeadBudgetVO> yearlist2(int storeNo);
	int insertBudget2(Map<String, Object> map);
	int updateBudget2(Map<String, Object> map);
	int deleteBudget(Map<String, Object> map);
	int chkDelete(Map<String, Object> map);
	
	// 계산서 발행 후 본사 예산 insert
	int insertOrderBudget(HeadBudgetVO headBudgetVO);
	
	// 계산서 발행 후 가맹점 예산 insert
	int insertStoreBudget(StoreVO storeBudgetVO);
	int getTotalBS();
	int getTotalGMJ();
}
