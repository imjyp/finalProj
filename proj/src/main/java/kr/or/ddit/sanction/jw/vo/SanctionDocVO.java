package kr.or.ddit.sanction.jw.vo;


import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonFormat;

import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.FileGroupVO;
import lombok.Data;


@Data
public class SanctionDocVO {

	private int docNo;
	private String userNo;
	private String docTitle;
	private String docContent;
//	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="Asia/Seoul")
	private Date docCreateDate;
	private long fileGroupNo;
	private int docTypeNo;
	private int docStatus;
	private int rnum;
	
	private String docTypeNm; //문서유형 이름
	private String sanctionTypeNm; //결제처리 이름
	private String sanctionStatusNm; //결제상태 이름
	private String sanctionLineNm; //결제선 이름
	
	
	private String userNm; //회원 이름
	private String deptNm; //부서 이름
	private MultipartFile[] uploadFiles; //스프링 파일 객체
	
	//1 : 1
	private FileGroupVO fileGroupVO;
	//1 : 1
	private EmployeeVO employeeVO;
	
	//1 : N
	private List<SanctionVO> sanctionVOList;
	//1 : N
	private List<ReceiveVO> receiveVOList;
	
	private String[] sanctionUsers;
	private String[] sanctionLines;
	private String[] sanctionTypes;
	private String[] receive;

	private String userId; //로그인 회원 id
	private String sanctionUserNm; //결재자 이름
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="Asia/Seoul")
	private Date sanctionDate;//결재날짜
}
