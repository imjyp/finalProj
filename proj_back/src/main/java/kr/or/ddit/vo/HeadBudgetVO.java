package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

@Data
public class HeadBudgetVO {
	private int deptBudgetNo;
	private int headNo;
	private int headBudget;
	private int headBudgetYear;
	private Date headBudgetDate;
	private String headBudgetContent;
	private int headBudgetTy;
}
