package kr.or.ddit.sanction.jw.vo;



import java.sql.Date;

import lombok.Data;


@Data
public class SanctionVO {
	
	private int sanctionStatusNo;
	private int docNo;
	private int sanctionTypeNo;
	private int sanctionNo;
	private String sanctionUser;
	private Date sanctionDate;
	private String sanctionLineType;

	private String sanctionTypeNm;
	private String sanctionLineNm;
	private String sanctionUserNm;
	private String sanctionUserPosition;
	private String sanctionUserSign;
	
	private int rnum;
	private String sanctionStatusNm;
	private String docTitle;
	private String docTypeNm;
	private Date docCreateDate;
	private String deptNm;
	private String userNm;
	
	
	
	
}
