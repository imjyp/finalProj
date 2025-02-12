package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class TBUserVO {
	
	private String userNo;
	private String userPw;
	private int enabled;
	private int userCode;
	private String userNm;
	private String userMail;
	private String userPhone;
	//2024-11-27(문자타입)->pattern->날짜타입
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date userBirth;
	private Date userIndate;
	private int userProfile;
	private int userSign;
	private String userSysYn;
	private Date userCreate;
	private String userAddr1;
	private String userAddr2;
	private int userZip;
	
	private int rnum;//행번호
		
	//MEMBER : FILE_GROUP = 1 : 1
	private FileGroupVO fileGroupVO;
	
	//이미지 파일들
	private MultipartFile[] uploadFiles;
	
	//TB_USER U : AUTH A = 1 : N
	private List<AuthVO> authList;
}
