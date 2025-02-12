package kr.or.ddit.commuteSG2.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CommuteController2 {

    @GetMapping("/commute2")
    public String showCommutePage() {
        return "commute2"; // commute2.jsp 파일을 반환
    }
}
