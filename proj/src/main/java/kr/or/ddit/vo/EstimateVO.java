package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class EstimateVO {

	private int estimateNo;
	private int storeOrderNo;
	private String estimateTitle;
	private long fileGroupNo;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private String estimateDate;
	private int estimateStatus;
	
	private MultipartFile[] uploadFiles;
	
	private FileGroupVO fileGroupVO;
	
	private int rnum;
	
	// 선택한 발주 번호 리스트
	private List<StoreOrderVO> selectedOrders;
	
	
}
