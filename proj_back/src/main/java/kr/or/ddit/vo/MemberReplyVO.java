package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

@Data
public class MemberReplyVO {
	private int idx;
	private String memId;// /member/detail?memId=u001
	private String userId;// 댓글 작성자
	private Date replyRegdate;
	private int parentIdx;
	private String replyContent;
	private String replyStatus;
	
	private String memName;//댓글 작성 회원 명
	private String fileSaveLocate;//댓글 작성 회원 대표 사진 웹경로
	private int    lvl;	//계층형 레벨
	
}
