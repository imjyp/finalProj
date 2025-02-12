package kr.or.ddit.vo;

import lombok.Data;

@Data
public class EmployeeVO {

	private String userNo;
	private int positionNo;
	private String empManager;
	private int deptNo;
	
	private String positionNm;
	private String userNm;
	private String deptNm;
	private String profile;
	
	private String userIndate;
	private String userPhone;
	private String fileSaveLocate;
}
