package kr.or.ddit.jstree.jw.service;

import java.util.List;

import kr.or.ddit.jstree.jw.vo.JstreeDeptVO;

public interface JstreeDeptService {

	//결재선 조직도 불러오기
	public List<JstreeDeptVO> deptTree();

	//수신 부서 불러오기
	public List<JstreeDeptVO> receiveDept();

}
