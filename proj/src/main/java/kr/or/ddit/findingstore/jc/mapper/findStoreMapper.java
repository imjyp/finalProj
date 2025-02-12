package kr.or.ddit.findingstore.jc.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.StoreVO;

@Mapper
public interface findStoreMapper {

	List<StoreVO> map(Map<String, Object> map);

}
