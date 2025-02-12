package kr.or.ddit.budget.jc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.StoreVO;
import kr.or.ddit.vo.HeadBudgetVO;

@Mapper
public interface BudgetMapper {
	List<HeadBudgetVO> getBudget();
	List<StoreVO> getBudget2();
	List<StoreVO> gmjList();
}
