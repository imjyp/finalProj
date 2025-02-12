package kr.or.ddit.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class RevenueVO {
	//가맹점 발주(store_order)
	private int storeOrderNo;
	private int storeNo;
	private Date storeOrderDate;
	private int fileGroupNo;
	
	//store_order_detail
	private int itemNo;
	private int storeOrderAmount;
	private int storeOrderPrice;
	private int storeOrderStatus;
	
	private String storeNm;
	
	//급여(salary)
	private int salNo;
	private String userNo;
	private String userNm;
	private Date salPymntDate;
	private int salAmount;
	private int salClassify;
	private Date salModifyDate;
	private int rnum;
	private String positionNm;
	private String deptNm;
	private String profile;
	private int year;
	private int month;
	
	//본사 예산(head_budget)
	private int deptBudgetNo;
	private int headNo;
	private long headBudget;
	private int headBudgetYear;
	private Date headBudgetDate;
	private String headBudgetContent;
	private int headBudgetTy;
	
	private long restBG;

}
