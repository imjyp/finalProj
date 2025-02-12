package kr.or.ddit.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class HeadBudgetVO {
	private int deptBudgetNo;
	private int headNo;
	private long headBudget;
	private int headBudgetYear;
	
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private String headBudgetDate;
	private String headBudgetContent;
	private int headBudgetTy;
	private int headBudgetCode;
	private int rnum;
	private long sum;
	private long useTotal;
	
	private long restBG;
	
	private int billNo;
}
