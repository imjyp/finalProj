package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

@Data
public class AlertVO {

	private int alertNo;
	private String alertCn;
	private int alertChk;
	private Date alertCreate;
	private int alertTy;
	private String userNo;
	private String alertPk;
	private String alertUrl;
	private int alertFile;
	
	private int rnum;
}
