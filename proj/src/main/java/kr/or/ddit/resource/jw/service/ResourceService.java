package kr.or.ddit.resource.jw.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.resource.jw.vo.ResourceVO;

public interface ResourceService {

	//자료실 목록 조회
	public List<ResourceVO> getList(Map<String, Object> map);

	//검색된 전체 행 수 가져오기
	public int total(Map<String, Object> map);

	//자료실 상세정보
	public ResourceVO detail(Map<String, Object> map);

	//자료실 수정
	public int update(ResourceVO resourceVO);

	//자료실 삭제
	public int delete(Map<String, Object> map);

	//자료실 등록
	public int createPost(ResourceVO resourceVO);
	
	

}
