package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

@Data
public class StoreVO {
	private int storeNo;
	private int storeLat;
	private int storeLot;
	private String storeAddr1;
	private int storeZip;
	private String storeNm;
	private String storeAddr2;
	
	
	private int storeBudgetNo;
	private int storeBudget;
	private int storeBudgetYear;
	private Date storeBudgetDate;
	private String storeBudgetContent;
	private int storeBudgetTy;
}
