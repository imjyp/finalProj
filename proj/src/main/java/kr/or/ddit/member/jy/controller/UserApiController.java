package kr.or.ddit.member.jy.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.servlet.server.Session;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.dept.jy.service.DeptService;
import kr.or.ddit.member.jy.service.UserService;
import kr.or.ddit.position.jy.mapper.PositionMapper;
import kr.or.ddit.position.jy.service.PositionService;
import kr.or.ddit.vo.AuthVO;
import kr.or.ddit.vo.DeptVO;
import kr.or.ddit.vo.PositionVO;
import kr.or.ddit.vo.TBUserVO;
import lombok.extern.slf4j.Slf4j;

@PreAuthorize("isAnonymous()")
@Slf4j
@Controller
public class UserApiController {
   
   @Autowired
   UserService userService;
   
   @Autowired
   DeptService deptService;
   
   @Autowired
   PositionService positionService;
   
   
   /*
      요청URI : /user
      요청파라미터 : request{email=test@test.com,password=asdf}
      요청방식 : post
    */
   @PostMapping("/user")
   public String signup(TBUserVO userVO, HttpSession session, Model model) {
      
	  log.info("signup->userVO(전) : " + userVO);
      
      //회원 가입 메서드 호출
      int result = this.userService.save(userVO);
      log.info("signup->userVO(후) : " + userVO);
      
      // userNo 세션에 저장;
      session.setAttribute("userNo", userVO.getUserNo());
      
      // 부서 목록
      List<DeptVO> deptList = this.deptService.listAll();
      log.info("user -> deptList : " + deptList);
      
      // 직책 목록
      List<PositionVO> positionList = this.positionService.listAll();
      log.info("user -> positionList : " + positionList);
      
      // 부서/직책 목록 세션에 저장
      session.setAttribute("deptList", deptList);
      session.setAttribute("positionList", positionList);
      
      // 권한 부여 메서드 호출(ROLE_PENDING 권한 부여)
//      AuthVO authVO = new AuthVO();
//      this.userService.pending(authVO);
      
      //회원 가입이 완료된 이후에 상세정보 입력 페이지로 리다이렉트      
      return "redirect:/detail";
   }
   
   // 상세 정보 입력 페이지
   @GetMapping("/detail")
   public String datailPage(HttpSession session, Model model) {
      // 세션에서 부서 목록 가져오기
      List<DeptVO> deptList = (List<DeptVO>) session.getAttribute("deptList");
      log.info("user -> deptList : " + deptList);
      
      // 세션에서 직책 목록
      List<PositionVO> positionList = (List<PositionVO>) session.getAttribute("positionList");
      log.info("user -> positionList : " + positionList);
      
      model.addAttribute("deptList", deptList);
      model.addAttribute("positionList", positionList);
      log.info("user -> userNo : " + (String) session.getAttribute("userNo"));

      String userNo = (String) session.getAttribute("userNo");
      
      if(userNo == null) {
         // 세션에 userNo가 없다면 오류 처리
         return "redirect:/member/signup";
      }
      
      return "member/details";
   }
   
   // 상세 정보 입력
   @PostMapping("/user/details")
   public String details(TBUserVO userVO) {
	   
	  // 기본 프로필 이미지에 해당하는 파일 그룹 번호 
	  long DEFAULT_PROFILE = 20250122036L; 
	    
	  // 프로필 이미지가 업로드되지 않은 경우, userProfile 필드가 기본값 0일 것으로 가정
	  if(userVO.getUserProfile() == 0) {
	     userVO.setUserProfile(DEFAULT_PROFILE);
	  } 
	    
      log.info("details -> userVO : " + userVO);
      
      int result = this.userService.details(userVO);
      
      if (result >0) {
         return "redirect:/";   // 입력 완료 후 메인 페이지(로그인 전)로 리다이렉트
      }
      else {
         return "redirect:/member/details";
      }
   }
   
   
   // 아이디 중복검사
   @ResponseBody
   @PostMapping("/idDupChk")
   public int idDupChk(@RequestBody TBUserVO userVO) {
      int result = this.userService.idDupChk(userVO);
      log.info("idDupChk -> result : " + result);
      
      return result;
   }
   
   // 로그아웃
   @GetMapping("/logout")
   public String logout(HttpServletRequest request, HttpServletResponse response) {
      new SecurityContextLogoutHandler().logout(request, response, 
            SecurityContextHolder.getContext().getAuthentication()
      );
      
      return "redirect:/main";
   }
}

