package kr.or.ddit.chatting.jc.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.chatting.jc.mapper.ChattingMapper;
import kr.or.ddit.chatting.jc.sample.FileUploadController;
import kr.or.ddit.chatting.jc.service.iChattingService;
import kr.or.ddit.resource.jw.service.ResourceServiceImpl;
import kr.or.ddit.util.UploadController;
import kr.or.ddit.vo.ChatVO;
import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.FileDetailVO;
import kr.or.ddit.vo.UsersVO;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Service
public class ChattingServiceImpl implements iChattingService{
	
	@Autowired
	ChattingMapper chatMapper;
	
	@Autowired
	FileUploadController uploadController;

	@Override
	public int insertMsg(ChatVO chatvo) {
		return this.chatMapper.inserMsg(chatvo);
	}

	@Override
	public long createPost(ChatVO chatvo) {
		int result =0;
		long fileGroupNo=0;
		// 다중 파일 업로드 처리(파일 + DB)
		MultipartFile[] uploadFiles = chatvo.getUploadFiles();
		
		if(uploadFiles !=null && uploadFiles[0].getOriginalFilename().length() >0) {
			
			fileGroupNo = this.uploadController.multiImageUpload(uploadFiles);
			log.info("createPost-fileGroupNo: "+fileGroupNo);
			
			chatvo.setFileGroupNo(fileGroupNo);
			log.info("createPost-resourceVO: "+chatvo);
		}
		
		//chatSendNo, chatRoomNo, senderNo, chatSendContent 등록
		result += this.chatMapper.createPost(chatvo);
		log.info("createPost-result: "+result);
		if(result>0) {
			return fileGroupNo;
		}
		
		
		
		return fileGroupNo;
	}

	@Override
	public List<FileDetailVO> selectFileDetail(long fileGroupNo) {
		return this.chatMapper.selectFileDetail(fileGroupNo);
	}

	@Override
	public List<EmployeeVO> listPeople() {
		return this.chatMapper.listPeople();
	}

	@Override
	public List<EmployeeVO> filter(Map<String, Object> map) {
		return this.chatMapper.filter(map);
	}

	// /chattingRoom에서 이름을 클릭 시 채팅창에 관련된 채팅내역 출력
	@Override
	public List<ChatVO> chatSendList(Map<String, Object> map) {
		return this.chatMapper.chatSendList(map);
	}
	
	
	
	

}
