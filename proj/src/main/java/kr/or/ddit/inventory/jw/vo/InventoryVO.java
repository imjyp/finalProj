package kr.or.ddit.inventory.jw.vo;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class InventoryVO {

	@JsonFormat(pattern="yyyy-MM-dd", timezone="Asia/Seoul")
	private Date expDate;
	private int invntryRecordNo;
	private int itemNo;
	private int recordTy;
	private int recordAmount;
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="Asia/Seoul")
	private Date recordRegDate;
	private int recordItemPrice;
	private int storeOrderNo;
	private int headOrderNo;
	private int remainAmount;
	
	private int rnum;
	
	private int safetyAmount; //안전재고 수량
	private String itemNm;
	private int itemAmount;
	private int salePrice; //판매가
	
	private String userNo; 
	private String userNm; 
	private String storeNm; 
}
