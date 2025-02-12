package kr.or.ddit.security;

import java.io.IOException;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler{
	
	
	@Override
	public void onAuthenticationSuccess (HttpServletRequest request, HttpServletResponse response,
			Authentication authentication)throws IOException, ServletException {
		    log.debug("인증되셨어용 {}",authentication);
		    
		    response.sendRedirect("/auth");
	}
	
}