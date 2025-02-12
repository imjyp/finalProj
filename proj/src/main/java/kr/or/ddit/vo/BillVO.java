package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class BillVO {

	private String billStatus;
//	골뱅이DateTimeFormat(pattern="yyyy-MM-dd")
	private String billDate;
	private int billNo;
	private String billTitle;
	private long fileGroupNo;
	
	private MultipartFile[] uploadFiles;
		
	private FileGroupVO fileGroupVO;
	private StoreOrderVO storeOrderVO;
	
	private int rnum;
	
	// 선택된 발주 상세 리스트
	private List<StoreOrderDetailVO> selectedItems;
	
	// 발주 데이터 값 불러오는 용도
	private int storeOrderNo;
	private int storeNo;
	private String storeNm;
	
}
