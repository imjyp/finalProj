package kr.or.ddit.suggest.jw.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.suggest.jw.VO.ReplyVO;
import kr.or.ddit.suggest.jw.VO.SuggestVO;

public interface SuggestService {

	//건의사항 목록 조회
	public List<SuggestVO> getList(Map<String, Object> map);

	//건의사항 전체 행 수 가져오기
	public int total(Map<String, Object> map);

	//건의사항 상세정보
	public SuggestVO detail(int suggestBoardNo);

	//건의사항 수정
	public int update(SuggestVO suggestVO);

	//건의사항 삭제
	public int delete(SuggestVO suggestVO);

	//건의사항 등록
	public int createPost(SuggestVO suggestVO);

	//댓글 가져오기
	public List<ReplyVO> selectReply(SuggestVO suggestVO);

	//댓글 입력
	public int createReply(ReplyVO replyVO);

	//댓글 수정
	public int updateReply(Map<String, Object> map);

	//댓글 삭제
	public int deleteReply(int repNo);

	//대댓글 저장
	public int createRereply(Map<String, Object> map);
	
	

}
