package kr.or.ddit.suggest.jw.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.alert.jy.mapper.AlertMapper;
import kr.or.ddit.alert.jy.service.AlertService;
import kr.or.ddit.suggest.jw.VO.ReplyVO;
import kr.or.ddit.suggest.jw.VO.SuggestVO;
import kr.or.ddit.suggest.jw.mapper.SuggestMapper;
import kr.or.ddit.vo.AlertVO;
import kr.or.ddit.vo.TBUserVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class SuggestServiceImpl implements SuggestService {
	
	@Autowired
	SuggestMapper suggestMapper;
	
	@Autowired
	AlertService alertService;

	@Autowired
	AlertMapper alertMapper;
	
	@Override
	public List<SuggestVO> getList(Map<String, Object> map) {
		return this.suggestMapper.getList(map);
	}

	@Override
	public int total(Map<String, Object> map) {
		return this.suggestMapper.total(map);
	}

	@Override
	public SuggestVO detail(int suggestBoardNo) {
		return this.suggestMapper.detail(suggestBoardNo);
	}

	@Override
	public int update(SuggestVO suggestVO) {
		return this.suggestMapper.update(suggestVO);
	}

	@Override
	public int delete(SuggestVO suggestVO) {
		return this.suggestMapper.delete(suggestVO);
	}

	@Override
	public int createPost(SuggestVO suggestVO) {
		return this.suggestMapper.createPost(suggestVO);
	}

	@Override
	public List<ReplyVO> selectReply(SuggestVO suggestVO) {
		return this.suggestMapper.selectReply(suggestVO);
	}

	@Override
	public int createReply(ReplyVO replyVO) {
		
		int result = this.suggestMapper.createReply(replyVO);
		log.info("createReply - > result : " + result);
		
		// 알림 발송
		if(result > 0) {
			// 댓글이 달린 게시글 작성자 조회
			SuggestVO suggestVO = this.alertMapper.findSBNo(replyVO.getSuggestBoardNo());
			
			if(suggestVO != null) {
				// 댓글 작성자와 게시글 작성자가 다를 경우에만 알림 발송
				if(!replyVO.getRepUser().equals(suggestVO.getUserNo())) {
				List<TBUserVO> recipients  = new ArrayList<>();
				
				TBUserVO recipient  = new TBUserVO();
				recipient.setUserNo(suggestVO.getUserNo());
				recipients.add(recipient);
				
				// 알림 내용 설정
	            String content = "게시글 번호 "+ suggestVO.getSuggestBoardNo() + " [ " + suggestVO.getSuggestTitle() + " ]에 새로운 댓글이 달렸습니다.";
	            int alertType = 2; 
	            String alertPk = String.valueOf(suggestVO.getSuggestBoardNo());
	            String alertUrl = "/suggest/detail?suggestBoardNo=" + suggestVO.getSuggestBoardNo();

	            // 수신자 리스트 조회
	            for(TBUserVO userVO : recipients) {
	                String recipientUserNo = userVO.getUserNo();
	                log.info("createReply -> recipientUserNo: " + recipientUserNo);
	                alertService.alert(recipientUserNo, content, alertType, alertPk, alertUrl);
	            }	
			  }
			}
		}
		
		return result;
	}
	

	@Override
	public int updateReply(Map<String, Object> map) {
		return this.suggestMapper.updateReply(map);
	}

	@Override
	public int deleteReply(int repNo) {
		return this.suggestMapper.deleteReply(repNo);
	}

	@Override
	public int createRereply(Map<String, Object> map) {
		
		// 대댓글 정보 가져오기
	    ReplyVO reReplyVO = (ReplyVO) map.get("reReplyVO");
	    log.info("createRereply -> reReplyVO: " + reReplyVO);
	    
	    // reReplyVO가 null이면 중단
	    if (reReplyVO == null) {
	        log.error("createRereply -> reReplyVO가 null입니다! map 데이터를 확인하세요.");
	        return 0;
	    }

	    // 부모 댓글 정보 조회 (PARENT_NO를 이용해 찾기)
	    ReplyVO parentReplyVO = this.alertMapper.findParentReply(reReplyVO.getParentNo());
	    log.info("createRereply -> parentReplyVO: " + parentReplyVO);
	    
	    // 부모 댓글이 존재하지 않으면 중단
	    if (parentReplyVO == null) {
	        log.error("createRereply -> 부모 댓글 정보가 존재 x! ParentNo: " + reReplyVO.getParentNo());
	        return 0;
	    }

	    // 대댓글 저장
	    int result = this.suggestMapper.createRereply(map);
	    log.info("createRereply -> result: " + result);

	    if (result > 0) {
	        List<TBUserVO> recipients = new ArrayList<>();  // 수신자 리스트

	        // 부모 댓글 작성자에게 알림 (대댓글 작성자와 다를 경우)
	        if (!reReplyVO.getRepUser().equals(parentReplyVO.getRepUser())) {
	            TBUserVO parentRecipient = new TBUserVO();
	            parentRecipient.setUserNo(parentReplyVO.getRepUser());
	            recipients.add(parentRecipient);

	            String content =  parentReplyVO.getRepUser() + "님의 댓글에 새로운 댓글이 달렸습니다.";
	            int alertType = 2;
	            String alertPk = String.valueOf(parentReplyVO.getRepNo());
	            String alertUrl = "/suggest/detail?suggestBoardNo=" + reReplyVO.getSuggestBoardNo();

	            log.info("createRereply -> 부모 댓글 작성자 : " + parentReplyVO.getRepUser());
	            
	            alertService.alert(parentReplyVO.getRepUser(), content, alertType, alertPk, alertUrl);
	        }

	        // 게시글 작성자 조회
	        SuggestVO suggestVO = this.alertMapper.findSBNo(reReplyVO.getSuggestBoardNo());

	        // 게시글 작성자에게 알림 (대댓글 작성자와 다를 경우)
	        if (suggestVO != null && !reReplyVO.getRepUser().equals(suggestVO.getUserNo())) {
	            // 부모 댓글 작성자와 중복 알림 방지
	            if (!suggestVO.getUserNo().equals(parentReplyVO.getRepUser())) {
	                TBUserVO postRecipient = new TBUserVO();
	                postRecipient.setUserNo(suggestVO.getUserNo());
	                recipients.add(postRecipient);

	                String content = "게시글 번호 " + suggestVO.getSuggestBoardNo() + " [" + suggestVO.getSuggestTitle() + "] 에 새로운 대댓글이 달렸습니다.";
	                int alertType = 2;
	                String alertPk = String.valueOf(suggestVO.getSuggestBoardNo());
	                String alertUrl = "/suggest/detail?suggestBoardNo=" + suggestVO.getSuggestBoardNo();

	                log.info("createRereply -> 게시글 작성자 : " + suggestVO.getUserNo());
	                
	                alertService.alert(suggestVO.getUserNo(), content, alertType, alertPk, alertUrl);
	            }
	        }

	        // 수신자 리스트 조회 후 알림 발송 (중복 알림 방지)
	        for (TBUserVO userVO : recipients) {
	            log.info("createRereply -> recipientUserNo: " + userVO.getUserNo());
	        }
	    }
		
		return result;
	}

}
