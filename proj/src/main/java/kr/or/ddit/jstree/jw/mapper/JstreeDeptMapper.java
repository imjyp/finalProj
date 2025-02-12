package kr.or.ddit.jstree.jw.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.jstree.jw.vo.JstreeDeptVO;

@Mapper
public interface JstreeDeptMapper {

	public List<JstreeDeptVO> deptTree();

	public List<JstreeDeptVO> receiveDept();

}
