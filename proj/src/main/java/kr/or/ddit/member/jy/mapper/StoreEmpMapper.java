package kr.or.ddit.member.jy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.StoreEmpVO;

@Mapper
public interface StoreEmpMapper {

	// 가맹점 직원 목록
	public List<StoreEmpVO> listAll();

	//서로 다른 가맹점으로는 접근할 수 없다. 1이상 : 접근 가능 / 0 : 접근 불가
	public int getUrlAccess(Map<String, Object> map);

}
