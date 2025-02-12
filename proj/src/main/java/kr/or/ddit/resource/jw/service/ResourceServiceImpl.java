package kr.or.ddit.resource.jw.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.resource.jw.mapper.ResourceMapper;
import kr.or.ddit.resource.jw.vo.ResourceVO;
import kr.or.ddit.util.UploadController;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ResourceServiceImpl implements ResourceService {
	
	@Autowired
	ResourceMapper resourceMapper;
	
	@Autowired
	UploadController uploadController;

	@Override
	public List<ResourceVO> getList(Map<String, Object> map) {
		return this.resourceMapper.getList(map);
	}

	@Override
	public int total(Map<String, Object> map) {
		return this.resourceMapper.total(map);
	}

	@Override
	public ResourceVO detail(Map<String, Object> map) {
		return this.resourceMapper.detail(map);
	}

	@Override
	public int update(ResourceVO resourceVO) {
		int result =0;
		
		// 다중 파일 업로드 처리(파일 + DB)
		MultipartFile[] uploadFiles = resourceVO.getUploadFiles();
		
		if(uploadFiles !=null && uploadFiles[0].getOriginalFilename().length() >0) {
			
			long fileGroupNo = this.uploadController.multiImageUpload(uploadFiles);
			log.info("update-fileGroupNo: "+fileGroupNo);
			
			// resourceVO에 값 넣기
			resourceVO.setFileGroupNo(fileGroupNo);
			log.info("update-resourceVO: "+resourceVO);
		}
		
		result += this.resourceMapper.update(resourceVO);
		log.info("update-result: "+result);
		
		
		return result;
	}

	@Override
	public int delete(Map<String, Object> map) {
		return this.resourceMapper.delete(map);
	}

	@Override
	public int createPost(ResourceVO resourceVO) {
		int result =0;
		
		// 다중 파일 업로드 처리(파일 + DB)
		MultipartFile[] uploadFiles = resourceVO.getUploadFiles();
		
		if(uploadFiles !=null && uploadFiles[0].getOriginalFilename().length() >0) {
			
			long fileGroupNo = this.uploadController.multiImageUpload(uploadFiles);
			log.info("createPost-fileGroupNo: "+fileGroupNo);
			
			// resourceVO에 값 넣기
			resourceVO.setFileGroupNo(fileGroupNo);
			log.info("createPost-resourceVO: "+resourceVO);
		}
		
		result += this.resourceMapper.createPost(resourceVO);
		log.info("createPost-result: "+result);
		
		
		return result;
	}

}
