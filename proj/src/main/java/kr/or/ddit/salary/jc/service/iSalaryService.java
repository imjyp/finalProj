package kr.or.ddit.salary.jc.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.PositionVO;
import kr.or.ddit.vo.SalaryVO;

public interface iSalaryService {

	/**
	 * 본사 직원 급여 지금 내역
	 * @param map 
	 * @return
	 */
	List<SalaryVO> getBsSalary(Map<String, Object> map);

	/**
	 * 가맹점별 직원 급여 지급 내역
	 * @param map
	 * @return
	 */
	List<SalaryVO> getGmjSalary(Map<String, Object> map);

	int getTotal(Map<String, Object> map);

	int getTotal2(Map<String, Object> map);

	List<SalaryVO> deptList();

	List<SalaryVO> positionList();

	int insertSalary(Map<String, Object> map);

	int editSalary(Map<String, Object> map);

	List<EmployeeVO> filterP(Map<String, Object> map);

	List<SalaryVO> year();

	List<SalaryVO> month();

	List<SalaryVO> year2();

	List<SalaryVO> month2();

	int insertAll();

	int editSalary();

	int insertAllGMJ(int storeNo);

	List<SalaryVO> gmjemplist(int storeNo);


}
