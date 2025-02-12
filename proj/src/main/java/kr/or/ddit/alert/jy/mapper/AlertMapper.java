package kr.or.ddit.alert.jy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.suggest.jw.VO.ReplyVO;
import kr.or.ddit.suggest.jw.VO.SuggestVO;
import kr.or.ddit.vo.AlertVO;
import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.StoreEmpVO;

@Mapper
public interface AlertMapper {
	
	// 알림 insert (생성)
	public void insertAlert(AlertVO alert);

    // 특정 사용자에 대한 알림 목록 조회
    public List<AlertVO> userAlertList(@Param("userNo") String userNo, int currentPage, String keyword);

    // 특정 알림 삭제 (선택 사항)
    public void deleteAlert(@Param("alertNo") int alertNo);
    
    // 알람 목록 전체 행 개수
	public int total(String userNo, String keyword);

	// 특정 알림을 확인 상태로 변경
	public boolean updAlertChk(int alertNo, String userNo);

	// 특정 알림 조회
	public AlertVO getAlert(int alertNo, String userNo);
	
	// 재정 직원 찾기
    public List<EmployeeVO> findJJ();
    
    // 가맹점주 찾기
    public List<StoreEmpVO> findGMJ(int storeNo);

    // 현재 댓글에 달린 게시글 정보를 가져오기
	public SuggestVO findSBNo(int suggestBoardNo);

	// 건의게시판 대댓글의 부모 댓글 정보 조회
	public ReplyVO findParentReply(int suggestBoardNo);

	// 안 읽음 알림 갯수
	public int unreadCnt(String userNo);

    
	
}
