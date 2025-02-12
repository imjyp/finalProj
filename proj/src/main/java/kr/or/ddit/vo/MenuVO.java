package kr.or.ddit.vo;

import java.sql.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class MenuVO {
	private int menuNo;
	private String menuNm;
	private int ctgryNo;
	private String ctgryNm;
	private int menuPrice;
	private String menuCn;
	private Date menuRegist;
	private int menuDel;
	private long fileGroupNo;
	
	private MultipartFile[] uploadFiles;
	private FileGroupVO fileGroupVO;
	private List<FileDetailVO> fileDetailList;
}
