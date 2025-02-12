package kr.or.ddit.member.jy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.AuthVO;
import kr.or.ddit.vo.MemberReplyVO;
import kr.or.ddit.vo.TBUserVO;

@Mapper
public interface MemberMapper {
	public int insertMember (TBUserVO userVO);
	public int insertAuth (AuthVO authVO);
	public TBUserVO read (String userNo);
	
	/* 회원 목록
	<select id="list" resultType="kr.or.ddit.vo.MemberVO">
	 */
	public List<TBUserVO> list(Map<String, Object> map);
	
	//회원 상세
	public TBUserVO detail(String userNo);

	//회원 수정
	public int updatePost(TBUserVO userVO);
	
	//회원 등록 실행
	public int createPost(TBUserVO userVO);
	
	//회원 가입 시 중복체크
	public int idDupChk(TBUserVO userVO);
	
	//회원 삭제
	public int deletePostAjax(TBUserVO userVO);
	
	//행의 수
	//map{currentPage=1&keyword=}
	public int getTotal(Map<String, Object> map);

	//댓글 등록
//	public int createReplyPost(MemberReplyVO memberReplyVO);
	
	/*
	댓글 목록 
	<select id="selectReply" parameterType="kr.or.ddit.vo.MemberVO"
		resultType="kr.or.ddit.vo.MemberReplyVO">
	 */
//	public List<MemberReplyVO> selectReply(TBUserVO memberVO);

	//update 실행. memberReplyVO{idx=9,..,replyContent=네네"...}
//	public int updateReplyPostAjax(MemberReplyVO memberReplyVO);
	
	/*댓글 1건 가져오기
	memberReplyVO{idx=9,..,replyContent=네네"...}
	<select id="getMemberReply" parameterType="kr.or.ddit.vo.MemberReplyVO"
		resultType="kr.or.ddit.vo.MemberReplyVO">
	 */
//	public MemberReplyVO getMemberReply(MemberReplyVO memberReplyVO);

	//MEMBER_REPLY 테이블의 REPLY_STATUS 컬럼의 값을 0으로 update
//	public int updatePostAjax(MemberReplyVO memberReplyVO);
}
