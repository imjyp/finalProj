package kr.or.ddit.sanction.jw.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.jstree.jw.vo.JstreeDeptVO;
import kr.or.ddit.sanction.jw.vo.ReceiveVO;
import kr.or.ddit.sanction.jw.vo.SanctionDocVO;
import kr.or.ddit.sanction.jw.vo.SanctionVO;

@Mapper
public interface SanctionMapper {

	public List<SanctionDocVO> getList(Map<String, Object> map);

	//keyword로 검색된 전체 데이터의 행수 가져오기
	public int total(Map<String, Object> map);

	//결재문서 생성
	public int createPost(SanctionDocVO sanctionDocVO);

	// 결재선 생성
	public int createSanctionLine(List<SanctionVO> sanctionVOList);

	//수신부서 생성
	public int createSanctionReceive( List<ReceiveVO> receiveVOList);

	//결재문서 상세정보 가져오기
	public SanctionDocVO detail(int docNo);

	//결재문서 수신부서 가져오기
	public SanctionDocVO receive(int docNo);

	//결재문서 다운로드 파일 가져오기
	public SanctionDocVO fileGroup(int docNo);

	//내문서함 목록 행 수 가져오기
	public int mysancTotal(Map<String, Object> map);

	//내문서함 목록 가져오기
	public List<SanctionDocVO> getMysancList(Map<String, Object> map);

	//결재대기함 목록 행 수 가져오기
	public int pendingTotal(Map<String, Object> map);

	//결재대기함 목록 가져오기
	public List<SanctionVO> pendingList(Map<String, Object> map);

	//결재 승인
	public int approve(Map<String, Object> map);

	//반려한 결재자 정보 업데이트
	public int sanctionReject(Map<String, Object> sanctionData);

	//반려한 문서의 반려사유 없데이트
	public int docReject(Map<String, Object> rejectData);

	//로그인 회원의 부서번호 가져오기
	public int getDept(String userId);

	//업무보고 목록 수
	public int reportTotal(Map<String, Object> map);

	//업무보고 목록
	public List<SanctionDocVO> reportList(Map<String, Object> map);


}
