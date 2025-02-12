package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class MemberVO {
	private String memId;
	private String memName;
	private String memPw;
	private boolean memEnable;
	private String memRegdate;
	private Long   fileGroupNo;//파일 그룹 번호
	private String fileSaveLocate; //파일 웹 경로
	
	private String memPass;
	private String memRegno1;
	private String memRegno2;
	//2024-11-27(문자타입)->pattern->날짜타입
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date   memBir;
	private String memBirStr;
	private String memZip;
	private String memAdd1;
	private String memAdd2;
	private String memHometel;
	private String memComtel;
	private String memHp;
	private String memMail;
	private String memJob;
	private String memLike;
	private String memMemorial;
	private Date   memMemorialday;
	private int    memMileage;
	private String memDelete;
	
//	request{memId=t001, memPass=0506, memName=성원태2,
// 			memZip=306-702, 
//			memAdd1=대전광역시 중구 유천동, memAdd2=한사랑아파트 302동 504호,
//			memBir=2024-11-27,uploadFiles=파일객체}
	
	private int rnum;//행번호
	
	
	//MEMBER : FILE_GROUP = 1 : 1
	private FileGroupVO fileGroupVO;
	
	//이미지 파일들
	private MultipartFile[] uploadFiles;
	
	private List<AuthVO> authList;
}