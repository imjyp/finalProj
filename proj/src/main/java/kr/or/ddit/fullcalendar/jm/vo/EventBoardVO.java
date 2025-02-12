package kr.or.ddit.fullcalendar.jm.vo;

import java.sql.Date;
import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class EventBoardVO {

	private int boardNo;		//게시판 번호
	private int boardCodeNo;	//게시판 분류번호 1.공지사항, 2.이벤트, 3.자료실
	private String boardTitle;	//제목
	private String boardCn;		//내용
	private Date boardRegDate;	//작성일자
	private int boardCnt;		//조회수
	private int boardStatus;	//게시글 삭제 여부 1.게시 2.삭제
	private String userNo;		//회번번호 작성자
	private int fileGroupNo;	//파일그룹번호
	
	//private Date boardStart;	// 이벤트 시작날짜
	//private Date boardEnd;		// 이벤트 종료날짜
	@DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
	private LocalDateTime boardStart;	// 이벤트 시작날짜
	@DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
	private LocalDateTime boardEnd;		// 이벤트 종료날짜
	
	//board 테이블에 없는 데이터 변수들
	private int rnum;			//각 행에 대해 고유한 번호(순차 번호)[테이블에 없음]
	private String userNm; 		//회원 이른[테이블에 없음]
	private String deptNm; 		//부서 이름[테이블에 없음]
}

