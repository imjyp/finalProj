package kr.or.ddit.vo;


import java.sql.Date;

import lombok.Data;

@Data
public class SalaryVO {
	private int salNo;
	private String userNo;
	private String userNm;
	private Date salPymntDate;
	private int salAmount;
	private int salClassify;
	private Date salModifyDate;
	private int rnum;
	private int storeNo;
	private String storeNm;
	private String positionNm;
	private String deptNm;
	private String profile;
	private int year;
	private int month;
	private int duty;
	private int afterTax;
	private long userProfile;
	private String userPhone;
}
