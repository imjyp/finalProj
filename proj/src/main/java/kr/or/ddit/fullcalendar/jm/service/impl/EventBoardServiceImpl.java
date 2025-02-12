package kr.or.ddit.fullcalendar.jm.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.fullcalendar.jm.mapper.EventBoardMapper;
import kr.or.ddit.fullcalendar.jm.service.EventBoardService;
import kr.or.ddit.resource.jw.service.ResourceServiceImpl;
import kr.or.ddit.util.UploadController;
import kr.or.ddit.vo.CalendarVO;
import kr.or.ddit.vo.FileDetailVO;
import kr.or.ddit.vo.FileGroupVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class EventBoardServiceImpl implements EventBoardService {
	
	@Autowired
	EventBoardMapper eventBoardMapper;
	
	@Autowired
	UploadController uploadController;
	
	@Override
	public List<CalendarVO> getList(Map<String, Object> map) {
		return this.eventBoardMapper.getList(map);
	}

	@Override
	public int total(Map<String, Object> map) {
		return this.eventBoardMapper.total(map);
	}

	@Override
	public CalendarVO detail(int calNm) {
		CalendarVO calendar = this.eventBoardMapper.detail(calNm);
        if (calendar.getFileGroupVO() != null) {
            for (FileDetailVO fileDetail : calendar.getFileGroupVO().getFileDetailVOList()) {
    			log.info("detail-File Detail:: "+ fileDetail.getFileOriginalName());
            }
        }
        return calendar;
        
        //return this.eventBoardMapper.detail(calNm);
	}
	
	@Override
	public FileGroupVO fileGroup(int calNm) {
		return this.eventBoardMapper.fileGroup(calNm);
	}

	@Override
	public int update(CalendarVO calendarVO) {
		return this.eventBoardMapper.update(calendarVO);
	}

	@Override
	public int delete(CalendarVO calendarVO) {
		return this.eventBoardMapper.delete(calendarVO);
	}

	@Override
	public int createPost(CalendarVO calendarVO) {
		int result =0;
		
		// 다중 파일 업로드 처리(파일 + DB)
		MultipartFile[] uploadFiles = calendarVO.getUploadFiles();
		
		if(uploadFiles !=null && uploadFiles[0].getOriginalFilename().length() >0) {
			long fileGroupNo = this.uploadController.multiImageUpload(uploadFiles);
			log.info("createPost-fileGroupNo: "+fileGroupNo);
			
			// calendarVO에 값 넣기
			calendarVO.setFileGroupNo(fileGroupNo);
			log.info("createPost-calendarVO: "+calendarVO);
		}
		
		result += this.eventBoardMapper.createPost(calendarVO);
		log.info("createPost-result: "+result);
		
		
		return result;
	}

	
}
