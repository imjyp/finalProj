package kr.or.ddit.jstree.jw.vo;

import java.util.List;

import kr.or.ddit.vo.TBUserVO;
import kr.or.ddit.vo.UsersVO;
import lombok.Data;

@Data
public class JstreeDeptVO {

	private int userStatus;
	private String userNo;
	private int enabled;
	private int userCode;
	private String userNm;
	//private long userProfile;
	private int userSign;
	//private String userSysYn;
	
	private String empManager;
	private int deptNo;
	private String deptNm;
	private int deptSuprr;
	
	
	private int positionNo;
	private String positionNm;
	
	private int id;
	private String text;
	private String parent;
	private String children;
	
	private List<TBUserVO> tbUserVOList;
	
	
}
