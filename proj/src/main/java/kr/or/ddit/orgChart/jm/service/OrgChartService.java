package kr.or.ddit.orgChart.jm.service;

import java.util.List;

import kr.or.ddit.vo.OrgChartVO;

public interface OrgChartService {
	
	//데이터 list<OrgChartVO> 타입으로 가져오기
	public List<OrgChartVO> listOrgChart();

//	//조직도 데이터를 children 있는 계층 구조로 변환
//	public Map<String, Object> getDeptHierarchyForTree();
	
//	//생성
//	public int createOrgChart(OrgChartVO orgChartVO);
//	//수정
//	public int updateOrgChart(OrgChartVO orgChartVO);
//	//삭제
//	public int deleteOrgChart(OrgChartVO orgChartVO);
	

	

	

}
