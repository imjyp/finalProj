package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

@Data
public class DeptVO {
	private Integer deptNo;	// 가맹점 직원 가입 시 null 처리 위해 Integer로 변경
	private String deptNm;
	private int authNo;
	private int deptSuprr;
	
	private int deptState;   //부서삭제 상태값
	
	private int level; 		// 부서관계 LEVEL

	private List<UsersVO> userVOList;
}
