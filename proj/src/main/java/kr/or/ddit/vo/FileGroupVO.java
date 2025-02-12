package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

//자바빈 클래스
//POJO(Plain Oriented Java Object)가 약해짐
@Data
public class FileGroupVO {
	private long fileGroupNo;
	private String fileGroupNm;
	private Date fileRegdate;
	private int fileGroupTy;
	
	//파일그룹 : 파일상세 = 1 : N
	private List<FileDetailVO> fileDetailVOList;
}
