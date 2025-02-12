package kr.or.ddit.salary.jc.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.salary.jc.mapper.SalaryMapper;
import kr.or.ddit.salary.jc.service.iSalaryService;
import kr.or.ddit.vo.SalaryVO;

@Service
public class SalaryServiceImpl implements iSalaryService{
	@Autowired
	SalaryMapper salaryMapper;

	@Override
	public List<SalaryVO> getBsSalary() {
		return this.salaryMapper.getBsSalary();
	}

	@Override
	public List<SalaryVO> getGmjSalary() {
		return this.salaryMapper.getGmjSalary();
	}

}
