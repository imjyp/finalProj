package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

@Data
public class AuthVO {
	private int authNo;
	private String userNo;
	private String authName;
	private Date authDate;
}
