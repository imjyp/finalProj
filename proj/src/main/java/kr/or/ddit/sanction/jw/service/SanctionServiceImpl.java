package kr.or.ddit.sanction.jw.service;

import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.alert.jy.mapper.AlertMapper;
import kr.or.ddit.alert.jy.service.AlertService;
import kr.or.ddit.sanction.jw.mapper.SanctionMapper;
import kr.or.ddit.sanction.jw.vo.ReceiveVO;
import kr.or.ddit.sanction.jw.vo.SanctionDocVO;
import kr.or.ddit.sanction.jw.vo.SanctionVO;
import kr.or.ddit.util.UploadController;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class SanctionServiceImpl implements SanctionService {
	
	@Autowired
	SanctionMapper sanctionMapper;
	
	@Autowired
	UploadController uploadController;
	
	@Autowired
	AlertService alertService;
	
	@Autowired
	AlertMapper alertMapper;

	@Override
	public List<SanctionDocVO> getList(Map<String, Object> map) {
		return this.sanctionMapper.getList(map);
	}

	//keyword로 검색된 전체 데이터의 행수 가져오기
	@Override
	public int total(Map<String, Object> map) {
		return this.sanctionMapper.total(map);
	}

	@Transactional
	@Override
	public void  createPost(SanctionDocVO sanctionDocVO, List<SanctionVO> sanctionVOList,  List<ReceiveVO> receiveVOList) {
		
		
		
		
		int result =0;
		int result2 =0;
		int result3 =0;
		
		
		// 다중 파일 업로드 처리(파일 + DB)
		MultipartFile[] uploadFiles = sanctionDocVO.getUploadFiles();
		
		if(uploadFiles !=null && uploadFiles[0].getOriginalFilename().length() >0) {
			
			long fileGroupNo = this.uploadController.multiImageUpload(uploadFiles);
			log.info("createPost-fileGroupNo: "+fileGroupNo);
			
			// sanctionDocVO에 값 넣기
			sanctionDocVO.setFileGroupNo(fileGroupNo);
			/*
			SanctionDocVO(docNo=0, userNo=, docTitle=테스트22, docContent="summernote 추가하기", 
			docCreateDate=null, fileGroupNo=20250120001, docTypeNo=1, docStatus=0, docTypeNm=null, 
			sanctionTypeNm=null, sanctionStatusNm=null, sanctionLine=null, userNm=null, deptNm=, 
			uploadFiles=[org.springframework.web.multipart.support.StandardMultipartHttpServletRequest$StandardMultipartFile@4cc82fbc], 
			fileGroupVO=null, sanctionVOList=null, receiveVOList=null
			, sanctionUsers=[qwer1234, a555, a999000]
			, sanctionLines=[middle, middle, final]
			, sanctionTypes=[1, 1, 1]
			, receive=[1, 9, 3])
			 */
			log.info("createPost-resourceVO: "+sanctionDocVO);
		}
		
		result += this.sanctionMapper.createPost(sanctionDocVO);
		log.info("createPost-result: "+result);
		//selectKey에 의해 
		int docNo = sanctionDocVO.getDocNo();
		log.info("createPost-docNo: "+docNo);
		
		//2. sanctionVOList의 각 sanctionVO의 docNo 세팅
		int sanctionNo = 1;
		for(SanctionVO vo : sanctionVOList) {
			vo.setSanctionNo(sanctionNo++);
			vo.setDocNo(docNo);
		}
		/*
		[
		SanctionVO(sanctionStatusNo=0, docNo=3, sanctionTypeNo=1, sanctionNo=1, sanctionUser=qwer1234, sanctionDate=null, sanctionLineType=middle), 
		SanctionVO(sanctionStatusNo=0, docNo=3, sanctionTypeNo=1, sanctionNo=2, sanctionUser=a555, sanctionDate=null, sanctionLineType=middle), 
		SanctionVO(sanctionStatusNo=0, docNo=3, sanctionTypeNo=1, sanctionNo=3, sanctionUser=a999000, sanctionDate=null, sanctionLineType=final)
		]
		 */
		result2 = this.sanctionMapper.createSanctionLine(sanctionVOList);
		log.info("createPost-result2: "+result2);
		
		
		//3. receiveVOList의 각 receiveVO의 docNo 세팅
		for(ReceiveVO vo2 : receiveVOList) {
			vo2.setDocNo(docNo);
		}
		
		/*
		[
		ReceiveVO(docNo=3, deptNo=1), 
		ReceiveVO(docNo=3, deptNo=9), 
		ReceiveVO(docNo=3, deptNo=3)
		]
		 */
		result3 = this.sanctionMapper.createSanctionReceive(receiveVOList);
		log.info("createPost-result3: "+result3);
		
		
		// 4. 결재자들에게 알림 발송
	    if (result > 0) {
	        try {
	        	
	            Set<String> recipients = new HashSet<>();
	            for (SanctionVO sanctionVO : sanctionVOList) {
	            	recipients.add(sanctionVO.getSanctionUser());
	            }
	            
	            String content = "문서번호 " + sanctionDocVO.getDocNo() + "번의 결재 요청";
	            int alertType = 1;  
	            String alertPk = String.valueOf(sanctionDocVO.getDocNo());
	            String alertUrl = "/sanction/pending";
	            
	            for (String recipient : recipients) {
	                log.info("createPost -> 결재자 알림 대상 : " + recipient);
	                alertService.alert(recipient, content, alertType, alertPk, alertUrl);
	            }
	        } catch (Exception e) {
	            log.error("알림 전송 실패: ", e);
	        }
	    }
	}

	@Override
	public SanctionDocVO detail(int docNo) {
		return this.sanctionMapper.detail(docNo);
	}

	@Override
	public SanctionDocVO receive(int docNo) {
		return this.sanctionMapper.receive(docNo);
	}

	@Override
	public SanctionDocVO fileGroup(int docNo) {
		return this.sanctionMapper.fileGroup(docNo);
	}

	@Override
	public int mysancTotal(Map<String, Object> map) {
		return this.sanctionMapper.mysancTotal(map);
	}

	@Override
	public List<SanctionDocVO> getMysancList(Map<String, Object> map) {
		return this.sanctionMapper.getMysancList(map);
	}

	@Override
	public int pendingTotal(Map<String, Object> map) {
		return this.sanctionMapper.pendingTotal(map);
	}

	@Override
	public List<SanctionVO> pendingList(Map<String, Object> map) {
		return this.sanctionMapper.pendingList(map);
	}

	@Override
	public int approve(Map<String, Object> map) {
		return this.sanctionMapper.approve(map);
	}

	@Override
	public int reject(Map<String, Object> sanctionData, Map<String, Object> rejectData) {
		
		int san = this.sanctionMapper.sanctionReject(sanctionData);
		
		int doc = this.sanctionMapper.docReject(rejectData);
		
		int result = 0;
		
		if(san == 1 && doc ==1) {
			result = 1;
		}
		
		
		return result;
	}

	@Override
	public int getDept(String userId) {
		return this.sanctionMapper.getDept(userId);
	}

	@Override
	public int reportTotal(Map<String, Object> map) {
		return this.sanctionMapper.reportTotal(map);
	}

	@Override
	public List<SanctionDocVO> reportList(Map<String, Object> map) {
		return this.sanctionMapper.reportList(map);
	}


}
