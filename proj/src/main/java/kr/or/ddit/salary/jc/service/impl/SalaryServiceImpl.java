package kr.or.ddit.salary.jc.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.salary.jc.mapper.SalaryMapper;
import kr.or.ddit.salary.jc.service.iSalaryService;
import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.PositionVO;
import kr.or.ddit.vo.SalaryVO;

@Service
public class SalaryServiceImpl implements iSalaryService{
	@Autowired
	SalaryMapper salaryMapper;

	@Override
	public List<SalaryVO> getBsSalary(Map<String, Object> map) {
		return this.salaryMapper.getBsSalary(map);
	}


	@Override
	public int getTotal(Map<String, Object> map) {
		return this.salaryMapper.getTotal(map);
	}


	@Override
	public List<SalaryVO> getGmjSalary(Map<String, Object> map) {
		return this.salaryMapper.getGmjSalary(map);
	}


	@Override
	public int getTotal2(Map<String, Object> map) {
		return this.salaryMapper.getTotal2(map);
	}


	@Override
	public List<SalaryVO> deptList() {
		return this.salaryMapper.deptList();
	}


	@Override
	public List<SalaryVO> positionList() {
		return this.salaryMapper.positionList();
	}


	@Override
	public int insertSalary(Map<String, Object> map) {
		return this.salaryMapper.insertSalary(map);
	}


	@Override
	public int editSalary(Map<String, Object> map) {
		return this.salaryMapper.editSalary(map);
	}


	@Override
	public List<EmployeeVO> filterP(Map<String, Object> map) {
		return this.salaryMapper.filterP(map);
	}


	@Override
	public List<SalaryVO> year() {
		return this.salaryMapper.year();
	}


	@Override
	public List<SalaryVO> month() {
		return this.salaryMapper.month();
	}


	@Override
	public List<SalaryVO> year2() {
		return this.salaryMapper.year2();
	}


	@Override
	public List<SalaryVO> month2() {
		return this.salaryMapper.month2();
	}


	@Override
	public int insertAll() {
		return this.salaryMapper.insertAll();
	}


	@Override
	public int editSalary() {
		return this.salaryMapper.editSalary();
	}


	@Override
	public int insertAllGMJ(int storeNo) {
		return this.salaryMapper.insertAllGMJ(storeNo);
	}


	@Override
	public List<SalaryVO> gmjemplist(int storeNo) {
		return this.salaryMapper.gmjemplist(storeNo);
	}

}
