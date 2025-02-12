package kr.or.ddit.jstree.jw.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.jstree.jw.mapper.JstreeDeptMapper;
import kr.or.ddit.jstree.jw.vo.JstreeDeptVO;

@Service
public class JstreeDeptServiceImpl implements JstreeDeptService {

	@Autowired
	JstreeDeptMapper jstreeDeptMapper;
	
	@Override
	public List<JstreeDeptVO> deptTree() {
		return this.jstreeDeptMapper.deptTree();
	}

	@Override
	public List<JstreeDeptVO> receiveDept() {
		return this.jstreeDeptMapper.receiveDept();
	}

}
