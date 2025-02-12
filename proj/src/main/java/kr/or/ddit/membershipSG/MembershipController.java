package kr.or.ddit.membershipSG;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MembershipController {

	@GetMapping("/membership")
	public String alertPage() {
		return "membership";
	}
}
