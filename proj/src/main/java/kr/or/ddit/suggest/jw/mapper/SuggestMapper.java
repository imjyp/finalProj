package kr.or.ddit.suggest.jw.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.suggest.jw.VO.ReplyVO;
import kr.or.ddit.suggest.jw.VO.SuggestVO;

@Mapper
public interface SuggestMapper {

	public List<SuggestVO> getList(Map<String, Object> map);

	public int total(Map<String, Object> map);

	public SuggestVO detail(int boardNo);

	public int update(SuggestVO suggestVO);

	public int delete(SuggestVO suggestVO);

	public int createPost(SuggestVO suggestVO);

	public List<ReplyVO> selectReply(SuggestVO suggestVO);

	public int createReply(ReplyVO replyVO);

	public int updateReply(Map<String, Object> map);

	public int deleteReply(int repNo);

	public int createRereply(Map<String, Object> map);

}
