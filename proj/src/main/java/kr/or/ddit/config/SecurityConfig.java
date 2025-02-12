package kr.or.ddit.config;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.access.hierarchicalroles.RoleHierarchy;
import org.springframework.security.access.hierarchicalroles.RoleHierarchyImpl;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.ProviderManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import jakarta.servlet.DispatcherType;
import kr.or.ddit.member.jy.service.impl.UserDetailServiceImpl;
import kr.or.ddit.security.CustomAccessDeniedHandler;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Configuration
@EnableWebSecurity(debug = false) // 스프링 시큐리티 필터가 스프링 필터체인에 등록이 됨.
@EnableMethodSecurity(securedEnabled = true, prePostEnabled = true) // securedEnabled => Secured 애노테이션 사용 여부, prePostEnabled => PreAuthorize 어노테이션 사용 여부.
public class SecurityConfig{

	@Autowired
	private DataSource dataSource; // application.properties에 설정한 spring.datasource D.I
	
	@Autowired
	UserDetailServiceImpl userServiceImpl;
	
	//1. 스프링 시큐리티 기능 비활성화
	/*
	 스프링 시큐리티의 모든 기능을 사용하지 않게 설정하는 코드. 즉, 인증, 인가 서비스를 모든 곳에 적용하지는 않음
	 일반적으로 정적 리소스(이미지, HTML 파일)에 설정함. 정적 리소스만 스프링 시큐리티 사용을 비활성화 하는 데
	 static 하위 경로에 있는 리소스를 대상으로 ignoring() 메서드를 사용함
	 */
	public WebSecurityCustomizer configure() {
		return (web)->web.ignoring()
				.requestMatchers(new AntPathRequestMatcher("/static/**"));
	}

	//2. 특정 HTTP 요청에 대한 웹 기반 보안 구성
	/*
	 이 메서드에서 인증/인가 및 로그인, 로그아웃 관련 설정을 할 수 있음
	 */
	@Bean
	protected SecurityFilterChain filterChain (HttpSecurity http)throws Exception {
		return http.csrf(csrf -> csrf.disable()).httpBasic(hbasic -> hbasic.disable())
				.headers(config -> config.frameOptions(customizer -> customizer.sameOrigin()))
				.authorizeHttpRequests(
						authz -> authz.dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.ASYNC).permitAll() // forward																														// 허가
								.requestMatchers("/login","/main","/signup" ,"/detail/**", "/error", "/adminlte/**", "/js/**", "/ckeditor/**", "/css/**", "/dist/**",  "/images/**", "/upload/**", "/error/**","/notice/**","/suggest/**","/**").permitAll()
								
								// 모든 권한 접근 가능
								//.requestMatchers("/**").hasAnyRole("CEO","SYS")
								
								
								// 공지사항
//								.requestMatchers("/notice/**").hasAnyRole("GY","IS","JJ","GH","MR","GMJ")
								
								// 본사 예산
								.requestMatchers("/bonsa/budget/**").hasAnyRole("IS","GH")
								
								// 가맹점 예산
								//.requestMatchers("/gmj/**").hasRole("GMJ")
								
								// 풀캘린더 이벤트
								.requestMatchers("/calendar/**").hasAnyRole("GY")
								
								// 풀캘린더 가맹점직원일정
								.requestMatchers("/calendarStore/**").hasAnyRole("GMJ")
								
								// 시스템 관리
								.requestMatchers("/sys/**").hasRole("SYS")
								
								/*
								// CEO
								.requestMatchers("/ceo/**").hasRole("CEO")
								// 경영
								.requestMatchers("/gy/**").hasRole("GY")
								// 인사/행정
								.requestMatchers("/is/**").hasRole("IS")
								// 재정/회계
								.requestMatchers("/jj/**").hasRole("JJ")
								// 전략/기획
								.requestMatchers("/gh/**").hasRole("GH")
								// 물류
								.requestMatchers("/mr/**").hasRole("MR")
								// 가맹점주
								.requestMatchers("/gmj/**").hasRole("GMJ")
								// 가맹점 직원(매니저, 알바)
								.requestMatchers("/gmjstaff/**").hasAnyRole("MANAGER","ALBA")
								*/
								
								// 대기 중인 사용자 제한 (ROLE_PENDING)
				                .requestMatchers("/pending/**").hasRole("PENDING") // 대기 중인 권한을 가진 사용자만 접근 가능
				                .requestMatchers("/ws/**", "/gs-guide-websocket/**").permitAll()
				                .requestMatchers("/notifications").authenticated()
				                .anyRequest().authenticated())
				
				.formLogin(formLogin->formLogin
						.loginPage("/login")
						.defaultSuccessUrl("/main",true))
				.sessionManagement(session -> session.maximumSessions(1))
				.exceptionHandling(ex->ex.accessDeniedHandler(customAccessDeniedHandler()))
				.logout(logout->logout
						.logoutSuccessUrl("/main")
						.invalidateHttpSession(true))
				.build();
		
	}
	
	//7. 인증 관리자 관련 설정
	/*
	 사용자 정보를 가져올 서비스를 재정의하거나, 인증 방법, 예를들어 LDAP, JDBC 기반 인증 등을 설정할 때 사용함
	 */
	@Bean
	public AuthenticationManager authenticationManager(HttpSecurity http,
			BCryptPasswordEncoder bCryptPasswordEncoder, 
			UserDetailsService userDetailService) throws Exception{
		DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
		//8. 사용자 정보 서비스 설정
		/*
		 userDetailsService() : 사용자 정보를 가져올 서비스를 설정함.
		 						 이때 설정하는 서비스클래스는 반드시 UserDetailsService를 상속받은 클래스여야 함.
		 passwordEncoder() : 비밀번호를 암호화하기 위한 인코더를 설정
		 */
		authProvider.setUserDetailsService(userServiceImpl);
		authProvider.setPasswordEncoder(bCryptPasswordEncoder);
		return new ProviderManager(authProvider);
	}
	
	//9. 패스워드 인코더로 사용할 빈 등록
	@Bean
	public BCryptPasswordEncoder bCryptPasswordEncoder() {
		return new BCryptPasswordEncoder();
	}
	
	//10. 접근거부 처리 핸들러
	@Bean
	public AccessDeniedHandler customAccessDeniedHandler() {
		//		 사용자정의 접근    거부   핸들러
		return new CustomAccessDeniedHandler();
	}

}




