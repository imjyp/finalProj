package kr.or.ddit.vacationSG;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class VacationController {

	@GetMapping("/vacation")
	public String alertPage() {
		return "vacation";
	}
}
