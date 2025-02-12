package kr.or.ddit.notice.jw.vo;

import java.sql.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class NoticeVO {

	private int boardNo;		//게시판 번호
	private int boardCodeNo;	//게시판 분류번호
	private String boardTitle;	//제목
	private String boardCn;		//내용
	private Date boardRegDate;	//작성일자
	private int boardCnt;		//조회수
	private int boardStatus;	//게시글 삭제여부
	private String userNo;		//회원번호
	private int fileGroupNo;	//파일그룹번호

	//@DateTimeFormat(pattern="yyyy-MM-dd") -> date 타입이면 오류발생
	private Date boardStart;	//시작날짜
	//@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date boardEnd;	//종료날짜
	
	private int rnum;
	private String userNm; //회원 이른
	private String deptNm; //부서 이름
}
