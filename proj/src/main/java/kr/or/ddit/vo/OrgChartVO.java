package kr.or.ddit.vo;


import lombok.Data;

@Data
public class OrgChartVO {

private Integer  id;	// DEPT_NO
private String name;	// DEPT_NM
private Integer parent; // DEPT_SUPRR (null 가능)
private int level; // LEVEL
private String img = "https://cdn.balkan.app/shared/empty-img-white.svg";

}
