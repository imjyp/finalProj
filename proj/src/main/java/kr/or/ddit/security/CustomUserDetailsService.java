package kr.or.ddit.security;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;

import jakarta.servlet.http.HttpSession;
import kr.or.ddit.alert.jy.service.AlertService;
import kr.or.ddit.member.jy.mapper.MemberMapper;
import kr.or.ddit.vo.AlertVO;
import kr.or.ddit.vo.TBUserVO;
import lombok.extern.slf4j.Slf4j;

//***사용안하고 있음.->UserDetailServiceImpl를 통해 로그인 처리중
@Slf4j
public class CustomUserDetailsService implements UserDetailsService{

	@Autowired
	private MemberMapper memberMapper;
	
	@Autowired
    AlertService alertService;
	
	@Override
	public UserDetails loadUserByUsername (String username) throws UsernameNotFoundException {
		log.debug("CKK1 {}",username);
	
		TBUserVO userVO = memberMapper.read(username);
		/*
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
		log.debug("loadUserByUsername->userVO : {}",userVO);
		
		
		if(userVO != null) {
			//로그인 시 알림 목록을 userVO에 넣어줌 시작 ///
//			Map<String, Object> map = new HashMap<>();
			List<AlertVO> alerts = alertService.userAlertList(username, 1, "");
			
			log.info("loadUserByUsername -> alerts : " + alerts);
			
			userVO.setAlerts(alerts);
			//로그인 시 알림 목록을 userVO에 넣어줌 끝 ///
			
			return new CustomUser(userVO);
		}else {
			throw new UsernameNotFoundException(username);
		}
	}
}