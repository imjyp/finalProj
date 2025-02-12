package kr.or.ddit.vo;


import java.sql.Date;

import lombok.Data;

@Data
public class SchdVO {
	private int schdulNo;
	private Date schdulDate;
	private String userNo;
	private String attend;
	private String leave;
	private String workingTime;
	private String status;
	private int js;
	private int jg;
	private int jgtg;
	private float avgWorkingTime;
	
	private String deptNm;
	private String positionNm;
	private String userNm;
	
}
