package kr.or.ddit.resource.jw.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.resource.jw.vo.ResourceVO;

@Mapper
public interface ResourceMapper {

	public List<ResourceVO> getList(Map<String, Object> map);

	public int total(Map<String, Object> map);

	public ResourceVO detail(Map<String, Object> map);

	public int update(ResourceVO resourceVO);

	public int delete(Map<String, Object> map);

	public int createPost(ResourceVO resourceVO);

}
