package kr.or.ddit.vo;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class CalendarVO {
	
	private int calNm;			//캘린더 번호
	private String calTitle;	//캘린더 제목
	private String calContent;	//캘린더 내용
    
//	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="Asia/Seoul")
	@DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private LocalDateTime  calStart; //캘린더 시작일
	@DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private LocalDateTime  calEnd;	//캘린더 종료일
    
	private String textColor;	//캘린더 글자색
	private String bgColor;		//캘린더 배경색
	private String userNo;		//캘린더 작성자
	private int calendarTy;		//캘린더 타입
	
	private long fileGroupNo;	//캘린더 파일그룹번호
	private int calStatus;	//캘린더 상태값(sql로 삭제상태 조회/처리)
	@DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
	private LocalDateTime calRegDate;	//캘린더 작성일
	private String readerNo;		//캘린더 대상자 아이디
	private String readerNm;	//캘린더 대상자 이름
	private int calCnt;			//캘린더 조회수
	
	private String userNm; //회원 이른
	private String deptNm; //부서 이름
	private int rnum;

	private MultipartFile[] uploadFiles; //스프링 파일 객체
	
	private FileGroupVO fileGroupVO; //1 : 1
}
