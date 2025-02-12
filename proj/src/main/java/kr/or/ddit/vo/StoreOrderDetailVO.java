package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

@Data
public class StoreOrderDetailVO {

	private int storeOrderNo;
	private int itemNo;
	private int storeOrderAmount;
	private int storeOrderPrice;
	
	// 선택된 품목 리스트
	private List<ItemVO> selectedItems;  
	 
	 // item 리스트 값 불러오는 용도
	 private int runm;
	 private String itemNm;
	 private int itemPrice;
	 private int salePrice;
	 
	 private Integer storeNo;
}
