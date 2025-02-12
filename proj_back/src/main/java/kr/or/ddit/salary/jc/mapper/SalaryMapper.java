package kr.or.ddit.salary.jc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.SalaryVO;

@Mapper
public interface SalaryMapper {

	List<SalaryVO> getBsSalary();

	List<SalaryVO> getGmjSalary();

}
