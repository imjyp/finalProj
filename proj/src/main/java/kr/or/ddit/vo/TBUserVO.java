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
	// 2024-11-27(문자타입)->pattern->날짜타입
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date userBirth;
	// 2024-11-27(문자타입)->pattern->날짜타입
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date userIndate;
	private long userProfile;
	private long userSign;
	private String userSysYn;
	// 2024-11-27(문자타입)->pattern->날짜타입
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date userCreate;
	private String userAddr1;
	private String userAddr2;
	private int userZip;
	private int userStatus;
	
	
	// 행번호
	private int rnum;
		
	// MEMBER : FILE_GROUP = 1 : 1
	private FileGroupVO fileGroupVO;
	private FileGroupVO fileGroupSignVO;
	
	// 이미지 파일들
	private MultipartFile[] uploadFiles;
	
	// AUTH
	private List<AuthVO> authList;
	private String authName;
	// 2024-11-27(문자타입)->pattern->날짜타입
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date authDate;
	
	// DEPT
	private List<DeptVO> deptList;
	private Integer deptNo;	// 가맹점 직원 가입 시 null 처리 위해 Integer로 변경
	private String deptNm;
	
	// POSITION
	private List<PositionVO> positionList;
	private Integer positionNo;
	private String positionNm;
	
	// STORE
	private List<StoreEmpVO> storeEmpList;
	private Integer storeNo;
	private String storeNm;
	
	// EMPOLYEE
	private List<EmployeeVO> employeeList;
	private String empManager;

	// 시스템 관리자 요약
	private int pendingCnt;
    private int approvalCnt;
    private int totalMem;
    private int bonsaEmp;
    private int storeEmp;
    private int mem;
    private int delMem;
    
    //알림
    private List<AlertVO> alerts;
}
