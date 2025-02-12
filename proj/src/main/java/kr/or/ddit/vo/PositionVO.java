package kr.or.ddit.vo;

import lombok.Data;

@Data
public class PositionVO {
	private Integer positionNo; 
	private String positionNm;
	private int positionState;
    private String positionAffiliation;
}
