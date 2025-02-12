package kr.or.ddit.budget.jc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import kr.or.ddit.vo.HeadBudgetVO;
import kr.or.ddit.vo.StoreVO;

public interface iBudgetService {
	
	/**
	 * 본사 예산 정보 불러오기
	 * @return
	 */
	List<HeadBudgetVO> getBudget();

	/**
	 * 가맹점 예산 불러오기
	 * @return
	 */
	List<StoreVO> getBudget2();

	/**
	 * 가맹점 리스트 불러오기
	 * @return
	 */
	List<StoreVO> gmjList();
	

}
