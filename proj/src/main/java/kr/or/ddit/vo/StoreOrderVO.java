package kr.or.ddit.vo;

import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class StoreOrderVO {
	private Integer storeOrderStatus;
	private int storeOrderSum;
	private int billNo;
	private String storeOrderTitle;
	private int storeOrderNo;
	private int storeNo;
//	골뱅이DateTimeFormat(pattern="yyyy-MM-dd")
	private String storeOrderDate;
	private long fileGroupNo;
	
	// 선택된 품목 리스트
	private List<ItemVO> selectedItems;  
	
	// 발주 상세 리스트
	private List<StoreOrderDetailVO> storeOrderDetailList;
	
	private String storeNm;
	
	private int totalPrice;
	
	private MultipartFile[] uploadFiles;
	
	private FileGroupVO fileGroupVO;
	private StoreVO storeVO;
	
	private int rnum;
	
	private Integer storeOrderCount;
}
