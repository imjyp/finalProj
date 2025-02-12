package kr.or.ddit.sanction.jw.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.sanction.jw.vo.ReceiveVO;
import kr.or.ddit.sanction.jw.vo.SanctionDocVO;
import kr.or.ddit.sanction.jw.vo.SanctionVO;

public interface SanctionService {

	//전자결재 목록 불러오기
 	public List<SanctionDocVO> getList(Map<String, Object> map);

 	//keyword로 검색된 전체 데이터의 행수 가져오기
	public int total(Map<String, Object> map);

	// 기안서 생성
	public void createPost(SanctionDocVO sanctionDocVO, List<SanctionVO> sanctionVOList, List<ReceiveVO> receiveVOList);
	
	// 결재문서 상세정보 가져오기 
	public SanctionDocVO detail(int docNo);

	// 결재문서 수신부서 가져오기
	public SanctionDocVO receive(int docNo);

	// 결재문서 다운로드 파일 가져오기
	public SanctionDocVO fileGroup(int docNo);

	// 내문서함 목록 행 수 가져오기
	public int mysancTotal(Map<String, Object> map);

	// 내문서함 목록 가져오기
	public List<SanctionDocVO> getMysancList(Map<String, Object> map);

	// 결재대기함 목록 총 행 수 가져오기
	public int pendingTotal(Map<String, Object> map);

	// 결재대기함 목록 가져오기
	public List<SanctionVO> pendingList(Map<String, Object> map);

	//결재 승인
	public int approve(Map<String, Object> map);

	//결재 반려
	public int reject(Map<String, Object> sanctionData, Map<String, Object> rejectData);

	//로그인 회원의 부서번호 가져오기
	public int getDept(String userId);

	//업무보고 목록 수
	public int reportTotal(Map<String, Object> map);

	//업무보고 목록
	public List<SanctionDocVO> reportList(Map<String, Object> map);



}
