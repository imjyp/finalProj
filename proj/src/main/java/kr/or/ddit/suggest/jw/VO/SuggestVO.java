package kr.or.ddit.suggest.jw.VO;


import java.sql.Date;

import lombok.Data;

@Data
public class SuggestVO {

	private int suggestBoardNo;
	private String suggestContent;
	private Date suggestDate;
	private String userNo;
	private String suggestTitle;
	private int suggestStatus;
	
	private int rnum;
	private String userNm; //회원 이른
}
