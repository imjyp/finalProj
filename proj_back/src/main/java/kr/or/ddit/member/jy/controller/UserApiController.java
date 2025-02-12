package kr.or.ddit.member.jy.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.member.jy.service.UserService;
import kr.or.ddit.vo.TBUserVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class UserApiController {
	
	@Autowired
	UserService userService;
	
	/*
      요청URI : /user
      요청파라미터 : request{email=test@test.com,password=asdf}
      요청방식 : post
	 */
	@PostMapping("/user")
	public String signup(TBUserVO userVO) {
		/*
		UsersVO(id=2, email=test@test.com
			, password=$2a$10$26Nre187gKSRlh.dhFV0N.ZpSDbXjL5VyrrgOWS1m1/J5DgoLdKlC, createdAt=null, updatedAt=null)
		 */
		log.info("signup->userVO(전) : " + userVO);
		
		//회원 가입 메서드 호출
		int result = this.userService.save(userVO);
		log.info("signup->userVO(후) : " + userVO);
		//회원 가입이 완료된 이후에 로그인 페이지로 이동		
		return "redirect:/login";
	}
	
	//로그아웃
	@GetMapping("/logout")
	public String logout(HttpServletRequest request, HttpServletResponse response) {
		new SecurityContextLogoutHandler().logout(request, response, 
				SecurityContextHolder.getContext().getAuthentication()
		);
		
		return "redirect:/main";
	}
}







