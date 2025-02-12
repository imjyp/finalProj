package kr.or.ddit.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class SellingVO {
	private int sellingNo;
	private int storeNo;
	private Date sellingDate;
	private long sellingTotal;
	private int sellingDetailNo;
	private int menuNo;
	private int sellingAmount;
	
	private String menuNm;
	private int menuPrice;
	private String ctgryNm;
	private String storeNm;
	
	private int year;
	private int month;
	private int rank;
	private int totalAmount;
	
	private String quarter;
	private long quarterlySales;
	private long monthlySales;
	private String monthS;
	private long yearlySales;
	private String yearS;
	
	private String quarterY;
	private long quarterlyYSales;
	private long monthlyYSales;
	private String monthY;
	private long yearlyYSales;
	private String yearY;
	
	private Date storeBudgetDate;
	private int storeBudgetTy;
	
	private long lastYearSales;
	private long thisYearSales;
	private float growthRate;
	
	private String tm;
	private String lm;
	
	private Long salePrice;
	private int itemNo;
	private String itemNm;
	private Long itemPrice;
	
	private int totalItem;
	private Long total;
	private int totalMenu;
	
	private long profit;

}
