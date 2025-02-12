package kr.or.ddit.find.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.TBUserVO;

@Mapper
public interface FindIdMapper {

	TBUserVO findId(Map<String, Object> map);

	int findPw(Map<String, Object> map);

	int pwdUpdate(Map<String, Object> map);

	int updatepwd(Map<String, Object> map);

}
