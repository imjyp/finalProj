package kr.or.ddit.security;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import kr.or.ddit.vo.TBUserVO;
import lombok.Getter;

//CustomUser 		= jsp의 principal
//CustomUser.userVO = jsp의 principal.userVO
@Getter
public class CustomUser extends User{

	private static final long serialVersionUID = 1L;
	private TBUserVO userVO;
	 
	public CustomUser (String username, String password, Collection<? extends GrantedAuthority> authorities){
		super(username, password, authorities);
	}
	
	/* userVO는
	TBUserVO(userNo=a001, userPw=$2a$10$h9l1k66yvuH4Gl6S6pNBHO.6kA7J4zTTOK6Sb.jjqn7fj5tiLL7jG, 
	enabled=1, userCode=1, userNm=김은대, userMail=null, userPhone=null, userBirth=null, userIndate=null, 
	userProfile=20241231003, userSign=0, userSysYn=N, userCreate=Fri Dec 20 14:58:51 KST 2024, userAddr1=null, 
	userAddr2=null, userZip=0, rnum=0, fileGroupVO=FileGroupVO(fileGroupNo=20241231003, fileGroupNm=프로필, 
	fileRegdate=Tue Dec 31 00:00:00 KST 2024, fileGroupTy=5, 
	
		fileDetailVOList=[FileDetailVO(fileNo=3, fileGroupNo=20241231003, fileOriginalName=1.jpg, 
		fileSaveName=dd0804e3-f84b-475e-a165-f240cf6ae495_1.jpg, 
		fileSaveLocate=/upload/2024/12/31/dd0804e3-f84b-475e-a165-f240cf6ae495_1.jpg, fileSize=196000, 
		fileExt=null, fileMime=image/jpeg, fileFancysize=196KB, fileSaveDate=Tue Dec 31 00:00:00 KST 2024, 
		fileDowncount=0)]), 
	uploadFiles=null, 
		authList=[AuthVO(authNo=1, userNo=a001, authName=ROLE_GY, authDate=Mon Dec 23 10:42:26 KST 2024, rnum=0), 
		AuthVO(authNo=116, userNo=a001, authName=ROLE_PENDING, authDate=Fri Jan 03 15:13:53 KST 2025, rnum=0)], 
	authName=null, authDate=null, deptList=null, deptNo=2, deptNm=경영, positionList=null, positionNo=3, 
	positionNm=부장, storeEmpList=null, storeNo=null, storeNm=null, employeeList=null, empManager=null)
	 */
	public CustomUser (TBUserVO userVO){
		super(userVO.getUserNo(),userVO.getUserPw(),
				userVO.getAuthList().stream().map(auth -> new SimpleGrantedAuthority(auth.getAuthName())).collect(Collectors.toList()));
		this.userVO = userVO;
	}
	
}