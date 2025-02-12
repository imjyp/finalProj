package kr.or.ddit.notice.jw.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class NoticeVO {

	private int boardNo;
	private int boardCodeNo;
	private String boardTitle;
	private String boardCn;
	private Date boardGegDate;
	private int boardCnt;
	private int boardStatus;
	private String userNo;
	private int fileGroupNo;
	private Date bardStart;
	private Date boardEnd;
}
