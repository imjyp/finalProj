package kr.or.ddit.salary.jc.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.PositionVO;
import kr.or.ddit.vo.SalaryVO;

@Mapper
public interface SalaryMapper {

	List<SalaryVO> getBsSalary(Map<String, Object> map);

	List<SalaryVO> getGmjSalary(Map<String, Object> map);

	int getTotal(Map<String, Object> map);

	List<SalaryVO> list(Map<String, Object> map);

	int getTotal2(Map<String, Object> map);

	List<SalaryVO> deptList();

	List<SalaryVO> positionList();

	int insertSalary(Map<String, Object> map);

	int editSalary(Map<String, Object> map);

	List<EmployeeVO> filterP(Map<String, Object> map);

	List<SalaryVO> year();

	List<SalaryVO> month();

	List<SalaryVO> month2();

	List<SalaryVO> year2();

	int insertAll();

	int editSalary();

	int insertAllGMJ(int storeNo);

	List<SalaryVO> gmjemplist(int storeNo);

}
