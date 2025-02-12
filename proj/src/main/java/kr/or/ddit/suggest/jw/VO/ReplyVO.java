package kr.or.ddit.suggest.jw.VO;


import java.util.Date;

import lombok.Data;

@Data
public class ReplyVO {
	private int repNo;
	private int parentNo;
	private int suggestBoardNo;
	private Date repRegDate;
	private String repContent;
	private int repStatus;
	private String repUser;
	private int lvl; //계층형쿼리에서 level
	
	private String userNm;
}
