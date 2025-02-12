package kr.or.ddit.orgChart.jm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.orgChart.jm.mapper.OrgChartMapper;
import kr.or.ddit.orgChart.jm.service.OrgChartService;
import kr.or.ddit.vo.OrgChartVO;

@Service
public class OrgChartServiceImpl implements OrgChartService {

	@Autowired
	OrgChartMapper orgChartMapper;
	
	// 데이터 list<OrgChartVO> 타입으로 가져오기
	@Override
	public List<OrgChartVO> listOrgChart() {
        return this.orgChartMapper.listOrgChart();
	}
	
	//  계층 구조로 변환 시작 ----------------------
//	// 1. 조직도 데이터를 children 있는 계층 구조로 변환하여 반환.	
// 	@Override
//    public Map<String, Object> getDeptHierarchyForTree() {
//        List<OrgChartVO> deptList = orgChartMapper.selectDeptList();	// 데이터베이스에서 조직도 데이터 조회
//        return buildHierarchyForTree(deptList);			// 계층 구조로 변환
//    }
//
// 	// 1-1. 계층 구조를 생성하는 내부 메서드
//    private Map<String, Object> buildHierarchyForTree(List<OrgChartVO> deptList) {
//    	// ID를 키로 시작하는 Map 생성
//    	Map<Integer, Map<String, Object>> nodeMap = new HashMap<>();
//        List<Map<String, Object>> rootChildren = new ArrayList<>();
//        
//        // 모든 노드를 초기화
//        for (OrgChartVO dept : deptList) {
//            Map<String, Object> node = new HashMap<>();
//            node.put("id", "node_" + dept.getId());	// 노드 ID
//            node.put("data", Map.of(
//                "imageURL", "", // 이미지 URL 비우기
//                "name", dept.getName()
//            ));
//            node.put("options", Map.of(
//                "nodeBGColor", "", // 노드 배경색
//                "nodeBGColorHover", "" // 노드 호버 배경색
//            ));
//            node.put("children", new ArrayList<Map<String, Object>>()); // 자식 노드 리스트 초기화
//            nodeMap.put(dept.getId(), node);	// ID를 키로 저장
//        }
//        
//        // 부모-자식 관계 설정
//        for (OrgChartVO dept : deptList) {
//            if (dept.getParent() == null) { // 상위 번호가 없는 경우 (루트 노드)
//                rootChildren.add(nodeMap.get(dept.getId()));
//            } else {
//                Map<String, Object> parent = nodeMap.get(dept.getParent());
//                if (parent != null) { // parent null 체크
//                    List<Map<String, Object>> children = (List<Map<String, Object>>) parent.get("children");	// 부모 노드의 자식 리스트에 현재 노드 추가
//                    if (children == null) {
//                        children = new ArrayList<>();
//                        parent.put("children", children); // 자식이 없으면 빈 리스트로 초기화
//                    }
//                    children.add(nodeMap.get(dept.getId())); // 자식 추가
//                }
//            }
//        }
//        // 루트 노드 반환
//        return Map.of(
//            "id", "root",
//            "data", Map.of(
//                "imageURL", "", // 루트 노드 이미지
//                "name", "Root Department" // 루트 노드 이름
//            ),
//            "options", Map.of(
//                "nodeBGColor", "", // 루트 노드 배경색
//                "nodeBGColorHover", "" // 루트 노드 호버 배경색
//            ),
//            "children", rootChildren // 루트 노드 배경색
//        );
//    }
	//  계층 구조로 변환 끝 ----------------------
    
	
//	//생성
//	@Override
//	public int createOrgChart(OrgChartVO orgChartVO) {
//		return this.orgChartMapper.createOrgChart(orgChartVO);
//	}
//	//수정
//	@Override
//	public int updateOrgChart(OrgChartVO orgChartVO) {
//		return this.orgChartMapper.updateOrgChart(orgChartVO);
//	}
//	//삭제
//	@Override
//	public int deleteOrgChart(OrgChartVO orgChartVO) {
//		return this.orgChartMapper.deleteOrgChart(orgChartVO);
//	}
	
}
