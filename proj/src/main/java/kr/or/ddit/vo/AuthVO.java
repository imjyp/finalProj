package kr.or.ddit.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class AuthVO {
	private int authNo;
	private String userNo;
	private String authName;
	// 2024-11-27(문자타입)->pattern->날짜타입
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date authDate;
	
	private int rnum; // 행번호
}
