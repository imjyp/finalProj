package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

@Data
public class SalaryVO {
	private int salNo;
	private String userNo;
	private Date salPymntDate;
	private int salAmount;
	private int salClassify;
	private Date salModifyDate;
}
