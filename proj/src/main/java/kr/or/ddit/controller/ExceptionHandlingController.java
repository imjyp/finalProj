package kr.or.ddit.controller;

import java.util.Date;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ExceptionHandlingController implements ErrorController {
	
	/* HTTP 오류 상태 코드(ERROR_STATUS_CODE) 정리
	- 400 : Bad Request. 문법 오류(잘못 입력한 url)
	- 404* : Not Found. 요청한 문서를 찾지 못함(url확인 및 캐시 삭제가 필요한 상태)
	- 405 : Method not allowed. 메소드 허용 안됨(메소드 매핑이 안 될 때 발생)
	- 415 : 서버의 요청에 대한 승인 거부. (ContentType, Content Encoding 데이터 확인 필요)
	- 500* : 서버 내부 오류. (웹 서버가 요청사항을 수행할 수 없을 때 발생)
	- 505 : HTTP Version Not Supported.
	*/
	
	//에러 페이지 정의
	private final String ERROR_404_PAGE_PATH = "error/error404";
	private final String ERROR_500_PAGE_PATH = "error/error500";
	private final String ERROR_ETC_PAGE_PATH = "error/errorException";

	@RequestMapping("/error")
	public String handleError(HttpServletRequest request, Model model) {
		
		//오류 코드 획득
		Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
		log.info("handleError->status : " + status.toString());//404
		
		//오류 코드에 대한 상태 정보
		HttpStatus httpStatus = HttpStatus.valueOf(Integer.valueOf(status.toString()));
		
		if(status != null) {
			//HttpStatus와 비교해 페이지 분기를 나누기 위한 변수
			int statusCode = Integer.valueOf(status.toString());//404, 500
			
			log.info("httpStatus : " + statusCode);
			
			//404 error(HttpStatus.NOT_FOUND.value() : 404)
			if(statusCode == HttpStatus.NOT_FOUND.value()) {
				model.addAttribute("code",status.toString());
				model.addAttribute("msg",httpStatus.getReasonPhrase());
				model.addAttribute("timestamp",new Date());
				// "error/404"
				return ERROR_404_PAGE_PATH;
			}
			
			//500 error
			if(statusCode == HttpStatus.INTERNAL_SERVER_ERROR.value()) {
				//서버 에러. 
				return ERROR_500_PAGE_PATH;
			}
		}
		
		//400, 500 외 모든 에러는 error/error 페이지로 보냄
		return ERROR_ETC_PAGE_PATH;
	}
	
	
	
}










