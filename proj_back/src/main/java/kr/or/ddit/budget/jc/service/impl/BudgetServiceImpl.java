package kr.or.ddit.budget.jc.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.budget.jc.mapper.BudgetMapper;
import kr.or.ddit.budget.jc.service.iBudgetService;
import kr.or.ddit.vo.HeadBudgetVO;
import kr.or.ddit.vo.StoreVO;

@Service
public class BudgetServiceImpl implements iBudgetService {

	@Autowired
	BudgetMapper bgMapper;
	
	@Override
	public List<HeadBudgetVO> getBudget() {
		return this.bgMapper.getBudget();
	}

	@Override
	public List<StoreVO> getBudget2() {
		return this.bgMapper.getBudget2();
	}

	@Override
	public List<StoreVO> gmjList() {
		return this.bgMapper.gmjList();
	}

}
