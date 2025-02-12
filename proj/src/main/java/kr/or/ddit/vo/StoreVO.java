package kr.or.ddit.vo;


import java.sql.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class StoreVO {
	private int storeNo;
	private double storeLat;
	private double storeLot;
	private String storeAddr1;
	private int storeZip;
	private String storeNm;
	private String storeAddr2;
	private String storeStatus;
	
	private Date storeOpenDate;
	
	private int useTotal;
	private int storeBudgetNo;
	private int storeBudget;
	 @DateTimeFormat(pattern="yyyy-MM-dd")
	private int storeBudgetYear;
	private String storeBudgetDate;
	private String storeBudgetContent;
	private int storeBudgetTy;
	
	private int rnum;
	private int rank;
	private int total;
	private int monthlyAvg;
	
	private long restBG;
	
	private int billNo;
}
