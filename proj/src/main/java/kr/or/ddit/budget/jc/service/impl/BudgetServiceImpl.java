package kr.or.ddit.budget.jc.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections4.ListUtils;
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

	@Override
	public int getTotal(Map<String, Object> map) {
		return this.bgMapper.getTotal(map);
	}

	@Override
	public List<HeadBudgetVO> ysgrlist(Map<String, Object> map) {
		return this.bgMapper.ysgrlist(map);
	}

	@Override
	public int insertBudget(Map<String, Object> map) {
		return this.bgMapper.insertBudget(map);
	}

	@Override
	public int updateBudget(Map<String, Object> map) {
		return this.bgMapper.updateBudget(map);
	}

	@Override
	public List<HeadBudgetVO> yssylist(Map<String, Object> map) {
		return this.bgMapper.yssylist(map);
	}

	@Override
	public List<HeadBudgetVO> yearlist() {
		return this.bgMapper.yearlist();
	}


	@Override
	public int getTotal2(Map<String, Object> map) {
		return this.bgMapper.getTotal2(map);
	}

	@Override
	public List<HeadBudgetVO> yssylist2(Map<String, Object> map) {
		return this.bgMapper.yssylist2(map);
	}

	@Override
	public List<HeadBudgetVO> yearlist2(int storeNo) {
		return this.bgMapper.yearlist2(storeNo);
	}

	@Override
	public List<StoreVO> ysgrlist2(Map<String, Object> map) {
		return this.bgMapper.ysgrlist2(map);
	}

	@Override
	public int insertBudget2(Map<String, Object> map) {
		return this.bgMapper.insertBudget2(map);
	}

	@Override
	public int updateBudget2(Map<String, Object> map) {
		return this.bgMapper.updateBudget2(map);
	}

	@Override
	public int deleteBudget(Map<String, Object> map) {
		return this.bgMapper.deleteBudget(map);
	}

	@Override
	public int chkDelete(Map<String, Object> map) {
		return this.bgMapper.chkDelete(map);
	}

	@Override
	public int getTotalBS() {
		return this.bgMapper.getTotalBS();
	}

	@Override
	public int getTotalGMJ() {
		return this.bgMapper.getTotalGMJ();
	}

}
