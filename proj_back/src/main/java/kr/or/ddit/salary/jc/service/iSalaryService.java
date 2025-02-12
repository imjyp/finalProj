package kr.or.ddit.salary.jc.service;

import java.util.List;

import kr.or.ddit.vo.SalaryVO;

public interface iSalaryService {

	List<SalaryVO> getBsSalary();

	List<SalaryVO> getGmjSalary();

}
