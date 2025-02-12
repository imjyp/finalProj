package kr.or.ddit.orgChart.jm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.OrgChartVO;

@Mapper
public interface OrgChartMapper {

	//데이터 계층형 json형식으로 변환하기
	public List<OrgChartVO> listOrgChart();

//	//데이터 list<OrgChartVO> 타입으로 가져오기
//	public List<OrgChartVO> selectDeptList();
	
//	//등록
//	public int createOrgChart(OrgChartVO orgChartVO);
//	//수정
//	public int updateOrgChart(OrgChartVO orgChartVO);
//	//삭제
//	public int deleteOrgChart(OrgChartVO orgChartVO);

}
