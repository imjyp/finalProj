package kr.or.ddit.find.controller;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.text.RandomStringGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.MailSender;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;

import org.apache.commons.lang3.RandomStringUtils;

import kr.or.ddit.config.MailService;
import kr.or.ddit.find.service.iFindIdService;
import kr.or.ddit.vo.TBUserVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class FindIdController {
	
	@Autowired
	MailService mail;
	
	@Autowired
	iFindIdService findIdService;
	
	
	
	@GetMapping("/findId")
	public String findId() {
		
		return "find/findId";
	}
	
	@PostMapping("/findIdChk")
	public String findIdChk(Model model, @RequestParam String userNm,
			 @RequestParam String userMail) {
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("userNm", userNm);
		map.put("userMail", userMail);
		log.info("아이디 찾기:", map);
		TBUserVO uservo = this.findIdService.findId(map);
		
		model.addAttribute("uservo",uservo);
		
		return "find/findId2";
	}
	
	@GetMapping("/findPassword")
	public String findPassword() {
		return "find/findPassword";
	}
	
	
	@PostMapping("/findPassword")
	public String findPassword(Model model, TBUserVO uservo, @RequestParam String userNm,
			 @RequestParam String userMail, @RequestParam String userNo) throws MessagingException {
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("userNm", userNm);
		map.put("userMail", userMail);
		map.put("userNo", userNo);
		
		log.info("비번 찾기:"+ map);
		
		int  cnt = this.findIdService.findPw(map);
		if(cnt == 0) {
			model.addAttribute("msg", "기입된 정보가 잘못되었습니다. 다시 입력해주세요.");
			return "find/findPassword";
		}
		
		 RandomStringGenerator generator = new RandomStringGenerator.Builder()
	                .withinRange('0', 'z') 
	                .filteredBy(Character::isLetterOrDigit) 
	                .build();
	    
		 
        String newPwd = generator.generate(10);
		log.info("새로운 비번"+newPwd);
		
		log.info("입력된 이메일 주소 (전처리 전): " + userMail);
		String cleanedUserMail = userMail.trim();
		log.info("입력된 이메일 주소 (전처리 후): " + cleanedUserMail);
		this.mail.sendSimpleMessage(cleanedUserMail, newPwd);
		
		map.put("newPwd", newPwd);
		int result = this.findIdService.pwdUpdate(map);
		model.addAttribute("newPwd", newPwd);
		
		//return "find/findPassword2";
		return "member/login";
	}
	

	@GetMapping("/updatePW")
	public String updatePW() {
		
		return "find/updatePw";
	}
	
	@PostMapping("/updatePassword")
	public String updatePassword(@RequestParam String userPw) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userNo = auth.getName();
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("userNo", userNo);
		map.put("userPw", userPw);
		
		int result = this.findIdService.updatepwd(map);
		
		return "mypage";
		
	}
}
