package kr.or.ddit.resource.jw.vo;

import java.sql.Date;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.vo.FileGroupVO;
import lombok.Data;

@Data
public class ResourceVO {

	private int boardNo;
	private int boardCodeNo;
	private String boardTitle;
	private String boardCn;
	private Date boardRegDate;
	private int boardCnt;
	private int boardStatus;
	private String userNo;
	private long fileGroupNo;
	//@DateTimeFormat(pattern="yyyy-MM-dd") -> date 타입이면 오류발생
	private Date boardStart;
	//@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date boardEnd;
	
	private int rnum;
	private String userNm; //회원 이른
	private String deptNm; //부서 이름
	private MultipartFile[] uploadFiles; //스프링 파일 객체
	
	private FileGroupVO fileGroupVO;
}
