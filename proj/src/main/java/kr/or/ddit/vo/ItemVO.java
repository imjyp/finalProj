package kr.or.ddit.vo;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class ItemVO {

	private int rnum;
	private int itemNo;
	private String itemNm;
	private int itemPrice;
	private int salePrice;
	private int itemDel;    // 1: 게시, 2: 삭제 상태 추가
	
	private int storeNo;	// 품목리스트를 이용하여 가맹점 발주
	
	private int storeOrderNo;
	
	private int safetyAmount; //안전재고 수량
	private int avgPurchasePrice; //평균 매입가
	private int remainAmount; //재고수량
	@JsonFormat(pattern="yyyy-MM-dd", timezone="Asia/Seoul")
	private Date expDate; // 유통기한
	
	
	
}
